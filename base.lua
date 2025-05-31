local module = DMod:new("fgo", {
	version = "0.9.6",
	name = "PD:TH Full Game Overhaul",
	author = "B Dawg",
	dependencies = {
		"ummlib",
		"scriman",
		"[ovk_193]",
		"[hud]",
		"[_hud]",
		"[wtfbm]",
		"[nwpab]",
		"[static_recoil]",
		"[bwr]",
		"[Alleviations Weapon Rework]",
		"[1° A.W.U. Rebalance]",
		"[yet_another_weapon_rebalance]",
	},
	description = { english = "WIP" },
	includes = { {"classes/element_spy"}, { "mod_localization", { type = "localization" } } },
	update = { id = "42754", platform = "modworkshop" },
})

module:hook("OnModuleRegistered", "load_fgo", function()
	for _, module_id in pairs({ "anticheat", "save_slot_selector" }) do
		D:unregister_module(module_id)
	end
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
module:hook_post_require("lib/managers/group_ai_states/groupaistatebesiege", "enemies/groupaistatebesiege")
--module:hook_post_require("lib/managers/group_ai_states/groupaistatestreet", "enemies/groupaistatestreet")
module:hook_post_require("lib/units/enemies/cop/copbase", "enemies/copbase")
module:hook_post_require("lib/units/civilians/logics/civilianlogicescort", "enemies/escort/civilianlogicescort")
module:hook_post_require("lib/units/player_team/teamaibase", "enemies/team_ai/teamaibase")
module:hook_post_require("lib/units/player_team/teamaidamage", "enemies/team_ai/mugshot_health")
module:hook_post_require("lib/units/player_team/teamaidamage", "enemies/team_ai/nobotrevive")
module:hook_post_require("lib/units/player_team/logics/teamailogicassault", "enemies/team_ai/teamailogicassault")
module:hook_post_require("lib/managers/hudmanager", "enemies/team_ai/mugshot_health")
module:hook_post_require("lib/units/enemies/cop/copdamage", "enemies/cop/copdamage")
module:hook_post_require("lib/units/enemies/spooc/logics/spooclogicattack", "enemies/spooc/spooclogicattack")
module:hook_post_require("lib/units/enemies/spooc/actions/lower_body/actionspooc", "enemies/spooc/actions/lower_body/actionspooc")
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

module:hook("OnModuleLoading", "dhfix", function(m)
    local mutator_key = "dia_roof_SO_fix"

    local script_type = "mission"
    local path = "levels/diamondheist/world/world"
    DPackageManager:register_processor(m, mutator_key, script_type, path, function(_, _, data)
        DPackageManager:load_custom_script_data(mutator_key, data, script_type, {
            id = "dia_roof_SO_bugfix",
            version = "0.1",
            mission = {
                update = {
                    prefereds = {
                        {
                            id = 100470,
                            class = "ElementSpecialObjective",
                            editor_name = "point_special_objective_065",
                            values = { SO_access = "262100" },
                        },
                        {
                            id = 100473,
                            class = "ElementSpecialObjective",
                            editor_name = "point_special_objective_060",
                            values = { SO_access = "262100" },
                        },
                    },
                },
            },
        })
    end)
end)

module:hook("OnModuleLoading", "ucfix", function(m)
    local mutator_key = "sstash_windows"

    local script_type = "mission"
    local path = "levels/secret_stash/world/world"
    DPackageManager:register_processor(m, mutator_key, script_type, path, function(_, _, data)
        DPackageManager:load_custom_script_data(mutator_key, data, script_type, {
            id = "whurr_ssw",
			version = "0.2",
			mission = {
				update = {
					default = {
                        {
							id = 101130,
							class = "ElementSpawnEnemyDummy",
							editor_name = "ai_spawn_enemy_079",
							values = {accessibility="any"}
                        },
                        {
							id = 101137,
							class = "ElementSpawnEnemyDummy",
							editor_name = "ai_spawn_enemy_084",
							values = {accessibility="any"}
                        }
					}
				},
				create = {
					default = {
                        {
							id = 199999,
							class = "ElementUnitSequenceTrigger",
							editor_name = "trigger destroyed planks 200578 (ground floor right)",
							module = "CoreElementUnitSequenceTrigger",
							trigger_times = 0,
							values = {
								enabled = true,
								rotation = Rotation(),
								position = Vector3(665, -1060, -1080),
								sequence_list = {
									{ guis_id = 1, unit_id = 200578, sequence = "destroy_planks" }
								},
								on_executed = {
									{ id = 199996, delay = 0 },
									{ id = 101138, delay = 0 }
								}
							}
						},
                        {
							id = 199998,
							class = "ElementUnitSequenceTrigger",
							editor_name = "trigger destroyed planks 200579 (ground floor left)",
							module = "CoreElementUnitSequenceTrigger",
							trigger_times = 0,
							values = {
								enabled = true,
								rotation = Rotation(),
								position = Vector3(665, -1060, -1080),
								sequence_list = {
									{ guis_id = 1, unit_id = 200579, sequence = "destroy_planks" }
								},
								on_executed = {
									{ id = 199997, delay = 0 },
									{ id = 101168, delay = 0 }
								}
							}
						},
                        {
							id = 199997,
							editor_name = "toggle on spawn point ground floor left",
							class = "ElementToggle",
							module = "CoreElementToggle",
							values = {
								toggle = "on",
								elements = { 101168 },
								on_executed = {},
								base_delay = 0,
								enabled = true,
								execute_on_restart = false,
								execute_on_startup = false,
								rotation = Rotation(),
								position = Vector3(665, -1060, -1080),
								trigger_times = 0
							}
						},
						{
							id = 199996,
							editor_name = "toggle on spawn point ground floor right",
							class = "ElementToggle",
							module = "CoreElementToggle",
							values = {
								toggle = "on",
								elements = { 101138 },
								on_executed = {},
								base_delay = 0,
								enabled = true,
								execute_on_restart = false,
								execute_on_startup = false,
								rotation = Rotation(),
								position = Vector3(665, -1060, -1080),
								trigger_times = 0
							}
						}
					}
				}
			}
        })
    end)
end)

-- mutators
module:hook("OnModuleLoading", "load_fgo_mutators", function(m)
	local ovk_193 = D:module("ovk_193")
	if not ovk_193 or (ovk_193 and not ovk_193:enabled()) then
		return
	end

	local mutator_availability = { all = true }

	if MutatorHelper.setup_mutator(m, "halfpay_gang", mutator_availability, nil, true) then
		module:hook_post_require("lib/units/beings/player/states/playerstandard", "mutators/halfpay_gang")
	end

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

	if MutatorHelper.setup_mutator(m, "no_antishield", mutator_availability, nil, true) then
		m:hook_post_require("lib/tweak_data/weapontweakdata", "mutators/no_antishield")
	end
	if MutatorHelper.setup_mutator(m, "no_crosshairs", mutator_availability, nil, true) then
		m:hook_post_require("lib/tweak_data/weapontweakdata", "mutators/no_crosshairs")
	end
	if MutatorHelper.setup_mutator(m, "fbi_mostwanted", mutator_availability, nil, true) then
		m:hook_post_require("lib/tweak_data/groupaitweakdata", "mutators/fbi_mostwanted")
	end
	if MutatorHelper.setup_mutator(m, "lmg_dozer", mutator_availability, nil, true) then
		m:hook_post_require("lib/units/enemies/cop/copbase", "mutators/lmg_dozer")
	end
	if MutatorHelper.setup_mutator(m, "esa", mutator_availability, nil, true) then
		m:hook_post_require("lib/units/enemies/cop/copbase", "mutators/esa")
	end
	if MutatorHelper.setup_mutator(m, "progressive_regen", mutator_availability, nil, true) then
		m:hook_post_require("lib/units/beings/player/playerdamage", "mutators/progressive_regen")
		m:hook_post_require("lib/tweak_data/playertweakdata", "mutators/progressive_regen")
	end
	if MutatorHelper.setup_mutator(m, "per_pellet", mutator_availability, nil, true) then
		m:hook_post_require("lib/units/weapons/shotgun/shotgunbase", "mutators/per_pellet")
		m:hook_post_require("lib/tweak_data/weapontweakdata", "mutators/per_pellet")
	end
	if MutatorHelper.setup_mutator(m, "grace_piercing", mutator_availability, nil, true) then
		m:hook_post_require("lib/units/beings/player/playerdamage", "mutators/grace_piercing")
		m:hook_post_require("lib/tweak_data/playertweakdata", "mutators/grace_piercing")
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
	
	mutator_availability = { all = { levels = { slaughter_house = true } } }
	if MutatorHelper.setup_mutator(m, "murky_assault", mutator_availability, nil, true) then
		m:hook_post_require("lib/tweak_data/groupaitweakdata", "mutators/murky_assault")
	end
end)

return module
