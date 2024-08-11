local WeaponTweakData = module:hook_class("WeaponTweakData")
module:post_hook(WeaponTweakData, "_init_data_no_antishield", function(self)
	self.beretta92.can_shoot_through_shield = false
	self.beretta92.AMMO_MAX = 80
	self.beretta92.AMMO_PICKUP = { 2, 6 }
	self.m79.use_data.selection_index = 4
	self.m79.EXPLOSION_RANGE = 1
end, false)