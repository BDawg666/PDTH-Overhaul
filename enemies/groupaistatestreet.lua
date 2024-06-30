function GroupAIStateStreet:_upd_assault_task(t)
	local task_data = self._task_data.assault
	if not task_data.active then
		return
	end

	local task_phase = task_data.phase
	if task_data.phase == "anticipation" then
		if t > task_data.phase_end_t then
			managers.hud:start_assault()
			self:_set_rescue_state(false)
			task_data.phase = "build"
			task_data.phase_end_t = self._t + tweak_data.group_ai.street.assault.build_duration
			self:set_assault_mode(true)
			managers.trade:set_trade_countdown(false)
		else
			managers.hud:check_anticipation_voice(task_data.phase_end_t - t)
			managers.hud:check_start_anticipation_music(task_data.phase_end_t - t)
		end
	elseif task_data.phase == "build" then
		if t > task_data.phase_end_t or self._drama_data.zone == "high" then
			task_data.phase = "sustain"
			task_phase = task_data.phase
			task_data.phase_end_t = t
				+ math.lerp(
					self:_get_difficulty_dependent_value(tweak_data.group_ai.street.assault.sustain_duration_min),
					self:_get_difficulty_dependent_value(tweak_data.group_ai.street.assault.sustain_duration_max),
					math.random()
				)
		end
	elseif task_phase == "sustain" then
		if t > task_data.phase_end_t and not self._hunt_mode then
			task_data.phase = "fade"
			task_phase = task_data.phase
			task_data.use_smoke = false
			task_data.use_smoke_timer = t + 20
			task_data.phase_end_t = nil
			task_data.phase_end_t = t + 10
		end
	elseif t > task_data.phase_end_t - 8 and not task_data.said_retreat then
		if self._drama_data.zone ~= "high" then
			task_data.said_retreat = true
			self:_police_announce_retreat()
		end
	elseif t > task_data.phase_end_t and self._drama_data.zone ~= "high" then
		task_data.active = nil
		task_data.phase = nil
		task_data.said_retreat = nil
		if self._draw_drama then
			self._draw_drama.assault_hist[#self._draw_drama.assault_hist][2] = t
		end
		self:_begin_regroup_task(true)
		return
	end

	local aggressive_cops = {}
	local nr_agressive_cops = 0
	local defensive_cops = {}
	local nr_defensive_cops = 0
	for u_key, u_data in pairs(self._police) do
		if u_data.assigned_area then
			local objective = u_data.unit:brain():objective()
			if not objective then
				defensive_cops[u_key] = u_data
				nr_defensive_cops = nr_defensive_cops + 1
			elseif objective.type == "defend_area" then
				if not u_data.assigned_area.factors or not u_data.assigned_area.factors.force then
					defensive_cops[u_key] = u_data
					nr_defensive_cops = nr_defensive_cops + 1
				end
			elseif objective.attitude == "engage" then
				aggressive_cops[u_key] = u_data
				nr_agressive_cops = nr_agressive_cops + 1
			else
				defensive_cops[u_key] = u_data
				nr_defensive_cops = nr_defensive_cops + 1
			end
		end
	end

	local target_area = task_data.target_area
	local area_data = self._area_data[target_area]
	local area_safe = true
	for criminal_key, _ in pairs(area_data.criminal.units) do
		local criminal_data = self._criminals[criminal_key]
		if not criminal_data.status and not criminal_data.is_deployable then
			local crim_area = criminal_data.tracker:nav_segment()
			if crim_area == target_area then
				area_safe = nil
				break
			end
		end
	end

	if area_safe then
		local target_pos = managers.navigation._nav_segments[target_area].pos
		local nearest_area, nearest_dis
		for _, criminal_data in pairs(self._criminals) do
			if not criminal_data.status and not criminal_data.is_deployable then
				local dis = mvector3.distance(target_pos, criminal_data.m_pos)
				if not nearest_dis or nearest_dis > dis then
					nearest_dis = dis
					nearest_area = criminal_data.tracker:nav_segment()
				end
			end
		end

		if nearest_area then
			target_area = nearest_area
			task_data.target_area = nearest_area
		end
	end

	local mvec3_dis = mvector3.distance
	local all_criminals = self._criminals
	local healthy_criminals = {}
	for c_key, c_data in pairs(all_criminals) do
		if not c_data.status and not c_data.is_deployable then
			healthy_criminals[c_key] = c_data
		end
	end

	if task_phase == "anticipation" then
		local spawn_threshold = math.max(0, self._police_force_max - self._police_force - 5)
		if 0 < spawn_threshold then
			local nr_wanted =
				math.min(spawn_threshold, task_data.force.defensive + task_data.force.aggressive - self._police_force)
			if 0 < nr_wanted then
				nr_wanted = math.min(3, nr_wanted)
				local spawn_points = GroupAIStateBesiege._find_spawn_points_near_area(
					self,
					target_area,
					nr_wanted,
					nil,
					10000,
					callback(self, GroupAIStateBesiege, "_verify_anticipation_spawn_point"),
					self
				)
				if spawn_points then
					local objectives = {}
					for _, sp_data in ipairs(spawn_points) do
						local new_objective = {
							type = "investigate_area",
							nav_seg = sp_data.nav_seg,
							attitude = "avoid",
							stance = "hos",
							interrupt_on = "obstructed",
							scan = true,
						}
						table.insert(objectives, new_objective)
					end

					self:_spawn_cops_with_objectives(
						spawn_points,
						objectives,
						tweak_data.group_ai.besiege.assault.units
					)
				end
			end
		end

		return
	else
		local spawn_threshold = task_phase == "fade" and 0 or math.max(0, self._police_force_max - self._police_force)
		local objective_attitude = "engage"
		local objective_interrupt = "obstructed"
		if task_phase == "anticipation" then
			objective_attitude = "avoid"
			spawn_threshold = math.max(0, spawn_threshold - 5)
		end

		local wanted_nr_aggressive_cops = task_data.force.aggressive
		local undershot_aggressive = wanted_nr_aggressive_cops - nr_agressive_cops
		if 0 < undershot_aggressive then
			local u_key, u_data
			while 0 < undershot_aggressive and 0 < nr_defensive_cops do
				u_key, u_data = next(defensive_cops, u_key)
				if not u_key then
					break
				end

				local unit = u_data.unit
				if
					not u_data.follower
					and u_data.unit:brain():is_available_for_assignment({
						type = "investigate_area",
						interrupt_on = objective_interrupt,
					})
				then
					local closest_dis, closest_criminal_data
					for c_key, c_data in pairs(healthy_criminals) do
						local my_dis = mvec3_dis(c_data.m_pos, u_data.m_pos)
						if not closest_dis or closest_dis > my_dis then
							closest_dis = my_dis
							closest_criminal_data = c_data
						end
					end
					if closest_criminal_data then
						local crim_area = closest_criminal_data.tracker:nav_segment()
						local new_objective = {
							type = "investigate_area",
							nav_seg = crim_area,
							attitude = objective_attitude,
							stance = "hos",
							interrupt_on = objective_interrupt,
							scan = true,
							pos = mvector3.copy(closest_criminal_data.m_pos),
						}
						unit:brain():set_objective(new_objective)
						self:_set_enemy_assigned(self._area_data[crim_area], unit:key())
						defensive_cops[u_key] = nil
						nr_defensive_cops = nr_defensive_cops - 1
						aggressive_cops[u_key] = u_data
						nr_agressive_cops = nr_agressive_cops + 1
						undershot_aggressive = undershot_aggressive - 1
					end
				end
			end

			if 0 < undershot_aggressive and 0 < spawn_threshold then
				local spawn_amount = math.min(undershot_aggressive, spawn_threshold)
				local spawn_points = GroupAIStateBesiege._find_spawn_points_near_area(self, target_area, spawn_amount)
				if spawn_points then
					local objectives = {}
					for _, sp_data in ipairs(spawn_points) do
						local closest_dis, closest_criminal_data
						for c_key, c_data in pairs(healthy_criminals) do
							local my_dis = mvec3_dis(c_data.m_pos, sp_data.pos)
							if not closest_dis or closest_dis > my_dis then
								closest_dis = my_dis
								closest_criminal_data = c_data
							end
						end
						if closest_criminal_data then
							local crim_area = closest_criminal_data.tracker:nav_segment()
							local new_objective = {
								type = "investigate_area",
								nav_seg = crim_area,
								attitude = objective_attitude,
								stance = "hos",
								interrupt_on = objective_interrupt,
								scan = true,
								pos = mvector3.copy(closest_criminal_data.m_pos),
							}
							table.insert(objectives, new_objective)
						end
					end

					self:_spawn_cops_with_objectives(spawn_points, objectives, tweak_data.group_ai.street.assault.units)
					spawn_threshold = spawn_threshold - #spawn_points
				end
			end
		elseif undershot_aggressive < 0 and task_phase ~= "fade" then
			local u_key, u_data
			while undershot_aggressive < 0 do
				u_key, u_data = next(aggressive_cops, u_key)
				if not u_key then
					break
				end

				if not u_data.follower and not u_data.unit:brain()._important then
					local unit = u_data.unit
					local old_objective = unit:brain():objective()
					if old_objective and u_data.unit:brain():is_available_for_assignment() then
						local new_objective = deep_clone(old_objective)
						new_objective.attitude = "avoid"
						unit:brain():set_objective(new_objective)
						aggressive_cops[u_key] = nil
						nr_agressive_cops = nr_agressive_cops - 1
						undershot_aggressive = undershot_aggressive + 1
						defensive_cops[u_key] = u_data
						nr_defensive_cops = nr_defensive_cops + 1
					end
				end
			end
		end

		local wanted_nr_defensive_cops = task_data.force.defensive
		local undershot_defensive = wanted_nr_defensive_cops - nr_defensive_cops
		if 0 < undershot_defensive and 0 < spawn_threshold then
			local spawn_amount = math.min(undershot_defensive, spawn_threshold)
			local spawn_points = GroupAIStateBesiege._find_spawn_points_near_area(self, target_area, spawn_amount)
			if spawn_points then
				local objectives = {}
				for _, sp_data in ipairs(spawn_points) do
					local closest_dis, closest_criminal_data
					for c_key, c_data in pairs(healthy_criminals) do
						local my_dis = mvec3_dis(c_data.m_pos, sp_data.pos)
						if not closest_dis or closest_dis > my_dis then
							closest_dis = my_dis
							closest_criminal_data = c_data
						end
					end

					if closest_criminal_data then
						local crim_area = closest_criminal_data.tracker:nav_segment()
						local new_objective = {
							type = "investigate_area",
							nav_seg = crim_area,
							attitude = "avoid",
							stance = "hos",
							interrupt_on = "obstructed",
							scan = true,
							pos = mvector3.copy(closest_criminal_data.m_pos),
						}

						table.insert(objectives, new_objective)
					end
				end
				self:_spawn_cops_with_objectives(spawn_points, objectives, tweak_data.group_ai.street.assault.units)
				spawn_threshold = spawn_threshold - #spawn_points
			end
		elseif task_phase == "fade" then
			for u_key, u_data in pairs(defensive_cops) do
				local unit = u_data.unit
				if
					not u_data.follower
					and u_data.unit:brain():is_available_for_assignment({
						type = "investigate_area",
						interrupt_on = "contact",
					})
				then
					local closest_dis, closest_criminal_data
					for c_key, c_data in pairs(healthy_criminals) do
						local my_dis = mvec3_dis(c_data.m_pos, u_data.m_pos)
						if not closest_dis or closest_dis > my_dis then
							closest_dis = my_dis
							closest_criminal_data = c_data
						end
					end

					if closest_criminal_data then
						local crim_area = closest_criminal_data.tracker:nav_segment()
						local new_objective = {
							type = "investigate_area",
							nav_seg = crim_area,
							attitude = "engage",
							stance = "hos",
							interrupt_on = "contact",
							scan = true,
							pos = mvector3.copy(closest_criminal_data.m_pos),
						}

						unit:brain():set_objective(new_objective)
						self:_set_enemy_assigned(self._area_data[crim_area], unit:key())

						defensive_cops[u_key] = nil
						nr_defensive_cops = nr_defensive_cops - 1

						aggressive_cops[u_key] = u_data
						nr_agressive_cops = nr_agressive_cops + 1
						undershot_aggressive = undershot_aggressive - 1
					end
				end
			end
		end

		for u_key, u_data in pairs(defensive_cops) do
			if not u_data.unit:brain():objective() then
				local closest_dis, closest_criminal_data
				for c_key, c_data in pairs(healthy_criminals) do
					local my_dis = mvec3_dis(c_data.m_pos, u_data.m_pos)
					if not closest_dis or closest_dis > my_dis then
						closest_dis = my_dis
						closest_criminal_data = c_data
					end
				end

				if closest_criminal_data then
					local crim_area = closest_criminal_data.tracker:nav_segment()
					local new_objective = {
						type = "investigate_area",
						nav_seg = crim_area,
						attitude = "avoid",
						stance = "hos",
						interrupt_on = "contact",
						scan = true,
						pos = mvector3.copy(closest_criminal_data.m_pos),
					}
				end
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
				local target_area = task_data.target_area
				local shoot_from_neighbours = managers.navigation:get_nav_seg_neighbours(target_area)
				local door_found
				for u_key, u_data in pairs(self._police) do
					local nav_seg = u_data.tracker:nav_segment()
					if nav_seg == target_area then
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

					managers.network:session():send_to_peers("sync_smoke_grenade", detonate_pos, shooter_pos, 0)
					self:sync_smoke_grenade(detonate_pos, shooter_pos, 0)

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
	end
end

function GroupAIStateStreet:_upd_blockade_task(t)
	local task_data = self._task_data.blockade
	if not task_data.active then
		return
	end

	local mvec3_dis = mvector3.distance
	local event = task_data.event
	local target_pos = event.pos
	local phase = task_data.phase
	if not phase and not task_data.passive and task_data.next_dispatch_t and t > task_data.next_dispatch_t then
		task_data.dispatch()
		phase = task_data.phase
	end

	local relevant_areas = event.relevant_areas
	local relevant_players = {}
	local has_irrelevant_players
	for c_key, c_data in pairs(self._player_criminals) do
		local nav_seg = c_data.tracker:nav_segment()
		if relevant_areas[nav_seg] then
			if not c_data.status then
				relevant_players[c_key] = c_data
			end
		else
			has_irrelevant_players = true
		end
	end

	local failed_to_change_event
	if has_irrelevant_players then
		local event = self:_find_blockade_event(t)
		if event then
			task_data.event = event
			task_data.target_area = event.nav_seg
			task_data.mission_fwd = event.rot:y()
			self:_use_spawn_event(event)
			event = task_data.event
			target_pos = event.pos
		else
			failed_to_change_event = true
		end
	end

	local compromise_dis = task_data.compromise_dis
	local nearest_dis, compromised
	for _, blockade_point in ipairs(event.blockade_points) do
		local blockade_pos = blockade_point[2]
		for c_key, c_record in pairs(relevant_players) do
			local pl_dis = mvec3_dis(c_record.m_pos, blockade_pos)
			if not failed_to_change_event and compromise_dis > pl_dis then
				local event = self:_find_blockade_event(t)
				if event then
					task_data.event = event
					task_data.target_area = event.nav_seg
					task_data.mission_fwd = event.rot:y()
					self:_use_spawn_event(event)
					return
				else
				end
			elseif not nearest_dis or nearest_dis > pl_dis then
				nearest_dis = pl_dis
			end
		end
	end

	if phase == "anticipation" then
		if t > task_data.phase_end_t then
			managers.hud:start_assault()
			self:_set_rescue_state(false)
			task_data.phase = "build"
			phase = task_data.phase
			task_data.phase_end_t = self._t + tweak_data.group_ai.street.blockade.build_duration
			self:set_assault_mode(true)
			managers.trade:set_trade_countdown(false)
		else
			managers.hud:check_anticipation_voice(task_data.phase_end_t - t)
			managers.hud:check_start_anticipation_music(task_data.phase_end_t - t)
		end
	elseif phase == "build" then
		if t > task_data.phase_end_t or self._drama_data.zone == "high" then
			task_data.phase = "sustain"
			phase = task_data.phase
			task_data.phase_end_t = t
				+ math.lerp(
					self:_get_difficulty_dependent_value(tweak_data.group_ai.street.blockade.sustain_duration_min),
					self:_get_difficulty_dependent_value(tweak_data.group_ai.street.blockade.sustain_duration_max),
					math.random()
				)
		end
	elseif phase == "sustain" then
		if t > task_data.phase_end_t and not self._hunt_mode then
			task_data.phase = "fade"
			phase = task_data.phase
			task_data.phase_end_t = nil
			task_data.phase_end_t = t + 10
		end
	elseif phase == "fade" then
		if t > task_data.phase_end_t - 8 and not task_data.said_retreat then
			if self._drama_data.zone ~= "high" then
				task_data.said_retreat = true
				self:_police_announce_retreat()
			end
		elseif t > task_data.phase_end_t and self._drama_data.zone ~= "high" then
			task_data.active = nil
			task_data.phase = nil
			phase = task_data.phase
			task_data.said_retreat = nil
			if self._draw_drama then
				self._draw_drama.assault_hist[#self._draw_drama.assault_hist][2] = t
			end

			self:_begin_regroup_task(true)

			return
		end
	end

	local attitude = phase and "engage" or "avoid"
	local cops_in_area = self._area_data[task_data.target_area].police.units
	local blocker_pigs = {}
	local front_pigs = 0
	for u_key, u_data in pairs(self._police) do
		if u_data.assigned_area then
			if
				cops_in_area[u_key]
				and u_data.unit:brain():objective()
				and u_data.unit:brain():objective().type == "defend_area"
			then
				table.insert(blocker_pigs, u_key)
			else
				front_pigs = front_pigs + 1
			end
		end
	end

	local undershot = task_data.force_required.defend - #blocker_pigs
	local spawn_threshold = math.max(0, self._police_force_max - self._police_force)
	if 0 < undershot then
		if 0 < spawn_threshold and not self:_try_use_task_spawn_event(t, task_data.target_area, "assault") then
			local nr_wanted = math.min(spawn_threshold, undershot, math.random(2, 3))
			local spawn_points =
				self:_find_spawn_points_behind_pos(task_data.target_area, target_pos, nr_wanted, task_data.mission_fwd)
			if spawn_points then
				local objectives = {}
				local objective = {
					type = "defend_area",
					nav_seg = task_data.target_area,
					pos = target_pos,
					defend_dir = -task_data.mission_fwd,
					status = "in_progress",
					stance = "cbt",
					attitude = attitude,
				}
				for _, _ in ipairs(spawn_points) do
					local my_objective = deep_clone(objective)
					my_objective.pos = mvector3.copy(event.blockade_points[math.random(#event.blockade_points)][2])
					table.insert(objectives, my_objective)
				end

				self:_spawn_cops_with_objectives(
					spawn_points,
					objectives,
					tweak_data.group_ai.street.blockade.units.defend
				)
				spawn_threshold = spawn_threshold - #spawn_points
			end
		end
	elseif undershot < 0 then
		for _ = 1, -undershot do
			local u_key = blocker_pigs[#blocker_pigs]
			table.remove(blocker_pigs)
			local u_data = self._police[u_key]
			u_data.unit:brain():set_objective(nil)
		end
	end

	if not self._task_data.regroup.active then
		if 0 < spawn_threshold then
			local flank_assault = task_data.flank_assault
			if flank_assault.sneak_unit_key and not self._police[flank_assault.sneak_unit_key] then
				flank_assault.sneak_unit_key = nil
				flank_assault.next_dispatch_t = t + math.random(45, 300)
			end

			if not flank_assault.sneak_unit_key and t > flank_assault.next_dispatch_t then
				local search_start_area = task_data.target_area
				local target_area_neighbours = managers.navigation._nav_segments[task_data.target_area].neighbours
				for nav_seg, _ in pairs(relevant_areas) do
					if target_area_neighbours[nav_seg] then
						search_start_area = nav_seg
						break
					end
				end

				local spawn_points = self:_find_spawn_points_behind_pos(
					search_start_area,
					target_pos,
					1,
					-task_data.mission_fwd,
					relevant_areas
				)

				if spawn_points then
					local my_objective = {
						type = "investigate_area",
						status = "in_progress",
						stance = "hos",
						attitude = attitude,
						interrupt_on = "obstructed",
					}
					local closest_criminal_data, closest_dis
					for _, c_data in pairs(relevant_players) do
						if not c_data.status then
							local my_dis = mvec3_dis(c_data.m_pos, target_pos)
							if not closest_dis or closest_dis < my_dis then
								closest_dis = my_dis
								closest_criminal_data = c_data
							end
						end
					end

					if closest_criminal_data then
						my_objective.nav_seg = closest_criminal_data.tracker:nav_segment()
					else
						my_objective.nav_seg = task_data.target_area
					end

					local spawned_units = {}
					self:_spawn_cops_with_objectives(
						spawn_points,
						{ my_objective },
						tweak_data.group_ai.street.blockade.units.flank,
						spawned_units
					)

					local sneak_unit = spawned_units[1]
					if sneak_unit then
						flank_assault.sneak_unit_key = sneak_unit:key()
					end
				end
			end
		end

		if 0 < spawn_threshold and (phase == "build" or phase == "sustain") then
			local wanted_fwd = math.min(task_data.force_required.frontal - front_pigs, spawn_threshold)
			if 0 < wanted_fwd and not self:_try_use_task_spawn_event(t, task_data.target_area, "assault") then
				wanted_fwd = math.min(wanted_fwd, math.random(2, 3))
				local spawn_points = self:_find_spawn_points_behind_pos(
					task_data.target_area,
					target_pos,
					wanted_fwd,
					task_data.mission_fwd,
					nil
				)
				if spawn_points then
					local objectives = {}
					local objective = {
						type = "investigate_area",
						status = "in_progress",
						stance = "hos",
						attitude = attitude,
						interrupt_on = "obstructed",
					}
					for _, sp_data in ipairs(spawn_points) do
						local sp_pos = sp_data.pos
						local my_objective = deep_clone(objective)
						local closest_criminal_data, closest_dis
						for c_key, c_data in pairs(self._criminals) do
							if not c_data.status and not c_data.is_deployable then
								local my_dis = mvec3_dis(c_data.m_pos, sp_pos)
								if not closest_dis or closest_dis > my_dis then
									closest_dis = my_dis
									closest_criminal_data = c_data
								end
							end
						end
						if closest_criminal_data then
							my_objective.nav_seg = closest_criminal_data.tracker:nav_segment()
						else
							my_objective.nav_seg = task_data.target_area
						end
						table.insert(objectives, my_objective)
					end
					self:_spawn_cops_with_objectives(
						spawn_points,
						objectives,
						tweak_data.group_ai.street.blockade.units.frontal
					)
					spawn_threshold = spawn_threshold - #spawn_points
				end
			end
		end
	end

	for u_key, u_data in pairs(self._police) do
		if
			u_data.assigned_area
			and u_data.unit:brain():is_available_for_assignment({
				type = "investigate_area",
				interrupt_on = "obstructed",
			})
		then
			local objective = u_data.unit:brain():objective()
			if not objective or objective.type == "free" then
				local closest_criminal_data, closest_dis
				for c_key, c_data in pairs(relevant_players) do
					if not c_data.status and not c_data.is_deployable then
						local my_dis = mvec3_dis(c_data.m_pos, u_data.m_pos)
						if not closest_dis or closest_dis > my_dis then
							closest_dis = my_dis
							closest_criminal_data = c_data
						end
					end
				end

				if closest_criminal_data and 5000 < closest_dis then
					local move_area = closest_criminal_data.tracker:nav_segment()
					local new_objective = {
						type = "investigate_area",
						nav_seg = move_area,
						status = "in_progress",
						attitude = attitude,
						stance = "hos",
						interrupt_on = "obstructed",
						pos = mvector3.copy(closest_criminal_data.m_pos),
					}
					u_data.unit:brain():set_objective(new_objective)
					self:_set_enemy_assigned(self._area_data[move_area], u_key)
				end
			end
		end
	end
end
