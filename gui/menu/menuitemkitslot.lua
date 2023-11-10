local MenuItemKitSlot = module:hook_class("MenuItemKitSlot")

-- fix inventory bug after disabling the Limited Arsenal mutator
module:post_hook(MenuItemKitSlot, "init", function(self, data_node, parameters)
	if self._parameters.category == "weapon" then
		Global.player_manager.kit.weapon_slots[self._parameters.slot] = self._options[self._current_index]
	end
end)
