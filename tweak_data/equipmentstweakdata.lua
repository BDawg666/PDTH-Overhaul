local EquipmentsTweakData = module:hook_class("EquipmentsTweakData")

module:post_hook(EquipmentsTweakData, "init", function(self)
	self.ammo_bag = {
		icon = "equipment_ammo_bag",
		use_function_name = "use_ammo_bag",
		quantity = 2,
		text_id = "debug_ammo_bag",
		description_id = "des_ammo_bag",
	}
	self.doctor_bag = {
		icon = "equipment_doctor_bag",
		use_function_name = "use_doctor_bag",
		quantity = 2,
		text_id = "debug_doctor_bag",
		description_id = "des_doctor_bag",
	}
	self.sentry_gun = {
		icon = "equipment_sentry",
		use_function_name = "use_sentry_gun",
		quantity = 2,
		text_id = "debug_sentry_gun",
		description_id = "des_sentry_gun",
	}

	self.specials.gold_bag_equip.player_rule = "no_run"
end)
