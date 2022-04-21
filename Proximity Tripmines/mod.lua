local SENSOR_RADIUS = 500 -- radius to mark enemies
local TRIGGER_RADIUS = 200 -- radius that triggers explosion

Hooks:PostHook(TripMineBase, "set_active", "set_active_predator", function (self)
	if not self._active or self._light then
		return
	end

	self._light = World:create_light("omni")
	self._light:set_position(self._position + self._forward * 10)
	self._light:set_near_range(0)
	self._light:set_far_range(30)
	self._light:set_color(Vector3(0, 0, 0))
end)

Hooks:PostHook(TripMineBase, "_set_armed", "_set_armed_predator", function (self)
	if self._light then
		self._light:set_color(self._armed and Vector3(1, 0, 0) or self._sensor_upgrade and Vector3(0, 0.25, 1) or Vector3(0, 0, 0))
	end
end)

Hooks:PostHook(TripMineBase, "destroy", "destroy_predator", function (self)
	if self._light then
		World:delete_light(self._light)
	end
end)


function TripMineBase:_sensor(t)
	if not managers.network:session() or not managers.player:has_category_upgrade("trip_mine", "sensor_highlight") then
		return
	end

	self._sensor_units_detected = self._sensor_units_detected or {}

	local highlight
	local vis_slotmask = managers.slot:get_mask("AI_visibility")
	local units = World:find_units_quick("sphere", self._unit:position(), SENSOR_RADIUS, self._slotmask)
	--Draw:brush(Color.blue:with_alpha(0.3), 0.02):sphere(self._unit:position(), SENSOR_RADIUS)
	for _, v in pairs(units) do
		if not tweak_data.character[v:base()._tweak_table].is_escort and not self._sensor_units_detected[v:key()] then
			if not World:raycast("ray", self._unit:position() + self._forward * 20, v:body(0):position(), "slot_mask", vis_slotmask, "ray_type", "ai_vision", "report") then
				self._sensor_units_detected[v:key()] = true
				managers.game_play_central:auto_highlight_enemy(v, true)
				highlight = true
			end
		end
	end

	if highlight then
		self._sensor_last_unit_time = t + 5
		self:_emit_sensor_sound_and_effect()
		managers.network:session():send_to_peers_synched("sync_unit_event_id_16", self._unit, "base", TripMineBase.EVENT_IDS.sensor_beep)
	end
end

function TripMineBase:_check()
	if not managers.network:session() then
		return
	end

	local team_id_player = tweak_data.levels:get_default_team_ID("player")
	local geometry_slotmask = managers.slot:get_mask("world_geometry")
	local units = World:find_units_quick("sphere", self._unit:position(), TRIGGER_RADIUS, self._slotmask)
	local explode_unit
	--Draw:brush(Color.red:with_alpha(0.3), 0.02):sphere(self._unit:position(), TRIGGER_RADIUS)
	for _, v in pairs(units) do
		if not tweak_data.character[v:base()._tweak_table].is_escort and managers.groupai:state():team_data(team_id_player).foes[v:movement():team().id] then
			if not World:raycast("ray", self._unit:position() + self._forward * 20, v:body(0):position(), "slot_mask", geometry_slotmask, "report") then
				explode_unit = v
				break
			end
		end
	end

	if not explode_unit then
		return
	end

	self._explode_timer = tweak_data.weapon.trip_mines.delay + managers.player:upgrade_value("trip_mine", "explode_timer_delay", 0)
	self._explode_ray = {
		unit = explode_unit,
		ray = Vector3(),
		position = mvector3.copy(self._ray_from_pos)
	}

	self._unit:sound_source():post_event("trip_mine_beep_explode")
	managers.network:session():send_to_peers_synched("sync_unit_event_id_16", self._unit, "base", TripMineBase.EVENT_IDS.explosion_beep)
end
