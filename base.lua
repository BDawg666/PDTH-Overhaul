local module = DMod:new("fgo", {
	version = "0.3",
	name = "PD:TH Full Game Overhaul",
	author = "B Dawg",
	dependencies = "[ovk_193]",
	description = {
		english = "WIP",
	},
})

-- sandbox overrides
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
module:hook_post_require("lib/units/player_team/teamaidamage", "enemies/team_ai/mugshot_health")
module:hook_post_require("lib/managers/hudmanager", "enemies/team_ai/mugshot_health")

-- player overrides
module:hook_post_require("lib/units/beings/player/states/playertased", "player/playertased")
module:hook_post_require("lib/units/cameras/fpcameraplayerbase", "player/static_recoil")

-- weapon overrides
module:hook_post_require("lib/units/weapons/raycastweaponbase", "weapons/bullet_penetration")
module:hook_post_require("lib/managers/gameplaycentralmanager", "weapons/bullet_penetration")
module:hook_post_require("lib/tweak_data/upgradestweakdata", "weapons/upgradestweakdata")
module:hook_post_require("lib/tweak_data/weapontweakdata", "weapons/weapontweakdata")

module:hook_post_require("lib/units/equipment/ammo_bag/ammobagbase", "deployables/bag_collision")
module:hook_post_require("lib/units/equipment/doctor_bag/doctorbagbase", "deployables/bag_collision")
module:hook_post_require("lib/managers/objectinteractionmanager", "player/interactionext")

module:set_update({ id = "42754", platform = "modworkshop" })

return module
