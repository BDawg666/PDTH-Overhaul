local WeaponTweakData = module:hook_class("WeaponTweakData")

module:pre_hook(WeaponTweakData, "init", function(self)
	-- ease looping through player weapons
	self.weapon_list = {
		"beretta92",
		"c45",
		"raging_bull",
		"glock",
		"r870_shotgun",
		"m4",
		"m14",
		"hk21",
		"ak47",
		"mossberg",
		"mp5",
		"mac11",
		"m79",
	}
end)

module:hook(WeaponTweakData, "_init_data_b9s_overhaul", function(self)
	self.beretta92.firerate_mult = 1
	self.beretta92.reload_speed = 1
	self.beretta92.can_shoot_through_shield = true
	self.beretta92.DAMAGE = 1.8
	self.beretta92.damage_melee = 1
	self.beretta92.damage_melee_effect_mul = 1
	self.beretta92.CLIP_AMMO_MAX = 20
	self.beretta92.AMMO_MAX = 40
	self.beretta92.AMMO_PICKUP = { 1, 3 }
	self.beretta92.spread.standing = 0.9
	self.beretta92.spread.crouching = 0.6
	self.beretta92.spread.steelsight = 0.4
	self.beretta92.spread.moving_standing = 2.25
	self.beretta92.spread.moving_crouching = 1.5
	self.beretta92.spread.moving_steelsight = 1
	self.beretta92.crosshair.standing.offset = 0.09
	self.beretta92.crosshair.standing.moving_offset = 0.225
	self.beretta92.crosshair.standing.kick_offset = 0.0
	self.beretta92.crosshair.crouching.offset = 0.06
	self.beretta92.crosshair.crouching.moving_offset = 0.15
	self.beretta92.crosshair.crouching.kick_offset = 0.0
	self.beretta92.kick.v.standing = 0.72
	self.beretta92.kick.v.crouching = 0.54
	self.beretta92.kick.v.steelsight = 0.36
	self.beretta92.ads_speed = 1.5
end)

module:hook(WeaponTweakData, "_init_data_crosskill_overhaul", function(self)
	self.c45.firerate_mult = 1
	self.c45.reload_speed = 1
	self.c45.DAMAGE = 2.4
	self.c45.damage_melee = 1
	self.c45.damage_melee_effect_mul = 1
	self.c45.CLIP_AMMO_MAX = 14
	self.c45.AMMO_MAX = 60
	self.c45.AMMO_PICKUP = { 2, 4 }
	self.c45.spread.standing = 1.05
	self.c45.spread.crouching = 0.75
	self.c45.spread.steelsight = 0.4
	self.c45.spread.moving_standing = 2.62
	self.c45.spread.moving_crouching = 1.87
	self.c45.spread.moving_steelsight = 1
	self.c45.crosshair.standing.offset = 0.105
	self.c45.crosshair.standing.moving_offset = 0.262
	self.c45.crosshair.standing.kick_offset = 0.0
	self.c45.crosshair.crouching.offset = 0.075
	self.c45.crosshair.crouching.moving_offset = 0.187
	self.c45.crosshair.crouching.kick_offset = 0.0
	self.c45.kick.v.standing = 2.25
	self.c45.kick.v.crouching = 1.8
	self.c45.kick.v.steelsight = 1.35
	self.c45.kick.h.standing = 0.9
	self.c45.kick.h.crouching = 0.6
	self.c45.kick.h.steelsight = 0.3
	self.c45.ads_speed = 1.5
end)

module:hook(WeaponTweakData, "_init_data_raging_bull_overhaul", function(self)
	self.raging_bull.firerate_mult = 1
	self.raging_bull.reload_speed = 1.2
	self.raging_bull.DAMAGE = 4.8
	self.raging_bull.damage_melee = 1
	self.raging_bull.damage_melee_effect_mul = 1
	self.raging_bull.AMMO_MAX = 30
	self.raging_bull.AMMO_PICKUP = { 1, 3 }
	self.raging_bull.spread.standing = 1
	self.raging_bull.spread.crouching = 0.69
	self.raging_bull.spread.steelsight = 0.35
	self.raging_bull.spread.moving_standing = 2.62
	self.raging_bull.spread.moving_crouching = 1.95
	self.raging_bull.spread.moving_steelsight = 0.875
	self.raging_bull.crosshair.standing.offset = 0.1
	self.raging_bull.crosshair.standing.moving_offset = 0.262
	self.raging_bull.crosshair.standing.kick_offset = 0.0
	self.raging_bull.crosshair.crouching.offset = 0.069
	self.raging_bull.crosshair.crouching.moving_offset = 0.195
	self.raging_bull.crosshair.crouching.kick_offset = 0.0
	self.raging_bull.kick.v.standing = 3.7
	self.raging_bull.kick.v.crouching = 3.2
	self.raging_bull.kick.v.steelsight = 2.7
	self.raging_bull.kick.h.standing = 1
	self.raging_bull.kick.h.crouching = 0.75
	self.raging_bull.kick.h.steelsight = 0.5
	self.raging_bull.ads_speed = 1.5
end)

module:hook(WeaponTweakData, "_init_data_glock_overhaul", function(self)
	self.glock.muzzleflash = "effects/particles/weapons/c45/muzzleflash"
	self.glock.firerate_mult = 1
	self.glock.reload_speed = 1.2
	self.glock.DAMAGE = 1.2
	self.glock.damage_melee = 1
	self.glock.damage_melee_effect_mul = 1
	self.glock.CLIP_AMMO_MAX = 20
	self.glock.AMMO_MAX = 120
	self.glock.AMMO_PICKUP = { 4, 6 }
	self.glock.spread.standing = 1.57
	self.glock.spread.crouching = 1.12
	self.glock.spread.steelsight = 0.6
	self.glock.spread.moving_standing = 3.92
	self.glock.spread.moving_crouching = 2.8
	self.glock.spread.moving_steelsight = 1.5
	self.glock.crosshair.standing.offset = 0.157
	self.glock.crosshair.standing.moving_offset = 0.392
	self.glock.crosshair.standing.kick_offset = 0.0
	self.glock.crosshair.crouching.offset = 0.112
	self.glock.crosshair.crouching.moving_offset = 0.28
	self.glock.crosshair.crouching.kick_offset = 0.0
	self.glock.kick.v.standing = 0.67
	self.glock.kick.v.crouching = 0.6
	self.glock.kick.v.steelsight = 0.52
	self.glock.kick.h.standing = 0.4
	self.glock.kick.h.crouching = 0.36
	self.glock.kick.h.steelsight = 0.31
	self.glock.ads_speed = 1.5
end)

module:hook(WeaponTweakData, "_init_data_amcar_overhaul", function(self)
	self.test_raycast_weapon.firerate_mult = 1
	self.test_raycast_weapon.reload_speed = 1
	self.test_raycast_weapon.DAMAGE = 2.4
	self.test_raycast_weapon.damage_melee = 2
	self.test_raycast_weapon.damage_melee_effect_mul = 2
	self.test_raycast_weapon.CLIP_AMMO_MAX = 30
	self.test_raycast_weapon.AMMO_MAX = 120
	self.test_raycast_weapon.AMMO_PICKUP = { 2, 4 }
	self.test_raycast_weapon.spread.standing = 0.8
	self.test_raycast_weapon.spread.crouching = 0.57
	self.test_raycast_weapon.spread.steelsight = 0.2
	self.test_raycast_weapon.spread.moving_standing = 4
	self.test_raycast_weapon.spread.moving_crouching = 2.85
	self.test_raycast_weapon.spread.moving_steelsight = 1
	self.test_raycast_weapon.crosshair.standing.offset = 0.08
	self.test_raycast_weapon.crosshair.standing.moving_offset = 0.4
	self.test_raycast_weapon.crosshair.standing.kick_offset = 0.0
	self.test_raycast_weapon.crosshair.crouching.offset = 0.057
	self.test_raycast_weapon.crosshair.crouching.moving_offset = 0.285
	self.test_raycast_weapon.crosshair.crouching.kick_offset = 0.0
	self.test_raycast_weapon.kick.v.standing = 1.12
	self.test_raycast_weapon.kick.v.crouching = 0.9
	self.test_raycast_weapon.kick.v.steelsight = 0.562
	self.test_raycast_weapon.kick.h.standing = 0.45
	self.test_raycast_weapon.kick.h.crouching = 0.3
	self.test_raycast_weapon.kick.h.steelsight = 0.15
	self.test_raycast_weapon.ads_speed = 1

	self.m4 = deep_clone(self.test_raycast_weapon)
end)

module:hook(WeaponTweakData, "_init_data_brenner_overhaul", function(self)
	self.hk21.firerate_mult = 1 -- higher = faster, only for shotguns
	self.hk21.reload_speed = 1 -- higher = faster
	self.hk21.DAMAGE = 3.6
	self.hk21.damage_melee = 2.5
	self.hk21.damage_melee_effect_mul = 2.5
	self.hk21.CLIP_AMMO_MAX = 90
	self.hk21.AMMO_MAX = 160
	self.hk21.AMMO_PICKUP = { 1, 4 }
	self.hk21.spread.standing = 3.2
	self.hk21.spread.crouching = 1.6
	self.hk21.spread.steelsight = 0.4
	self.hk21.spread.moving_standing = 9
	self.hk21.spread.moving_crouching = 6
	self.hk21.spread.moving_steelsight = 2
	self.hk21.crosshair.standing.offset = 0.32
	self.hk21.crosshair.standing.moving_offset = 0.9
	self.hk21.crosshair.standing.kick_offset = 0.0
	self.hk21.crosshair.crouching.offset = 0.16
	self.hk21.crosshair.crouching.moving_offset = 0.6
	self.hk21.crosshair.crouching.kick_offset = 0.0
	self.hk21.kick.v.standing = 1.35
	self.hk21.kick.v.crouching = 1.12
	self.hk21.kick.v.steelsight = 0.9
	self.hk21.kick.h.standing = 1.08
	self.hk21.kick.h.crouching = 0.9
	self.hk21.kick.h.steelsight = 0.675
	self.hk21.ads_speed = 0.5

	self.hk21.movement_speed_multiplier = 0.8 -- 80% movement speed
	self.hk21.fall_damage_multiplier = 1.5 -- 50% extra fall damage
end)

module:hook(WeaponTweakData, "_init_data_m308_overhaul", function(self)
	self.m14.firerate_mult = 1
	self.m14.reload_speed = 1
	self.m14.DAMAGE = 4.8
	self.m14.damage_melee = 2
	self.m14.damage_melee_effect_mul = 2
	self.m14.CLIP_AMMO_MAX = 16
	self.m14.AMMO_MAX = 60
	self.m14.AMMO_PICKUP = { 1, 3 }
	self.m14.spread.standing = 0.44
	self.m14.spread.crouching = 0.33
	self.m14.spread.steelsight = 0.08
	self.m14.spread.moving_standing = 3.96
	self.m14.spread.moving_crouching = 2.97
	self.m14.spread.moving_steelsight = 0.72
	self.m14.crosshair.standing.offset = 0.044
	self.m14.crosshair.standing.moving_offset = 0.396
	self.m14.crosshair.standing.kick_offset = 0.0
	self.m14.crosshair.crouching.offset = 0.033
	self.m14.crosshair.crouching.moving_offset = 0.297
	self.m14.crosshair.crouching.kick_offset = 0.0
	self.m14.kick.v.standing = 3.15
	self.m14.kick.v.crouching = 2.02
	self.m14.kick.v.steelsight = 1.8
	self.m14.kick.h.standing = 0.27
	self.m14.kick.h.crouching = 0.21
	self.m14.kick.h.steelsight = 0.15
	self.m14.ads_speed = 1
end)

module:hook(WeaponTweakData, "_init_data_reinbeck_overhaul", function(self)
	self.r870_shotgun.firerate_mult = 1.25
	self.r870_shotgun.reload_speed = 1
	self.r870_shotgun.DAMAGE = 8.4
	self.r870_shotgun.damage_melee = 2
	self.r870_shotgun.damage_melee_effect_mul = 2
	self.r870_shotgun.CLIP_AMMO_MAX = 10
	self.r870_shotgun.AMMO_MAX = 30
	self.r870_shotgun.AMMO_PICKUP = { 1, 1 }
	self.r870_shotgun.single.fire_rate = 1.0
	self.r870_shotgun.spread.moving_steelsight = self.r870_shotgun.spread.steelsight
	self.r870_shotgun.crosshair.standing.offset = 0.4
	self.r870_shotgun.crosshair.standing.moving_offset = 0.4
	self.r870_shotgun.crosshair.standing.kick_offset = 0.0
	self.r870_shotgun.crosshair.crouching.offset = 0.4
	self.r870_shotgun.crosshair.crouching.moving_offset = 0.4
	self.r870_shotgun.crosshair.crouching.kick_offset = 0.0
	self.r870_shotgun.kick.v.standing = 3.6
	self.r870_shotgun.kick.v.crouching = 2.7
	self.r870_shotgun.kick.v.steelsight = 2.25
	self.r870_shotgun.kick.h.standing = 0.42
	self.r870_shotgun.kick.h.crouching = 0.36
	self.r870_shotgun.kick.h.steelsight = 0.3
	self.r870_shotgun.ads_speed = 1
end)

module:hook(WeaponTweakData, "_init_data_ak47_overhaul", function(self)
	self.ak47.firerate_mult = 1
	self.ak47.reload_speed = 1
	self.ak47.DAMAGE = 3.6
	self.ak47.damage_melee = 2
	self.ak47.damage_melee_effect_mul = 2
	self.ak47.CLIP_AMMO_MAX = 35
	self.ak47.AMMO_MAX = 80
	self.ak47.AMMO_PICKUP = { 1, 4 }
	self.ak47.auto.fire_rate = 0.08
	self.ak47.spread.standing = 1.38
	self.ak47.spread.crouching = 1.03
	self.ak47.spread.steelsight = 0.3
	self.ak47.spread.moving_standing = 6.9
	self.ak47.spread.moving_crouching = 5.17
	self.ak47.spread.moving_steelsight = 1.5
	self.ak47.crosshair.standing.offset = 0.138
	self.ak47.crosshair.standing.moving_offset = 0.69
	self.ak47.crosshair.standing.kick_offset = 0.0
	self.ak47.crosshair.crouching.offset = 0.103
	self.ak47.crosshair.crouching.moving_offset = 0.517
	self.ak47.crosshair.crouching.kick_offset = 0.0
	self.ak47.kick.v.standing = 1.35
	self.ak47.kick.v.crouching = 1.05
	self.ak47.kick.v.steelsight = 0.75
	self.ak47.kick.h.standing = 0.82
	self.ak47.kick.h.crouching = 0.72
	self.ak47.kick.h.steelsight = 0.54
	self.ak47.ads_speed = 1
end)

module:hook(WeaponTweakData, "_init_data_mark11_overhaul", function(self)
	self.mac11.firerate_mult = 1
	self.mac11.reload_speed = 1
	self.mac11.DAMAGE = 2.4
	self.mac11.damage_melee = 1
	self.mac11.damage_melee_effect_mul = 1
	self.mac11.CLIP_AMMO_MAX = 54
	self.mac11.AMMO_MAX = 90
	self.mac11.AMMO_PICKUP = { 2, 4 }
	self.mac11.spread.standing = 2.02
	self.mac11.spread.crouching = 1.57
	self.mac11.spread.steelsight = 0.5
	self.mac11.spread.moving_standing = 8.4
	self.mac11.spread.moving_crouching = 6.59
	self.mac11.spread.moving_steelsight = 2.1
	self.mac11.crosshair.standing.offset = 0.202
	self.mac11.crosshair.standing.moving_offset = 0.84
	self.mac11.crosshair.standing.kick_offset = 0.0
	self.mac11.crosshair.crouching.offset = 0.157
	self.mac11.crosshair.crouching.moving_offset = 0.659
	self.mac11.crosshair.crouching.kick_offset = 0.0
	self.mac11.kick.v.standing = 1.86
	self.mac11.kick.v.crouching = 1.51
	self.mac11.kick.v.steelsight = 1.18
	self.mac11.kick.h.standing = 0.81
	self.mac11.kick.h.crouching = 0.675
	self.mac11.kick.h.steelsight = 0.54
	self.mac11.ads_speed = 1.25
end)

module:hook(WeaponTweakData, "_init_data_locomotive_overhaul", function(self)
	self.mossberg.firerate_mult = 1.6
	self.mossberg.reload_speed = 1.2
	self.mossberg.DAMAGE = 8.4
	self.mossberg.damage_melee_effect_mul = 1.5
	self.mossberg.damage_near = 300
	self.mossberg.damage_far = 2100
	self.mossberg.CLIP_AMMO_MAX = 6
	self.mossberg.AMMO_MAX = 22
	self.mossberg.AMMO_PICKUP = { 1, 1 }
	self.mossberg.spread.moving_steelsight = self.mossberg.spread.steelsight
	self.mossberg.crosshair.standing.offset = 0.5
	self.mossberg.crosshair.standing.moving_offset = 0.5
	self.mossberg.crosshair.standing.kick_offset = 0.0
	self.mossberg.crosshair.crouching.offset = 0.5
	self.mossberg.crosshair.crouching.moving_offset = 0.5
	self.mossberg.crosshair.crouching.kick_offset = 0.0
	self.mossberg.kick.v.standing = 4.4
	self.mossberg.kick.v.crouching = 3.6
	self.mossberg.kick.v.steelsight = 3.3
	self.mossberg.kick.h.standing = 0.5
	self.mossberg.kick.h.crouching = 0.44
	self.mossberg.kick.h.steelsight = 0.38
	self.mossberg.ads_speed = 1.25
end)

module:hook(WeaponTweakData, "_init_data_mp5_overhaul", function(self)
	self.mp5.firerate_mult = 1
	self.mp5.reload_speed = 1.4
	self.mp5.DAMAGE = 1.8
	self.mp5.damage_melee_effect_mul = 1.5
	self.mp5.AMMO_MAX = 120
	self.mp5.AMMO_PICKUP = { 3, 5 }
	self.mp5.spread.standing = 0.945
	self.mp5.spread.crouching = 0.63
	self.mp5.spread.steelsight = 0.35
	self.mp5.spread.moving_standing = 3.96
	self.mp5.spread.moving_crouching = 2.64
	self.mp5.spread.moving_steelsight = 1.47
	self.mp5.crosshair.standing.offset = 0.0945
	self.mp5.crosshair.standing.moving_offset = 0.396
	self.mp5.crosshair.standing.kick_offset = 0.0
	self.mp5.crosshair.crouching.offset = 0.063
	self.mp5.crosshair.crouching.moving_offset = 0.264
	self.mp5.crosshair.crouching.kick_offset = 0.0
	self.mp5.kick.v.standing = 0.78
	self.mp5.kick.v.crouching = 0.65
	self.mp5.kick.v.steelsight = 0.39
	self.mp5.kick.h.standing = 0.367
	self.mp5.kick.h.crouching = 0.315
	self.mp5.kick.h.steelsight = 0.21
	self.mp5.ads_speed = 1.25
end)

module:hook(WeaponTweakData, "_init_data_gl40_overhaul", function(self)
	self.m79.firerate_mult = 1
	self.m79.reload_speed = 1
	self.m79.DAMAGE = 56
	self.m79.damage_melee = 2
	self.m79.damage_melee_effect_mul = 2
	self.m79.AMMO_MAX = 6
	self.m79.spread.moving_steelsight = 0.2
	self.m79.kick.v.standing = 5.25
	self.m79.kick.v.crouching = 4.8
	self.m79.kick.v.steelsight = 4.8
	self.m79.kick.h.steelsight = 0.35
	self.m79.EXPLOSION_RANGE = 600
	self.m79.ads_speed = 1
end)

module:hook(WeaponTweakData, "_init_data_no_antishield", function(self)
end)

module:hook(WeaponTweakData, "_init_data_no_crosshairs", function(self)
end)

module:hook(WeaponTweakData, "_init_data_limited_arsenal", function(self)
end)

module:hook(WeaponTweakData, "_init_data_per_pellet", function(self)
end)

module:post_hook(WeaponTweakData, "_init_data_player_weapons", function(self)
	self:_init_data_b9s_overhaul()
	self:_init_data_crosskill_overhaul()
	self:_init_data_raging_bull_overhaul()
	self:_init_data_glock_overhaul()
	self:_init_data_amcar_overhaul()
	self:_init_data_brenner_overhaul()
	self:_init_data_m308_overhaul()
	self:_init_data_reinbeck_overhaul()
	self:_init_data_ak47_overhaul()
	self:_init_data_mark11_overhaul()
	self:_init_data_locomotive_overhaul()
	self:_init_data_mp5_overhaul()
	self:_init_data_gl40_overhaul()

	self:_init_data_no_crosshairs()
	self:_init_data_per_pellet()
	self:_init_data_no_antishield()
	self:_init_data_limited_arsenal()

	self.trip_mines.damage = 160
end, false)
