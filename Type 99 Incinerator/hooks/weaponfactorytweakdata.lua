Hooks:PostHook(WeaponFactoryTweakData, "create_bonuses", "Type99IncModInit", function(self)
	self.parts.wpn_fps_fla_system_b_standard.unit = "units/mods/weapons/wpn_fps_fla_type99inc_pts/wpn_fps_fla_type99inc_barrel"
	self.parts.wpn_fps_fla_system_b_standard.animations = {equip = "equip", unequip = "unequip", reload = "reload", reload_not_empty = "reload"}
	self.parts.wpn_fps_fla_system_b_wtf.unit = "units/mods/weapons/wpn_fps_fla_type99inc_pts/wpn_fps_fla_type99inc_barrel_pilot_slim"
	self.parts.wpn_fps_fla_system_b_wtf.animations = {equip = "equip", unequip = "unequip", reload = "reload", reload_not_empty = "reload"}
	self.parts.wpn_fps_fla_system_body_standard.unit = "units/mods/weapons/wpn_fps_fla_type99inc_pts/wpn_fps_fla_type99inc_rec"
	self.parts.wpn_fps_fla_system_body_upper.unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy"
	self.parts.wpn_fps_fla_system_dh_standard.unit = "units/mods/weapons/wpn_fps_fla_type99inc_pts/wpn_fps_fla_type99inc_handle"
	self.parts.wpn_fps_fla_system_m_high.unit = "units/mods/weapons/wpn_fps_fla_type99inc_pts/wpn_fps_fla_type99inc_mag_high"
	self.parts.wpn_fps_fla_system_m_low.unit = "units/mods/weapons/wpn_fps_fla_type99inc_pts/wpn_fps_fla_type99inc_mag_low"
	self.parts.wpn_fps_fla_system_m_standard.unit = "units/mods/weapons/wpn_fps_fla_type99inc_pts/wpn_fps_fla_type99inc_mag"
end)