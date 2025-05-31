local module = ... or D:module("fgo")

if RequiredScript == "lib/tweak_data/tweakdata" then
	local TweakData = module:hook_class("TweakData")
	module:post_hook(TweakData, "post_init", function(self)
		for _, mask_id in pairs({ "developer", "hockey_com", "troll", "tester", "vyse" }) do
			local mask_set = deep_clone(self.mask_sets[mask_id])
			mask_set.is_custom = true
			mask_set.allow_sync = true
			mask_set.fallback = "clowns"

			self.mask_sets["fake_" .. mask_id] = mask_set
		end
	end)
end

if RequiredScript == "lib/managers/menumanager" then
	local MaskOptionInitiator = module:hook_class("MaskOptionInitiator")
	module:post_hook(MaskOptionInitiator, "add_additional_items", function(self, data_node)
		local weight = 1.11
		for mask_key, mask_id in pairs({
			developer = "developer",
			hockey_com = "hockey_com",
			troll = "troll",
			tester_group = "tester",
			vyse = "vyse",
		}) do
			if not managers.network.account:has_mask(mask_key) then -- prevent dupes
				table.insert(data_node, {
					text_id = "menu_mask_" .. mask_id,
					value = "fake_" .. mask_id,
					weight = weight,
				})
				weight = weight + 0.01
			end
		end
	end, true)
end
