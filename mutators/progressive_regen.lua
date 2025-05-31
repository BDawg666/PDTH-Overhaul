local module = ... or D:module("fgo")

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

	module:post_hook(PlayerTweakData, "_set_easy", function(self)
		self.damage.ARMOR_INIT = 14
	end)

	module:post_hook(PlayerTweakData, "_set_normal", function(self)
		self.damage.ARMOR_INIT = 12
	end)

	module:post_hook(PlayerTweakData, "_set_hard", function(self)
		self.damage.ARMOR_INIT = 12
	end)

	module:post_hook(PlayerTweakData, "_set_overkill", function(self)
		self.damage.ARMOR_INIT = 10
	end)

	module:post_hook(PlayerTweakData, "_set_overkill_145", function(self)
		self.damage.ARMOR_INIT = 10
	end)
end
