local UpgradesTweakData = module:hook_class("UpgradesTweakData")
module:hook(UpgradesTweakData, "init_data_player_overhaul", function(self)
	self.values.player.body_armor = { 0, 0, 0, 0, 0 }

	self.values.extra_cable_tie.quantity = { 18, 18, 18, 18 }
	self.values.player.thick_skin = { 10, 10, 10, 10, 10 }
	self.values.player.extra_ammo_multiplier = { 1.25, 1.25, 1.25, 1.25, 1.25 }
	self.values.player.toolset = { 0.6, 0.6, 0.6, 0.6 }
	self.values.crew_bonus.more_ammo = { 1.1 }
end)

module:hook(UpgradesTweakData, "init_data_deployable_overhaul", function(self)
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
module:hook(UpgradesTweakData, "init_data_handguns_overhaul", function(self)
	self.values.beretta92.clip_ammo_increase = { 0, 0 }
	self.values.beretta92.recoil_multiplier = { 1, 1, 1, 1 }
	self.values.beretta92.enter_steelsight_speed_multiplier = { 1.5, 1.5 }

	self.values.c45.clip_ammo_increase = { 0, 0 }
	self.values.c45.recoil_multiplier = { 1, 1, 1, 1 }
	self.values.c45.enter_steelsight_speed_multiplier = { 1.5, 1.5, 1.5, 1.5 }

	self.values.raging_bull.spread_multiplier = { 1, 1, 1, 1 }
	self.values.raging_bull.enter_steelsight_speed_multiplier = { 1.5, 1.5, 1.5, 1.5 }

	self.values.glock.recoil_multiplier = { 1, 1 }
	self.values.glock.clip_ammo_increase = { 0, 0, 0, 0 }
	self.values.glock.enter_steelsight_speed_multiplier = { 1.5, 1.5 }
end)

module:hook(UpgradesTweakData, "init_data_primary_overhaul", function(self)
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

	self.values.ak47.spread_multiplier = { 1, 1 }
	self.values.ak47.recoil_multiplier = { 1, 1, 1, 1 }
	self.values.ak47.damage_multiplier = { 1, 1, 1, 1 }
	self.values.ak47.clip_ammo_increase = { 0, 0 }
end)

module:hook(UpgradesTweakData, "init_data_secondary_overhaul", function(self)
	self.values.mac11.clip_ammo_increase = { 0, 0, 0, 0 }
	self.values.mac11.recoil_multiplier = { 1, 1, 1, 1 }
	self.values.mac11.enter_steelsight_speed_multiplier = { 1.25, 1.25 }

	self.values.mossberg.clip_ammo_increase = { 0, 0 }
	self.values.mossberg.enter_steelsight_speed_multiplier = { 1.25, 1.25 }

	self.values.mp5.recoil_multiplier = { 1, 1 }
	self.values.mp5.spread_multiplier = { 1, 1 }
	self.values.mp5.enter_steelsight_speed_multiplier = { 1.25, 1.25 }

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

module:hook(UpgradesTweakData, "_hk21_definitions", function(self)
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
		description_text_id = "des_hk21",
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
				value = i,
			},
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
				value = i,
			},
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
				value = i,
			},
		}
	end
end)

module:hook(UpgradesTweakData, "_raging_bull_definitions", function(self)
	self.definitions.raging_bull = {
		tree = 3,
		step = 6,
		category = "weapon",
		weapon_id = "raging_bull",
		unit_name = Idstring("units/weapons/raging_bull/raging_bull"),
		name_id = "debug_raging_bull",
		title_id = "debug_upgrade_new_weapon",
		subtitle_id = "debug_raging_bull_short",
		icon = "raging_bull",
		image = "upgrades_ragingbull",
		image_slice = "upgrades_ragingbull_slice",
		unlock_lvl = 60,
		prio = "high",
		description_text_id = "des_raging_bull",
	}
	for i, _ in ipairs(self.values.raging_bull.spread_multiplier) do
		local depends_on = i - 1 > 0 and "raging_bull_spread" .. i - 1
		local unlock_lvl = 61
		local prio = i == 1 and "high"
		self.definitions["raging_bull_spread" .. i] = {
			tree = 3,
			step = self.steps.raging_bull.spread_multiplier[i],
			category = "feature",
			name_id = "debug_upgrade_raging_bull_spread" .. i,
			title_id = "debug_raging_bull_short",
			subtitle_id = "debug_upgrade_spread" .. i,
			icon = "raging_bull",
			image = "upgrades_ragingbull",
			image_slice = "upgrades_ragingbull_slice",
			description_text_id = "spread_multiplier",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "raging_bull",
				upgrade = "spread_multiplier",
				value = i,
			},
		}
	end
	for i, _ in ipairs(self.values.raging_bull.reload_speed_multiplier) do
		local depends_on = i - 1 > 0 and "raging_bull_reload_speed" .. i - 1 or "raging_bull"
		local unlock_lvl = 61
		local prio = i == 1 and "high"
		self.definitions["raging_bull_reload_speed" .. i] = {
			tree = 3,
			step = self.steps.raging_bull.reload_speed_multiplier[i],
			category = "feature",
			name_id = "debug_upgrade_raging_bull_reload_speed" .. i,
			title_id = "debug_raging_bull_short",
			subtitle_id = "debug_upgrade_reload_speed" .. i,
			icon = "raging_bull",
			image = "upgrades_ragingbull",
			image_slice = "upgrades_ragingbull_slice",
			description_text_id = "reload_speed_multiplier",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "raging_bull",
				upgrade = "reload_speed_multiplier",
				value = i,
			},
		}
	end
	for i, _ in ipairs(self.values.raging_bull.damage_multiplier) do
		local depends_on = i - 1 > 0 and "raging_bull_enter_steelsight_speed" .. i - 1 or "raging_bull"
		local unlock_lvl = 61
		local prio = i == 1 and "high"
		self.definitions["raging_bull_enter_steelsight_speed" .. i] = {
			tree = 3,
			step = self.steps.raging_bull.damage_multiplier[i],
			category = "feature",
			name_id = "debug_upgrade_raging_bull_damage" .. i,
			title_id = "debug_raging_bull_short",
			subtitle_id = "debug_upgrade_enter_steelsight_speed" .. i,
			icon = "raging_bull",
			image = "upgrades_ragingbull",
			image_slice = "upgrades_ragingbull_slice",
			description_text_id = "enter_steelsight_speed_multiplier",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "raging_bull",
				upgrade = "enter_steelsight_speed_multiplier",
				value = i,
			},
		}
	end
end)

module:hook(UpgradesTweakData, "_c45_definitions", function(self)
	self.definitions.c45 = {
		tree = 1,
		step = 13,
		category = "weapon",
		unit_name = Idstring("units/weapons/c45/c45"),
		name_id = "debug_c45",
		title_id = "debug_upgrade_new_weapon",
		subtitle_id = "debug_c45_short",
		icon = "c45",
		image = "upgrades_45",
		image_slice = "upgrades_45_slice",
		unlock_lvl = 30,
		prio = "high",
		description_text_id = "des_c45",
	}
	for i, _ in ipairs(self.values.c45.clip_ammo_increase) do
		local depends_on = i - 1 > 0 and "c45_mag" .. i - 1 or "c45"
		local unlock_lvl = 31
		local prio = i == 1 and "high"
		self.definitions["c45_mag" .. i] = {
			tree = 1,
			step = self.steps.c45.clip_ammo_increase[i],
			category = "feature",
			name_id = "debug_upgrade_c45_mag" .. i,
			title_id = "debug_c45_short",
			subtitle_id = "debug_upgrade_mag" .. i,
			icon = "c45",
			image = "upgrades_45",
			image_slice = "upgrades_45_slice",
			description_text_id = "clip_ammo_increase",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "c45",
				upgrade = "clip_ammo_increase",
				value = i,
			},
		}
	end
	for i, _ in ipairs(self.values.c45.recoil_multiplier) do
		local depends_on = i - 1 > 0 and "c45_recoil" .. i - 1 or "c45"
		local unlock_lvl = 31
		local prio = i == 1 and "high"
		self.definitions["c45_recoil" .. i] = {
			tree = 1,
			step = self.steps.c45.recoil_multiplier[i],
			category = "feature",
			name_id = "debug_upgrade_c45_recoil" .. i,
			title_id = "debug_c45_short",
			subtitle_id = "debug_upgrade_recoil" .. i,
			icon = "c45",
			image = "upgrades_45",
			image_slice = "upgrades_45_slice",
			description_text_id = "recoil_multiplier",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "c45",
				upgrade = "recoil_multiplier",
				value = i,
			},
		}
	end
	for i, _ in ipairs(self.values.c45.damage_multiplier) do
		local depends_on = i - 1 > 0 and "c45_enter_steelsight_speed" .. i - 1 or "c45"
		local unlock_lvl = 31
		local prio = i == 1 and "high"
		self.definitions["c45_enter_steelsight_speed" .. i] = {
			tree = 1,
			step = self.steps.c45.damage_multiplier[i],
			category = "feature",
			name_id = "debug_upgrade_c45_damage" .. i,
			title_id = "debug_c45_short",
			subtitle_id = "debug_upgrade_enter_steelsight_speed" .. i,
			icon = "c45",
			image = "upgrades_45",
			image_slice = "upgrades_45_slice",
			description_text_id = "enter_steelsight_speed_multiplier",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "c45",
				upgrade = "enter_steelsight_speed_multiplier",
				value = i,
			},
		}
	end
end)

module:hook(UpgradesTweakData, "_glock_definitions", function(self)
	self.definitions.glock = {
		tree = 4,
		step = 2,
		category = "weapon",
		weapon_id = "glock",
		unit_name = Idstring("units/weapons/glock/glock"),
		name_id = "debug_glock",
		title_id = "debug_upgrade_new_weapon",
		subtitle_id = "debug_glock_short",
		icon = "glock",
		image = "upgrades_glock",
		image_slice = "upgrades_glock_slice",
		unlock_lvl = 0,
		prio = "high",
		description_text_id = "des_glock",
	}
	for i, _ in ipairs(self.values.glock.damage_multiplier) do
		local depends_on = 0 < i - 1 and "glock_enter_steelsight_speed" .. i - 1 or "glock"
		local unlock_lvl = 141
		local prio = i == 1 and "high"
		self.definitions["glock_enter_steelsight_speed" .. i] = {
			tree = 4,
			step = self.steps.glock.damage_multiplier[i],
			category = "feature",
			name_id = "debug_upgrade_glock_damage" .. i,
			title_id = "debug_glock_short",
			subtitle_id = "debug_upgrade_enter_steelsight_speed" .. i,
			icon = "glock",
			image = "upgrades_glock",
			image_slice = "upgrades_glock_slice",
			description_text_id = "enter_steelsight_speed_multiplier",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "glock",
				upgrade = "enter_steelsight_speed_multiplier",
				value = i,
			},
		}
	end
	for i, _ in ipairs(self.values.glock.recoil_multiplier) do
		local depends_on = 0 < i - 1 and "glock_recoil" .. i - 1 or "glock"
		local unlock_lvl = 141
		local prio = i == 1 and "high"
		self.definitions["glock_recoil" .. i] = {
			tree = 4,
			step = self.steps.glock.recoil_multiplier[i],
			category = "feature",
			name_id = "debug_upgrade_glock_recoil" .. i,
			title_id = "debug_glock_short",
			subtitle_id = "debug_upgrade_recoil" .. i,
			icon = "glock",
			image = "upgrades_glock",
			image_slice = "upgrades_glock_slice",
			description_text_id = "recoil_multiplier",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "glock",
				upgrade = "recoil_multiplier",
				value = i,
			},
		}
	end
	for i, _ in ipairs(self.values.glock.clip_ammo_increase) do
		local depends_on = 0 < i - 1 and "glock_mag" .. i - 1 or "glock"
		local unlock_lvl = 141
		local prio = i == 1 and "high"
		self.definitions["glock_mag" .. i] = {
			tree = 4,
			step = self.steps.glock.clip_ammo_increase[i],
			category = "feature",
			name_id = "debug_upgrade_glock_mag" .. i,
			title_id = "debug_glock_short",
			subtitle_id = "debug_upgrade_mag" .. i,
			icon = "glock",
			image = "upgrades_glock",
			image_slice = "upgrades_glock_slice",
			description_text_id = "clip_ammo_increase",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "glock",
				upgrade = "clip_ammo_increase",
				value = i,
			},
		}
	end
	for i, _ in ipairs(self.values.glock.reload_speed_multiplier) do
		local depends_on = 0 < i - 1 and "glock_reload_speed" .. i - 1 or "glock"
		local unlock_lvl = 141
		local prio = i == 1 and "high"
		self.definitions["glock_reload_speed" .. i] = {
			tree = 4,
			step = self.steps.glock.reload_speed_multiplier[i],
			category = "feature",
			name_id = "debug_upgrade_glock_reload_speed" .. i,
			title_id = "debug_glock_short",
			subtitle_id = "debug_upgrade_reload_speed" .. i,
			icon = "glock",
			image = "upgrades_glock",
			image_slice = "upgrades_glock_slice",
			description_text_id = "reload_speed_multiplier",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "glock",
				upgrade = "reload_speed_multiplier",
				value = i,
			},
		}
	end
end)

module:hook(UpgradesTweakData, "_beretta92_definitions", function(self)
	self.definitions.beretta92 = {
		category = "weapon",
		weapon_id = "beretta92",
		unit_name = Idstring("units/weapons/beretta92/beretta92"),
		name_id = "debug_beretta92",
		title_id = "debug_upgrade_new_weapon",
		subtitle_id = "debug_beretta92_short",
		icon = "beretta92",
		image = "upgrades_m9sd",
		image_slice = "upgrades_m9sd_slice",
		unlock_lvl = 0,
		prio = "high",
		description_text_id = "des_beretta92",
	}
	for i, _ in ipairs(self.values.beretta92.clip_ammo_increase) do
		local depends_on = 0 < i - 1 and "beretta_mag" .. i - 1 or "beretta92"
		local unlock_lvl = 2
		local prio = i == 1 and "high"
		self.definitions["beretta_mag" .. i] = {
			tree = 1,
			step = self.steps.beretta92.clip_ammo_increase[i],
			category = "feature",
			name_id = "debug_upgrade_beretta_mag" .. i,
			title_id = "debug_beretta92_short",
			subtitle_id = "debug_upgrade_mag" .. i,
			icon = "beretta92",
			image = "upgrades_m9sd",
			image_slice = "upgrades_m9sd_slice",
			description_text_id = "clip_ammo_increase",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "beretta92",
				upgrade = "clip_ammo_increase",
				value = i,
			},
		}
	end
	for i, _ in ipairs(self.values.beretta92.recoil_multiplier) do
		local depends_on = 0 < i - 1 and "beretta_recoil" .. i - 1 or "beretta92"
		local unlock_lvl = 2
		local prio = i == 1 and "high"
		self.definitions["beretta_recoil" .. i] = {
			tree = 2,
			step = self.steps.beretta92.recoil_multiplier[i],
			category = "feature",
			name_id = "debug_upgrade_beretta_recoil" .. i,
			title_id = "debug_beretta92_short",
			subtitle_id = "debug_upgrade_recoil" .. i,
			icon = "beretta92",
			image = "upgrades_m9sd",
			image_slice = "upgrades_m9sd_slice",
			description_text_id = "recoil_multiplier",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "beretta92",
				upgrade = "recoil_multiplier",
				value = i,
			},
		}
	end
	for i, _ in ipairs(self.values.beretta92.spread_multiplier) do
		local depends_on = 0 < i - 1 and "beretta_enter_steelsight_speed" .. i - 1 or "beretta92"
		local unlock_lvl = 2
		local prio = i == 1 and "high"
		self.definitions["beretta_enter_steelsight_speed" .. i] = {
			tree = 3,
			step = self.steps.beretta92.spread_multiplier[i],
			category = "feature",
			name_id = "debug_upgrade_beretta_spread" .. i,
			title_id = "debug_beretta92_short",
			subtitle_id = "debug_upgrade_enter_steelsight_speed" .. i,
			icon = "beretta92",
			image = "upgrades_m9sd",
			image_slice = "upgrades_m9sd_slice",
			description_text_id = "enter_steelsight_speed_multiplier",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "beretta92",
				upgrade = "enter_steelsight_speed_multiplier",
				value = i,
			},
		}
	end
end)

module:hook(UpgradesTweakData, "_mossberg_definitions", function(self)
	self.definitions.mossberg = {
		tree = 2,
		step = 7,
		category = "weapon",
		weapon_id = "mossberg",
		unit_name = Idstring("units/weapons/mossberg/mossberg"),
		name_id = "debug_mossberg",
		title_id = "debug_upgrade_new_weapon",
		subtitle_id = "debug_mossberg_short",
		icon = "mossberg",
		image = "upgrades_mossberg",
		image_slice = "upgrades_mossberg_slice",
		unlock_lvl = 120,
		prio = "high",
		description_text_id = "des_mossberg",
	}
	for i, _ in ipairs(self.values.mossberg.clip_ammo_increase) do
		local depends_on = i - 1 > 0 and "mossberg_mag" .. i - 1 or "mossberg"
		local unlock_lvl = 121
		local prio = i == 1 and "high"
		self.definitions["mossberg_mag" .. i] = {
			tree = 2,
			step = self.steps.mossberg.clip_ammo_increase[i],
			category = "feature",
			name_id = "debug_upgrade_mossberg_mag" .. i,
			title_id = "debug_mossberg_short",
			subtitle_id = "debug_upgrade_mag" .. i,
			icon = "mossberg",
			image = "upgrades_mossberg",
			image_slice = "upgrades_mossberg_slice",
			description_text_id = "clip_ammo_increase",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "mossberg",
				upgrade = "clip_ammo_increase",
				value = i,
			},
		}
	end
	for i, _ in ipairs(self.values.mossberg.reload_speed_multiplier) do
		local depends_on = i - 1 > 0 and "mossberg_reload_speed" .. i - 1 or "mossberg"
		local unlock_lvl = 121
		local prio = i == 1 and "high"
		self.definitions["mossberg_reload_speed" .. i] = {
			tree = 2,
			step = self.steps.mossberg.reload_speed_multiplier[i],
			category = "feature",
			name_id = "debug_upgrade_mossberg_reload_speed" .. i,
			title_id = "debug_mossberg_short",
			subtitle_id = "debug_upgrade_reload_speed" .. i,
			icon = "mossberg",
			image = "upgrades_mossberg",
			image_slice = "upgrades_mossberg_slice",
			description_text_id = "reload_speed_multiplier",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "mossberg",
				upgrade = "reload_speed_multiplier",
				value = i,
			},
		}
	end
	for i, _ in ipairs(self.values.mossberg.fire_rate_multiplier) do
		local depends_on = i - 1 > 0 and "mossberg_fire_rate_multiplier" .. i - 1 or "mossberg"
		local unlock_lvl = 121
		local prio = i == 1 and "high"
		self.definitions["mossberg_fire_rate_multiplier" .. i] = {
			tree = 2,
			step = self.steps.mossberg.fire_rate_multiplier[i],
			category = "feature",
			name_id = "debug_upgrade_mossberg_fire_rate" .. i,
			title_id = "debug_mossberg_short",
			subtitle_id = "debug_upgrade_fire_rate" .. i,
			icon = "mossberg",
			image = "upgrades_mossberg",
			image_slice = "upgrades_mossberg_slice",
			description_text_id = "fire_rate_multiplier",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "mossberg",
				upgrade = "fire_rate_multiplier",
				value = i,
			},
		}
	end
	for i, _ in ipairs(self.values.mossberg.recoil_multiplier) do
		local depends_on = i - 1 > 0 and "mossberg_enter_steelsight_speed" .. i - 1 or "mossberg"
		local unlock_lvl = 121
		local prio = i == 1 and "high"
		self.definitions["mossberg_enter_steelsight_speed" .. i] = {
			tree = 2,
			step = self.steps.mossberg.recoil_multiplier[i],
			category = "feature",
			name_id = "debug_upgrade_mossberg_recoil_multiplier" .. i,
			title_id = "debug_mossberg_short",
			subtitle_id = "debug_upgrade_enter_steelsight_speed" .. i,
			icon = "mossberg",
			image = "upgrades_mossberg",
			image_slice = "upgrades_mossberg_slice",
			description_text_id = "enter_steelsight_speed_multiplier",
			depends_on = depends_on,
			unlock_lvl = unlock_lvl,
			prio = prio,
			upgrade = {
				category = "mossberg",
				upgrade = "enter_steelsight_speed_multiplier",
				value = i,
			},
		}
	end
end)
