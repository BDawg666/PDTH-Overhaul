local module = ... or D:module("fgo")

local WeaponTweakData = module:hook_class("WeaponTweakData")
module:post_hook(WeaponTweakData, "_init_data_c45_npc", function(self)
	self.c45_npc.DAMAGE = 1.7
end)

module:post_hook(WeaponTweakData, "_init_data_glock_18_npc", function(self)
	self.glock_18_npc.usage = "mp5"
	self.glock_18_npc.auto.fire_rate = 0.08
end)

module:post_hook(WeaponTweakData, "_init_data_raging_bull_npc", function(self)
	self.raging_bull_npc.DAMAGE = 2.4
end)

module:post_hook(WeaponTweakData, "_init_data_hk21_npc", function(self)
	self.hk21_npc.DAMAGE = 2
	self.hk21_npc.auto.fire_rate = 0.25
end)

module:post_hook(WeaponTweakData, "_init_data_ak47_npc", function(self)
	self.ak47_npc.DAMAGE = 2
end)

module:post_hook(WeaponTweakData, "_init_data_mac11_npc", function(self)
	self.mac11_npc.DAMAGE = 1.7
end)

module:post_hook(WeaponTweakData, "_init_data_mp5_npc", function(self)
	self.mp5_npc.DAMAGE = 1.3
end)
