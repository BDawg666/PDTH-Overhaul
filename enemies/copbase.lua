local overrides = {
	spooc = "mac11",
}

-- credits: Dorentuz` for the template
module:pre_hook(60, CopBase, "init", function(self, unit)
	if not Network:is_server() then
		return
	end

	self._default_weapon_id_override = overrides[unit:base()._tweak_table]
end, false)

module:pre_hook(60, CopBase, "post_init", function(self)
	if self._default_weapon_id_override then
		self._default_weapon_id = self._default_weapon_id_override
	end
end, false)
