local module = ... or D:module("fgo")

local UpgradesVisualTweakData = module:hook_class("UpgradesVisualTweakData")
module:hook(UpgradesVisualTweakData, "init_glock_upgrades", function(self)
	self.upgrade.glock_mag1 = {
		objs = { g_mag = true, g_mag_long = false },
	}
end)

module:post_hook(UpgradesVisualTweakData, "init", function(self)
	self:init_glock_upgrades()
end)
