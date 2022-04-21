Hooks:Add("LocalizationManagerPostInit", "predator_ecmjammer_mod", function(loc)
    LocalizationManager:add_localized_strings({
        ["bm_equipment_ecm_jammer"] = "U.A.V. Scanjammer",
        ["bm_equipment_ecm_jammer_desc"] = "The U.A.V. Scanjammer is really handy when it comes to Stealth. It can basically block all the electronic equipment that sends shortwave signal in/out which involves cameras and cellular network. You need to place it by holding the default [G] button or the button that is assigned by you for deployment of the equipment. Once you do that, be aware that the signal is depending on the special batteries and can recharge over time to cause headache induced and powered by it's built-in Feedback Status. Tread lightly and be careful with that thing. You're hunting Predators, not Humans.... Are you?",
    })
end)