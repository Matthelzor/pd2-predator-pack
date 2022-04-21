Hooks:Add("LocalizationManagerPostInit", "predator_medicbag_mod", function(loc)
    LocalizationManager:add_localized_strings({
        ["bm_equipment_doctor_bag"] = "Medical Kit",
        ["bm_equipment_doctor_bag_desc"] = "Perfect for treating serious wounds, and you can only use it twice, so tread lightly. Help your fellow teammates.",        
    })
end)