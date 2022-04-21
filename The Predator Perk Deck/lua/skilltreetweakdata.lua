
local paid = false
--if you want this perk deck to be instantly unlocked, change the above "true" to "false" (no quotation marks)



Hooks:PostHook(SkillTreeTweakData,"init","oak_initskilltree",function(self,data)
	local costs = {
		[1] = 200,
		[2] = 300,
		[3] = 400,
		[4] = 600,
		[5] = 1000,
		[6] = 1600,
		[7] = 2400,
		[8] = 3200,
		[9] = 4000
	}
	local function cost(n)
		return paid and costs[n] or 0
	end

	local deck2 = {
		cost = cost(2),
		name_id = "menu_deckall_2",
		desc_id = "menu_deckall_fixed_2_desc",
		upgrades = {
			"weapon_passive_headshot_damage_multiplier"
		},
		icon_xy = {
			1,
			0
		}
	}
	local deck4 = {
		cost = cost(4),
		name_id = "menu_deckall_4",
		desc_id = "menu_deckall_fixed_4_desc",
		upgrades = {
			"passive_player_xp_multiplier",
			"player_passive_suspicion_bonus",
			"player_passive_armor_movement_penalty_multiplier"
		},
		icon_xy = {
			3,
			0
		}
	}
	local deck6 = {
		cost = cost(6),
		name_id = "menu_deckall_6",
		desc_id = "menu_deckall_fixed_6_desc",
		upgrades = {
			"armor_kit",
			"player_pick_up_ammo_multiplier"
		},
		icon_xy = {
			5,
			0
		}
	}
	local deck8 = {
		cost = cost(8),
		name_id = "menu_deckall_8",
		desc_id = "menu_deckall_fixed_8_desc",
		upgrades = {
			"weapon_passive_damage_multiplier",
			"passive_doctor_bag_interaction_speed_multiplier"
		},
		icon_xy = {
			7,
			0
		}
	}

	table.insert(self.specializations,
		{
			name_id = "menu_deck_oak_title",
			desc_id = "menu_deck_oak_desc",
			{
				upgrades = {
					"player_oak_damage_restores_armor"
				},
				cost = cost(1),
				icon_xy = {6,1},
				name_id = "menu_deck_oak_1_title",
				desc_id = "menu_deck_oak_1_desc"
			},
			deck2,
			{
				upgrades = {
					"player_oak_health_to_armor_conversion",
					"player_oak_budget_leech"
				},
				cost = cost(3),
				icon_xy = {3, 6},
				name_id = "menu_deck_oak_3_title",
				desc_id = "menu_deck_oak_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_oak_melee_damage_increase_near_team"
				},
				cost = cost(5),
				icon_xy = {4,2},
				name_id = "menu_deck_oak_5_title",
				desc_id = "menu_deck_oak_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_oak_health_on_kill"
				},
				cost = cost(7),
				icon_xy = {0, 0},
				texture_bundle_folder = "oak",
				name_id = "menu_deck_oak_7_title",
				desc_id = "menu_deck_oak_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_oak_nova_shield",
					"player_oak_nova_bonuses"
				},
				cost = cost(9),
				icon_xy = {1, 0},
				texture_bundle_folder = "oak",
				name_id = "menu_deck_oak_9_title",
				desc_id = "menu_deck_oak_9_desc"
			}
		}
	)
	
	
	Hooks:Add("KineticTrackers_OnBuffDataLoaded","OakPerkDeck_AddKineticTrackersData",function(kt_td)
	--compatibility with KineticTrackers, my (Offyerrocker's) standalone buff tracker mod
	--[[
		local perkdeck_num
		kt_td.buffs.asdds = {
			disabled = false,
			source = "perk",
			text_id = "menu_deck22_1",
			icon1data = {
				source = "perk",
				tree = 1,
				card = 1
			},
			
		}
		
		kt_td.buffs_lookup_table.properties.asdf = "asdf"
	--]]
	end)
	
end)