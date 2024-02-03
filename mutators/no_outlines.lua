if RequiredScript == "lib/tweak_data/tweakdata" then
    module:post_hook(TweakData, "init", function(self)
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
    function HUDManager:_add_name_label(data)
    end
end

