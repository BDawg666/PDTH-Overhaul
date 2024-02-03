module:hook(PlayerStandard, "_stop_shooting", function(self)
	if not self._shooting then
		return
	end

	self._equipped_unit:base():stop_shooting()
	self._camera_unit:base():stop_shooting()
end)

module:hook(PlayerStandard, "_check_action_primary_attack", function(self, t, input)
	local new_action
	if not input.btn_primary_attack_state then
		self:_stop_shooting()
		return new_action
	end

	local action_forbidden = self:_is_reloading()
		or self:_changing_weapon()
		or self._melee_expire_t
		or self._use_item_expire_t
		or self:_interacting()
	if not action_forbidden then
		self._queue_reload_interupt = nil
		self._ext_inventory:equip_selected_primary(false)
		if not alive(self._equipped_unit) then
			return
		end

		local weap_base = self._equipped_unit:base()
		local fire_mode = weap_base:fire_mode()
		if weap_base:out_of_ammo() or weap_base.clip_empty and weap_base:clip_empty() then
			if input.btn_primary_attack_press then
				weap_base:dryfire()
			end
		elseif self._running then
			self:_interupt_action_running(t)
		else
			if not self._shooting then
				if weap_base:start_shooting_allowed() then
					local start = fire_mode == "single" and input.btn_primary_attack_press
					start = start or fire_mode ~= "single" and input.btn_primary_attack_state
					if start then
						weap_base:start_shooting()
						self._camera_unit:base():start_shooting()
						self._shooting = true
					end
				else
					return false
				end
			end

			local fired
			if fire_mode == "single" then
				if input.btn_primary_attack_press then
					fired = weap_base:trigger_pressed(self._ext_camera:position(), self._ext_camera:forward())
				end
			elseif input.btn_primary_attack_state then
				fired = weap_base:trigger_held(self._ext_camera:position(), self._ext_camera:forward())
			end

			new_action = true

			if fired then
				managers.rumble:play("weapon_fire")
				local weap_tweak_data = tweak_data.weapon[weap_base:get_name_id()]
				self._unit:camera():play_shaker("fire_weapon", weap_tweak_data.fire_weapon_shaker_multiplier)
				if
					not self._in_steelsight
					or not weap_base:tweak_data_anim_play("fire_steelsight", weap_base:fire_rate_multiplier())
				then
					weap_base:tweak_data_anim_play("fire", weap_base:fire_rate_multiplier())
				end
				if not self._in_steelsight then
					self._unit:camera():play_redirect(self.IDS_RECOIL, weap_base:fire_rate_multiplier())
				elseif weap_tweak_data.animations.recoil_steelsight then
					self._unit:camera():play_redirect(self.IDS_RECOIL_STEELSIGHT, weap_base:fire_rate_multiplier())
				end
				local kick_v =
					weap_tweak_data.kick.v[self._in_steelsight and "steelsight" or self._ducking and "crouching" or "standing"]
				local kick_h = weap_tweak_data.kick.h
						and weap_tweak_data.kick.h[self._in_steelsight and "steelsight" or self._ducking and "crouching" or "standing"]
					or 0
				local recoil_multiplier = managers.player:upgrade_value(weap_base:get_name_id(), "recoil_multiplier")
				recoil_multiplier = recoil_multiplier ~= 0 and recoil_multiplier or 1
				self._camera_unit:base():recoil_kick(kick_v * recoil_multiplier, kick_h * recoil_multiplier)
				local spread_multiplier = weap_base:spread_multiplier()
				managers.hud:_kick_crosshair_offset(
					weap_tweak_data.crosshair[self._in_steelsight and "steelsight" or self._ducking and "crouching" or "standing"].kick_offset
						* spread_multiplier
				)
				managers.hud:set_ammo_amount(weap_base:ammo_info())
				if self._ext_network then
					local impact = not fired.hit_enemy
					self._ext_network:send("shot_blank", impact)
				end
			elseif fire_mode == "single" then
				new_action = false
			end
		end
	elseif
		self:_is_reloading()
		and self._equipped_unit:base():reload_interuptable()
		and input.btn_primary_attack_press
	then
		self._queue_reload_interupt = true
	end

	if not new_action then
		self:_stop_shooting()
	end

	return new_action
end)
