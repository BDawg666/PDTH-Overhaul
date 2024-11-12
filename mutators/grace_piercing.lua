if RequiredScript == "lib/units/beings/player/playerdamage" then
local PlayerDamage = module:hook_class("PlayerDamage")
module:hook(PlayerDamage, "_chk_dmg_too_soon", function(self, damage)
	if damage <= self._last_received_dmg and TimerManager:game():time() < self._next_allowed_dmg_t then
		return true
	end
end)
end

if RequiredScript == "lib/tweak_data/playertweakdata" then
local PlayerTweakData = module:hook_class("PlayerTweakData")

module:post_hook(PlayerTweakData, "_set_easy", function(self)
	self.damage.MIN_DAMAGE_INTERVAL = 0.4
end)

module:post_hook(PlayerTweakData, "_set_normal", function(self)
	self.damage.MIN_DAMAGE_INTERVAL = 0.35
end)

module:post_hook(PlayerTweakData, "_set_hard", function(self)
	self.damage.MIN_DAMAGE_INTERVAL = 0.3
end)

module:post_hook(PlayerTweakData, "_set_overkill", function(self)
	self.damage.MIN_DAMAGE_INTERVAL = 0.25
end)

module:post_hook(PlayerTweakData, "_set_overkill_145", function(self)
	self.damage.MIN_DAMAGE_INTERVAL = 0.2
end)

end