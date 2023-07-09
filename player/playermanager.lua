function PlayerManager:aquire_default_upgrades()
	managers.upgrades:aquire_default("beretta92")
	managers.upgrades:aquire_default("c45")
	managers.upgrades:aquire_default("raging_bull")
	managers.upgrades:aquire_default("m4")
	managers.upgrades:aquire_default("hk21")
	managers.upgrades:aquire_default("m14")
	managers.upgrades:aquire_default("r870_shotgun")
	managers.upgrades:aquire_default("mac11")
	managers.upgrades:aquire_default("mossberg")
	managers.upgrades:aquire_default("mp5")
	managers.upgrades:aquire_default("cable_tie")
	managers.upgrades:aquire_default("thick_skin")
	managers.upgrades:aquire_default("extra_ammo_multiplier")
	managers.upgrades:aquire_default("extra_cable_tie")
	managers.upgrades:aquire_default("ammo_bag")
	managers.upgrades:aquire_default("doctor_bag")
	managers.upgrades:aquire_default("trip_mine")
	managers.upgrades:aquire_default("welcome_to_the_gang")
	managers.upgrades:aquire_default("aggressor")
	managers.upgrades:aquire_default("protector")
	managers.upgrades:aquire_default("sharpshooters")
	managers.upgrades:aquire_default("more_blood_to_bleed")
	managers.upgrades:aquire_default("speed_reloaders")
	managers.upgrades:aquire_default("mr_nice_guy")
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

end