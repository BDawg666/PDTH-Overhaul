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
	self.values.beretta92.spread_multiplier = { 1, 1 }
	self.values.beretta92.recoil_multiplier = { 1, 1, 1, 1 }

	self.values.c45.clip_ammo_increase = { 0, 0 }
	self.values.c45.recoil_multiplier = { 1, 1, 1, 1 }
	self.values.c45.damage_multiplier = { 1, 1, 1, 1 }

	self.values.raging_bull.spread_multiplier = { 1, 1, 1, 1 }
	self.values.raging_bull.damage_multiplier = { 1, 1, 1, 1 }

	self.values.glock.recoil_multiplier = { 1, 1 }
	self.values.glock.clip_ammo_increase = { 0, 0, 0, 0 }
	self.values.glock.damage_multiplier = { 1, 1 }
end)

module:hook(UpgradesTweakData, "init_data_primary_overhaul", function(self)
	self.values.m4.clip_ammo_increase = { 0, 0 }
	self.values.m4.spread_multiplier = { 1, 1, 1, 1 }
	self.values.m4.damage_multiplier = { 1, 1 }

	self.values.hk21.clip_ammo_increase = { 0, 0, 0, 0 }
	self.values.hk21.damage_multiplier = { 1, 1, 1, 1 }
	self.values.hk21.recoil_multiplier = { 1, 1 }

	self.values.m14.clip_ammo_increase = { 0, 0 }
	self.values.m14.recoil_multiplier = { 1, 1, 1, 1 }
	self.values.m14.spread_multiplier = { 1, 1 }
	self.values.m14.damage_multiplier = { 1, 1 }

	self.values.r870_shotgun.clip_ammo_increase = { 0, 0 }
	self.values.r870_shotgun.recoil_multiplier = { 1, 1, 1, 1 }
	self.values.r870_shotgun.damage_multiplier = { 1, 1, 1, 1 }

	self.values.ak47.spread_multiplier = { 1, 1 }
	self.values.ak47.recoil_multiplier = { 1, 1, 1, 1 }
	self.values.ak47.damage_multiplier = { 1, 1, 1, 1 }
	self.values.ak47.clip_ammo_increase = { 0, 0 }
end)

module:hook(UpgradesTweakData, "init_data_secondary_overhaul", function(self)
	self.values.mac11.clip_ammo_increase = { 0, 0, 0, 0 }
	self.values.mac11.recoil_multiplier = { 1, 1, 1, 1 }

	self.values.mossberg.clip_ammo_increase = { 0, 0 }
	self.values.mossberg.recoil_multiplier = { 1, 1 }

	self.values.mp5.recoil_multiplier = { 1, 1 }
	self.values.mp5.spread_multiplier = { 1, 1 }

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