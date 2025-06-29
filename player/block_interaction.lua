local module = ... or D:module("fgo")

local whitelist = {
	["drill"] = true,
	["s_drill_2h"] = true,
	["embassy_door"] = true,
	["apartment_saw"] = "bridge",
	["hack_ipad"] = true,
	["hospital_saw"] = true,
	["c4"] = true,
	-- ["c4_special"] = true,
	["apartment_key"] = true,
	["open_door"] = true,
}

if RequiredScript == "lib/units/interactions/interactionext" then
	local BaseInteractionExt = module:hook_class("BaseInteractionExt")
	local current_level
	module:post_hook(BaseInteractionExt, "init", function(self, unit)
		current_level = current_level or Global.level_data.level_id
		local data = whitelist[self.tweak_data]
		if type(data) == "nil" then
			return
		end

		local ignore_wall
		if type(data) == "boolean" and data or (data == current_level) then
			ignore_wall = true
		end

		if type(data) == "table" and table.contains(data, current_level) then
			ignore_wall = true
		end

		self.ignore_wall = ignore_wall
	end)
end

if RequiredScript == "lib/managers/objectinteractionmanager" then
	local ObjectInteractionManager = module:hook_class("ObjectInteractionManager")

	local check_wall = function(obj)
		if obj:interaction().ignore_wall then
			return false
		end

		return obj:raycast(
			"ray",
			obj:interaction():interact_position(),
			managers.viewport:get_current_camera_position(),
			"slot_mask",
			managers.slot:get_mask("world_geometry"),
			"report"
		)
	end

	local mvec1 = Vector3()
	local mvec3_dis = mvector3.distance
	module:hook(ObjectInteractionManager, "_update_targeted", function(self, player_pos, player_unit)
		if next(self._close_objects) then
			for k, unit in pairs(self._close_objects) do
				if alive(unit) and unit:interaction():active() then
					local interaction = unit:interaction()
					if
						check_wall(unit)
						or mvec3_dis(player_pos, interaction:interact_position()) > interaction:interact_distance()
					then
						table.remove(self._close_objects, k)
					end
				else
					table.remove(self._close_objects, k)
				end
			end
		end

		for _ = 1, self._close_freq do
			self._close_index = (self._close_index >= self._interactive_count) and 1 or self._close_index + 1

			local obj = self._interactive_objects[self._close_index]
			if
				alive(obj)
				and obj:interaction():active()
				and not self:_in_close_list(obj)
				and not check_wall(obj)
				and mvec3_dis(player_pos, obj:interaction():interact_position())
					<= obj:interaction():interact_distance()
			then
				table.insert(self._close_objects, obj)
			end
		end

		local last_active = self._active_object
		if next(self._close_objects) then
			local active_obj
			local current_dot = 0.9
			local player_fwd = player_unit:camera():forward()
			local camera_pos = player_unit:camera():position()
			for _, unit in pairs(self._close_objects) do
				if alive(unit) then
					mvector3.set(mvec1, unit:interaction():interact_position())
					mvector3.subtract(mvec1, camera_pos)
					mvector3.normalize(mvec1)
					local dot = mvector3.dot(player_fwd, mvec1)
					if current_dot < dot then
						local interact_axis = unit:interaction():interact_axis()
						if not interact_axis or 0 > mvector3.dot(mvec1, interact_axis) then
							current_dot = dot
							active_obj = unit
						end
					end
				end
			end

			if active_obj and self._active_object ~= active_obj then
				if alive(self._active_object) then
					self._active_object:interaction():unselect()
				end
				active_obj:interaction():selected(player_unit)
			end

			self._active_object = active_obj
		else
			self._active_object = nil
		end

		if alive(last_active) and not self._active_object then
			last_active:interaction():unselect()
		end
	end)
end
