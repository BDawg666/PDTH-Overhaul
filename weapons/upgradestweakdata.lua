local UpgradesTweakData = module:hook_class("UpgradesTweakData")
module:post_hook(UpgradesTweakData, "init_data_player_overhaul", function(self)
	self.values.player.body_armor = { 0, 0, 0, 0, 0 }

	self.values.extra_cable_tie.quantity = { 18, 18, 18, 18 }
	self.values.player.thick_skin = { 10, 10, 10, 10, 10 }
	self.values.player.extra_ammo_multiplier = { 1.25, 1.25, 1.25, 1.25, 1.25 }
	self.values.player.toolset = { 0.6, 0.6, 0.6, 0.6 }
	self.values.crew_bonus.more_ammo = { 1.1 }
end)

module:post_hook(UpgradesTweakData, "init_data_deployable_overhaul", function(self)
	self.ammo_bag_base = 5
	self.values.ammo_bag.ammo_increase = { 0, 0, 0 }

	self.doctor_bag_base = 2
	self.values.doctor_bag.amount_increase = { 0, 0, 0 }

	self.values.trip_mine.quantity = { 10, 10, 10, 10, 10, 10 }
	self.values.trip_mine.damage_multiplier = { 1, 1 }

	self.sentry_gun_base_ammo = 800
	self.sentry_gun_base_armor = 10
	self.values.sentry_gun.ammo_increase = { 0, 0, 0, 0 }
	self.values.sentry_gun.armor_increase = { 0, 0, 0, 0 }
end)

-- there is not a lot of changes per weapon, will split by slot instead.
module:post_hook(UpgradesTweakData, "init_data_handguns_overhaul", function(self)
	self.values.beretta92.clip_ammo_increase = { 0, 0 }
	self.values.beretta92.recoil_multiplier = { 1, 1, 1, 1 }
	self.values.beretta92.spread_multiplier = { 1, 1 }

	self.values.c45.clip_ammo_increase = { 0, 0 }
	self.values.c45.recoil_multiplier = { 1, 1, 1, 1 }
	self.values.c45.damage_multiplier = { 1, 1, 1, 1 }

	self.values.raging_bull.spread_multiplier = { 1, 1, 1, 1 }
	self.values.raging_bull.damage_multiplier = { 1, 1, 1, 1 }
	--self.values.raging_bull.reload_speed_multiplier = {1, 1}

	self.values.glock.recoil_multiplier = { 1, 1 }
	self.values.glock.clip_ammo_increase = { 0, 0, 0, 0 }
	self.values.glock.damage_multiplier = { 1, 1 }
	--self.values.glock.reload_speed_multiplier = {1, 1}
end)

module:post_hook(UpgradesTweakData, "init_data_primary_overhaul", function(self)
	self.values.m4.clip_ammo_increase = { 0, 0 }
	self.values.m4.spread_multiplier = { 1, 1, 1, 1 }
	self.values.m4.damage_multiplier = { 1, 1 }

	self.values.hk21.clip_ammo_increase = { 0, 0, 0, 0 }
	self.values.hk21.recoil_multiplier = { 1, 1 }
	self.values.hk21.enter_steelsight_speed_multiplier = { 0.5, 0.5, 0.5, 0.5 }

	self.values.m14.clip_ammo_increase = { 0, 0 }
	self.values.m14.recoil_multiplier = { 1, 1, 1, 1 }
	self.values.m14.spread_multiplier = { 1, 1 }
	self.values.m14.damage_multiplier = { 1, 1 }

	self.values.r870_shotgun.clip_ammo_increase = { 0, 0 }
	self.values.r870_shotgun.recoil_multiplier = { 1, 1, 1, 1 }
	self.values.r870_shotgun.fire_rate_multiplier = { 1.25, 1.25, 1.25, 1.25 }

	self.values.ak47.spread_multiplier = { 1, 1 }
	self.values.ak47.recoil_multiplier = { 1, 1, 1, 1 }
	self.values.ak47.damage_multiplier = { 1, 1, 1, 1 }
	self.values.ak47.clip_ammo_increase = { 0, 0 }
end)

module:post_hook(UpgradesTweakData, "init_data_secondary_overhaul", function(self)
	self.values.mac11.clip_ammo_increase = { 0, 0, 0, 0 }
	self.values.mac11.recoil_multiplier = { 1, 1, 1, 1 }
	--Remove steelsight multipliers for now, re-add later and to more weapons
	self.values.mac11.enter_steelsight_speed_multiplier = {1, 1}

	self.values.mossberg.clip_ammo_increase = { 0, 0 }
	self.values.mossberg.recoil_multiplier = { 1, 1 }
	--ToDo: not in weapontweakdata
	--self.values.mossberg.reload_speed_multiplier = {1.1, 1.2}
	-- self.values.mossberg.fire_rate_multiplier = { 1, 1, 1, 1 }

	self.values.mp5.recoil_multiplier = { 1, 1 }
	self.values.mp5.spread_multiplier = { 1, 1 }
	--ToDo: not in weapontweakdata
	-- self.values.mp5.reload_speed_multiplier = { 1, 1, 1, 1 }
	self.values.mp5.enter_steelsight_speed_multiplier = {1, 1}

	self.values.m79.damage_multiplier = { 1, 1, 1, 1 }
	self.values.m79.explosion_range_multiplier = { 1, 1 }
	self.values.m79.clip_amount_increase = { 0, 0 }
end)

module:post_hook(UpgradesTweakData, "init", function(self)
	self:init_data_player_overhaul()
	self:init_data_deployable_overhaul()
	self:init_data_handguns_overhaul()
	self:init_data_primary_overhaul()
	self:init_data_secondary_overhaul()
end, false)

function UpgradesTweakData:_remington_definitions()
	self.definitions.r870_shotgun = {
		tree = 3,
		step = 13,
		category = "weapon",
		weapon_id = "r870_shotgun",
		unit_name = Idstring("units/weapons/r870_shotgun/r870_shotgun"),
		name_id = "debug_r870_shotgun",
		title_id = "debug_upgrade_new_weapon",
		subtitle_id = "debug_r870_shotgun_short",
		icon = "r870_shotgun",
		image = "upgrades_remington",
		image_slice = "upgrades_remington_slice",
		unlock_lvl = 1,
		prio = "high",
		description_text_id = "des_r870_shotgun"
	}
	for i, _ in ipairs(self.values.r870_shotgun.clip_ammo_increase) do
		local depends_on = i - 1 > 0 and "remington_mag" .. i - 1 or "r870_shotgun"
		local unlock_lvl = 2
		local prio = i == 1 and "high"
		self.definitions["remington_mag" .. i] = {
			tree = 3,
			step = self.steps.r870_shotgun.clip_ammo_increase[i],
			category = "feature",
			name_id = "debug_upgrade_remington_mag" .. i,
			title_id = "debug_r870_shotgun_short",
			subtitle_id = "debug_upgrade_mag" .. i,
			icon = "r870_shotgun",
			image = "upgrades_remington",
			image_slice = "upgrades_remington_slice",
			description_text_id = "clip_ammo_increase",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "r870_shotgun",
				upgrade = "clip_ammo_increase",
				value = i
			}
		}
	end
	for i, _ in ipairs(self.values.r870_shotgun.recoil_multiplier) do
		local depends_on = i - 1 > 0 and "remington_recoil" .. i - 1 or "r870_shotgun"
		local unlock_lvl = 3
		local prio = i == 1 and "high"
		self.definitions["remington_recoil" .. i] = {
			tree = 3,
			step = self.steps.r870_shotgun.recoil_multiplier[i],
			category = "feature",
			name_id = "debug_upgrade_remington_recoil" .. i,
			title_id = "debug_r870_shotgun_short",
			subtitle_id = "debug_upgrade_recoil" .. i,
			icon = "r870_shotgun",
			image = "upgrades_remington",
			image_slice = "upgrades_remington_slice",
			description_text_id = "recoil_multiplier",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "r870_shotgun",
				upgrade = "recoil_multiplier",
				value = i
			}
		}
	end
	for i, _ in ipairs(self.values.r870_shotgun.damage_multiplier) do
		local depends_on = i - 1 > 0 and "remington_fire_rate_multiplier" .. i - 1 or "r870_shotgun"
		local unlock_lvl = 4
		local prio = i == 1 and "high"
		self.definitions["remington_fire_rate_multiplier" .. i] = {
			tree = 3,
			step = self.steps.r870_shotgun.damage_multiplier[i],
			category = "feature",
			name_id = "debug_upgrade_remington_damage" .. i,
			title_id = "debug_r870_shotgun_short",
			subtitle_id = "debug_upgrade_damage" .. i,
			icon = "r870_shotgun",
			image = "upgrades_remington",
			image_slice = "upgrades_remington_slice",
			description_text_id = "damage_multiplier",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "r870_shotgun",
				upgrade = "fire_rate_multiplier",
				value = i
			}
		}
	end
end

function UpgradesTweakData:_hk21_definitions()
	self.definitions.hk21 = {
		tree = 1,
		step = 22,
		category = "weapon",
		weapon_id = "hk21",
		unit_name = Idstring("units/weapons/hk21/hk21"),
		name_id = "debug_hk21",
		title_id = "debug_upgrade_new_weapon",
		subtitle_id = "debug_hk21_short",
		icon = "hk21",
		image = "upgrades_hk21",
		image_slice = "upgrades_hk21_slice",
		unlock_lvl = 140,
		prio = "high",
		description_text_id = "des_hk21"
	}
	for i, _ in ipairs(self.values.hk21.clip_ammo_increase) do
		local depends_on = i - 1 > 0 and "hk21_mag" .. i - 1 or "hk21"
		local unlock_lvl = 141
		local prio = i == 1 and "high"
		self.definitions["hk21_mag" .. i] = {
			tree = 1,
			step = self.steps.hk21.clip_ammo_increase[i],
			category = "feature",
			name_id = "debug_upgrade_hk21_mag" .. i,
			title_id = "debug_hk21_short",
			subtitle_id = "debug_upgrade_mag" .. i,
			icon = "hk21",
			image = "upgrades_hk21",
			image_slice = "upgrades_hk21_slice",
			description_text_id = "clip_ammo_increase",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "hk21",
				upgrade = "clip_ammo_increase",
				value = i
			}
		}
	end
	for i, _ in ipairs(self.values.hk21.recoil_multiplier) do
		local depends_on = i - 1 > 0 and "hk21_recoil" .. i - 1 or "hk21"
		local unlock_lvl = 141
		local prio = i == 1 and "high"
		self.definitions["hk21_recoil" .. i] = {
			tree = 1,
			step = self.steps.hk21.recoil_multiplier[i],
			category = "feature",
			name_id = "debug_upgrade_hk21_recoil" .. i,
			title_id = "debug_hk21_short",
			subtitle_id = "debug_upgrade_recoil" .. i,
			icon = "hk21",
			image = "upgrades_hk21",
			image_slice = "upgrades_hk21_slice",
			description_text_id = "recoil_multiplier",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "hk21",
				upgrade = "recoil_multiplier",
				value = i
			}
		}
	end
	for i, _ in ipairs(self.values.hk21.damage_multiplier) do
		local depends_on = i - 1 > 0 and "hk21_enter_steelsight_speed" .. i - 1 or "hk21"
		local unlock_lvl = 141
		local prio = i == 1 and "high"
		self.definitions["hk21_enter_steelsight_speed" .. i] = {
			tree = 1,
			step = self.steps.hk21.damage_multiplier[i],
			category = "feature",
			name_id = "debug_upgrade_hk21_damage" .. i,
			title_id = "debug_hk21_short",
			subtitle_id = "debug_upgrade_enter_steelsight_speed" .. i,
			icon = "hk21",
			image = "upgrades_hk21",
			image_slice = "upgrades_hk21_slice",
			description_text_id = "enter_steelsight_speed_multiplier",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "hk21",
				upgrade = "enter_steelsight_speed_multiplier",
				value = i
			}
		}
	end
end