local GroupAITweakData = module:hook_class("GroupAITweakData")

function GroupAITweakData:_set_easy()
	self.difficulty_curve_points = { 0.35 }
	self.besiege.assault.sustain_duration_min = { 30, 70, 140 }
	self.besiege.assault.sustain_duration_max = { 40, 120, 200 }
	self.besiege.assault.delay = { 80, 50, 40 }
	self.besiege.assault.units = {
		security = { 1, 0, 0 },
		murky = { 0, 1.5, 1.5 },
		shield = { 0, 0.1, 0.2 },
		spooc = { 0, 0.1, 0.2 },
		taser = { 0, 0.05, 0.1 },
	}
	
	local is_singleplayer = Global.game_settings.single_player
	self.besiege.assault.force = is_singleplayer and { 15, 15, 15 } or { 20, 20, 20 }
end

function GroupAITweakData:_set_normal()
	self.difficulty_curve_points = { 0.1 }
	self.max_nr_simultaneous_boss_types = 4
	self.besiege.assault.sustain_duration_min = { 100, 120, 200 }
	self.besiege.assault.sustain_duration_max = { 150, 180, 300 }
	self.besiege.assault.delay = { 40, 35, 30 }
	self.besiege.assault.units = {
		murky = { 1.4, 1.5, 0.45 },
		shield = { 0.2, 0.5, 0.5 },
		tank = { 0, 0, 0.1 },
		spooc = { 0.2, 0.5, 1 },
		taser = { 0.05, 0.2, 0.3 },
	}
	
	local is_singleplayer = Global.game_settings.single_player
	self.besiege.assault.force = is_singleplayer and { 15, 15, 15 } or { 20, 20, 20 }
end

function GroupAITweakData:_set_hard()
	self.difficulty_curve_points = { 0.1 }
	self.max_nr_simultaneous_boss_types = 4
	self.besiege.assault.sustain_duration_min = { 150, 180, 250 }
	self.besiege.assault.sustain_duration_max = { 200, 220, 360 }
	self.besiege.assault.delay = { 40, 35, 30 }
	self.besiege.assault.units = {
		murky = { 1.4, 1.5, 0.45 },
		shield = { 0.2, 0.5, 0.5 },
		tank = { 0, 0, 0.1 },
		spooc = { 0.2, 0.5, 1 },
		taser = { 0.05, 0.2, 0.3 },
	}
end

function GroupAITweakData:_set_overkill()
	self.difficulty_curve_points = { 0.1 }
	self.max_nr_simultaneous_boss_types = 4
	self.besiege.assault.build_duration = 30
	self.besiege.assault.sustain_duration_min = { 200, 280, 360 }
	self.besiege.assault.sustain_duration_max = { 200, 360, 400 }
	self.besiege.assault.delay = { 40, 35, 30 }
	self.besiege.assault.units = {
		murky = { 1.5, 1.5, 0.1 },
		shield = { 0.5, 0.7, 0.7 },
		tank = { 0, 0.1, 0.2 },
		spooc = { 0.2, 0.7, 1 },
		taser = { 0.05, 0.35, 0.45 },
	}

	local is_singleplayer = Global.game_settings.single_player
	self.besiege.assault.force = is_singleplayer and { 20, 25, 25 } or { 25, 30, 30 }
	self.besiege.recon.group_size = is_singleplayer and { 2, 2, 2 } or { 4, 4, 4 }
	self.besiege.recon.interval_variation = 7
	self.besiege.recon.interval = { 1, 1, 1 }
	self.besiege.recon.group_size = { 6, 6, 6 }
	self.besiege.rescue.group_size = { 4, 4, 4 }
end

function GroupAITweakData:_set_overkill_145()
	self.difficulty_curve_points = { 0.1 }
	self.max_nr_simultaneous_boss_types = 4
	self.besiege.assault.build_duration = 30
	self.besiege.assault.sustain_duration_min = { 200, 360, 400 }
	self.besiege.assault.sustain_duration_max = { 200, 360, 400 }
	self.besiege.assault.delay = { 40, 35, 30 }
	self.besiege.assault.units = {
		murky = { 1.5, 1.5, 0.1 },
		shield = { 0.5, 0.7, 0.7 },
		tank = { 0, 0.1, 0.2 },
		spooc = { 0.2, 0.7, 1 },
		taser = { 0.05, 0.35, 0.45 },
	}

	local is_singleplayer = Global.game_settings.single_player
	self.besiege.assault.force = is_singleplayer and { 20, 25, 30 } or { 25, 35, 35 }
	self.besiege.recon.group_size = is_singleplayer and { 2, 2, 2 } or { 4, 4, 4 }
	self.besiege.recon.interval_variation = 7
	self.besiege.recon.interval = { 1, 1, 1 }
	self.besiege.recon.group_size = { 6, 6, 6 }
	self.besiege.rescue.group_size = { 4, 4, 4 }
end