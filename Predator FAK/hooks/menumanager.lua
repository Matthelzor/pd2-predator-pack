Hooks:Add("LocalizationManagerPostInit", "predator_fak_mod", function(loc)
    LocalizationManager:add_localized_strings({
        ["bm_equipment_first_aid_kit"] = "First Aid Stimpak",
        ["bm_equipment_first_aid_kit_desc"] = "Great for healing yourself instantly. By default, you can only have four unless you use skills, the amount is tripled.",        
    })
end)