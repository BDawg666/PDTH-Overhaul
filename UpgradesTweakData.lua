local UpgradesTweakData = module:hook_class("UpgradesTweakData")

module:post_hook(UpgradesTweakData, "init", function(self)
	self.values.player.body_armor = {
		0,
		0,
		0,
		0,
		0
	}
	self.values.player.thick_skin = {
		10,
		10,
		10,
		10,
		10
	}
	self.values.player.extra_ammo_multiplier = {
		1.5,
		1.5,
		1.5,
		1.5,
		1.5
	}
	self.values.player.toolset = {
		0.5,
		0.5,
		0.5,
		0.5
	}
	self.values.trip_mine.quantity = {
		10,
		10,
		10,
		10,
		10,
		10
	}
	self.values.trip_mine.damage_multiplier = {1, 1}
	self.ammo_bag_base = 10
	self.values.ammo_bag.ammo_increase = {
		0,
		0,
		0
	}
	self.sentry_gun_base_ammo = 800
	self.sentry_gun_base_armor = 10
	self.values.sentry_gun.ammo_increase = {
		0,
		0,
		0,
		0
	}
	self.values.sentry_gun.armor_increase = {
		0,
		0,
		0,
		0
	}
	self.doctor_bag_base = 5
	self.values.doctor_bag.amount_increase = {
		0,
		0,
		0
	}
	self.values.extra_cable_tie.quantity = {
		18,
		18,
		18,
		18
	}
	self.values.c45.clip_ammo_increase = {0, 0}
	self.values.c45.recoil_multiplier = {
		1,
		1,
		1,
		1
	}
	self.values.c45.damage_multiplier = {
		1,
		1,
		1,
		1
	}
	self.values.beretta92.clip_ammo_increase = {0, 0}
	self.values.beretta92.recoil_multiplier = {
		1,
		1,
		1,
		1
	}
	self.values.beretta92.spread_multiplier = {1, 1}
	self.values.raging_bull.spread_multiplier = {
		1,
		1,
		1,
		1
	}
	--self.values.raging_bull.reload_speed_multiplier = {1, 1}
	self.values.raging_bull.damage_multiplier = {
		1,
		1,
		1,
		1
	}
	self.values.m4.clip_ammo_increase = {0, 0}
	self.values.m4.spread_multiplier = {
		1,
		1,
		1,
		1
	}
	self.values.m4.damage_multiplier = {1, 1}
	self.values.m14.clip_ammo_increase = {0, 0}
	self.values.m14.recoil_multiplier = {
		1,
		1,
		1,
		1
	}
	self.values.m14.spread_multiplier = {1, 1}
	self.values.m14.damage_multiplier = {1, 1}
	self.values.r870_shotgun.clip_ammo_increase = {0, 0}
	self.values.r870_shotgun.recoil_multiplier = {
		1,
		1,
		1,
		1
	}
	self.values.r870_shotgun.damage_multiplier = {
		1,
		1,
		1,
		1
	}
	self.values.mossberg.clip_ammo_increase = {0, 0}
	--To do, not in weapontweakdata
	--self.values.mossberg.reload_speed_multiplier = {1.1, 1.2}
	--
	--self.values.mossberg.fire_rate_multiplier = {
		--1,
		--1,
		--1,
		--1
	--}
	self.values.mossberg.recoil_multiplier = {1, 1}
	self.values.mp5.recoil_multiplier = {1, 1}
	self.values.mp5.spread_multiplier = {1, 1}
	--self.values.mp5.reload_speed_multiplier = {
		--1,
		--1,
		--1,
		--1
	--}
	--To do, not in weapontweakdata
	--self.values.mp5.enter_steelsight_speed_multiplier = {1.5, 1.8}
	--
	self.values.mac11.clip_ammo_increase = {
		0,
		0,
		0,
		0
	}
	self.values.mac11.recoil_multiplier = {
		1,
		1,
		1,
		1
	}
	--To do, not in weapontweakdata
	--self.values.mac11.enter_steelsight_speed_multiplier = {1.1, 1.2}
	--
	self.values.hk21.clip_ammo_increase = {
		0,
		0,
		0,
		0
	}
	self.values.hk21.recoil_multiplier = {1, 1}
	self.values.hk21.damage_multiplier = {
		1,
		1,
		1,
		1
	}
	self.values.ak47.spread_multiplier = {1, 1}
	self.values.ak47.recoil_multiplier = {
		1,
		1,
		1,
		1
	}
	self.values.ak47.damage_multiplier = {
		1,
		1,
		1,
		1
	}
	self.values.ak47.clip_ammo_increase = {0, 0}
	self.values.glock.recoil_multiplier = {1, 1}
	self.values.glock.clip_ammo_increase = {
		0,
		0,
		0,
		0
	}
	self.values.glock.damage_multiplier = {1, 1}
	--self.values.glock.reload_speed_multiplier = {1, 1}
	self.values.m79.damage_multiplier = {
		1,
		1,
		1,
		1
	}
	self.values.m79.explosion_range_multiplier = {1, 1}
	self.values.m79.clip_amount_increase = {0, 0}
end, false)