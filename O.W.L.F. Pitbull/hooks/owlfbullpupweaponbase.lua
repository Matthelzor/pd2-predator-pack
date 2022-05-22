OWLFBullpupWeaponBase = OWLFBullpupWeaponBase or class(NewRaycastWeaponBase)

function OWLFBullpupWeaponBase:clbk_assembly_complete(...)
	OWLFBullpupWeaponBase.super.clbk_assembly_complete(self, ...)

	if table.contains(self._blueprint, "wpn_fps_upg_owlfbullpup_mag_drum") then
		self:weapon_tweak_data().animations.reload_name_id = "owlfbullpup_drum"
		self:weapon_tweak_data().timers.reload_empty = 4.8
		self:weapon_tweak_data().timers.reload_not_empty = 3.0
	end
end