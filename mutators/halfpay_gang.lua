local module = ... or D:module("fgo")

local PlayerStandard = module:hook_class("PlayerStandard")
module:hook(PlayerStandard, "_stance_entered", function(self, unequipped)
	local head_stance = tweak_data.player.stances.default.crouched.head
	local weapon_id = not unequipped and self._equipped_unit:base():get_name_id()

	local in_steelsight = self._in_steelsight
	local ducking = self._ducking

	local stances = tweak_data.player.stances[weapon_id] or tweak_data.player.stances.default
	local misc_attribs = in_steelsight and stances.steelsight or ducking and stances.crouched or stances.standard
	local duration_multiplier = 1
	if in_steelsight then
		duration_multiplier = 1 / managers.player:upgrade_value(weapon_id, "enter_steelsight_speed_multiplier", 1)
	end

	local new_fov = managers.user:get_setting("fov_standard")
	if in_steelsight and stances.steelsight.zoom_fov then
		new_fov = managers.user:get_setting("fov_zoom")
	end

	self._camera_unit:base():clbk_stance_entered(
		misc_attribs.shoulders,
		head_stance,
		misc_attribs.vel_overshot,
		new_fov,
		misc_attribs.shakers,
		duration_multiplier
	)

	managers.menu:set_mouse_sensitivity(in_steelsight and stances.steelsight.zoom_fov)
end)

module:hook(PlayerStandard, "_start_action_ducking", function(self, t) end)
module:hook(PlayerStandard, "_end_action_ducking", function(self, t) end)
module:hook(PlayerStandard, "save", function(self, data)
	data.pose = 2
end)
