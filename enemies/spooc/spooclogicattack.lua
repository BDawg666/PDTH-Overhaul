local SpoocLogicAttack = module:hook_class("SpoocLogicAttack")

module:hook(SpoocLogicAttack, "_is_last_standing_criminal", function(focus_enemy)
	local all_criminals = managers.groupai:state():all_char_criminals()

	for u_key, u_data in pairs(all_criminals) do
		if not u_data.status and focus_enemy.u_key ~= u_key then
			return
		end
	end

	return true
end)

module:hook(SpoocLogicAttack, "_upd_spooc_attack", function(data, my_data)
	local focus_enemy = my_data.focus_enemy
	local record = managers.groupai:state():criminal_record(focus_enemy.unit:key())
	if not record.is_deployable and not record.status and not my_data.spooc_attack and focus_enemy.verified then
		if
			focus_enemy.verified_dis < (my_data.attitude == "engage" and 1500 or 900)
			and not data.unit:movement():chk_action_forbidden("walk")
			and (not my_data.last_dmg_t or data.t - my_data.last_dmg_t > 0.6)
			and SpoocLogicAttack._is_last_standing_criminal(focus_enemy)
		then
			local enemy_tracker = focus_enemy.unit:movement():nav_tracker()
			local ray_params = {
				tracker_from = data.unit:movement():nav_tracker(),
				tracker_to = enemy_tracker,
				trace = true,
			}
			if enemy_tracker:lost() then
				ray_params.pos_to = enemy_tracker:field_position()
			end
			local col_ray = managers.navigation:raycast(ray_params)
			if not col_ray then
				local z_diff_abs = math.abs(ray_params.trace[1].z - focus_enemy.m_pos.z)
				if z_diff_abs < 200 and SpoocLogicAttack._chk_request_action_spooc_attack(data, my_data) then
					my_data.spooc_attack = {
						start_t = data.t,
						target_u_data = focus_enemy,
					}
					return true
				end
			end
		end
	end
end)
