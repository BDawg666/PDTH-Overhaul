local TankCopDamage = module:hook_class("TankCopDamage")
module:hook(TankCopDamage, "damage_melee", function(self, attack_data)
    self.super.damage_melee(self, attack_data)
end)

module:hook(TankCopDamage, "sync_damage_melee", function(self, ...)
    self.super.sync_damage_melee(self, ...)
end)