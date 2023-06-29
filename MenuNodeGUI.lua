module:pre_hook(60, MenuNodeGui, "_setup_panels", function(self, node)
	if game_state_machine:current_state_name() ~= "menu_main" then
		return
	end

	self._bfgo_version = self.ws:panel():text({
		name = "bfgo_version_str",
		text = string.format(
			"%s v%s - matchmaking is sandboxed.",
			module:info_attr("name") or module:id(),
			module:version()
		),
		font = tweak_data.menu.small_font,
		font_size = tweak_data.menu.small_font_size,
		layer = 900,
		alpha = 0.5,
		align = "left",
	})
end, false)

module:post_hook(60, MenuNodeGui, "_layout_legends", function(self)
	if self._bfgo_version then
		local safe_rect_pixels = managers.viewport:get_safe_rect_pixels()
		local _, _, w, h = self._bfgo_version:text_rect()
		self._bfgo_version:set_size(w, h)
		self._bfgo_version:set_center_x(self._bfgo_version:parent():center_x())
		self._bfgo_version:set_y(safe_rect_pixels.y)
	end
end, false)
