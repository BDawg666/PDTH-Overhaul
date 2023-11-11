local strings = {
	["des_beretta92"] = {
		english = "stats : 9mm : semiautomatic : low recoil \nthe b9-s is one of the most used law-enforcement pistols today \nthe relatively light damage is compensated by its big clips \nloaded with shield piercing rounds.",
	},
	["des_glock"] = {
		english = "stats : 9mm : full auto : medium recoil \nthe military has it. the police have it. and now you have it. the stryk is an easy to use fully automatic pistol. specifically designed to fight crime. wait a minute...",
	},
	["des_m4"] = {
		english = "stats : 5.56mm : automatic : low recoil \nthe amcar-4 is one of the most versatile assault rifles there is \nthe good accuracy coupled with the high rate of fire prepares its owner for any situation.",
	},
	["des_hk21"] = {
		english = "stats : 7.62mm : high capacity magazine \neven though it was originally designed as a mounted machinegun, the brenner 21 is a powerhouse. with its huge capacity magazine, this is a given choice for the assault specialist. \nslows move speed by 20% while drawn and increases fall damage.",
	},
	["des_thick_skin"] = {
		english = "thick skin allows the wearer to receive more damage before going into bleed out. you get 10 extra health points (33% increase).",
	},
	["des_extra_start_out_ammo"] = {
		english = "extra start out ammo allows the owner to carry more ammo. you carry 25% more ammo per weapon.",
	},
	["des_toolset"] = {
		english = "the toolkit allows the owner to organize, carry and protect the tools, making them more effective. reduces interaction times by 40%.",
	},
	["des_extra_cable_tie"] = {
		english = "extra cable ties give you 18 more cable ties to start with.",
	},
	["mutator_overcharged_tasers"] = {
		english = "Overcharged Tasers",
	},
	["mutator_overcharged_tasers_help"] = {
		english = "- Camera twitching while being tased is massively increased.\n- Tasers will be merciless.\n- Tears will be dropped and desks may be slammed.",
	},
	["mutator_overcharged_tasers_motd"] = {
		english = 'The "Overcharged Tasers" mutator is enabled, tasers will have no mercy upon you.',
	},
	["mutator_meth_heads"] = {
		english = "Meth Heads",
	},
	["mutator_meth_heads_help"] = {
		english = "- Players can't aim down sights.\n- Crosshairs are disabled.\n- Weapons are 25% more accurate.",
	},
	["mutator_meth_heads_motd"] = {
		english = 'The "Meth Heads" mutator is enabled, Crosshairs are disabled, Players can\'t aim down sights and weapons are 25% more accurate.',
	},
	["mutator_limited_arsenal"] = {
		english = "Limited Arsenal",
	},
	["mutator_limited_arsenal_help"] = {
		english = "You idiots! The driver found some of your weapons at the back of the van!\n\n- Secondary weapon slot is disabled.\n- Max ammo capacity for all weapons is increased by 50%.\n- Secondary weapons have been moved to the primary slot.\n- Ammo pickup for secondary weapons is increased by 75%",
	},
	["mutator_limited_arsenal_motd"] = {
		english = 'The "Limited Arsenal" mutator is enabled, The secondary weapon slot is disabled, overall ammo pickup for is increased by 50%, secondary weapons have been moved to the primary slot and their max ammo capacity is increased by 75%.',
	},
	["mutator_friendly_fire"] = {
		english = "Friendly Fire",
	},
	["mutator_friendly_fire_help"] = {
		english = "- Damage between players is enabled.\n- Your trip mines can be triggered by teammates.",
	},
	["mutator_friendly_fire_motd"] = {
		english = 'The "Friendly Fire" mutator is enabled, Players can Shoot, Melee and Explode each other.',
	},
	["mutator_heavy_bags"] = {
		english = "Heavy Bags",
	},
	["mutator_heavy_bags_help"] = {
		english = "- Gold, Money and Diamond bags will impact your mobility capabilities.",
	},
	["mutator_heavy_bags_motd"] = {
		english = 'The "Heavy Bags" mutator is enabled, Gold and Money bags will reduce your movement speed and jump height.',
	},
	["debug_equipment_diamond_bag"] = {
		english = "Diamond Bag",
	},
}

for string_id, translations in pairs(strings) do
	module:add_localization_string(string_id, translations)
end
