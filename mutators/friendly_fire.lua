if RequiredScript == "lib/units/weapons/raycastweaponbase" then
	local RaycastWeaponBase = module:hook_class("RaycastWeaponBase")

	module:post_hook(RaycastWeaponBase, "init", function(self)
		self._bullet_slotmask = self._bullet_slotmask + World:make_slot_mask(3, 16)
	end, false)

	module:post_hook(RaycastWeaponBase, "setup", function(self)
		self._bullet_slotmask = self._bullet_slotmask + World:make_slot_mask(3, 16)
	end)

	local InstantBulletBase = module:hook_class("InstantBulletBase")
	module:post_hook(InstantBulletBase, "on_collision", function(self, col_ray, weapon_unit, user_unit, damage)
		local hit_unit = col_ray.unit

		if hit_unit:base() and hit_unit:base().is_husk_player then
			DNet:send_to_peer(col_ray.unit:network():peer(), "FriendlyFire", {
				ray = { x = col_ray.ray.x, y = col_ray.ray.y, z = col_ray.ray.z },
				damage = damage,
				variant = "bullet",
			})
		end
	end)
end

if RequiredScript == "lib/units/weapons/grenades/m79grenadebase" then
	local M79GrenadeBase = module:hook_class(M79GrenadeBase)

	module:post_hook(M79GrenadeBase, "_detect_and_give_dmg", function(self, hit_pos)
		DNet:send_to_peers("FriendlyFire", {
			position = { x = hit_pos.x, y = hit_pos.y, z = hit_pos.z },
			range = self._range,
			damage = 9,
			variant = "explosion",
		})
	end)
end

if RequiredScript == "lib/units/weapons/trip_mine/tripminebase" then
	local TripMineBase = module:hook_class("TripMineBase")

	module:post_hook(TripMineBase, "_setup", function(self)
		self._slotmask = self._slotmask + World:make_slot_mask(3)
	end)

	module:post_hook(TripMineBase, "_explode", function(self, col_ray)
		if self._exploded then
			return
		end

		self._exploded = true
		DNet:send_to_peers("FriendlyFire", {
			position = { x = col_ray.position.x, y = col_ray.position.y, z = col_ray.position.z },
			range = 500,
			damage = 9,
			variant = "explosion",
		})
	end)

	module:hook(TripMineBase, "_check", function(self)
		if not managers.network:session() then
			return
		end

		local ray = self._unit:raycast(
			"ray",
			self._ray_from_pos,
			self._ray_to_pos,
			"slot_mask",
			self._slotmask,
			"ray_type",
			"trip_mine body"
		)

		if not ray then
			return
		end

		local unit = ray and ray.unit
		if not alive(unit) then
			return
		end

		if unit:base()._tweak_table and tweak_data.character[unit:base()._tweak_table].is_escort then
			return
		end

		self._explode_timer = tweak_data.weapon.trip_mines.delay
		self._explode_ray = ray

		self._unit:sound_source():post_event("trip_mine_beep_explode")

		if managers.network:session() then
			managers.network:session():send_to_peers_synched("sync_trip_mine_beep_explode", self._unit)
		end
	end)
end

if RequiredScript == "lib/units/equipment/sentry_gun/sentrygundamage" then
	local SentryGunDamage = module:hook_class("SentryGunDamage")

	-- SentryGun data is not synced to session clients and damaging a sentry crashes the game ;(
	-- Making sentries target teammates would be unfair for them.
	module:hook(SentryGunDamage, "_look_for_friendly_fire", function(self, unit)
		local players = managers.player:players()
		for _, player in ipairs(players) do
			if player == unit then
				return true
			end
		end
		local criminals = managers.groupai:state():all_criminals()
		if unit and criminals[unit:key()] then
			return true
		end
		return false
	end)

	module:hook(SentryGunDamage, "damage_bullet", function(self, attack_data)
		if self._dead or self._invulnerable or self:_look_for_friendly_fire(attack_data.attacker_unit) then
			return
		end

		local hit_shield = attack_data.col_ray.body and attack_data.col_ray.body:name() == self._shield_body_name
		local dmg_adjusted = attack_data.damage * (hit_shield and tweak_data.weapon.sentry_gun.SHIELD_DMG_MUL or 1)
		if dmg_adjusted >= self._health then
			self:die()
		else
			self._health = self._health - dmg_adjusted
		end

		local health_percent = self._health / self._health_max
		if health_percent == 0 or math.abs(health_percent - self._health_sync) >= self._health_sync_resolution then
			self._health_sync = health_percent
			self._unit:network():send("sentrygun_health", math.ceil(health_percent / self._health_sync_resolution))
		end
	end)
end

if RequiredScript == "lib/units/beings/player/playerdamage" then
	local PlayerDamage = module:hook_class("PlayerDamage")

	module:hook(PlayerDamage, "_look_for_friendly_fire", function(self)
		return false
	end)

	module:hook(PlayerDamage, "damage_melee", function(self, attack_data)
		World:effect_manager():spawn({
			effect = Idstring("effects/particles/character/player/blood_screen"),
			position = Vector3(),
			normal = Rotation(),
		})

		self._unit:sound():play("clk_punch_3p", nil, nil)

		local result = self:damage_bullet(attack_data)
		self._unit:camera():play_shaker("player_melee")

		self._unit:movement():push(attack_data.push_vel)

		return result
	end)
end

if RequiredScript == "lib/units/beings/player/playermovement" then
	local PlayerMovement = module:hook_class("PlayerMovement")

	module:hook(PlayerMovement, "push", function(self, vel)
		if self._current_state.push then
			self._current_state:push(vel)
		end
	end)
end

if RequiredScript == "lib/units/beings/player/states/playerstandard" then
	local PlayerStandard = module:hook_class("PlayerStandard")

	module:post_hook(PlayerStandard, "init", function(self, vel)
		self._slotmask_bullet_impact_targets = self._slotmask_bullet_impact_targets + World:make_slot_mask(3)
	end)

	module:hook(PlayerStandard, "push", function(self, vel)
		if self._unit:mover() then
			self._last_velocity_xy = self._last_velocity_xy + vel

			self._unit:mover():set_velocity(self._last_velocity_xy)
		end

		self:_interupt_action_running(TimerManager:game():time())
	end)

	module:hook(PlayerStandard, "_check_action_melee", function(self, t, input)
		local action_wanted = input.btn_melee_press
		if not action_wanted then
			return nil
		end

		local action_forbidden = self._melee_expire_t
			or self._use_item_expire_t
			or self:_changing_weapon()
			or self:_interacting()
		if action_forbidden then
			return nil
		end

		self._equipped_unit:base():tweak_data_anim_stop("fire")
		self:_interupt_action_reload(t)
		self:_interupt_action_steelsight(t)
		self:_interupt_action_running(t)

		managers.network:session():send_to_peers("play_distance_interact_redirect", self._unit, "melee")

		self._unit:camera():play_shaker("player_melee")
		self._unit:camera():play_redirect(self.IDS_MELEE)

		self._melee_expire_t = t + 0.6

		local range = 200 -- * managers.player:synced_crew_bonus_upgrade_value("gang_of_ninjas", 1)
		local from = self._unit:movement():m_head_pos()
		local to = from + self._unit:movement():m_head_rot():y() * range
		local sphere_cast_radius = 20
		local col_ray = self._unit:raycast(
			"ray",
			from,
			to,
			"slot_mask",
			self._slotmask_bullet_impact_targets,
			"sphere_cast_radius",
			sphere_cast_radius,
			"ray_type",
			"body melee"
		)

		if not col_ray then
			return nil
		end

		local damage, damage_effect = self._equipped_unit:base():melee_damage_info()
		col_ray.sphere_cast_radius = sphere_cast_radius

		local hit_unit = col_ray.unit
		if not hit_unit:character_damage() or not hit_unit:character_damage()._no_blood then
			managers.game_play_central:play_impact_flesh({ col_ray = col_ray })
			managers.game_play_central:play_impact_sound_and_effects({
				col_ray = col_ray,
				no_decal = true,
			})
		end

		if hit_unit:base() and hit_unit:base().is_husk_player then
			DNet:send_to_peer(col_ray.unit:network():peer(), "FriendlyFire", {
				ray = { x = col_ray.ray.x, y = col_ray.ray.y, z = col_ray.ray.z },
				damage = damage,
				variant = "melee",
			})
		end

		local damage_ext = col_ray.body:extension() and col_ray.body:extension().damage
		if hit_unit:damage() and damage_ext then
			damage_ext:damage_melee(self._unit, col_ray.normal, col_ray.position, col_ray.direction, damage)
			if hit_unit:id() ~= -1 then
				managers.network:session():send_to_peers_synched(
					"sync_body_damage_melee",
					col_ray.body,
					self._unit,
					col_ray.normal,
					col_ray.position,
					col_ray.direction,
					damage
				)
			end
		end

		managers.rumble:play("melee_hit")
		managers.game_play_central:physics_push(col_ray)

		if hit_unit:character_damage() and hit_unit:character_damage().damage_melee then
			local action_data = {}
			action_data.variant = "melee"
			action_data.damage = damage
			action_data.damage_effect = damage_effect
			action_data.attacker_unit = self._unit
			action_data.col_ray = col_ray
			local defense_data = col_ray.unit:character_damage():damage_melee(action_data)
			return defense_data
		end

		return true
	end)
end
