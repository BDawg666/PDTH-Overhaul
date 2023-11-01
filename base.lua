local module = DMod:new("fgo", {
	version = "0.7",
	name = "PD:TH Full Game Overhaul",
	author = "B Dawg",
	dependencies = {
		"ummlib",
		"[ovk_193]",
		"[nwpab]",
		"[static_recoil]",
		"[bwr]",
		"[Alleviations Weapon Rework]",
		"[1° A.W.U. Rebalance]",
		"[yet_another_weapon_rebalance]",
	},
	description = { english = "WIP" },
	includes = { { "mod_localization", { type = "localization" } } },
	update = { id = "42754", platform = "modworkshop" },
})

module:hook("OnModuleRegistered", "load_fgo", function()
	D:unregister_module("anticheat")
end)

-- init classes
module:hook_post_require("lib/states/ingamewaitingforplayers", function(m)
	m:post_hook(m:hook_class("IngameWaitingForPlayersState"), "at_enter", function()
		local scripts = { "element_spy" }
		for i = 1, #scripts do
			dofile(string.format("%s/classes/%s.lua", m:path(), scripts[i]))
		end
	end)
end)

-- sandbox overrides
module:hook_post_require("lib/managers/achievmentmanager.", "sandbox/achievmentmanager")
module:hook_post_require("lib/network/matchmaking/networkaccountsteam", "sandbox/NetworkAccountSTEAM")
module:hook_post_require("lib/network/matchmaking/networkmatchmakingsteam", "sandbox/NetworkMatchMakingSTEAM")
module:hook_post_require("lib/managers/menu/menunodegui", "sandbox/menunodegui")
module:hook_post_require("lib/tweak_data/tweakdata", "sandbox/unlock_masks")
module:hook_post_require("lib/managers/menumanager", "sandbox/unlock_masks")

-- tweak_data overrides
module:hook_post_require("lib/tweak_data/charactertweakdata", "tweak_data/charactertweakdata")
module:hook_post_require("lib/tweak_data/equipmentstweakdata", "tweak_data/equipmentstweakdata")
module:hook_post_require("lib/tweak_data/groupaitweakdata", "tweak_data/groupaitweakdata")
module:hook_post_require("lib/tweak_data/playertweakdata", "tweak_data/playertweakdata")

-- enemy overrides
module:hook_post_require("lib/units/enemies/cop/copbase", "enemies/copbase")
module:hook_post_require("lib/units/civilians/logics/civilianlogicescort", "enemies/escort/civilianlogicescort")
module:hook_post_require("lib/units/player_team/teamaibase", "enemies/team_ai/teamaibase")
module:hook_post_require("lib/units/player_team/teamaidamage", "enemies/team_ai/mugshot_health")
module:hook_post_require("lib/managers/hudmanager", "enemies/team_ai/mugshot_health")
module:hook_post_require("lib/units/enemies/spooc/logics/spooclogicattack", "enemies/spooc/spooclogicattack")
module:hook_post_require("lib/units/enemies/cop/copdamage", "enemies/cop/copdamage")

-- player overrides
module:hook_post_require("lib/units/beings/player/states/playerstandard", "player/states/playerstandard")
module:hook_post_require("lib/units/beings/player/states/playertased", "player/states/playertased")
module:hook_post_require("lib/units/cameras/fpcameraplayerbase", "player/static_recoil")
module:hook_post_require("lib/managers/playermanager", "player/playermanager")
module:hook_post_require("lib/units/beings/player/playerdamage", "player/playerdamage")

-- weapon overrides
module:hook_post_require("lib/units/weapons/raycastweaponbase", "weapons/player_spread")
module:hook_post_require("lib/units/weapons/raycastweaponbase", "weapons/bullet_penetration")
module:hook_post_require("lib/managers/gameplaycentralmanager", "weapons/bullet_penetration")
module:hook_post_require("lib/tweak_data/upgradestweakdata", "weapons/upgradestweakdata")
module:hook_post_require("lib/tweak_data/weapontweakdata", "weapons/player_weapons")
module:hook_post_require("lib/tweak_data/weapontweakdata", "weapons/npc_weapons")
module:register_post_override("lib/units/weapons/grenades/m79grenadebase", "weapons/m79grenadebase")

module:hook_post_require("lib/units/equipment/ammo_bag/ammobagbase", "deployables/bag_collision")
module:hook_post_require("lib/units/equipment/doctor_bag/doctorbagbase", "deployables/bag_collision")
-- module:hook_post_require("lib/units/interactions/interactionext", "player/block_interaction")
-- module:hook_post_require("lib/managers/objectinteractionmanager", "player/block_interaction")

-- gui scripts
module:hook_post_require("lib/managers/menumanager", "gui/menu/difficulties")

-- mission scripts
module:hook_post_require("lib/managers/missionmanager", "mission/element_spy")
module:hook_post_require("lib/managers/mission/missionscriptelement", "mission/element_spy")
module:hook_post_require("lib/network/networkmember", "mission/networkmember")

-- mutators
module:hook("OnModuleLoading", "load_fgo_mutators", function(module)
	local mutator_availability = { all = true }

	if MutatorHelper.setup_mutator(module, "overcharged_tasers", mutator_availability, nil, true) then
		module:hook_post_require("lib/units/beings/player/states/playertased", "mutators/overcharged_tasers")
	end

	mutator_availability = { all = { levels = { bank = true, diamond_heist = true, slaughter_house = true } } }
	if MutatorHelper.setup_mutator(module, "heavy_bags", mutator_availability, nil, true) then
		module:hook_post_require("lib/units/beings/player/states/playerstandard", "mutators/heavy_bags")
		module:hook_post_require("lib/tweak_data/equipmentstweakdata", "mutators/heavy_bags")
	end
end)

return module
