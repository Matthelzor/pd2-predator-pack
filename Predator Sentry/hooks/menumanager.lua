Hooks:Add("LocalizationManagerPostInit", "predator_sentrygun_mod", function(loc)
    LocalizationManager:add_localized_strings({
        ["bm_equipment_sentry_gun"] = "UA 571-C Automated Sentry Gun",
        ["bm_equipment_sentry_gun_desc"] = "The UA 571-C Automated Sentry Gun, known colloquially as the ''Robot Sentry'', is a tripod-mounted automated perimeter defense system employed by the United States Colonial Marine Corps to deliver pre-set automatic fire to any hostile within range or area targets.",        
        ["bm_equipment_sentry_gun_silent"] = "Suppressed UA 571-C Auto Sentry Gun",
        ["bm_equipment_sentry_gun_silent_desc"] = "Same version as the original, except the noise itself has been eliminated and does not attract as much attention as it should in the Battlefield.",    
    })
end)