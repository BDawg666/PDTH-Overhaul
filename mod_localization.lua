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
		english = "You idiots! The driver found some of your weapons at the back of the van!\n\n- Secondary weapon slot is disabled.\n- Secondary weapons have been moved to the primary slot and their max ammo capacity is increased by 75%.\n- Ammo pickup for all weapons is increased by 50%.",
	},
	["mutator_limited_arsenal_motd"] = {
		english = 'The "Limited Arsenal" mutator is enabled, The secondary weapon slot is disabled, overall ammo pickup for is increased by 50%, secondary weapons have been moved to the primary slot and their max ammo capacity is increased by 75%.',
	},
	["mutator_bad_trip"] = {
		english = "Bad Trip",
	},
	["mutator_bad_trip_help"] = {
		english = "Are you Okay?\nMan, I told you not to smoke that shit!\n\n- Players will struggle to focus their sight.\n- Players will have trouble keeping balance (FOV and camera roll changes).\n- Players will suffer from motion sickness.",
	},
	["mutator_bad_trip_motd"] = {
		english = 'The mutator "Bad Trip" is enabled, Players will experience motion sickness to its finest.',
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
	["mutator_no_outlines"] = {
		english = "No Outlines",
	},
	["mutator_no_outlines_help"] = {
		english = "Also disables name labels above your teammates.",
	},
	["mutator_no_outlines_motd"] = {
		english = "The 'No Outlines' mutator is enabled, Contours and player labels are disabled.",
	},
	["mutator_wasteful_premature_reload"] = { english = "Wasteful premature reloads" },
	["mutator_wasteful_premature_reload_help"] = {
		english = "When reloading, any ammo remaining in your magazine will be permanently lost.",
	},
	["mutator_wasteful_premature_reload_motd"] = {
		english = "The 'Wasteful Premature Reloads' mutator is enabled, any ammo remaining in the magazines will be lost when reloading your weapons.",
	},
	["mutator_disable_auto_reload"] = { english = "Disable auto reload" },
	["mutator_disable_auto_reload_help"] = {
		english = "Pressing the fire button with an empty magazine will not make your character reload your weapon.",
	},
	["mutator_disable_auto_reload_motd"] = {
		english = "The 'Disable Auto Reload' mutator is enabled, reloading your weapons by pressing the fire button is no longer possible.",
	},
	["mutator_halfpay_gang"] = {
		english = "HALFPAY Gang",
	},
	["mutator_halfpay_gang_help"] = {
		english = "It seems Bain's recruitment list has fallen short...",
	},
	["mutator_halfpay_gang_motd"] = {
		english = "The 'HALFPAY Gang' mutator is enabled, all players will be visually crouching and able to sprint and jump.",
	},
	["mutator_no_antishield"] = {
		english = "No Shield Counters",
	},
	["mutator_no_antishield_help"] = {
		english = "Some of your weapons have gone missing...",
	},
	["mutator_no_antishield_motd"] = {
		english = "The 'No Shield Counters' mutator is enabled, the B9-S and GL40 cannot be equipped.",
	},
}

for string_id, translations in pairs(strings) do
	module:add_localization_string(string_id, translations)
end
