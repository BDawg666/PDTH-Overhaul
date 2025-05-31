local module = ... or D:module("fgo")

local PlayerDamage = module:hook_class("PlayerDamage")
module:hook(PlayerDamage, "get_fall_damage_multiplier", function(self)
	local multiplier = 1

	local equipped_unit = self._unit:inventory():equipped_unit()
	if alive(equipped_unit) then
		local weapon_tdata = equipped_unit:base():weapon_tweak_data()
		if weapon_tdata.fall_damage_multiplier then
			multiplier = weapon_tdata.fall_damage_multiplier
		end
	end

	return multiplier
end)

module:hook(50, PlayerDamage, "damage_fall", function(self, data)
	local damage_info = { result = { type = "hurt", variant = "fall" } }

	if self._god_mode or self._invulnerable then
		self:_call_listeners(damage_info)
		return
	elseif self:incapacitated() then
		return
	end

	local height_limit = 300
	local death_limit = 631
	if height_limit > data.height then
		return
	end

	local die = death_limit < data.height

	self._unit:sound():play("player_hit")
	managers.environment_controller:hit_feedback_down()

	if self._bleed_out then
		return
	end

	if die then
		self._health = 0
	else
		local damage = self._health - (tweak_data.player.fall_health_damage * self:get_fall_damage_multiplier())
		self._health = math.clamp(damage, 1, self:_max_health())
	end

	self._armor = 0

	managers.hud:set_player_armor({ current = self._armor, total = self:_max_armor(), no_hint = true })
	SoundDevice:set_rtpc("shield_status", 0)

	self:_send_set_armor()

	managers.hud:set_player_health({ current = self._health, total = self:_max_health() })

	self:_send_set_health()
	self:_set_health_effect()
	self:_damage_screen()
	self:_check_bleed_out()

	if die then
		managers.challenges:set_flag("fall_to_bleed_out")
	end

	self:_call_listeners(damage_info)

	return true
end)

module:hook(PlayerDamage, "_chk_dmg_too_soon", function(self, damage)
	if TimerManager:game():time() < self._next_allowed_dmg_t then
		return true
	end
end)
