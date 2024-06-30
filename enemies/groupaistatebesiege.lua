module:hook(GroupAIStateBesiege, "_begin_new_tasks", function(self)
	local all_areas = self._area_data
	local nav_manager = managers.navigation
	local all_nav_segs = nav_manager._nav_segments
	local task_data = self._task_data
	local t = self._t
	local reenforce_candidates
	local reenforce_data = task_data.reenforce

	if reenforce_data.next_dispatch_t and t > reenforce_data.next_dispatch_t then
		reenforce_candidates = {}
	end

	local recon_candidates
	local recon_data = task_data.recon
	if
		recon_data.next_dispatch_t
		and t > recon_data.next_dispatch_t
		and not task_data.assault.active
		and not task_data.regroup.active
	then
		recon_candidates = {}
	end

	local assault_candidates
	local assault_data = task_data.assault
	if assault_data.next_dispatch_t and t > assault_data.next_dispatch_t and not task_data.regroup.active then
		assault_candidates = {}
	end

	if not reenforce_candidates and not recon_candidates and not assault_candidates then
		return
	end

	local found_segs = {}
	local to_search_segs = {}

	for nav_seg, area_data in pairs(all_areas) do
		if area_data.spawn_points and not all_nav_segs[nav_seg].disabled then
			for _, sp_data in pairs(area_data.spawn_points) do
				if t >= sp_data.delay_t then
					table.insert(to_search_segs, nav_seg)
					found_segs[nav_seg] = true
					break
				end
			end
		end
	end

	if #to_search_segs == 0 then
		return
	end

	if assault_candidates and self._hunt_mode then
		for _, criminal_data in pairs(self._criminals) do
			if not criminal_data.status and not criminal_data.is_deployable then
				local nav_seg = criminal_data.tracker:nav_segment()
				found_segs[nav_seg] = true
				table.insert(assault_candidates, nav_seg)
			end
		end
	end

	local i = 1
	repeat
		local search_seg = to_search_segs[i]
		local area = all_areas[search_seg]
		local force_factor = area.factors.force
		local demand = force_factor and force_factor.force
		local nr_police = table.size(area.police.units)
		local nr_criminals = table.size(area.criminal.units)
		local undershot = demand and demand - nr_police
		if reenforce_candidates and undershot and 0 < undershot and nr_criminals == 0 then
			local area_free = true
			for _, reenforce_task_data in ipairs(reenforce_data.tasks) do
				if reenforce_task_data.target_area == search_seg then
					area_free = false
					break
				end
			end
			if area_free then
				table.insert(reenforce_candidates, { search_seg, undershot })
			end
		end

		if recon_candidates and not area.is_safe and nr_criminals == 0 and nr_police == 0 then
			table.insert(recon_candidates, search_seg)
		end

		if assault_candidates then
			for criminal_key, _ in pairs(area.criminal.units) do
				if not self._criminals[criminal_key].status and not self._criminals[criminal_key].is_deployable then
					table.insert(assault_candidates, search_seg)
					break
				end
			end
		end

		if nr_criminals == 0 then
			for _neigh_seg_id, _ in pairs(all_nav_segs[search_seg].neighbours) do
				if not found_segs[_neigh_seg_id] then
					if not all_nav_segs[_neigh_seg_id].disabled then
						table.insert(to_search_segs, _neigh_seg_id)
					end
					found_segs[_neigh_seg_id] = true
				end
			end
		end

		i = i + 1
	until i > #to_search_segs

	if assault_candidates and 0 < #assault_candidates then
		self:_begin_assault_task(assault_candidates)
		recon_candidates = nil
	end

	if reenforce_candidates and 0 < #reenforce_candidates then
		local lucky_i_candidate = math.random(#reenforce_candidates)
		local reenforce_area = reenforce_candidates[lucky_i_candidate][1]
		local undershot = reenforce_candidates[lucky_i_candidate][2]
		self:_begin_reenforce_task(reenforce_area, undershot)
		recon_candidates = nil
	end

	if recon_candidates and 0 < #recon_candidates then
		local best_i_candidate, best_has_hostages
		for i_area, seg_id in ipairs(recon_candidates) do
			for u_key, u_data in ipairs(managers.enemy:all_civilians()) do
				if seg_id == u_data.tracker:nav_segment() then
					local so_id = u_data.unit:brain():wants_rescue()
					if so_id then
						best_has_hostages = true
						best_i_candidate = i_area
						break
					end
				end
			end

			if best_has_hostages then
				break
			end
		end

		best_i_candidate = best_i_candidate or math.random(#recon_candidates)
		local recon_area = recon_candidates[best_i_candidate]
		self:_begin_recon_task(recon_area)
	end
end)

module:hook(GroupAIStateBesiege, "_upd_assault_task", function(self)
	local task_data = self._task_data.assault
	if not task_data.active then
		return
	end

	local t = self._t
	if task_data.phase == "anticipation" then
		if t > task_data.phase_end_t then
			managers.hud:start_assault()
			self:_set_rescue_state(false)
			task_data.phase = "build"
			task_data.phase_end_t = self._t + tweak_data.group_ai.besiege.assault.build_duration
			self:set_assault_mode(true)
			managers.trade:set_trade_countdown(false)
		else
			managers.hud:check_anticipation_voice(task_data.phase_end_t - t)
			managers.hud:check_start_anticipation_music(task_data.phase_end_t - t)
		end
	elseif task_data.phase == "build" then
		if t > task_data.phase_end_t or self._drama_data.zone == "high" then
			task_data.phase = "sustain"
			task_data.phase_end_t = t
				+ math.lerp(
					self:_get_difficulty_dependent_value(tweak_data.group_ai.besiege.assault.sustain_duration_min),
					self:_get_difficulty_dependent_value(tweak_data.group_ai.besiege.assault.sustain_duration_max),
					math.random()
				)
		end
	elseif task_data.phase == "sustain" then
		if t > task_data.phase_end_t and not self._hunt_mode then
			task_data.phase = "fade"
			task_data.use_smoke = false
			task_data.use_smoke_timer = t + 20
			task_data.phase_end_t = t + 10
		end
	elseif t > task_data.phase_end_t - 8 and not task_data.said_retreat then
		if self._drama_data.amount < tweak_data.drama.assault_fade_end then
			task_data.said_retreat = true
			self:_police_announce_retreat()
		end
	elseif t > task_data.phase_end_t and self._drama_data.amount < tweak_data.drama.assault_fade_end then
		task_data.active = nil
		task_data.phase = nil
		task_data.said_retreat = nil
		if self._draw_drama then
			self._draw_drama.assault_hist[#self._draw_drama.assault_hist][2] = t
		end

		self:_begin_regroup_task()
		return
	end

	local primary_target_area = task_data.target_areas[1]
	local area_data = self._area_data[primary_target_area]
	local area_safe = true
	for criminal_key, _ in pairs(area_data.criminal.units) do
		local criminal_data = self._criminals[criminal_key]
		if not criminal_data.status and not criminal_data.is_deployable then
			local crim_area = criminal_data.tracker:nav_segment()
			if crim_area == primary_target_area then
				area_safe = nil
				break
			end
		end
	end

	if area_safe then
		local target_pos = managers.navigation._nav_segments[primary_target_area].pos
		local nearest_area, nearest_dis
		for _, criminal_data in pairs(self._criminals) do
			if not criminal_data.status and not criminal_data.is_deployable then
				local dis = mvector3.distance_sq(target_pos, criminal_data.m_pos)
				if not nearest_dis or nearest_dis > dis then
					nearest_dis = dis
					nearest_area = criminal_data.tracker:nav_segment()
				end
			end
		end

		if nearest_area then
			primary_target_area = nearest_area
			task_data.target_areas[1] = nearest_area
		end
	end

	if task_data.phase == "anticipation" then
		local spawn_threshold = math.max(0, self._police_force_max - self._police_force - 5)
		if 0 < spawn_threshold then
			local nr_wanted = math.min(spawn_threshold, task_data.force - self._police_force)
			if 0 < nr_wanted then
				nr_wanted = math.min(3, nr_wanted)
				local spawn_points = self:_find_spawn_points_near_area(
					primary_target_area,
					nr_wanted,
					nil,
					10000,
					callback(self, self, "_verify_anticipation_spawn_point")
				)

				if spawn_points then
					local objectives = {}
					local function complete_clbk(chatter_unit)
						if
							not chatter_unit:sound():speaking(self._t)
							and tweak_data.character[chatter_unit:base()._tweak_table].chatter.ready
						then
							self:chk_say_enemy_chatter(chatter_unit, chatter_unit:movement():m_pos(), "ready")
						end
					end

					for _, sp_data in ipairs(spawn_points) do
						local new_objective = {
							type = "investigate_area",
							nav_seg = sp_data.nav_seg,
							attitude = "avoid",
							stance = "hos",
							interrupt_on = "obstructed",
							scan = true,
							complete_clbk = complete_clbk,
						}
						table.insert(objectives, new_objective)
					end

					GroupAIStateStreet._spawn_cops_with_objectives(
						self,
						spawn_points,
						objectives,
						tweak_data.group_ai.besiege.assault.units
					)
				end
			end
		end

		return
	end

	if task_data.phase ~= "fade" and task_data.phase ~= "anticipation" then
		local spawn_threshold = math.max(0, self._police_force_max - self._police_force)
		if 0 < spawn_threshold then
			local nr_wanted = math.min(spawn_threshold, task_data.force - self._police_force)
			if 0 < nr_wanted then
				local used_event
				if task_data.use_spawn_event then
					task_data.use_spawn_event = false
					if self:_try_use_task_spawn_event(t, primary_target_area, "assault") then
						used_event = true
					end
				end

				if not used_event then
					nr_wanted = math.min(3, nr_wanted)
					local spawn_points = self:_find_spawn_points_near_area(primary_target_area, nr_wanted)
					if spawn_points then
						self:_spawn_cops_to_recon(primary_target_area, spawn_points, "engage", "assault")
					end
				end
			end
		end

		local existing_cops = self:_find_surplus_cops_around_area(primary_target_area, 100, 0)
		if existing_cops then
			self:_assign_cops_to_recon(primary_target_area, existing_cops, "engage")
		end
	end

	if t > task_data.use_smoke_timer then
		task_data.use_smoke = true
	end

	if task_data.use_smoke and not self:is_smoke_grenade_active() then
		local shoot_smoke, shooter_pos, shooter_u_data, detonate_pos
		local duration = 0
		if self._smoke_grenade_queued then
			shoot_smoke = true
			shooter_pos = self._smoke_grenade_queued[1]
			detonate_pos = self._smoke_grenade_queued[1]
			duration = self._smoke_grenade_queued[2]
		else
			local door_found
			local shoot_from_neighbours = managers.navigation:get_nav_seg_neighbours(primary_target_area)
			for u_key, u_data in pairs(self._police) do
				local nav_seg = u_data.tracker:nav_segment()
				if nav_seg == primary_target_area then
					task_data.use_smoke = false
					door_found = nil
					break
				elseif not door_found then
					local door_ids = shoot_from_neighbours[nav_seg]
					if door_ids and tweak_data.character[u_data.unit:base()._tweak_table].use_smoke then
						local random_door_id = door_ids[math.random(#door_ids)]
						if type(random_door_id) == "number" then
							door_found = managers.navigation._room_doors[random_door_id]
							shooter_pos = mvector3.copy(u_data.m_pos)
							shooter_u_data = u_data
						end
					end
				end
			end

			if door_found then
				detonate_pos = mvector3.copy(door_found.center)
				shoot_smoke = true
			end
		end

		if shoot_smoke then
			task_data.use_smoke_timer = t + math.lerp(10, 40, math.rand(0, 1) ^ 0.5)
			task_data.use_smoke = false

			if Network:is_server() then
				local ignore_ctrl
				if self._smoke_grenade_queued and self._smoke_grenade_queued[3] then
					ignore_ctrl = true
				end

				managers.network:session():send_to_peers("sync_smoke_grenade", detonate_pos, shooter_pos, duration)
				self:sync_smoke_grenade(detonate_pos, shooter_pos, duration)

				if ignore_ctrl then
					self._smoke_grenade_ignore_control = true
				end

				if
					shooter_u_data
					and not shooter_u_data.unit:sound():speaking(self._t)
					and tweak_data.character[shooter_u_data.unit:base()._tweak_table].chatter.smoke
				then
					self:chk_say_enemy_chatter(shooter_u_data.unit, shooter_u_data.m_pos, "smoke")
				end
			end
		end
	end
end)

module:hook(GroupAIStateBesiege, "_verify_anticipation_spawn_point", function(self, sp_data)
	local sp_nav_seg = sp_data.nav_seg
	local area = self._area_data[sp_nav_seg]
	if area.is_safe then
		return true
	else
		for _, c_data in pairs(self._criminals) do
			if
				not c_data.status
				and not c_data.is_deployable
				and mvector3.distance(sp_data.pos, c_data.m_pos) < 2500
				and math.abs(sp_data.pos.z - c_data.m_pos.z) < 300
			then
				return
			end
		end
	end

	return true
end)
