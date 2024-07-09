if RequiredScript == "lib/tweak_data/weapontweakdata" then
	local WeaponTweakData = module:hook_class("WeaponTweakData")
	module:post_hook(WeaponTweakData, "_init_data_player_weapons", function(self)
		for _, weapon_id in pairs({ "mossberg", "mp5", "mac11", "beretta92", "m79", "c45", "raging_bull", "glock", "r870_shotgun", "m4", "m14", "hk21", "ak47" }) do
			self[weapon_id].crosshair.standing.hidden = true
			self[weapon_id].crosshair.crouching.hidden = true
		end
	end)
end
