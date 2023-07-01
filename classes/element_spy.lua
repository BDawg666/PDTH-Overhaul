ElementSpyClass = class()
ElementSpyClass._filters = {
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
		element_data.callback()
	end
end

ElementSpy = ElementSpy or ElementSpyClass:new()
