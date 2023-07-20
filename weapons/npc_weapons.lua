local WeaponTweakData = module:hook_class("WeaponTweakData")

module:post_hook(WeaponTweakData, "_init_data_glock_18_npc", function(self)
	self.glock_18_npc.usage = "mp5"
	self.glock_18_npc.auto.fire_rate = 0.066
end)

module:post_hook(WeaponTweakData, "_init_data_raging_bull_npc", function(self)
	self.raging_bull_npc.DAMAGE = 2
end)
