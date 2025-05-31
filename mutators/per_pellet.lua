local module = ... or D:module("fgo")

if RequiredScript == "lib/units/weapons/shotgun/shotgunbase" then
	local ShotgunBase = module:hook_class("ShotgunBase")

	module:hook(ShotgunBase, "_fire_raycast", function(self, user_unit, from_pos, direction)
		local result = {}
		local hit_enemies = {}
		local col_rays

		if self._alert_events then
			col_rays = {}
		end

		local autoaim, _ = self:check_autoaim(from_pos, direction, self._range)
		local weight = 0.1

		local function hit_enemy(col_ray)
			if col_ray.unit:in_slot(12) then
				-- local enemy_key = col_ray.unit:key()

				-- -- was enemy not hit before or we hit their head?
				-- if not hit_enemies[enemy_key] or col_ray.unit:character_damage():is_head(col_ray.body) then
				-- 	-- we hit him with this ray!
				-- 	hit_enemies[enemy_key] = col_ray
				-- end

				-- don't care, we know it is an enemy so we add the ray to the track list.
				table.insert(hit_enemies, col_ray)
			else
				InstantBulletBase:on_collision(col_ray, self._unit, user_unit, self._damage)
			end
		end

		for _ = 1, 9 do -- number of rays, can make it per-weapon id
			local spread_direction = direction:spread(self:_get_spread(user_unit))
			local ray_to = mvector3.copy(spread_direction)

			mvector3.multiply(ray_to, self._range)
			mvector3.add(ray_to, from_pos)

			local col_ray = World:raycast(
				"ray",
				from_pos,
				ray_to,
				"slot_mask",
				self._bullet_slotmask,
				"ignore_unit",
				self._setup.ignore_units
			)

			if col_rays then
				if col_ray then
					table.insert(col_rays, col_ray)
				else
					table.insert(col_rays, { position = ray_to, ray = spread_direction })
				end
			end

			if self._autoaim and autoaim then
				if col_ray and col_ray.unit:in_slot(managers.slot:get_mask("enemies")) then
					self._autohit_current = (self._autohit_current + weight) / (1 + weight)
					hit_enemy(col_ray)
					autoaim = false
				else
					autoaim = false
					local autohit = self:check_autoaim(from_pos, direction, self._range)
					if autohit then
						local autohit_chance = 1
							- math.clamp(
								(self._autohit_current - self._autohit_data.MIN_RATIO)
									/ (self._autohit_data.MAX_RATIO - self._autohit_data.MIN_RATIO),
								0,
								1
							)
						if autohit_chance > math.random() then
							self._autohit_current = (self._autohit_current + weight) / (1 + weight)
							hit_enemy(autohit)
						else
							self._autohit_current = self._autohit_current / (1 + weight)
						end
					elseif col_ray then
						hit_enemy(col_ray)
					end
				end
			elseif col_ray then
				hit_enemy(col_ray)
			end
		end

		-- go through our tracked hit list and apply damage
		for _, col_ray in pairs(hit_enemies) do
			local dist = mvector3.distance(col_ray.unit:position(), user_unit:position())
			local damage = (1 - math.min(1, math.max(0, dist - self._damage_near) / self._damage_far)) * self._damage

			InstantBulletBase:on_collision(col_ray, self._unit, user_unit, damage)
		end

		result.hit_enemy = next(hit_enemies) and true or false
		result.rays = 0 < #col_rays and col_rays

		managers.statistics:shot_fired({
			hit = result.hit_enemy,
			weapon_unit = self._unit,
		})

		return result
	end)
end

if RequiredScript == "lib/tweak_data/weapontweakdata" then
	local WeaponTweakData = module:hook_class("WeaponTweakData")
	module:post_hook(WeaponTweakData, "_init_data_per_pellet", function(self)
		self.r870_shotgun.DAMAGE = 2
		self.r870_shotgun.AMMO_PICKUP = { 0, 1 }
		self.r870_shotgun.spread.standing = 2
		self.r870_shotgun.spread.crouching = 2
		self.r870_shotgun.spread.steelsight = 1.5
		self.r870_shotgun.spread.moving_standing = 2
		self.r870_shotgun.spread.moving_crouching = 2
		self.r870_shotgun.spread.moving_steelsight = 1.5
		self.r870_shotgun.crosshair.standing.offset = 0.2
		self.r870_shotgun.crosshair.standing.moving_offset = 0.2
		self.r870_shotgun.crosshair.crouching.offset = 0.2
		self.r870_shotgun.crosshair.crouching.moving_offset = 0.2
		self.mossberg.DAMAGE = 2
		self.mossberg.AMMO_PICKUP = { 0, 1 }
		self.mossberg.spread.standing = 3
		self.mossberg.spread.crouching = 3
		self.mossberg.spread.steelsight = 2.5
		self.mossberg.spread.moving_standing = 3
		self.mossberg.spread.moving_crouching = 3
		self.mossberg.spread.moving_steelsight = 2.5
		self.mossberg.crosshair.standing.offset = 0.3
		self.mossberg.crosshair.standing.moving_offset = 0.3
		self.mossberg.crosshair.crouching.offset = 0.3
		self.mossberg.crosshair.crouching.moving_offset = 0.3
	end)
end
