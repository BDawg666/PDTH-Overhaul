ElementSpyClass = class()
ElementSpyClass._filters = {
	["bank"] = {
		["101024"] = {
			callback = function(self)
				if Network:is_server() then
					self._synced_equipment = "money_bag"
					managers.network:session():send_to_peers("give_equipment", "money_bag")
				end

				if managers.player:has_special_equipment("money_bag") then
					return
				end

				managers.player:add_special({ name = "money_bag" })
				managers.network:session():send_to_peers(
					"sync_add_equipment_possession",
					managers.network:session():local_peer():id(),
					"money_bag"
				)
				managers.player:add_equipment_possession(managers.network:session():local_peer():id(), "money_bag")
			end,
		},
	},
	["slaughter_house"] = {
		["102253"] = {
			callback = function()
				if managers.player:has_special_equipment("gold_bag_equip") then
					managers.player:remove_special("gold_bag_equip")
				end
			end,
		},
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
		element_data.callback(self)
	end
end

ElementSpy = ElementSpy or ElementSpyClass:new()
