local ease_in_out_sine = function(time, start, final, delta)
	return -final / 2 * (math.cos(math.pi * time / delta) - 1) + start
end

local module = ... or D:module("fgo")

if RequiredScript == "lib/units/cameras/fpcameraplayerbase" then
	local FPCameraPlayerBase = module:hook_class("FPCameraPlayerBase")

	module:hook(FPCameraPlayerBase, "animate_fov", function() end)
	module:hook(FPCameraPlayerBase, "set_stance_fov_instant", function() end)

	module:post_hook(FPCameraPlayerBase, "update", function(self, unit, t, dt)
		local camera = self._parent_unit:camera()

		self._camera_properties.target_tilt = ease_in_out_sine(t, -15, 50, 0.1)
		camera:set_FOV(ease_in_out_sine(t, 75, 25, 0.1))
	end)
end

if RequiredScript == "core/lib/managers/coreenvironmentcontrollermanager" then
	local _blurzone_update = function(self, t, dt)
		return ease_in_out_sine(t, 0.5, 3, 0.1)
	end

	local CoreEnvironmentControllerManager = module:hook_class("CoreEnvironmentControllerManager")
	module:post_hook(CoreEnvironmentControllerManager, "init", function(self)
		self._blurzone = 1
		self._blurzone_update = _blurzone_update
	end)

	for _, func in pairs({ "blurzone_flash_in", "blurzone_fade_in", "blurzone_fade_idle", "blurzone_fade_out" }) do
		module:hook(CoreEnvironmentControllerManager, func, _blurzone_update)
	end
end
