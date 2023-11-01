local PlayerStandard = module:hook_class("PlayerStandard")

module:hook(PlayerStandard, "_get_walk_speed_multiplier", function(self)
	local multiplier_data = self._tweak_data.movement.speed.multipliers

	-- get player rule multiplier
	local multiplier = multiplier_data.standard.walk
	for _, rule in ipairs({ "slow", "heavy", "super_slow" }) do
		if managers.player:get_player_rule(rule .. "_walk") then
			multiplier = multiplier_data[rule].walk
		end
	end

	if alive(self._equipped_unit) then
		local weapon_tdata = self._equipped_unit:base():weapon_tweak_data()
		if weapon_tdata.movement_speed_multiplier then
			multiplier = multiplier * weapon_tdata.movement_speed_multiplier
		end
	end

	return multiplier
end)

module:hook(PlayerStandard, "_get_run_speed_multiplier", function(self)
	local multiplier_data = self._tweak_data.movement.speed.multipliers

	-- get player rule multiplier
	local multiplier = multiplier_data.standard.run
	for _, rule in ipairs({ "slow", "heavy", "super_slow" }) do
		if managers.player:get_player_rule(rule .. "_run") then
			multiplier = multiplier_data[rule].run
		end
	end

	if alive(self._equipped_unit) then
		local weapon_tdata = self._equipped_unit:base():weapon_tweak_data()
		if weapon_tdata.movement_speed_multiplier then
			multiplier = multiplier * weapon_tdata.movement_speed_multiplier
		end
	end

	return multiplier
end)

module:hook(PlayerStandard, "_get_max_walk_speed", function(self, t)
	local movement_speed = self._tweak_data.movement.speed

	if self._running then
		return movement_speed.RUNNING_MAX * self:_get_run_speed_multiplier()
	end

	local multiplier = self:_get_walk_speed_multiplier()
	if self._in_steelsight then
		return movement_speed.STEELSIGHT_MAX * multiplier
	end

	if self._ducking then
		return movement_speed.CROUCHING_MAX * multiplier
	end

	if self._in_air then
		return movement_speed.INAIR_MAX * multiplier
	end

	return movement_speed.STANDARD_MAX * multiplier
end)
