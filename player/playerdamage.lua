local PlayerDamage = module:hook_class("PlayerDamage")

module:hook(PlayerDamage, "_max_armor", function(self)
	return (self._ARMOR_INIT + managers.player:body_armor_value())
		* managers.player:synced_crew_bonus_upgrade_value("protector", 1)
end)

-- function PlayerDamage:_regenerate_armor()
--[[module:hook(PlayerDamage, "_regenerate_armor", function(self)
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
end)--]]

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
