local module = ... or D:module("fgo")

local TeamAIDamage = module:hook_class("TeamAIDamage")
function TeamAIDamage:need_revive()
	return false
end

function TeamAIDamage:arrested()
	return false
end