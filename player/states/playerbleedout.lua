local PlayerBleedOut = module:hook_class("PlayerBleedOut")
module:hook(PlayerBleedOut, "enter", function(self, enter_data)
	PlayerBleedOut.super.enter(self, enter_data)

	self._revive_SO_data = { unit = self._unit }

	self:_start_action_bleedout(Application:time())

	self._old_selection = nil
	if self._unit:inventory():equipped_selection() ~= 1 then
		self._old_selection = self._unit:inventory():equipped_selection()
		self:_start_action_unequip_weapon(Application:time(), { selection_wanted = 1 })
		-- self._unit:inventory():unit_by_selection(1):base():on_reload()
		PrettyMenu:show_notification("call")
	end

	self._unit:camera():camera_unit():base():set_target_tilt(35) -- upcoming mutator? 👀

	managers.groupai:state():on_criminal_disabled(self._unit)

	if Network:is_server() and self._ext_movement:nav_tracker() then
		self._register_revive_SO(self._revive_SO_data, "revive")
	end

	managers.groupai:state():report_criminal_downed(self._unit)
end)
