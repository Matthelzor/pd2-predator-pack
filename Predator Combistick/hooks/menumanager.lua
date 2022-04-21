Hooks:Add("LocalizationManagerPostInit", "predator_pack_thing", function(loc)
    LocalizationManager:add_localized_strings({
        ["bm_wpn_prj_jav"] = "Combistick",
        ["bm_wpn_prj_jav_desc"] = "The Combistick, also known as the Telescoping Spear, is a spear-like Yautja weapon.\n\nThe Combistick is telescopic, making it relatively small and easy to store when not in use but extending to its full length when required in combat.\n\nIt is made of incredibly light, sharp, thin but strong material.\n\nIt can be used both as a close-quarters hand-to-hand weapon and thrown like a spear.",
		["menu_l_global_value_steel"] = "This is a Predator Pack Item!",
    })
end)