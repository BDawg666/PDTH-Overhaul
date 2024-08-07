if RequiredScript == "lib/units/beings/player/playerdamage" then
local PlayerDamage = module:hook_class("PlayerDamage")
module:hook(PlayerDamage, "_regenerate_armor", function(self)
	if not self._armor then
		module:call_orig(PlayerDamage, "_regenerate_armor", self)
		return
	end

	local max_armor = self:_max_armor()
	self._armor = math.clamp(self._armor + (max_armor * 0.2), 0, max_armor)
	managers.hud:set_player_armor({
		current = self._armor,
		total = max_armor,
	})

	local new_t
	local is_full = self._armor == max_armor
	if not is_full then
		new_t = 1.5
		self._hurt_value = 0.5
	end

	if is_full and self._unit:sound() then
		self._unit:sound():play("shield_full_indicator")
	end

	self._regenerate_timer = new_t
	self:_send_set_armor()
end)
end

if RequiredScript == "lib/tweak_data/playertweakdata" then
local PlayerTweakData = module:hook_class("PlayerTweakData")

function PlayerTweakData:_set_easy()
	self.damage.ARMOR_INIT = 14
	self.damage.MIN_DAMAGE_INTERVAL = 0.35
	self.damage.automatic_respawn_time = 180
end

function PlayerTweakData:_set_normal()
	self.damage.ARMOR_INIT = 12
	self.damage.MIN_DAMAGE_INTERVAL = 0.3
	self.damage.DOWNED_TIME_DEC = 10
	self.damage.automatic_respawn_time = 300
end

function PlayerTweakData:_set_hard()
	self.damage.ARMOR_INIT = 12
	self.damage.MIN_DAMAGE_INTERVAL = 0.25
	self.damage.DOWNED_TIME_DEC = 10
	self.damage.DOWNED_TIME_MIN = 5
end

function PlayerTweakData:_set_overkill()
	self.damage.ARMOR_INIT = 10
	self.damage.MIN_DAMAGE_INTERVAL = 0.2
	self.damage.DOWNED_TIME_DEC = 10
	self.damage.DOWNED_TIME_MIN = 1
	self.damage.REVIVE_HEALTH_STEPS = { 0.5, 0.25 }
end

function PlayerTweakData:_set_overkill_145()
	self.damage.ARMOR_INIT = 10
	self.damage.MIN_DAMAGE_INTERVAL = 0.15
	self.damage.DOWNED_TIME_DEC = 15
	self.damage.DOWNED_TIME_MIN = 1
	self.damage.REVIVE_HEALTH_STEPS = { 0.2 }
end

end