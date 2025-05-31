local module = ... or D:module("fgo")

local TeamAIBase = module:hook_class("TeamAIBase")
function TeamAIBase:default_weapon_name()
	return Idstring("units/weapons/raging_bull_npc/raging_bull_npc")
end
