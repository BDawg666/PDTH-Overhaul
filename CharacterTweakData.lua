local module = DorHUD:module('fgo')
local CharacterTweakData = module:hook_class("CharacterTweakData")

function CharacterTweakData:_set_easy()
	self:_multiply_all_hp(1, 1)
	self:_multiply_weapon_delay(self.presets.weapon.normal, 5)
	self:_multiply_weapon_delay(self.presets.weapon.good, 1.5)
	self:_multiply_weapon_delay(self.presets.weapon.expert, 0.75)
	self:_multiply_weapon_delay(self.presets.weapon.sniper, 3)
	self:_multiply_weapon_delay(self.presets.weapon.gang_member, 1.5)
	self.presets.gang_member_damage.REGENERATE_TIME = 2
	self.presets.gang_member_damage.REGENERATE_TIME_AWAY = 1
end

function CharacterTweakData:_set_normal()
	self:_multiply_all_hp(1.5, 1.5)
	self:_multiply_weapon_delay(self.presets.weapon.normal, 3)
	self:_multiply_weapon_delay(self.presets.weapon.good, 1)
	self:_multiply_weapon_delay(self.presets.weapon.expert, 0.5)
	self:_multiply_weapon_delay(self.presets.weapon.sniper, 2)
	self:_multiply_weapon_delay(self.presets.weapon.gang_member, 0.5)
	self.presets.gang_member_damage.REGENERATE_TIME = 2.5
	self.presets.gang_member_damage.REGENERATE_TIME_AWAY = 1.4
end

function CharacterTweakData:_set_hard()
	self:_multiply_all_hp(1.5, 1.5)
	self:_multiply_weapon_delay(self.presets.weapon.normal, 3)
	self:_multiply_weapon_delay(self.presets.weapon.good, 1)
	self:_multiply_weapon_delay(self.presets.weapon.expert, 0.5)
	self:_multiply_weapon_delay(self.presets.weapon.sniper, 2)
	self:_multiply_weapon_delay(self.presets.weapon.gang_member, 0.5)
	self.presets.gang_member_damage.REGENERATE_TIME = 2.5
	self.presets.gang_member_damage.REGENERATE_TIME_AWAY = 1.4
end

function CharacterTweakData:_set_overkill()
	self:_multiply_all_hp(2, 1.55)
	self:_multiply_all_speeds(1.05, 1.15)
	self:_multiply_weapon_delay(self.presets.weapon.normal, 2)
	self:_multiply_weapon_delay(self.presets.weapon.good, 0.5)
	self:_multiply_weapon_delay(self.presets.weapon.expert, 0.25)
	self:_multiply_weapon_delay(self.presets.weapon.sniper, 1)
	self:_multiply_weapon_delay(self.presets.weapon.gang_member, 0.25)
	self.presets.gang_member_damage.REGENERATE_TIME = 2.5
	self.presets.gang_member_damage.REGENERATE_TIME_AWAY = 1.4
end

function CharacterTweakData:_set_overkill_145()
	self:_multiply_all_hp(2, 1.55)
	self:_multiply_all_speeds(1.05, 1.15)
	self:_multiply_weapon_delay(self.presets.weapon.normal, 2)
	self:_multiply_weapon_delay(self.presets.weapon.good, 0.5)
	self:_multiply_weapon_delay(self.presets.weapon.expert, 0.25)
	self:_multiply_weapon_delay(self.presets.weapon.sniper, 1)
	self:_multiply_weapon_delay(self.presets.weapon.gang_member, 0.25)
	self.presets.gang_member_damage.REGENERATE_TIME = 2.5
	self.presets.gang_member_damage.REGENERATE_TIME_AWAY = 1.4
end

module:post_hook(CharacterTweakData, "_init_spanish", function(self, presets)
	self.spanish.SPEED_WALK = 215
	self.spanish.SPEED_RUN = 340
end, false)

module:post_hook(CharacterTweakData, "_init_german", function(self, presets)
	self.german.SPEED_WALK = 215
	self.german.SPEED_RUN = 340
end, false)

module:post_hook(CharacterTweakData, "_init_russian", function(self, presets)
	self.russian.SPEED_WALK = 215
	self.russian.SPEED_RUN = 340
end, false)

--Copied whole function because I'm too lazy to figure out how to post hook it properly, fixed shotguns aim delay being 0.02 instead of 0.2
function CharacterTweakData:_presets(tweak_data)
	local presets = {}
	presets.base = {}
	presets.base.HEALTH_INIT = 2
	presets.base.headshot_dmg_mul = 2
	presets.base.SPEED_WALK = 130
	presets.base.SPEED_RUN = 370
	presets.base.crouch_move = true
	presets.base.allow_crouch = true
	presets.base.shooting_death = true
	presets.base.surrender_hard = true
	presets.base.suspicious = true
	presets.base.submission_max = {45, 60}
	presets.base.submission_intimidate = 15
	presets.base.weapon_range = 1400
	presets.base.speech_prefix = "po"
	presets.base.speech_prefix_count = 1
	presets.base.use_smoke = true
	presets.base.rescue_hostages = true
	presets.base.use_radio = "dispatch_generic_message"
	presets.base.dodge = nil
	presets.base.challenges = {type = "law"}
	presets.base.experience = {}
	presets.base.experience.cable_tie = "tie_swat"
	presets.base.damage = {}
	presets.base.damage.hurt_severity = {
		0,
		0.2,
		0.5,
		0.75
	}
	presets.base.damage.death_severity = 0.5
	presets.gang_member_damage = {}
	presets.gang_member_damage.HEALTH_INIT = 75
	presets.gang_member_damage.REGENERATE_TIME = 2
	presets.gang_member_damage.REGENERATE_TIME_AWAY = 0.2
	presets.gang_member_damage.DOWNED_TIME = tweak_data.player.damage.DOWNED_TIME
	presets.gang_member_damage.TASED_TIME = tweak_data.player.damage.TASED_TIME
	presets.gang_member_damage.BLEED_OUT_HEALTH_INIT = tweak_data.player.damage.BLEED_OUT_HEALTH_INIT
	presets.gang_member_damage.ARRESTED_TIME = tweak_data.player.damage.ARRESTED_TIME
	presets.gang_member_damage.INCAPACITATED_TIME = tweak_data.player.damage.INCAPACITATED_TIME
	presets.gang_member_damage.hurt_severity = {
		0.1,
		0.12,
		0.14,
		0.16
	}
	presets.gang_member_damage.MIN_DAMAGE_INTERVAL = 0
	presets.gang_member_damage.respawn_time_penalty = 0
	presets.gang_member_damage.base_respawn_time_penalty = 5
	presets.weapon = {}
	presets.weapon.normal = {
		beretta92 = {},
		c45 = {},
		m4 = {},
		r870 = {},
		mp5 = {},
		mac11 = {}
	}
	presets.weapon.normal.beretta92.aim_delay = {0, 0.2}
	presets.weapon.normal.beretta92.focus_delay = 1
	presets.weapon.normal.beretta92.focus_dis = 2000
	presets.weapon.normal.beretta92.spread = 25
	presets.weapon.normal.beretta92.miss_dis = 20
	presets.weapon.normal.beretta92.hit_chance = {
		near = {0.1, 0.6},
		far = {0, 0.1}
	}
	presets.weapon.normal.beretta92.RELOAD_SPEED = 1.5
	presets.weapon.normal.beretta92.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {0.25, 0.35},
			mode = {
				2,
				1,
				0,
				0
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {0.25, 0.35},
			mode = {
				2,
				1,
				0,
				0
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.25, 0.35},
			mode = {
				2,
				1,
				0,
				0
			}
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = {2, 5},
			mode = {
				1,
				0,
				0,
				0
			}
		}
	}
	presets.weapon.normal.c45.aim_delay = {0, 0.2}
	presets.weapon.normal.c45.focus_delay = 1
	presets.weapon.normal.c45.focus_dis = 2000
	presets.weapon.normal.c45.spread = 25
	presets.weapon.normal.c45.miss_dis = 20
	presets.weapon.normal.c45.hit_chance = {
		near = {0.1, 0.6},
		far = {0, 0.1}
	}
	presets.weapon.normal.c45.RELOAD_SPEED = 1.5
	presets.weapon.normal.c45.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {0.25, 0.35},
			mode = {
				2,
				1,
				0,
				0
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {0.25, 0.35},
			mode = {
				2,
				1,
				0,
				0
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.25, 0.35},
			mode = {
				2,
				1,
				0,
				0
			}
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = {2, 5},
			mode = {
				1,
				0,
				0,
				0
			}
		}
	}
	presets.weapon.normal.m4.aim_delay = {0, 0.2}
	presets.weapon.normal.m4.focus_delay = 1
	presets.weapon.normal.m4.focus_dis = 2000
	presets.weapon.normal.m4.spread = 15
	presets.weapon.normal.m4.miss_dis = 10
	presets.weapon.normal.m4.hit_chance = {
		near = {0.1, 0.6},
		far = {0, 0.2}
	}
	presets.weapon.normal.m4.RELOAD_SPEED = 1
	presets.weapon.normal.m4.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {0.25, 0.45},
			mode = {
				3,
				3,
				3,
				3
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {0.25, 0.45},
			mode = {
				3,
				3,
				3,
				3
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.25, 0.45},
			mode = {
				3,
				3,
				3,
				3
			}
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = {1.5, 3},
			mode = {
				2,
				1,
				0,
				0
			}
		}
	}
	presets.weapon.normal.r870.aim_delay = {0, 0.2}
	presets.weapon.normal.r870.focus_delay = 1
	presets.weapon.normal.r870.focus_dis = 2000
	presets.weapon.normal.r870.spread = 25
	presets.weapon.normal.r870.miss_dis = 10
	presets.weapon.normal.r870.hit_chance = {
		near = {0.2, 0.9},
		far = {0, 0.8}
	}
	presets.weapon.normal.r870.RELOAD_SPEED = 2
	presets.weapon.normal.r870.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {2, 2},
			mode = {
				1,
				0,
				0,
				0
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {2, 2},
			mode = {
				1,
				0,
				0,
				0
			}
		},
		{
			r = 1000,
			dmg_mul = 1,
			recoil = {2, 2},
			mode = {
				1,
				0,
				0,
				0
			}
		},
		{
			r = 4000,
			dmg_mul = 0.5,
			recoil = {2, 3},
			mode = {
				1,
				0,
				0,
				0
			}
		},
		{
			r = 10000,
			dmg_mul = 0.3,
			recoil = {2, 4},
			mode = {
				1,
				0,
				0,
				0
			}
		}
	}
	presets.weapon.normal.mp5.aim_delay = {0, 0.2}
	presets.weapon.normal.mp5.focus_delay = 1
	presets.weapon.normal.mp5.focus_dis = 2000
	presets.weapon.normal.mp5.spread = 25
	presets.weapon.normal.mp5.miss_dis = 10
	presets.weapon.normal.mp5.hit_chance = {
		near = {0.1, 0.6},
		far = {0, 0.2}
	}
	presets.weapon.normal.mp5.RELOAD_SPEED = 2
	presets.weapon.normal.mp5.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {0.35, 0.55},
			mode = {
				2,
				1,
				3,
				0
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {0.35, 0.55},
			mode = {
				2,
				1,
				3,
				0
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.35, 0.55},
			mode = {
				2,
				1,
				3,
				0
			}
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = {2, 4},
			mode = {
				3,
				1,
				0,
				0
			}
		}
	}
	presets.weapon.normal.mac11.aim_delay = {0, 0.2}
	presets.weapon.normal.mac11.focus_delay = 1
	presets.weapon.normal.mac11.focus_dis = 2000
	presets.weapon.normal.mac11.spread = 25
	presets.weapon.normal.mac11.miss_dis = 10
	presets.weapon.normal.mac11.hit_chance = {
		near = {0.1, 0.6},
		far = {0, 0.2}
	}
	presets.weapon.normal.mac11.RELOAD_SPEED = 2
	presets.weapon.normal.mac11.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {0.35, 0.55},
			mode = {
				2,
				1,
				3,
				0
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {0.35, 0.55},
			mode = {
				2,
				1,
				3,
				0
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.35, 0.55},
			mode = {
				2,
				1,
				3,
				0
			}
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = {2, 4},
			mode = {
				4,
				1,
				0,
				0
			}
		}
	}
	presets.weapon.good = {
		beretta92 = {},
		c45 = {},
		m4 = {},
		r870 = {},
		mp5 = {},
		mac11 = {}
	}
	presets.weapon.good.beretta92.aim_delay = {0, 0.2}
	presets.weapon.good.beretta92.focus_delay = 1
	presets.weapon.good.beretta92.focus_dis = 2000
	presets.weapon.good.beretta92.spread = 15
	presets.weapon.good.beretta92.miss_dis = 20
	presets.weapon.good.beretta92.hit_chance = {
		near = {0.1, 0.6},
		far = {0, 0.1}
	}
	presets.weapon.good.beretta92.RELOAD_SPEED = 1.5
	presets.weapon.good.beretta92.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {0.25, 0.35},
			mode = {
				1,
				3,
				1,
				0
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {0.25, 0.35},
			mode = {
				1,
				3,
				1,
				0
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.25, 0.35},
			mode = {
				1,
				3,
				1,
				0
			}
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = {1.6, 3.5},
			mode = {
				1,
				0,
				0,
				0
			}
		}
	}
	presets.weapon.good.c45.aim_delay = {0, 0.2}
	presets.weapon.good.c45.focus_delay = 1
	presets.weapon.good.c45.focus_dis = 2000
	presets.weapon.good.c45.spread = 15
	presets.weapon.good.c45.miss_dis = 20
	presets.weapon.good.c45.hit_chance = {
		near = {0.1, 0.6},
		far = {0, 0.1}
	}
	presets.weapon.good.c45.RELOAD_SPEED = 1.5
	presets.weapon.good.c45.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {0.25, 0.35},
			mode = {
				1,
				3,
				1,
				0
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {0.25, 0.35},
			mode = {
				1,
				3,
				1,
				0
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.25, 0.35},
			mode = {
				1,
				3,
				1,
				0
			}
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = {1.6, 3.5},
			mode = {
				1,
				0,
				0,
				0
			}
		}
	}
	presets.weapon.good.m4.aim_delay = {0, 0.2}
	presets.weapon.good.m4.focus_delay = 1
	presets.weapon.good.m4.focus_dis = 2000
	presets.weapon.good.m4.spread = 15
	presets.weapon.good.m4.miss_dis = 10
	presets.weapon.good.m4.hit_chance = {
		near = {0.1, 0.6},
		far = {0, 0.2}
	}
	presets.weapon.good.m4.RELOAD_SPEED = 1
	presets.weapon.good.m4.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {0.25, 0.45},
			mode = {
				3,
				3,
				3,
				3
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {0.25, 0.45},
			mode = {
				3,
				3,
				3,
				3
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.25, 0.45},
			mode = {
				3,
				3,
				3,
				3
			}
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = {1.2, 2.5},
			mode = {
				2,
				1,
				0,
				0
			}
		}
	}
	presets.weapon.good.r870.aim_delay = {0, 0.2}
	presets.weapon.good.r870.focus_delay = 1
	presets.weapon.good.r870.focus_dis = 2000
	presets.weapon.good.r870.spread = 15
	presets.weapon.good.r870.miss_dis = 10
	presets.weapon.good.r870.hit_chance = {
		near = {0.4, 0.9},
		far = {0, 0.9}
	}
	presets.weapon.good.r870.RELOAD_SPEED = 2
	presets.weapon.good.r870.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {2, 2},
			mode = {
				1,
				1,
				0,
				0
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {2, 2},
			mode = {
				1,
				1,
				0,
				0
			}
		},
		{
			r = 1000,
			dmg_mul = 1,
			recoil = {2, 2},
			mode = {
				1,
				1,
				0,
				0
			}
		},
		{
			r = 4000,
			dmg_mul = 0.5,
			recoil = {2, 3},
			mode = {
				1,
				0,
				0,
				0
			}
		},
		{
			r = 10000,
			dmg_mul = 0.3,
			recoil = {2, 4},
			mode = {
				1,
				0,
				0,
				0
			}
		}
	}
	presets.weapon.good.mp5.aim_delay = {0, 0.2}
	presets.weapon.good.mp5.focus_delay = 1
	presets.weapon.good.mp5.focus_dis = 2000
	presets.weapon.good.mp5.spread = 15
	presets.weapon.good.mp5.miss_dis = 10
	presets.weapon.good.mp5.hit_chance = {
		near = {0.1, 0.6},
		far = {0, 0.2}
	}
	presets.weapon.good.mp5.RELOAD_SPEED = 1.5
	presets.weapon.good.mp5.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {0.35, 0.55},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {0.35, 0.55},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.35, 0.55},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = {1.8, 3.5},
			mode = {
				3,
				1,
				0,
				0
			}
		}
	}
	presets.weapon.good.mac11.aim_delay = {0, 0.2}
	presets.weapon.good.mac11.focus_delay = 1
	presets.weapon.good.mac11.focus_dis = 2000
	presets.weapon.good.mac11.spread = 15
	presets.weapon.good.mac11.miss_dis = 10
	presets.weapon.good.mac11.hit_chance = {
		near = {0.1, 0.6},
		far = {0, 0.2}
	}
	presets.weapon.good.mac11.RELOAD_SPEED = 1.5
	presets.weapon.good.mac11.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {0.35, 0.55},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {0.35, 0.55},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.35, 0.55},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = {2, 4},
			mode = {
				4,
				1,
				0,
				0
			}
		}
	}
	presets.weapon.expert = {
		beretta92 = {},
		c45 = {},
		m4 = {},
		r870 = {},
		mp5 = {},
		mac11 = {}
	}
	presets.weapon.expert.beretta92.aim_delay = {0, 0.2}
	presets.weapon.expert.beretta92.focus_delay = 1
	presets.weapon.expert.beretta92.focus_dis = 2000
	presets.weapon.expert.beretta92.spread = 15
	presets.weapon.expert.beretta92.miss_dis = 20
	presets.weapon.expert.beretta92.hit_chance = {
		near = {0.1, 0.9},
		far = {0, 0.3}
	}
	presets.weapon.expert.beretta92.RELOAD_SPEED = 1.5
	presets.weapon.expert.beretta92.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {0.25, 0.35},
			mode = {
				1,
				3,
				1,
				0
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {0.25, 0.35},
			mode = {
				1,
				3,
				1,
				0
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.25, 0.35},
			mode = {
				1,
				3,
				1,
				0
			}
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = {1.5, 3},
			mode = {
				1,
				0,
				0,
				0
			}
		}
	}
	presets.weapon.expert.c45.aim_delay = {0, 0.2}
	presets.weapon.expert.c45.focus_delay = 1
	presets.weapon.expert.c45.focus_dis = 2000
	presets.weapon.expert.c45.spread = 15
	presets.weapon.expert.c45.miss_dis = 20
	presets.weapon.expert.c45.hit_chance = {
		near = {0.1, 0.9},
		far = {0, 0.3}
	}
	presets.weapon.expert.c45.RELOAD_SPEED = 1.5
	presets.weapon.expert.c45.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {0.25, 0.35},
			mode = {
				1,
				3,
				1,
				0
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {0.25, 0.35},
			mode = {
				1,
				3,
				1,
				0
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.25, 0.35},
			mode = {
				1,
				3,
				1,
				0
			}
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = {1.5, 3},
			mode = {
				1,
				0,
				0,
				0
			}
		}
	}
	presets.weapon.expert.m4.aim_delay = {0, 0.2}
	presets.weapon.expert.m4.focus_delay = 1
	presets.weapon.expert.m4.focus_dis = 2000
	presets.weapon.expert.m4.spread = 15
	presets.weapon.expert.m4.miss_dis = 10
	presets.weapon.expert.m4.hit_chance = {
		near = {0.1, 0.9},
		far = {0, 0.5}
	}
	presets.weapon.expert.m4.RELOAD_SPEED = 1
	presets.weapon.expert.m4.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {0.25, 0.45},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {0.25, 0.45},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.25, 0.45},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = {1.1, 2.2},
			mode = {
				2,
				1,
				0,
				0
			}
		}
	}
	presets.weapon.expert.r870.aim_delay = {0, 0.2}
	presets.weapon.expert.r870.focus_delay = 1
	presets.weapon.expert.r870.focus_dis = 2000
	presets.weapon.expert.r870.spread = 15
	presets.weapon.expert.r870.miss_dis = 10
	presets.weapon.expert.r870.hit_chance = {
		near = {0.4, 0.9},
		far = {0, 0.9}
	}
	presets.weapon.expert.r870.RELOAD_SPEED = 2
	presets.weapon.expert.r870.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {2, 2},
			mode = {
				1,
				1,
				0,
				0
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {2, 2},
			mode = {
				1,
				1,
				0,
				0
			}
		},
		{
			r = 1000,
			dmg_mul = 1,
			recoil = {2, 2},
			mode = {
				1,
				1,
				0,
				0
			}
		},
		{
			r = 2000,
			dmg_mul = 0.5,
			recoil = {2, 3},
			mode = {
				1,
				0,
				0,
				0
			}
		},
		{
			r = 10000,
			dmg_mul = 0.3,
			recoil = {2, 4},
			mode = {
				1,
				0,
				0,
				0
			}
		}
	}
	presets.weapon.expert.mp5.aim_delay = {0, 0.2}
	presets.weapon.expert.mp5.focus_delay = 1
	presets.weapon.expert.mp5.focus_dis = 2000
	presets.weapon.expert.mp5.spread = 15
	presets.weapon.expert.mp5.miss_dis = 10
	presets.weapon.expert.mp5.hit_chance = {
		near = {0.1, 0.9},
		far = {0, 0.3}
	}
	presets.weapon.expert.mp5.RELOAD_SPEED = 1.5
	presets.weapon.expert.mp5.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {0.35, 0.55},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {0.35, 0.55},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.35, 0.55},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = {1.5, 3.1},
			mode = {
				3,
				1,
				0,
				0
			}
		}
	}
	presets.weapon.expert.mac11.aim_delay = {0, 0.2}
	presets.weapon.expert.mac11.focus_delay = 1
	presets.weapon.expert.mac11.focus_dis = 2000
	presets.weapon.expert.mac11.spread = 15
	presets.weapon.expert.mac11.miss_dis = 10
	presets.weapon.expert.mac11.hit_chance = {
		near = {0.1, 0.9},
		far = {0, 0.3}
	}
	presets.weapon.expert.mac11.RELOAD_SPEED = 1.5
	presets.weapon.expert.mac11.FALLOFF = {
		{
			r = 0,
			dmg_mul = 4,
			recoil = {0.35, 0.55},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {0.35, 0.55},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.35, 0.55},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = {1.8, 3.5},
			mode = {
				4,
				1,
				0,
				0
			}
		}
	}
	presets.weapon.sniper = {
		m4 = {}
	}
	presets.weapon.sniper.m4.aim_delay = {0, 0.2}
	presets.weapon.sniper.m4.focus_delay = 1
	presets.weapon.sniper.m4.focus_dis = 10000
	presets.weapon.sniper.m4.spread = 5
	presets.weapon.sniper.m4.miss_dis = 7
	presets.weapon.sniper.m4.hit_chance = {
		near = {0.5, 1},
		far = {0.5, 1}
	}
	presets.weapon.sniper.m4.RELOAD_SPEED = 1
	presets.weapon.sniper.m4.FALLOFF = {
		{
			r = 0,
			dmg_mul = 5,
			recoil = {1, 3},
			mode = {
				1,
				1,
				1,
				1
			}
		},
		{
			r = 50000,
			dmg_mul = 5,
			recoil = {1, 3},
			mode = {
				1,
				1,
				1,
				1
			}
		}
	}
	presets.weapon.gang_member = {
		beretta92 = {},
		m4 = {},
		r870 = {},
		mp5 = {}
	}
	presets.weapon.gang_member.beretta92.aim_delay = {0, 0.2}
	presets.weapon.gang_member.beretta92.focus_delay = 1
	presets.weapon.gang_member.beretta92.focus_dis = 2000
	presets.weapon.gang_member.beretta92.spread = 15
	presets.weapon.gang_member.beretta92.miss_dis = 20
	presets.weapon.gang_member.beretta92.hit_chance = {
		near = {0.1, 0.6},
		far = {0, 0.3}
	}
	presets.weapon.gang_member.beretta92.RELOAD_SPEED = 1.5
	presets.weapon.gang_member.beretta92.FALLOFF = {
		{
			r = 0,
			dmg_mul = 1,
			recoil = {0.15, 0.25},
			mode = {
				1,
				0,
				0,
				0
			}
		},
		{
			r = 700,
			dmg_mul = 2,
			recoil = {0.15, 0.25},
			mode = {
				1,
				0,
				0,
				0
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.25, 0.35},
			mode = {
				1,
				0,
				0,
				0
			}
		},
		{
			r = 10000,
			dmg_mul = 0.3,
			recoil = {2, 3},
			mode = {
				1,
				0,
				0,
				0
			}
		}
	}
	presets.weapon.gang_member.m4.aim_delay = {0, 0.2}
	presets.weapon.gang_member.m4.focus_delay = 1
	presets.weapon.gang_member.m4.focus_dis = 2000
	presets.weapon.gang_member.m4.spread = 15
	presets.weapon.gang_member.m4.miss_dis = 10
	presets.weapon.gang_member.m4.hit_chance = {
		near = {0.1, 0.6},
		far = {0, 0.3}
	}
	presets.weapon.gang_member.m4.RELOAD_SPEED = 1
	presets.weapon.gang_member.m4.FALLOFF = {
		{
			r = 0,
			dmg_mul = 1,
			recoil = {0.25, 0.45},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 700,
			dmg_mul = 2,
			recoil = {0.25, 0.45},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.45, 0.8},
			mode = {
				1,
				5,
				5,
				4
			}
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = {1.5, 3},
			mode = {
				10,
				4,
				1,
				0
			}
		}
	}
	presets.weapon.gang_member.r870.aim_delay = {0, 0.2}
	presets.weapon.gang_member.r870.focus_delay = 1
	presets.weapon.gang_member.r870.focus_dis = 2000
	presets.weapon.gang_member.r870.spread = 15
	presets.weapon.gang_member.r870.miss_dis = 10
	presets.weapon.gang_member.r870.hit_chance = {
		near = {0.5, 0.9},
		far = {0, 0.3}
	}
	presets.weapon.gang_member.r870.RELOAD_SPEED = 2
	presets.weapon.gang_member.r870.FALLOFF = {
		{
			r = 0,
			dmg_mul = 1,
			recoil = {2, 2},
			mode = {
				1,
				0,
				0,
				0
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {2, 2},
			mode = {
				1,
				0,
				0,
				0
			}
		},
		{
			r = 1000,
			dmg_mul = 1,
			recoil = {2, 2},
			mode = {
				1,
				0,
				0,
				0
			}
		},
		{
			r = 2000,
			dmg_mul = 0.5,
			recoil = {2, 3},
			mode = {
				1,
				0,
				0,
				0
			}
		},
		{
			r = 10000,
			dmg_mul = 0.3,
			recoil = {2, 4},
			mode = {
				1,
				0,
				0,
				0
			}
		}
	}
	presets.weapon.gang_member.mp5.aim_delay = {0, 0.2}
	presets.weapon.gang_member.mp5.focus_delay = 1
	presets.weapon.gang_member.mp5.focus_dis = 2000
	presets.weapon.gang_member.mp5.spread = 15
	presets.weapon.gang_member.mp5.miss_dis = 10
	presets.weapon.gang_member.mp5.hit_chance = {
		near = {0.1, 0.6},
		far = {0, 0.3}
	}
	presets.weapon.gang_member.mp5.RELOAD_SPEED = 1.5
	presets.weapon.gang_member.mp5.FALLOFF = {
		{
			r = 0,
			dmg_mul = 1,
			recoil = {0.3, 0.5},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 700,
			dmg_mul = 1,
			recoil = {0.3, 0.5},
			mode = {
				0.2,
				2,
				4,
				10
			}
		},
		{
			r = 3000,
			dmg_mul = 1,
			recoil = {0.35, 0.55},
			mode = {
				1,
				5,
				5,
				5
			}
		},
		{
			r = 10000,
			dmg_mul = 1,
			recoil = {0.35, 0.55},
			mode = {
				10,
				3,
				0.5,
				0
			}
		}
	}
	presets.detection = {}
	presets.detection.normal = {
		idle = {},
		combat = {},
		recon = {},
		guard = {}
	}
	presets.detection.normal.idle.dis_max = 10000
	presets.detection.normal.idle.angle_max = 140
	presets.detection.normal.idle.delay = {min = 0, max = 0}
	presets.detection.normal.combat.dis_max = 10000
	presets.detection.normal.combat.angle_max = 140
	presets.detection.normal.combat.delay = {min = 0, max = 0}
	presets.detection.normal.recon.dis_max = 10000
	presets.detection.normal.recon.angle_max = 140
	presets.detection.normal.recon.delay = {min = 0, max = 0}
	presets.detection.normal.guard.dis_max = 10000
	presets.detection.normal.guard.angle_max = 140
	presets.detection.normal.guard.delay = {min = 0, max = 0}
	presets.detection.guard = {
		idle = {},
		combat = {},
		recon = {},
		guard = {}
	}
	presets.detection.guard.idle.dis_max = 6000
	presets.detection.guard.idle.angle_max = 120
	presets.detection.guard.idle.delay = {min = 0, max = 0}
	presets.detection.guard.combat.dis_max = 10000
	presets.detection.guard.combat.angle_max = 90
	presets.detection.guard.combat.delay = {min = 0, max = 0}
	presets.detection.guard.recon.dis_max = 10000
	presets.detection.guard.recon.angle_max = 120
	presets.detection.guard.recon.delay = {min = 0, max = 0}
	presets.detection.guard.guard.dis_max = 10000
	presets.detection.guard.guard.angle_max = 100
	presets.detection.guard.guard.delay = {min = 0, max = 0}
	presets.detection.sniper = {
		idle = {},
		combat = {},
		recon = {},
		guard = {}
	}
	presets.detection.sniper.idle.dis_max = 10000
	presets.detection.sniper.idle.angle_max = 180
	presets.detection.sniper.idle.delay = {min = 0, max = 0}
	presets.detection.sniper.combat.dis_max = 10000
	presets.detection.sniper.combat.angle_max = 120
	presets.detection.sniper.combat.delay = {min = 0, max = 0}
	presets.detection.sniper.recon.dis_max = 10000
	presets.detection.sniper.recon.angle_max = 120
	presets.detection.sniper.recon.delay = {min = 0, max = 0}
	presets.detection.sniper.guard.dis_max = 10000
	presets.detection.sniper.guard.angle_max = 150
	presets.detection.sniper.guard.delay = {min = 0, max = 0}
	presets.detection.gang_member = {
		idle = {},
		combat = {},
		recon = {},
		guard = {}
	}
	presets.detection.gang_member.idle.dis_max = 10000
	presets.detection.gang_member.idle.angle_max = 120
	presets.detection.gang_member.idle.delay = {min = 0, max = 0}
	presets.detection.gang_member.combat.dis_max = 10000
	presets.detection.gang_member.combat.angle_max = 120
	presets.detection.gang_member.combat.delay = {min = 0, max = 0}
	presets.detection.gang_member.recon.dis_max = 10000
	presets.detection.gang_member.recon.angle_max = 120
	presets.detection.gang_member.recon.delay = {min = 0, max = 0}
	presets.detection.gang_member.guard.dis_max = 10000
	presets.detection.gang_member.guard.angle_max = 120
	presets.detection.gang_member.guard.delay = {min = 0, max = 0}
	self:_process_weapon_usage_table(presets.weapon.normal)
	self:_process_weapon_usage_table(presets.weapon.good)
	self:_process_weapon_usage_table(presets.weapon.expert)
	self:_process_weapon_usage_table(presets.weapon.gang_member)
	presets.detection.patrol = {
		idle = {},
		combat = {},
		recon = {},
		guard = {}
	}
	presets.detection.patrol.idle.dis_max = 1100
	presets.detection.patrol.idle.angle_max = 80
	presets.detection.patrol.idle.delay = {min = 1, max = 1.5}
	presets.detection.patrol.combat.dis_max = 4000
	presets.detection.patrol.combat.angle_max = 90
	presets.detection.patrol.combat.delay = {min = 0.25, max = 0.5}
	presets.detection.patrol.recon.dis_max = 1100
	presets.detection.patrol.recon.angle_max = 80
	presets.detection.patrol.recon.delay = {min = 1, max = 1.5}
	presets.detection.patrol.guard.dis_max = 1100
	presets.detection.patrol.guard.angle_max = 80
	presets.detection.patrol.guard.delay = {min = 1, max = 1.5}
	presets.dodge = {}
	presets.dodge.poor = {
		on_hurt = {},
		on_hit = {},
		on_contact = {},
		scared = {}
	}
	presets.dodge.poor.on_hurt.chance = 0.2
	presets.dodge.poor.on_hurt.variation = {0.8, 1}
	presets.dodge.poor.on_hit.chance = 1
	presets.dodge.poor.on_hit.variation = {0.8, 1}
	presets.dodge.poor.on_contact.chance = 1
	presets.dodge.poor.on_contact.variation = {0, 1}
	presets.dodge.poor.scared.chance = 0.2
	presets.dodge.poor.scared.variation = {0.8, 1}
	presets.dodge.normal = {
		on_hurt = {},
		on_hit = {},
		on_contact = {},
		scared = {}
	}
	presets.dodge.normal.on_hurt.chance = 0.4
	presets.dodge.normal.on_hurt.variation = {0.6, 0.8}
	presets.dodge.normal.on_hit.chance = 1
	presets.dodge.normal.on_hit.variation = {0.6, 0.8}
	presets.dodge.normal.on_contact.chance = 1
	presets.dodge.normal.on_contact.variation = {0, 1}
	presets.dodge.normal.scared.chance = 0.4
	presets.dodge.normal.scared.variation = {0.6, 0.8}
	presets.dodge.good = {
		on_hurt = {},
		on_hit = {},
		on_contact = {},
		scared = {}
	}
	presets.dodge.good.on_hurt.chance = 0.6
	presets.dodge.good.on_hurt.variation = {0.4, 0.7}
	presets.dodge.good.on_contact.chance = 1
	presets.dodge.good.on_contact.variation = {0, 1}
	presets.dodge.good.scared.chance = 0.5
	presets.dodge.good.scared.variation = {0.4, 0.7}
	presets.dodge.expert = {
		on_hurt = {},
		on_hit = {},
		on_contact = {},
		scared = {}
	}
	presets.dodge.expert.on_hurt.chance = 0.7
	presets.dodge.expert.on_hurt.variation = {0.2, 0.5}
	presets.dodge.expert.on_contact.chance = 1
	presets.dodge.expert.on_contact.variation = {0, 0.9}
	presets.dodge.expert.scared.chance = 0.5
	presets.dodge.expert.scared.variation = {0.2, 0.5}
	presets.dodge.ninja = {
		on_hurt = {},
		on_hit = {},
		on_contact = {},
		scared = {}
	}
	presets.dodge.ninja.on_hurt.chance = 1
	presets.dodge.ninja.on_hurt.variation = {0, 0.3}
	presets.dodge.ninja.on_contact.chance = 1
	presets.dodge.ninja.on_contact.variation = {0, 0.75}
	presets.dodge.ninja.scared.chance = 1
	presets.dodge.ninja.scared.variation = {0, 0.3}
	presets.enemy_chatter = {
		no_chatter = {},
		cop = {
			aggressive = true,
			retreat = true,
			go_go = true
		},
		swat = {
			aggressive = true,
			retreat = true,
			follow_me = true,
			clear = true,
			go_go = true,
			ready = true,
			smoke = true,
			incomming_tank = true,
			incomming_spooc = true,
			incomming_shield = true,
			incomming_taser = true
		},
		shield = {follow_me = true}
	}
	return presets
end