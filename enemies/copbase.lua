local overrides = {
	spooc = "mac11",
	gangster = { "glock", "ak47", "mac11", "mossberg" },
	dealer = { "ak47", "mac11", "mossberg" },
	murky = { "m4", "mp5", "r870" },
	fbi = { "m4", "mp5" },
}

-- credits: Dorentuz` for the template
module:pre_hook(60, CopBase, "init", function(self, unit)
	if not Network:is_server() then
		return
	end

	local data = overrides[unit:base()._tweak_table]
	local weapon_override
	if type(data) == "nil" then
		return
	end

	if type(data) == "table" then
		weapon_override = data[math.random(1, #data)]
	end

	if type(data) == "string" then
		weapon_override = data
	end

	self._default_weapon_id_override = weapon_override
end, false)

module:pre_hook(60, CopBase, "post_init", function(self)
	if self._default_weapon_id_override then
		self._default_weapon_id = self._default_weapon_id_override
	end
end, false)
