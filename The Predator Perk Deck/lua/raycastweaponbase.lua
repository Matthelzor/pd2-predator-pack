local orig_damage = RaycastWeaponBase._get_current_damage
function RaycastWeaponBase:_get_current_damage(...)
	local bonus_damage = 1 
	local pm = managers.player
	
	
	if pm:has_category_upgrade("player","oak_nova_bonuses") then 
		local upgrade_data = pm:upgrade_value("player","oak_nova_bonuses")
		local damage_stacks = upgrade_data.ranged_damage_bonus * pm:get_temporary_property("oak_nova_stacks",0)
		bonus_damage = bonus_damage + damage_stacks
	end
	
	return orig_damage(self,...) * bonus_damage
end
