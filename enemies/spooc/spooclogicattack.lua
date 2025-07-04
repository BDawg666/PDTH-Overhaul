local module = ... or D:module("fgo")

local SpoocLogicAttack = module:hook_class("SpoocLogicAttack")
module:hook(SpoocLogicAttack, "_is_last_standing_criminal", function()
	return table.size(managers.groupai:state():all_char_criminals()) <= 1
end)

module:hook(SpoocLogicAttack, "_upd_spooc_attack", function(data, my_data)
	local target = my_data.focus_enemy
	local target_unit = target.unit
	local record = managers.groupai:state():criminal_record(target_unit:key())
	if record.is_deployable or record.status then
		return false
	end

	if my_data.spooc_attack or not target.verified then
		return false
	end

	local target_mov = target_unit:movement()
	if
		(my_data.attitude == "engage" and 1500 or 900) > target.verified_dis
		and (not my_data.last_dmg_t or data.t - my_data.last_dmg_t > 0.6)
		and not data.unit:movement():chk_action_forbidden("walk")
		and not SpoocLogicAttack._is_last_standing_criminal()
	then
		local enemy_tracker = target_mov:nav_tracker()
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
			local z_diff_abs = math.abs(ray_params.trace[1].z - target.m_pos.z)
			if z_diff_abs < 200 and SpoocLogicAttack._chk_request_action_spooc_attack(data, my_data) then
				my_data.spooc_attack = {
					start_t = data.t,
					target_u_data = target,
				}
				return true
			end
		end
	end

	return false
end)
