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
