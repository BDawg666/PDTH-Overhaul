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
	self.spanish.SPEED_WALK = 400
	self.spanish.SPEED_RUN = 600
end, false)

module:post_hook(CharacterTweakData, "_init_german", function(self, presets)
	self.german.SPEED_WALK = 400
	self.german.SPEED_RUN = 600
end, false)

module:post_hook(CharacterTweakData, "_init_russian", function(self, presets)
	self.russian.SPEED_WALK = 400
	self.russian.SPEED_RUN = 600
end, false)

module:post_hook(CharacterTweakData, "_init_american", function(self, presets)
	self.american.SPEED_WALK = 400
	self.american.SPEED_RUN = 600
end, false)

module:hook(50, CharacterTweakData, "_presets", function(self, tweak_data)
	local presets = module:call_orig(CharacterTweakData, "_presets", self, tweak_data)

	presets.weapon.normal.r870.aim_delay = { 0, 0.2 }
	presets.weapon.good.r870.aim_delay = { 0, 0.2 }
	presets.weapon.expert.r870.aim_delay = { 0, 0.2 }
	presets.weapon.gang_member.r870.aim_delay = { 0, 0.2 }

	return presets
end, false)
