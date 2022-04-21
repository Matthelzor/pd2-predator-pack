Hooks:Add("LocalizationManagerPostInit", "predator_tripmine_mod", function(loc)
    LocalizationManager:add_localized_strings({
        ["bm_equipment_trip_mine"] = "Predator Tripmine",
        ["bm_equipment_trip_mine_desc"] = "Ancient Yautjan Technology. With this trip mine you can blow up almost anything you want that is marked by the Shaped Charges icon. It also glows up and genuinely looks better than a normal trip mine.",        
    })
end)