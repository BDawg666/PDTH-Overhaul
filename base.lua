local module = DMod:new("fgo", {
	version = "0.8.3",
	name = "PD:TH Full Game Overhaul",
	author = "B Dawg",
	dependencies = {
		"ummlib",
		"[ovk_193]",
		"[hud]",
		"[_hud]",
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
	for _, module_id in pairs({ "anticheat", "save_slot_selector" }) do
		D:unregister_module(module_id)
	end
end)

-- init ass
module:hook_post_require("lib/states/ingamewaitingforplayers", function(m)
	m:post_hook(m:hook_class("IngameWaitingForPlayersState"), "at_enter", function()
		local scripts = { "element_spy" }
		for i = 1, #scripts do
			dofile(string.format("%s/classes/%s.lua", m:path(), scripts[i]))
		end
	end)
end)

-- sandbox overrides
module:hook_post_require("lib/managers/savefilemanager", "sandbox/savefilemanager")
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
module:hook_post_require("lib/units/enemies/cop/copdamage", "enemies/cop/copdamage")
module:hook_post_require("lib/units/enemies/spooc/logics/spooclogicattack", "enemies/spooc/spooclogicattack")
module:hook_post_require(
	"lib/units/enemies/spooc/actions/lower_body/actionspooc",
	"enemies/spooc/actions/lower_body/actionspooc"
)
module:hook_post_require("lib/units/enemies/tank/tankcopdamage", "enemies/tank/tankcopdamage")
module:hook_post_require("core/lib/units/coreunitdamage", "enemies/coreunitdamage")

-- player overrides
module:hook_post_require("lib/units/beings/player/states/playerstandard", "player/states/playerstandard")
module:hook_post_require("lib/units/beings/player/states/playerbleedout", "player/states/playerbleedout")
module:hook_post_require("lib/units/beings/player/states/playertased", "player/states/playertased")
module:hook_post_require("lib/units/cameras/fpcameraplayerbase", "player/static_recoil")
module:hook_post_require("lib/managers/playermanager", "player/playermanager")
module:hook_post_require("lib/units/beings/player/playerdamage", "player/playerdamage")

-- weapon overrides
module:hook_post_require("lib/units/weapons/raycastweaponbase", "weapons/player_spread")
module:hook_post_require("lib/units/weapons/raycastweaponbase", "weapons/bullet_penetration")
module:hook_post_require("lib/managers/gameplaycentralmanager", "weapons/bullet_penetration")
module:hook_post_require("lib/tweak_data/upgradestweakdata", "weapons/upgradestweakdata")
module:hook_post_require("lib/tweak_data/upgradesvisualtweakdata", "weapons/upgradesvisualtweakdata")
module:hook_post_require("lib/tweak_data/weapontweakdata", "weapons/player_weapons")
module:hook_post_require("lib/tweak_data/weapontweakdata", "weapons/npc_weapons")
module:register_post_override("lib/units/weapons/grenades/m79grenadebase", "weapons/m79grenadebase")

-- module:hook_post_require("lib/units/equipment/sentry_gun/sentrygunbase", "deployables/sentrygunbase")
module:hook_post_require("lib/units/equipment/ammo_bag/ammobagbase", "deployables/bag_collision")
module:hook_post_require("lib/units/equipment/doctor_bag/doctorbagbase", "deployables/bag_collision")
-- module:hook_post_require("lib/units/interactions/interactionext", "player/block_interaction")
-- module:hook_post_require("lib/managers/objectinteractionmanager", "player/block_interaction")

-- gui scripts
module:hook_post_require("lib/managers/menumanager", "gui/menu/difficulties")
module:hook_post_require("lib/managers/menu/items/menuitemkitslot", "gui/menu/menuitemkitslot")

-- mission scripts
module:hook_post_require("lib/managers/missionmanager", "mission/element_spy")
module:hook_post_require("lib/managers/mission/missionscriptelement", "mission/element_spy")
module:hook_post_require("lib/network/networkmember", "mission/networkmember")

-- mutators
module:hook("OnModuleLoading", "load_fgo_mutators", function(m)
	local ovk_193 = D:module("ovk_193")
	if not ovk_193 or (ovk_193 and not ovk_193:enabled()) then
		return
	end

	local mutator_availability = { all = true }

	if MutatorHelper.setup_mutator(m, "no_outlines", mutator_availability, nil, true) then
		m:hook_post_require("lib/tweak_data/tweakdata", "mutators/no_outlines")
		m:hook_post_require("lib/managers/hudmanager", "mutators/no_outlines")
	end

	if MutatorHelper.setup_mutator(m, "overcharged_tasers", mutator_availability, nil, true) then
		m:hook_post_require("lib/units/beings/player/states/playertased", "mutators/overcharged_tasers")
	end

	if MutatorHelper.setup_mutator(m, "meth_heads", mutator_availability, nil, true) then
		m:hook_post_require("lib/tweak_data/weapontweakdata", "mutators/meth_heads")
		m:hook_post_require("lib/units/beings/player/states/playerstandard", "mutators/meth_heads")
		m:hook_post_require("lib/units/weapons/raycastweaponbase", "mutators/meth_heads")
	end

	if MutatorHelper.setup_mutator(m, "limited_arsenal", mutator_availability, nil, true) then
		m:hook_post_require("lib/tweak_data/weapontweakdata", "mutators/limited_arsenal")
		m:hook_post_require("lib/managers/playermanager", "mutators/limited_arsenal")
	end

	if MutatorHelper.setup_mutator(m, "wasteful_premature_reload", mutator_availability, nil, true) then
		m:hook_post_require("lib/units/weapons/raycastweaponbase", "mutators/wasteful_premature_reload")
	end

	if MutatorHelper.setup_mutator(m, "disable_auto_reload", mutator_availability, nil, true) then
		m:hook_post_require("lib/units/beings/player/states/playerstandard", "mutators/disable_auto_reload")
	end

	if MutatorHelper.setup_mutator(m, "bad_trip", mutator_availability, nil, true) then
		m:hook_post_require("lib/units/cameras/fpcameraplayerbase", "mutators/bad_trip")
		m:hook_post_require("core/lib/managers/coreenvironmentcontrollermanager", "mutators/bad_trip")
	end

	if MutatorHelper.setup_mutator(m, "friendly_fire", mutator_availability, nil, true) then
		local hook, filter = "OnNetworkDataRecv", "FriendlyFire"
		m:hook(hook, string.format("%s_%s", hook, filter), filter, function(peer, data_type, data)
			local variant = data.variant

			if type(data.ray) == "table" then
				data.ray = Vector3(data.ray.x, data.ray.y, data.ray.z)
			end

			if type(data.position) == "table" then
				data.position = Vector3(data.position.x, data.position.y, data.position.z)
			end

			local player_unit = managers.player:player_unit()
			local attacker_unit = managers.network:game():unit_from_peer_id(peer:id())
			if alive(player_unit) and alive(attacker_unit) then
				local attack_info = {
					range = data.range or 100,
					attacker_unit = attacker_unit,
					damage = data.damage,
					variant = variant,
					col_ray = data.ray and { position = player_unit:position(), ray = data.ray },
					position = data.position,
					push_vel = data.ray and data.ray:with_z(0.1):normalized() * 600,
				}

				if variant == "bullet" then
					player_unit:character_damage():damage_bullet(attack_info)
				elseif variant == "melee" then
					player_unit:character_damage():damage_melee(attack_info)
				elseif variant == "explosion" then
					player_unit:character_damage():damage_explosion(attack_info)
				end
			end
		end)

		m:hook_post_require("lib/units/weapons/raycastweaponbase", "mutators/friendly_fire")
		m:hook_post_require("lib/units/weapons/grenades/m79grenadebase", "mutators/friendly_fire")
		m:hook_post_require("lib/units/weapons/trip_mine/tripminebase", "mutators/friendly_fire")
		m:hook_post_require("lib/units/equipment/sentry_gun/sentrygundamage", "mutators/friendly_fire")
		m:hook_post_require("lib/units/beings/player/playerdamage", "mutators/friendly_fire")
		m:hook_post_require("lib/units/beings/player/playermovement", "mutators/friendly_fire")
		m:hook_post_require("lib/units/beings/player/states/playerstandard", "mutators/friendly_fire")
	end

	mutator_availability = { all = { levels = { bank = true, diamond_heist = true, slaughter_house = true } } }
	if MutatorHelper.setup_mutator(m, "heavy_bags", mutator_availability, nil, true) then
		m:hook_post_require("lib/units/beings/player/states/playerstandard", "mutators/heavy_bags")
		m:hook_post_require("lib/tweak_data/equipmentstweakdata", "mutators/heavy_bags")
	end
end)

return module
