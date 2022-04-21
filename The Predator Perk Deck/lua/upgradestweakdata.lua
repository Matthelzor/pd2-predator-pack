Hooks:PostHook(UpgradesTweakData,"_player_definitions","oak_init_player_definitions",function(self)
	self.values.player.oak_damage_to_armor = {
		{
			armor_restored = 0.1, --10% of armor restored
			cooldown = 5
		}
	}
	
	self.values.player.oak_health_to_armor_conversion = {
		{
			armor_added = 1.25, -- +25% armor
			health_removed = 0.5 -- -50% health converted
		}
	}
	self.values.player.oak_budget_leech = {
		0.125 --8 segments
	}
	self.values.player.oak_melee_damage_increase_near_team = {
		{
			melee_damage_bonus = 1, --+100%
			range = 1500, --15m
			slotmasks = {
				"criminals_no_deployables",
				"players"
			}
		}
	}
		
	self.values.player.oak_health_on_kill = {
		{
			ranged = 0.05, --5% hp restored
			melee = 0.15, --15% hp restored
			cooldown = 3
		}
	}
	
	self.values.player.oak_nova_shield = {
		{
			range = 1500,
			cooldown = 20,
			fire_dot_data = {
				dot_trigger_chance = "100",
				dot_damage = "3",
				dot_length = "3.1",
				dot_trigger_max_distance = "3000",
				dot_tick_period = "0.25"
			}
		}
	}
	self.values.player.oak_nova_bonuses = {
		{
			ranged_damage_bonus = 0.05,
			melee_damage_bonus = 1,
			firerate_bonus = 0.1,
			damage_reduction = 0.05,
			damage_absorption = 0.5,
			
			max_stacks = 5,
			duration = 10
		}
	}
	
	self.definitions.player_oak_damage_restores_armor = {
		name_id = "menu_deck_oak_1",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "oak_damage_to_armor",
			category = "player"
		}
	}
	
	self.definitions.player_oak_health_to_armor_conversion = {
		name_id = "menu_deck_oak_3",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "oak_health_to_armor_conversion",
			category = "player"
		}
	}
	self.definitions.player_oak_budget_leech = {
		name_id = "menu_deck_oak_3",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "oak_budget_leech",
			category = "player"
		}
	}
	
	self.definitions.player_oak_melee_damage_increase_near_team = {
		name_id = "menu_deck_oak_5",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "oak_melee_damage_increase_near_team",
			category = "player"
		}
	}
	
	self.definitions.player_oak_health_on_kill = {
		name_id = "menu_deck_oak_7",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "oak_health_on_kill",
			category = "player"
		}
	}
	
	self.definitions.player_oak_nova_shield = {
		name_id = "menu_deck_oak_9",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "oak_nova_shield",
			category = "player"
		}
	}
	
	self.definitions.player_oak_nova_bonuses = {
		name_id = "menu_deck_oak_9",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "oak_nova_bonuses",
			category = "player"
		}
	}
end)


