module:hook(MenuManager, "refresh_level_select", function(node, verify_dlc_owned)
	if verify_dlc_owned and tweak_data.levels[Global.game_settings.level_id].dlc then
		local dlcs = string.split(managers.dlc:dlcs_string(), " ")
		if not table.contains(dlcs, tweak_data.levels[Global.game_settings.level_id].dlc) then
			Global.game_settings.level_id = "bank"
		end
	end

	for _, item in ipairs(node:items()) do
		local level_id = item:parameter("level_id")
		if level_id then
			item:set_value(level_id == Global.game_settings.level_id and "on" or "off")
		end
	end

	local item_difficulty = node:item("lobby_difficulty")
	if item_difficulty then
		item_difficulty:set_value(Global.game_settings.difficulty)
	end
end)
