if RequiredScript == "lib/units/weapons/raycastweaponbase" then
	local RaycastWeaponBase = module:hook_class("RaycastWeaponBase")
	module:hook(50, RaycastWeaponBase, "spread_multiplier", function(self)
		local multiplier = managers.player:upgrade_value(self._name_id, "spread_multiplier", 1)
		multiplier = multiplier * managers.player:synced_crew_bonus_upgrade_value("sharpshooters", 1)
		return math.clamp(multiplier * 1.25, 0, 1)
	end, true)
end

if RequiredScript == "lib/units/beings/player/states/playerstandard" then
	local PlayerStandard = module:hook_class("PlayerStandard")
	module:hook(50, PlayerStandard, "_start_action_steelsight", function() end, true)
	module:hook(50, PlayerStandard, "_end_action_steelsight", function() end, true)
end

if RequiredScript == "lib/tweak_data/weapontweakdata" then
	local WeaponTweakData = module:hook_class("WeaponTweakData")
	module:post_hook(WeaponTweakData, "_init_data_player_weapons", function(self)
		for _, weapon in pairs(self.weapon_list) do
			self[weapon].crosshair.standing.hidden = true
			self[weapon].crosshair.crouching.hidden = true
		end
	end)
end
