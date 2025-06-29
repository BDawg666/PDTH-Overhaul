local module = ... or D:module("fgo")

local PlayerTweakData = module:hook_class("PlayerTweakData")
function PlayerTweakData:_set_easy()
	self.damage.ARMOR_INIT = 7
	self.damage.MIN_DAMAGE_INTERVAL = 0.35
	self.damage.automatic_respawn_time = 180
end

function PlayerTweakData:_set_normal()
	self.damage.ARMOR_INIT = 6
	self.damage.MIN_DAMAGE_INTERVAL = 0.3
	self.damage.DOWNED_TIME_DEC = 10
	self.damage.automatic_respawn_time = 300
end

function PlayerTweakData:_set_hard()
	self.damage.ARMOR_INIT = 6
	self.damage.MIN_DAMAGE_INTERVAL = 0.25
	self.damage.DOWNED_TIME_DEC = 10
	self.damage.DOWNED_TIME_MIN = 5
end

function PlayerTweakData:_set_overkill()
	self.damage.ARMOR_INIT = 5
	self.damage.MIN_DAMAGE_INTERVAL = 0.2
	self.damage.DOWNED_TIME_DEC = 10
	self.damage.DOWNED_TIME_MIN = 1
	self.damage.REVIVE_HEALTH_STEPS = { 0.5, 0.25 }
end

function PlayerTweakData:_set_overkill_145()
	self.damage.ARMOR_INIT = 5
	self.damage.MIN_DAMAGE_INTERVAL = 0.15
	self.damage.DOWNED_TIME_DEC = 15
	self.damage.DOWNED_TIME_MIN = 1
	self.damage.REVIVE_HEALTH_STEPS = { 0.2 }
end

module:post_hook(PlayerTweakData, "init", function(self)
	self.fall_health_damage = 4

	self.stances.glock.steelsight.zoom_fov = false

	self.movement_state.standard.movement.speed.multipliers = {
		standard = { walk = 1, run = 1 },
		slow = { walk = 0.8, run = 0.8 },
		heavy = { walk = 0.7, run = 0.7 },
		super_slow = { walk = 0.6, run = 0.5 },
	}
end, false)
