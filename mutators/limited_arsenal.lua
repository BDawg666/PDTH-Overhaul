if RequiredScript == "lib/managers/playermanager" then
	local PlayerManager = module:hook_class("PlayerManager")
    PlayerManager.WEAPON_SLOTS = 2
end

if RequiredScript == "lib/tweak_data/weapontweakdata" then
	local WeaponTweakData = module:hook_class("WeaponTweakData")
	module:post_hook(WeaponTweakData, "_init_data_player_weapons", function(self)
		for _, weapon_id in pairs({ "mossberg", "mp5", "mac11", "m79" }) do
			self[weapon_id].use_data.selection_index = 2
			self[weapon_id].AMMO_MAX = self[weapon_id].AMMO_MAX * 1.5
		end

		for _, weapon_id in pairs(self.weapon_list) do
			local weapon = self[weapon_id]
			for i, v in pairs(weapon.AMMO_PICKUP) do
				weapon.AMMO_PICKUP[i] = math.round(v * 1.5)
			end
		end
	end)
end
