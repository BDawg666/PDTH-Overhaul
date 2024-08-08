local overrides = {
	tank = { "r870", "hk21" },
	spooc = { "r870", "mac11", "mp5" },
	taser = { "r870", "m4" },
	gangster = { "glock", "ak47", "mac11", "mossberg", "bronco" },
	dealer = { "glock", "ak47", "mac11", "mossberg", "bronco" },
	murky = { "m4", "mp5", "r870", "hk21" },
	fbi = { "c45", "m4", "mp5", "r870" },
	security = {
		slaughter_house = { "bronco", "m4", "mp5", "r870" },
		default = { "c45" }, -- bank, no mercy
	},
	patrol = { diamond_heist = { "m4", "mp5", "r870" }, default = { "mp5" } },
}

local current_level
local function get_weapon(data)
	current_level = current_level or Global.level_data.level_id

	local result
	if type(data) == "table" then
		if data[current_level] then
			data = get_weapon(data[current_level])
		elseif data.default then
			data = get_weapon(data.default)
		end

		result = data[math.random(1, #data)]
	end

	if type(data) == "string" then
		result = data
	end

	return result
end

-- credits: Dorentuz` for the template
local CopBase = module:hook_class("CopBase")
module:pre_hook(60, CopBase, "init", function(self, unit)
	if Network:is_client() then
		return
	end

	local data = overrides[unit:base()._tweak_table]
	if type(data) == "nil" then
		return
	end

	self._default_weapon_id_override = get_weapon(data)
end, false)

module:pre_hook(60, CopBase, "post_init", function(self)
	if type(self._default_weapon_id_override) == "string" then
		self._default_weapon_id = self._default_weapon_id_override
	end
end, false)
