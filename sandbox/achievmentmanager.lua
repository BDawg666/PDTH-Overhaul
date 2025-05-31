local module = ... or D:module("fgo")

local AchievmentManager = module:hook_class("AchievmentManager")
module:hook(AchievmentManager, "award_steam", function(self) end)
