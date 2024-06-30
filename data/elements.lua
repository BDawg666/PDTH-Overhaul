local give_equipment = function(self, equipment)
	if Network:is_server() then
		self._synced_equipment = equipment
		managers.network:session():send_to_peers("give_equipment", equipment)
	end

	if managers.player:has_special_equipment(equipment) then
		return
	end

	managers.player:add_special({ name = equipment })

	local local_id = managers.network:session():local_peer():id()
	managers.network:session():send_to_peers("sync_add_equipment_possession", local_id, equipment)
	managers.player:add_equipment_possession(local_id, equipment)
end

return {
	["bank"] = {
		["101024"] = function(self)
			give_equipment(self, "money_bag")
		end,
	},
	["diamond_heist"] = {
		["100790"] = function(self)
			give_equipment(self, "diamond_bag")
		end,
	},
	["slaughter_house"] = {
		["102253"] = function()
			local equipment = "gold_bag_equip"
			if not managers.player:has_special_equipment(equipment) then
				return
			end

			managers.player:remove_special(equipment)
		end,
	},
}
