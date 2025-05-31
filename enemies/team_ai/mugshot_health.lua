local module = ... or D:module("fgo")

if RequiredScript == "lib/managers/hudmanager" then
	local colors = {
		hp_low = Color(1, 0, 0),
		hp_normal = Color(0.5, 0.8, 0.4),
		state_downed = Color(1, 0, 0),
	}

	local HUDManager = module:hook_class("HUDManager")
	module:post_hook(HUDManager, "_add_mugshot", function(self, data, mugshot_data)
		mugshot_data.health_background:show()
		mugshot_data.health_health:show()
	end, false)

	module:post_hook(HUDManager, "layout_mugshot_health", function(self, data)
		if not data or (data and (data.peer_id or data.state_name ~= "mugshot_downed")) then
			return
		end

		data.health_health:set_color(colors.state_downed)
	end, false)

	module:post_hook(HUDManager, "set_mugshot_normal", function(self, id)
		local data = self:_get_mugshot_data(id)
		if not data or data.peer_id or not data.health_amount then
			return
		end

		local color = data.health_amount < 0.33 and colors.hp_low or colors.hp_normal
		data.health_health:set_color(color)
	end, false)
end

if RequiredScript == "lib/units/player_team/teamaidamage" then
	local TeamAIDamage = module:hook_class("TeamAIDamage")
	module:post_hook(55, TeamAIDamage, "_regenerated", function(self)
		managers.hud:set_mugshot_health(self._unit:unit_data().mugshot_id, 1)

		if self._unit:network() then
			self._unit:network():send("set_health", 100)
		end
	end, false)

	module:hook(55, TeamAIDamage, "_apply_damage", function(self, attack_data, result)
		local precent, subtract = module:call_orig(TeamAIDamage, "_apply_damage", self, attack_data, result)
		if subtract <= 0 then
			return precent, subtract
		end

		local ratio = self._health_ratio
		managers.hud:set_mugshot_health(self._unit:unit_data().mugshot_id, ratio)

		if self._unit:network() then
			self._unit:network():send("set_health", math.clamp(math.round(ratio * 100), 0, 100))
		end

		return precent, subtract
	end, true)
end
