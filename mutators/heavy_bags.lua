if RequiredScript == "lib/units/beings/player/states/playerstandard" then
	local PlayerStandard = module:hook_class("PlayerStandard")
	module:hook(PlayerStandard, "_get_max_walk_speed", function(self, t)
		local movement_speed = self._tweak_data.movement.speed

		local speed_multiplier = managers.player:get_player_rule("super_slow_walk") and 0.6
			or managers.player:get_player_rule("slow_walk") and 0.75
			or 1

		if self._in_steelsight then
			return movement_speed.STEELSIGHT_MAX * speed_multiplier
		end

		if self._ducking then
			return movement_speed.CROUCHING_MAX * speed_multiplier
		end

		if self._in_air then
			return movement_speed.INAIR_MAX * speed_multiplier
		end

		if self._running then
			speed_multiplier = managers.player:get_player_rule("super_slow_run") and 0.5
				or managers.player:get_player_rule("slow_run") and 0.75
				or 1

			return movement_speed.RUNNING_MAX * speed_multiplier
		end

		return movement_speed.STANDARD_MAX * speed_multiplier
	end)

	module:hook(PlayerStandard, "_check_action_jump", function(self, t, input)
		local new_action
		local action_wanted = input.btn_jump_press
		if not action_wanted then
			return action_wanted
		end

		local action_forbidden = self._jump_t and t < self._jump_t + 0.75
		action_forbidden = action_forbidden
			or self._unit:base():stats_screen_visible()
			or self._in_air
			or self:_interacting()
			or managers.player:get_player_rule("no_jump")

		if action_forbidden then
			return action_wanted
		end

		if self._ducking then
			self:_interupt_action_ducking(t)
			return action_wanted
		end

		local action_start_data = {}
		local jump_vel_z = tweak_data.player.movement_state.standard.movement.jump_velocity.z

		local jump_multiplier = managers.player:get_player_rule("super_heavy_jump") and 0.5
			or managers.player:get_player_rule("heavy_jump") and 0.75
			or 1

		action_start_data.jump_vel_z = jump_vel_z * jump_multiplier
		if self._move_dir then
			local is_running = self._running and t - self._start_running_t > 0.4
			local jump_vel_xy =
				tweak_data.player.movement_state.standard.movement.jump_velocity.xy[is_running and "run" or "walk"]
			action_start_data.jump_vel_xy = jump_vel_xy
		end

		new_action = self:_start_action_jump(t, action_start_data)
		return new_action
	end)
end

if RequiredScript == "lib/tweak_data/equipmentstweakdata" then
	local EquipmentsTweakData = module:hook_class("EquipmentsTweakData")
	module:post_hook(EquipmentsTweakData, "init", function(self)
		self.specials.gold_bag_equip.player_rule = { "super_slow_walk", "no_run", "super_heavy_jump" }
		self.specials.money_bag.player_rule = { "slow_walk", "slow_run", "no_jump" }
	end)
end
