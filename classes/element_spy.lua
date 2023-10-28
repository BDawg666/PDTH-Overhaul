local give_equipment = function(self, equipment)
	if Network:is_server() then
		self._synced_equipment = equipment
		managers.network:session():send_to_peers("give_equipment", equipment)
	end

	if managers.player:has_special_equipment(equipment) then
		return
	end

	managers.player:add_special({ name = equipment })

	local lpeer_id = managers.network:session():local_peer():id()
	managers.network:session():send_to_peers("sync_add_equipment_possession", lpeer_id, equipment)
	managers.player:add_equipment_possession(lpeer_id, equipment)
end

local remove_equipment = function(_, equipment)
	if not managers.player:has_special_equipment(equipment) then
		return
	end

	managers.player:remove_special(equipment)
end

ElementSpyClass = class()
ElementSpyClass._filters = {
	["bank"] = {
		["101024"] = { callback = give_equipment, args = "money_bag" },
	},
	["diamond_heist"] = {
		["100790"] = { callback = give_equipment, args = "diamond_bag" },
	},
	["slaughter_house"] = {
		["102253"] = { callback = remove_equipment, args = "gold_bag_equip" },
	},
}

function ElementSpyClass:init()
	self.level = Global.level_data.level_id
	self._synced_equipment = "none"
end

function ElementSpyClass:on_executed(element)
	local level_data = self._filters[self.level]
	if not element or not level_data then
		return
	end

	if not element._values.enabled then
		return
	end

	local element_data = level_data[tostring(element._id)]
	if not element_data then
		return
	end

	if element_data.callback then
		element_data.callback(self, element_data.args)
	end
end

ElementSpy = ElementSpy or ElementSpyClass:new()
