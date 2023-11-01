local SentryGunBase = module:hook_class("SentryGunBase")

-- Credits: Hoppip
-- Unregister sentry guns to prevent enemies from getting stuck/cheesed
-- Enemies will still shoot sentries but they won't actively path towards them
module:hook(SentryGunBase, "post_init", function(self)
	-- managers.groupai:state():register_criminal(self._unit)
	if Network:is_client() then
		self._unit:brain():set_active(true)
	end
end)

module:hook(SentryGunBase, "pre_destroy", function(self)
	SentryGunBase.super.pre_destroy(self, self._unit)
	-- managers.groupai:state():unregister_criminal(self._unit)
	self._removed = true
end)
