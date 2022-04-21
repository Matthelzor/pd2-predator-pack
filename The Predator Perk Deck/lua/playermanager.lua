--local mvec3_copy = mvector3.copy
--local dis_sq = mvector3.distance_sq


Hooks:PostHook(PlayerManager,"check_skills","oak_playermanager_checkskills",function(self)
	blt.xaudio.setup()
	if self:has_category_upgrade("player","oak_damage_to_armor") then 
		
		local upgrade_data = self:upgrade_value("player","oak_damage_to_armor")
		
		local cooldown = upgrade_data.cooldown
		local armor_restored = upgrade_data.armor_restored
		
		self._message_system:register(Message.OnEnemyShot, "proc_oak_damage_to_armor", 
			function (unit, attack_data)
				local attacker_unit = attack_data.attacker_unit
				if alive(attacker_unit) and attacker_unit == self:local_player() then 
					if not self:has_active_temporary_property("oak_damage_to_armor_cooldown") then 
						self:activate_temporary_property("oak_damage_to_armor_cooldown",cooldown,true)
						
						local dmg_ext = attacker_unit:character_damage()
						dmg_ext:restore_armor(armor_restored * dmg_ext:_max_armor())
					end
				end
			end
		)
	else
		self._message_system:unregister(Message.OnEnemyShot, "proc_oak_damage_to_armor")
	end
	
	if self:has_category_upgrade("player","oak_melee_damage_increase_near_team") then
		local upgrade_data = self:upgrade_value("player","oak_melee_damage_increase_near_team")
		local slotmask
		for _,slot_name in pairs(upgrade_data.slotmasks) do 
			local new_slotmask = managers.slot:get_mask(slot_name)
			slotmask = (slotmask and (slotmask + new_slotmask)) or new_slotmask
		end
		if slotmask then 
			self._oak_melee_allies_slotmask = slotmask
		end
		
	end
	
	if self:has_category_upgrade("player","oak_health_on_kill") then 
		
		local upgrade_data = self:upgrade_value("player","oak_health_on_kill")
		local cooldown = upgrade_data.cooldown
		local ranged_restore = upgrade_data.ranged
		local melee_restore = upgrade_data.melee
		
		self:register_message(Message.OnEnemyKilled,"proc_oak_health_on_kill",
			function(equipped_unit,variant,killed_unit)
				local player = self:local_player()
				if alive(player) then
					if not self:has_active_temporary_property("oak_health_on_kill_cooldown") then 
						local dmg_ext = player:character_damage()
						if dmg_ext:_max_health() > dmg_ext:get_real_health() then 
							local restored
							if variant == "bullet" or variant == "graze" or variant == "poison" or variant == "explosion" then 
								restored = ranged_restore
							elseif variant == "melee" then
								restored = melee_restore
							end
							
							if restored then
								self:activate_temporary_property("oak_health_on_kill_cooldown",cooldown,true)
								dmg_ext:restore_health(restored,false,true)
							end
						end
					end
				end
			end
		)
		
	else
		self:unregister_message(Message.OnEnemyKilled,"proc_oak_health_on_kill")
	end
end)


local orig_health_mul = PlayerManager.health_skill_multiplier
function PlayerManager:health_skill_multiplier(...)
	local result = {orig_health_mul(self,...)}
	if self:has_category_upgrade("player","oak_health_to_armor_conversion") then 
		local upgrade_data = self:upgrade_value("player","oak_health_to_armor_conversion")
		local health_removed = upgrade_data.health_removed
		result[1] = result[1] * (1 - health_removed)
	end
	return unpack(result)
end

--this function is probably incompatible with other mods that change it
local orig_body_armor_addend = PlayerManager.body_armor_skill_addend
function PlayerManager:body_armor_skill_addend(override_armor,...)

	if not self:has_category_upgrade("player","oak_health_to_armor_conversion") then 
		return orig_body_armor_addend(self,override_armor,...)
	end
	
	local upgrade_data = self:upgrade_value("player","oak_health_to_armor_conversion",{armor_added = 0,health_removed = 0})
	local health_removed = upgrade_data.health_removed
	local armor_added = upgrade_data.armor_added
	
	local addend = 0
	addend = addend + self:upgrade_value("player", tostring(override_armor or managers.blackmarket:equipped_armor(true, true)) .. "_armor_addend", 0)
	local max_health_default = PlayerDamage._HEALTH_INIT + self:health_skill_addend()
	
	do
		local health_multiplier = orig_health_mul(self)
		local max_health = max_health_default * health_multiplier
		
		addend = addend + (max_health * health_removed * armor_added)
	end
	
	if self:has_category_upgrade("player", "armor_increase") then
		local health_multiplier = self:health_skill_multiplier()
		local max_health = max_health_default * health_multiplier
		addend = addend + max_health * self:upgrade_value("player", "armor_increase", 1)
	end

	addend = addend + self:upgrade_value("team", "crew_add_armor", 0)

	return addend
end


local orig_damage_resist = PlayerManager.damage_reduction_skill_multiplier
function PlayerManager:damage_reduction_skill_multiplier(...)
	local bonus_resist = 0 
	if self:has_category_upgrade("player","oak_nova_bonuses") then 
		local upgrade_data = self:upgrade_value("player","oak_nova_bonuses")
		local resist_per_stack = upgrade_data.damage_reduction
		
		bonus_resist = self:get_temporary_property("oak_nova_stacks",0) * resist_per_stack
	end
	return orig_damage_resist(self,...) - bonus_resist
end


local orig_melee_damage_mul = PlayerManager.get_melee_dmg_multiplier
function PlayerManager:get_melee_dmg_multiplier(...)
	local bonus_damage_mul = 0
	
	if self:has_category_upgrade("player","oak_nova_bonuses") then 
		local upgrade_data = self:upgrade_value("player","oak_nova_bonuses")
		local damage_per_stack = upgrade_data.melee_damage_bonus
		
		local damage_bonus = self:get_temporary_property("oak_nova_stacks",0) * damage_per_stack
		bonus_damage_mul = bonus_damage_mul + damage_bonus
	end
	
	if self:has_category_upgrade("player","oak_melee_damage_increase_near_team") then 
		local upgrade_data = self:upgrade_value("player","oak_melee_damage_increase_near_team")
		
		local range = upgrade_data.range
		local damage_per_stack = upgrade_data.melee_damage_bonus
		
		local damage_bonus = 0
		
		local player = self:local_player()
		local slot_mask = self._oak_melee_allies_slotmask or managers.slot:get_mask("players")
		local nearby_allies = World:find_units_quick("sphere",player:movement():m_pos(),range,slot_mask) -- seems ignore_units only works on raycasts :(
		
		local damage_bonus = (#nearby_allies - 1) * damage_per_stack --player is in this mask so no bonus for that
		
		bonus_damage_mul = bonus_damage_mul + math.max(damage_bonus,0)
	end
	return orig_melee_damage_mul(self,...) + bonus_damage_mul
end
