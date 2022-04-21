Hooks:PostHook(WeaponFactoryTweakData, "create_bonuses", "PlasmaProtoModInit", function(self)
	local custom_wpn_id = "wpn_fps_ass_plasmaproto"
	local offset = Vector3(0, 0, 0)
	for _, part_id in pairs(self.parts) do
		if part_id.type == "gadget" and part_id.sub_type == "second_sight" and part_id.stance_mod and part_id.a_obj == "a_o" then
			if part_id.stance_mod[custom_wpn_id] and part_id.stance_mod[custom_wpn_id].translation then
				part_id.stance_mod[custom_wpn_id].translation = (part_id.stance_mod[custom_wpn_id].translation + offset)
			end
		end
	end
end)