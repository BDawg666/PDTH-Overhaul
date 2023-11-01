local strings = {
	["des_beretta92"] = {
		english = "stats : 9mm : semiautomatic : low recoil \nthe b9-s is one of the most used law-enforcement pistols todayn \nthe relatively light damage is compensated by its big clips \nloaded with shield piercing rounds.",
	},
	["des_glock"] = {
		english = "stats : 9mm : full auto : medium recoil \nthe military has it. the police have it. and now you have it. the stryk is an easy to use fully automatic pistol. specifically designed to fight crime. wait a minute.",
	},
	["des_m4"] = {
		english = "stats : 5.56 : semiautomatic : low recoil \nthe amcar-4 is one of the most versatile assault rifles there isn \nthe good accuracy coupled with the high rate of fire prepares its owner for any situation.",
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
		english = "Increases camera twitching while being tased to be incredibly difficult and unfair to counter.",
	},
	["mutator_overcharged_tasers_motd"] = {
		english = 'The "Overcharged Tasers" mutator is enabled, tasers will have no mercy upon you.',
	},
	["mutator_heavy_bags"] = {
		english = "Heavy Bags",
	},
	["mutator_heavy_bags_help"] = {
		english = "Gold and Money bags will impact your mobility capabilities.",
	},
	["mutator_heavy_bags_motd"] = {
		english = 'The "Heavy Bags" mutator is enabled, Gold and Money bags will reduce your movement speed and jump height.',
	},
	["debug_equipment_diamond_bag"] = {
		english = 'Diamond Bag',
	},
}

for string_id, translations in pairs(strings) do
	module:add_localization_string(string_id, translations)
end