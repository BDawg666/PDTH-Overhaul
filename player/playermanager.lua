local PlayerManager = module:hook_class("PlayerManager")

module:hook(PlayerManager, "_setup_rules", function(self)
	self._rules = {
		slow_walk = 0,
		heavy_walk = 0,
		super_slow_walk = 0,
		no_run = 0,
		slow_run = 0,
		heavy_run = 0,
		super_slow_run = 0,
		no_jump = 0,
		heavy_jump = 0,
		super_heavy_jump = 0,
	}
end)

module:hook(PlayerManager, "set_player_rule", function(self, name, value)
	local rules = name
	if type(rules) ~= "table" then
		rules = { name }
	end

	for _, rule in pairs(rules) do
		self._rules[rule] = self._rules[rule] + (value and 1 or -1)

		if rule == "no_run" and self:get_player_rule(rule) then
			local player = self:player_unit()
			if player:movement():current_state()._interupt_action_running then
				player:movement():current_state():_interupt_action_running(Application:time())
			end
		end
	end
end)

module:hook(PlayerManager, "aquire_default_upgrades", function(self)
	for _, item in pairs({
		"beretta92",
		"c45",
		"raging_bull",
		"m4",
		"hk21",
		"m14",
		"r870_shotgun",
		"mac11",
		"mossberg",
		"mp5",
		"cable_tie",
		"thick_skin",
		"extra_start_out_ammo",
		"extra_cable_tie",
		"ammo_bag",
		"doctor_bag",
		"trip_mine",
		"welcome_to_the_gang",
		"aggressor",
		"protector",
		"sharpshooters",
		"more_blood_to_bleed",
		"speed_reloaders",
		"mr_nice_guy",
	}) do
		managers.upgrades:aquire_default(item)
	end
	
	if managers.dlc:has_dlc1() then
	for _, item in pairs({
		"ak47",
		"glock",
		"m79",
		"sentry_gun",
		"toolset",
		"more_ammo",
	}) do
		managers.upgrades:aquire_default(item)
	end
	end

	for i = 1, PlayerManager.WEAPON_SLOTS do
		if not managers.player:weapon_in_slot(i) then
			self._global.kit.weapon_slots[i] = managers.player:availible_weapons(i)[1]
		end
	end

	for i = 1, 3 do
		if not managers.player:equipment_in_slot(i) then
			self._global.kit.equipment_slots[i] = managers.player:availible_equipment(i)[1]
		end
	end
end)
