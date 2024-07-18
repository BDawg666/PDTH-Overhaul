local CharacterTweakData = module:hook_class("CharacterTweakData")

function CharacterTweakData:_set_easy()
	self:_multiply_all_hp(1, 1)
	self:_multiply_weapon_delay(self.presets.weapon.normal, 5)
	self:_multiply_weapon_delay(self.presets.weapon.good, 1.5)
	self:_multiply_weapon_delay(self.presets.weapon.expert, 0.75)
	self:_multiply_weapon_delay(self.presets.weapon.sniper, 3)
	self:_multiply_weapon_delay(self.presets.weapon.gang_member, 1.5)
	self.presets.gang_member_damage.MIN_DAMAGE_INTERVAL = 0.35
	self.presets.gang_member_damage.REGENERATE_TIME = 2.5
	self.presets.gang_member_damage.REGENERATE_TIME_AWAY = 0.75
end

function CharacterTweakData:_set_normal()
	self:_multiply_all_hp(1.5, 1.5)
	self:_multiply_weapon_delay(self.presets.weapon.normal, 3)
	self:_multiply_weapon_delay(self.presets.weapon.good, 1)
	self:_multiply_weapon_delay(self.presets.weapon.expert, 0.5)
	self:_multiply_weapon_delay(self.presets.weapon.sniper, 2)
	self:_multiply_weapon_delay(self.presets.weapon.gang_member, 0.5)
	self.presets.gang_member_damage.MIN_DAMAGE_INTERVAL = 0.3
	self.presets.gang_member_damage.REGENERATE_TIME = 2.75
	self.presets.gang_member_damage.REGENERATE_TIME_AWAY = 0.9
	self.tank.damage.visor_health = 55
end

function CharacterTweakData:_set_hard()
	self:_multiply_all_hp(1.5, 1.5)
	self:_multiply_weapon_delay(self.presets.weapon.normal, 3)
	self:_multiply_weapon_delay(self.presets.weapon.good, 1)
	self:_multiply_weapon_delay(self.presets.weapon.expert, 0.5)
	self:_multiply_weapon_delay(self.presets.weapon.sniper, 2)
	self:_multiply_weapon_delay(self.presets.weapon.gang_member, 0.5)
	self.presets.gang_member_damage.MIN_DAMAGE_INTERVAL = 0.25
	self.presets.gang_member_damage.REGENERATE_TIME = 2.75
	self.presets.gang_member_damage.REGENERATE_TIME_AWAY = 0.9
	self.tank.damage.visor_health = 55
end

function CharacterTweakData:_set_overkill()
	self:_multiply_all_hp(2, 1.55)
	self:_multiply_all_speeds(1.05, 1.15)
	self:_multiply_weapon_delay(self.presets.weapon.normal, 2)
	self:_multiply_weapon_delay(self.presets.weapon.good, 0.5)
	self:_multiply_weapon_delay(self.presets.weapon.expert, 0.25)
	self:_multiply_weapon_delay(self.presets.weapon.sniper, 1)
	self:_multiply_weapon_delay(self.presets.weapon.gang_member, 0.25)
	self.presets.gang_member_damage.MIN_DAMAGE_INTERVAL = 0.2
	self.tank.damage.visor_health = 69
end

function CharacterTweakData:_set_overkill_145()
	self:_multiply_all_hp(2, 1.55)
	self:_multiply_all_speeds(1.05, 1.15)
	self:_multiply_weapon_delay(self.presets.weapon.normal, 2)
	self:_multiply_weapon_delay(self.presets.weapon.good, 0.5)
	self:_multiply_weapon_delay(self.presets.weapon.expert, 0.25)
	self:_multiply_weapon_delay(self.presets.weapon.sniper, 1)
	self:_multiply_weapon_delay(self.presets.weapon.gang_member, 0.25)
	self.presets.gang_member_damage.MIN_DAMAGE_INTERVAL = 0.15
	self.tank.damage.visor_health = 69
end

module:post_hook(CharacterTweakData, "_init_spanish", function(self, presets)
	self.spanish.SPEED_WALK = 215
	self.spanish.SPEED_RUN = 400
end, false)

module:post_hook(CharacterTweakData, "_init_german", function(self, presets)
	self.german.SPEED_WALK = 215
	self.german.SPEED_RUN = 400
end, false)

module:post_hook(CharacterTweakData, "_init_russian", function(self, presets)
	self.russian.SPEED_WALK = 215
	self.russian.SPEED_RUN = 400
end, false)

module:post_hook(CharacterTweakData, "_init_american", function(self, presets)
	self.american.SPEED_WALK = 215
	self.american.SPEED_RUN = 400
end, false)

module:post_hook(CharacterTweakData, "_init_fbi", function(self, presets)
	self.fbi.weapon = presets.weapon.expert
	self.fbi.HEALTH_INIT = 4
	self.fbi.headshot_dmg_mul = 3
	self.fbi.dodge = presets.dodge.ninja
	self.fbi.weapon.c45.FALLOFF[1].dmg_mul = 1.5
	self.fbi.weapon.c45.FALLOFF[2].dmg_mul = 1.5
	self.fbi.weapon.c45.FALLOFF[3].dmg_mul = 1.5
	self.fbi.weapon.m4.FALLOFF[1].dmg_mul = 1.5
	self.fbi.weapon.m4.FALLOFF[2].dmg_mul = 1.5
	self.fbi.weapon.m4.FALLOFF[3].dmg_mul = 1.5
	self.fbi.weapon.mp5.FALLOFF[1].dmg_mul = 1.5
	self.fbi.weapon.mp5.FALLOFF[2].dmg_mul = 1.5
	self.fbi.weapon.mp5.FALLOFF[3].dmg_mul = 1.5
	self.fbi.weapon.r870.FALLOFF[1].dmg_mul = 2
	self.fbi.weapon.r870.FALLOFF[2].dmg_mul = 1.5
	self.fbi.weapon.r870.FALLOFF[3].dmg_mul = 0.75
end, false)

module:post_hook(CharacterTweakData, "_init_swat", function(self, presets)
	self.swat.HEALTH_INIT = 4.5
	self.swat.rescue_hostages = false
	self.swat.dodge = presets.dodge.expert
end, false)

module:post_hook(CharacterTweakData, "_init_heavy_swat", function(self, presets)
	self.heavy_swat.rescue_hostages = false
	self.heavy_swat.dodge = presets.dodge.good
end, false)

module:post_hook(CharacterTweakData, "_init_murky", function(self, presets)
	self.murky.weapon_voice = "1" --hk21 sfx fix
end, false)

module:post_hook(CharacterTweakData, "_init_tank", function(self, presets)
	self.tank.damage.visor_health = 53
	self.tank.headshot_dmg_mul = 23
end, false)

module:post_hook(CharacterTweakData, "_init_civilian", function(self, presets)
	self.civilian.HEALTH_INIT = 2
	self.civilian.scare_shot = 0
end, false)

module:post_hook(CharacterTweakData, "_init_bank_manager", function(self, presets)
	self.bank_manager.HEALTH_INIT = 1
end, false)

module:post_hook(CharacterTweakData, "_init_gangster", function(self, presets)
	self.gangster.weapon.r870.FALLOFF[2].dmg_mul = 0.5 -- affects mossberg
	self.gangster.weapon.r870.FALLOFF[3].dmg_mul = 0.3
	self.gangster.weapon.r870.FALLOFF[4].dmg_mul = 0.1
end, false)

module:post_hook(CharacterTweakData, "_init_dealer", function(self, presets)
	self.dealer.weapon.r870.FALLOFF[2].dmg_mul = 0.5
	self.dealer.weapon.r870.FALLOFF[3].dmg_mul = 0.3
	self.dealer.weapon.r870.FALLOFF[4].dmg_mul = 0.1
end, false)

module:hook(50, CharacterTweakData, "_presets", function(self, tweak_data)
	local presets = module:call_orig(CharacterTweakData, "_presets", self, tweak_data)

	-- nerf shotgun reaction times
	presets.weapon.normal.r870.aim_delay = { 0, 0.2 }
	presets.weapon.good.r870.aim_delay = { 0, 0.2 }
	presets.weapon.expert.r870.aim_delay = { 0, 0.2 }
	presets.weapon.gang_member.r870.aim_delay = { 0, 0.2 }

	-- not sure if these actually do anything but whatever
	presets.weapon.normal.glock = deep_clone(presets.weapon.normal.mp5)
	presets.weapon.good.glock = deep_clone(presets.weapon.good.mp5)
	presets.weapon.expert.glock = deep_clone(presets.weapon.expert.mp5)
	presets.weapon.gang_member.glock = deep_clone(presets.weapon.gang_member.mp5)

	presets.weapon.normal.ak47 = deep_clone(presets.weapon.normal.m4)
	presets.weapon.good.ak47 = deep_clone(presets.weapon.good.m4)
	presets.weapon.expert.ak47 = deep_clone(presets.weapon.expert.m4)
	presets.weapon.gang_member.ak47 = deep_clone(presets.weapon.gang_member.m4)

	presets.weapon.normal.bronco = deep_clone(presets.weapon.normal.c45)
	presets.weapon.good.bronco = deep_clone(presets.weapon.good.c45)
	
	presets.weapon.expert.hk21 = deep_clone(presets.weapon.expert.m4)

	presets.weapon.good.mossberg = deep_clone(presets.weapon.good.r870)

	-- presets for AI heisters, these do work
	-- beretta92 still applies even if their actual pistol is switched to Bronco
	presets.gang_member_damage.HEALTH_INIT = 55
	presets.gang_member_damage.REGENERATE_TIME = 3
	presets.gang_member_damage.REGENERATE_TIME_AWAY = 1

	presets.weapon.gang_member.beretta92 = deep_clone(presets.weapon.expert.c45)
	presets.weapon.gang_member.beretta92.RELOAD_SPEED = 1
	presets.weapon.gang_member.beretta92.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = { 0.25, 0.35 },
			mode = { 1, 3, 1, 0 },
		},
		{
			r = 700,
			dmg_mul = 2,
			recoil = { 0.25, 0.35 },
			mode = { 1, 3, 1, 0 },
		},
		{
			r = 3000,
			dmg_mul = 1.5,
			recoil = { 0.25, 0.35 },
			mode = { 1, 3, 1, 0 },
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = { 1.5, 3 },
			mode = { 1, 0, 0, 0 },
		},
	}
	presets.weapon.gang_member.m4 = deep_clone(presets.weapon.expert.m4)
	presets.weapon.gang_member.m4.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = { 0.25, 0.45 },
			mode = { 0.2, 2, 4, 10 },
		},
		{
			r = 700,
			dmg_mul = 2,
			recoil = { 0.25, 0.45 },
			mode = { 0.2, 2, 4, 10 },
		},
		{
			r = 3000,
			dmg_mul = 1.5,
			recoil = { 0.25, 0.45 },
			mode = { 0.2, 2, 4, 10 },
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = { 1.1, 2.2 },
			mode = { 2, 1, 0, 0 },
		},
	}
	presets.weapon.gang_member.mp5 = deep_clone(presets.weapon.expert.mp5)
	presets.weapon.gang_member.mp5.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = { 0.35, 0.55 },
			mode = { 0.2, 2, 4, 10 },
		},
		{
			r = 700,
			dmg_mul = 2,
			recoil = { 0.35, 0.55 },
			mode = { 0.2, 2, 4, 10 },
		},
		{
			r = 3000,
			dmg_mul = 1.5,
			recoil = { 0.35, 0.55 },
			mode = { 0.2, 2, 4, 10 },
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = { 1.5, 3.1 },
			mode = { 3, 1, 0, 0 },
		},
	}

	return presets
end, false)

module:post_hook(CharacterTweakData, "_create_table_structure", function(self)
	for id, data in pairs({
		glock = { folder = "glock_npc", unit = "glock_18_npc" },
		bronco = { folder = "raging_bull_npc", unit = "raging_bull_npc" },
		mossberg = { folder = "mossberg_npc", unit = "mossberg_npc" },
		ak47 = { folder = "ak47_npc", unit = "ak47_npc" },
		hk21 = { folder = "hk21_npc", unit = "hk21_npc" },
	}) do
		table.insert(self.weap_ids, id)
		table.insert(self.weap_unit_names, Idstring(string.format("units/weapons/%s/%s", data.folder, data.unit)))
	end
end, false)