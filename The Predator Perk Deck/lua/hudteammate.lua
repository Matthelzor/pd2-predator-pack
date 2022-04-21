Hooks:PostHook(HUDTeammate,"set_health","oak_hudteammate_set_health",function(self,i,teammates_panel,is_player,width)
	if self._main_player then 
		local static_damage_ratio = managers.player:has_category_upgrade("player","oak_budget_leech") and managers.player:upgrade_value("player","oak_budget_leech")
		if static_damage_ratio then 
			self:set_copr_indicator(true,static_damage_ratio)
		end
	end
end)