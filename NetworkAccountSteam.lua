local module = DorHUD:module('fgo')
local NetworkAccountSTEAM = module:hook_class("NetworkAccountSTEAM")

module:hook(NetworkAccountSTEAM, "publish_statistics", function(self, stats, success, ...)
    if not Global.game_settings.disable_stats then -- or whatever
        return
    end

    return module:call_orig(NetworkAccountSTEAM, "publish_statistics", self, stats, success, ...)
end)