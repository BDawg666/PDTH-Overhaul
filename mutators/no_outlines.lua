local module = ... or D:module("fgo")

if RequiredScript == "lib/tweak_data/tweakdata" then
	local TweakData = module:hook_class("TweakData")
	module:post_hook(TweakData, "init", function(self)
		self.contours_disabled = true

		self.contour.character.standard_color = Vector3(0, 0, 0)
		self.contour.character.downed_color = Vector3(0, 0, 0)
		self.contour.character.dead_color = Vector3(0, 0, 0)
		self.contour.character.dangerous_color = Vector3(0, 0, 0)
		self.contour.character_interactable.standard_color = Vector3(0, 0, 0)
		self.contour.character_interactable.selected_color = Vector3(0, 0, 0)
		self.contour.interactable.standard_color = Vector3(0, 0, 0)
		self.contour.interactable.selected_color = Vector3(0, 0, 0)
		self.contour.interactable_look_at.standard_color = Vector3(0, 0, 0)
		self.contour.interactable_look_at.selected_color = Vector3(0, 0, 0)
		self.contour.deployable.standard_color = Vector3(0, 0, 0)
		self.contour.deployable.selected_color = Vector3(0, 0, 0)
		self.contour.pickup.standard_color = Vector3(0, 0, 0)
		self.contour.pickup.selected_color = Vector3(0, 0, 0)
		self.contour.pickup.standard_opacity = 0
	end, false)
end

if RequiredScript == "lib/managers/hudmanager" then
	local HUDManager = module:hook_class("HUDManager")
	module:hook(HUDManager, "_add_name_label", function() end)
end
