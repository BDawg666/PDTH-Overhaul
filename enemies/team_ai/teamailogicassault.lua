local module = ... or D:module("fgo")

local TeamAILogicAssault = module:hook_class("TeamAILogicAssault")
module:hook(64, TeamAILogicAssault, "_chk_change_weapon", function(data, my_data)
	local selection
	if not my_data.focus_enemy or not my_data.focus_enemy.verified or my_data.focus_enemy.verified_dis > 1500 then
		local inventory = data.unit:inventory()
		local equipped_selection = inventory:equipped_selection()
		if not my_data.focus_enemy and not managers.groupai:state():enemy_weapons_hot() then
			selection = 1
		elseif
			my_data.focus_enemy
			and my_data.focus_enemy.verified_dis < 800
			and my_data.focus_enemy.unit:base()._tweak_table ~= "tank"
		then
			if equipped_selection ~= 3 then
				selection = TeamAILogicAssault._choose_between_weapon_selections(data, my_data, inventory, { 3 })
			end
		elseif equipped_selection ~= 2 and equipped_selection ~= 4 then
			selection = TeamAILogicAssault._choose_between_weapon_selections(data, my_data, inventory, { 2, 3, 4 })
			if selection == equipped_selection then
				selection = nil
			end
		end
	end
	if selection then
		data.unit:inventory():equip_selection(selection, true)
	end
end, false)
