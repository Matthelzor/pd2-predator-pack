local orig_fire_rate_mul = NewRaycastWeaponBase.fire_rate_multiplier
function NewRaycastWeaponBase:fire_rate_multiplier(...)
	local bonus_mul = 1
	local pm = managers.player
	
	if pm:has_category_upgrade("player","oak_nova_bonuses") then 
		local upgrade_data = pm:upgrade_value("player","oak_nova_bonuses")
		local firerate_bonus = upgrade_data.firerate_bonus * pm:get_temporary_property("oak_nova_stacks",0)
		bonus_mul = bonus_mul + firerate_bonus
	end
	
	return orig_fire_rate_mul(self,...) * bonus_mul
end
