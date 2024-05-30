if RequiredScript == "lib/tweak_data/weapontweakdata" then
	local WeaponTweakData = module:hook_class("WeaponTweakData")
	module:post_hook(WeaponTweakData, "_init_data_player_weapons", function(self)
		for _, weapon_id in pairs({ "beretta92", "m79" }) do
			self[weapon_id].use_data.selection_index = 4
		end
	end)
end
