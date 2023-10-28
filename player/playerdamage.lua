local PlayerDamage = module:hook_class("PlayerDamage")
module:hook(50, PlayerDamage, "damage_fall", function(self, data)
	local damage_info = {
		result = { variant = "fall", type = "hurt" },
	}

	if self._god_mode or self._invulnerable then
		self:_call_listeners(damage_info)
		return
	elseif self:incapacitated() then
		return
	end

	local height_limit = 300
	local death_limit = 631
	if data.height < height_limit then
		return
	end

	local die = death_limit < data.height

	self._unit:sound():play("player_hit")
	managers.environment_controller:hit_feedback_down()
	if self._bleed_out then
		return
	end

	if die then
		self:set_health(0)
	else
		self._health = math.clamp(
			self._health - (tweak_data.player.fall_health_damage * tweak_data.player.fall_damage_multiplier),
			0,
			self:_max_health()
		)
	end

	local max_armor = self:_max_armor()

	if die then
		self._armor = 0
	else
		self._armor = math.clamp(self._armor - (max_armor * tweak_data.player.fall_damage_multiplier), 0, max_armor)
	end

	managers.hud:set_player_armor({
		current = self._armor,
		total = max_armor,
		no_hint = true,
	})

	SoundDevice:set_rtpc("shield_status", 0)
	self:_send_set_armor()

	self._bleed_out_blocked_by_movement_state = nil

	managers.hud:set_player_health({
		current = self._health,
		total = self:_max_health(),
	})

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
