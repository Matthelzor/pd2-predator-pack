Hooks:Add("LocalizationManagerPostInit", "predator_ammobag_mod", function(loc)
    LocalizationManager:add_localized_strings({
        ["bm_equipment_ammo_bag"] = "Military Ammo Box",
        ["bm_equipment_ammo_bag_desc"] = "I don't think this one needs any introduction, it has been used for over many decades during War and still is being used to this day. It is portable and has four charges, use it wisely. It's a Classic among Surplus Stores.",        
    })
end)