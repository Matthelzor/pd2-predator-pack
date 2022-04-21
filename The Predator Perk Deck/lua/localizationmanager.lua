
local path = ModPath .. "loc/english.json"
Hooks:Add("LocalizationManagerPostInit", "PerkDeck_GenericCardsLocalizationFix_OnLocalizationPostInit", function(loc)
	if BeardLib then 
		--if beardlib is installed, then we don't need to load localization,
		--since beardlib's localization module can handle localization
	else
		loc:load_localization_file( path )
	end

		
--	the 'generic' perkdeck cards ("menu_deckall_2_desc" etc) have a macro localization issue when referenced directly
--	so we need to fix it for our deck here and substitute the macro keys with the proper values
--	if a mod has edited the values, that will be a problem, however

	local adjusted_description_2 = loc:text("menu_deckall_2_desc")
	adjusted_description_2 = string.gsub(adjusted_description_2,"$multiperk;","25%%")
	local adjusted_description_4 = loc:text("menu_deckall_4_desc")
	adjusted_description_4 = string.gsub(adjusted_description_4,"$multiperk;","+1")
	adjusted_description_4 = string.gsub(adjusted_description_4,"$multiperk2;","15%%")
	adjusted_description_4 = string.gsub(adjusted_description_4,"$multiperk3;","45%%")
	local adjusted_description_6 = loc:text("menu_deckall_6_desc")
	adjusted_description_6 = string.gsub(adjusted_description_6,"$multiperk;","135%%")
	local adjusted_description_8 = loc:text("menu_deckall_8_desc")
	adjusted_description_8 = string.gsub(adjusted_description_8,"$multiperk;","5%%")
	adjusted_description_8 = string.gsub(adjusted_description_8,"$multiperk2;","20%%")
	
	loc:add_localized_strings({
		menu_deckall_fixed_2_desc = adjusted_description_2,
		menu_deckall_fixed_4_desc = adjusted_description_4,
		menu_deckall_fixed_6_desc = adjusted_description_6,
		menu_deckall_fixed_8_desc = adjusted_description_8 
	})
end)