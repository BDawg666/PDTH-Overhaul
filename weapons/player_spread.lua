local RaycastWeaponBase = module:hook_class("RaycastWeaponBase")

module:hook(RaycastWeaponBase, "_get_spread", function(self, user_unit)
	local spread_multiplier = self:spread_multiplier()
	local current_state = user_unit:movement()._current_state
	local spread_data = tweak_data.weapon[self._name_id].spread

	local state = (current_state._in_steelsight and "steelsight")
		or (current_state._ducking and "crouching")
		or "standing"

	local moving = (current_state._moving and "moving_") or ""
	return spread_data[string.format("%s%s", moving, state)] * spread_multiplier
end)
