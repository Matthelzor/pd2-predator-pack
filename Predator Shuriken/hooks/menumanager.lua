Hooks:Add("LocalizationManagerPostInit", "predator_pack_thingy", function(loc)
    LocalizationManager:add_localized_strings({
        ["bm_wpn_prj_four"] = "Predator Shuriken",
        ["bm_wpn_prj_four_desc"] = "The Shuriken is a primarily thrown Yautja weapon. Constructed with six retractable blades, it is sharp enough to cut into three inches of solid stone or cut a Xenomorph in two.\n\nMuch like the Smart Disc with which the weapon shares several similarities, it can also be used as a handheld slashing weapon.\n\nWatch your fingertips.",
		["menu_l_global_value_turtles"] = "This is a Predator Pack Item!",
    })
end)