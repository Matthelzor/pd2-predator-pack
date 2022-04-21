local snd_path = ((oakpd_core and oakpd_core:GetPath()) or ModPath) .. "assets/snd/seismic_charge.ogg"

local mvec3_dis = mvector3.distance
Hooks:PreHook(PlayerDamage,"_on_damage_event","oak_check_shield_break",function(self)
	local armor_broken = self:_max_armor() > 0 and self:get_real_armor() <= 0
	local pm = managers.player
	if armor_broken and pm:has_category_upgrade("player","oak_nova_shield") then 
		if not pm:has_active_temporary_property("oak_nova_cooldown") then 

			local upgrade_data = pm:upgrade_value("player","oak_nova_shield")
			local cooldown = upgrade_data.cooldown
			local range = upgrade_data.range
			local fire_dot_data = upgrade_data.fire_dot_data
			
			pm:activate_temporary_property("oak_nova_cooldown",cooldown,true)

			XAudio.Source:new(XAudio.Buffer:new(snd_path))
			local snd_delay = 1.66
			managers.enemy:add_delayed_clbk("oak_nova_shield_proc",
				function()
					
					
					local player_unit = self._unit
					
					local pos = player_unit:movement():m_pos()
					--play sound
					--play effect
					
					World:effect_manager():spawn({
						effect = Idstring("effects/payday2/particles/explosions/grenade_incendiary_explosion" or "effects/particles/explosions/explosion_flash_grenade"),
						position = pos,
						normal = player_unit:rotation():y()
					})
					
					
					--[[
					--old vanilla grenade snd effect
					local sound_source = SoundDevice:create_source("ExplosionManager")
					sound_source:set_position(pos)
					sound_source:post_event("grenade_explode")
					managers.enemy:add_delayed_clbk("ExplosionManager", callback(ProjectileBase, ProjectileBase, "_dispose_of_sound", {
						sound_source = sound_source
					}), TimerManager:game():time() + 4)
					--]]
						
					
					local nova_stacks = 0
					
					local nearby_enemies = World:find_units_quick("sphere",pos,range,managers.slot:get_mask("enemies"))
					
					for _,unit in pairs(nearby_enemies) do 
						local unit_pos = unit:position()
						local dmg_ext = unit:character_damage()
						local attack_data = {
							variant = "fire",
							damage = 0,
							owner = nil,
							attacker_unit = player_unit,
		--					weapon_unit = melee_weapon,
							direction = unit_pos - pos,
							col_ray = {
								normal = pos - unit_pos,
								position = unit_pos,
								ray = unit_pos - pos,
								hit_position = unit_pos,
								body = nil,
								distance = mvec3_dis(pos,unit_pos),
								unit = unit
		--						position = unit_pos
							},
							fire_dot_data = fire_dot_data
						}
						
						dmg_ext:damage_fire(attack_data)
						nova_stacks = nova_stacks + 1
					end
					
		--			log("nova proc (hit " .. nova_stacks .. " enemies")
					
					if pm:has_category_upgrade("player","oak_nova_bonuses") then 
						local nova_bonus_data = pm:upgrade_value("player","oak_nova_bonuses")
						local duration = nova_bonus_data.duration
						local max_stacks = nova_bonus_data.max_stacks
						local damage_absorption = nova_bonus_data.damage_absorption
						
						nova_stacks = math.min(nova_stacks,max_stacks)
						pm:activate_temporary_property("oak_nova_stacks",duration,nova_stacks)
						
						
						pm:set_damage_absorption("oak_nova_bonus_damage_absorption",damage_absorption * nova_stacks)
						
						managers.enemy:add_delayed_clbk("oak_nova_bonus_damage_absorption_expire",
							function()
								pm:set_damage_absorption("oak_nova_bonus_damage_absorption",false)
							end,
							duration
						)
						
						
					end
				end,
				TimerManager:game():time() + snd_delay
			)
		else
--			log("nova cooldown is active")
			
		end
	end
	
end)

Hooks:PostHook(PlayerDamage,"copr_update_attack_data","oak_static_damage_ratio",function(self,attack_data)
	local pm = managers.player
	if pm:has_category_upgrade("player", "oak_budget_leech") and self:get_real_armor() <= 0 then
		local static_damage_ratio = pm:upgrade_value("player", "oak_budget_leech")

		if static_damage_ratio and attack_data.damage > 0 then

			local health_segment_size = self:_max_health() * static_damage_ratio
			attack_data.damage = math.min(attack_data.damage,health_segment_size)

		end
	end
end)
