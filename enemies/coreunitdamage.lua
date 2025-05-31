-- we are only hooking to this path, why are we even checking?
if RequiredScript ~= "core/lib/units/coreunitdamage" then
	return
end

local module = ... or D:module("fgo")

local CoreBodyDamage = module:hook_class("CoreBodyDamage")
CoreBodyDamage.dozer_visor_bs = false

local ids_glass = Idstring("glass")
module:post_hook(CoreBodyDamage, "init", function(self, unit, unit_extension, body, body_element)
	if not alive(unit) or not alive(body) then
		return
	end

	if
		not CoreBodyDamage.dozer_visor_bs
		and tablex.get(unit:base(), "_tweak_table") == "tank"
		and body:name() == ids_glass
	then
		self._endurance["explosion"]["_endurance"]["damage"] = tweak_data.character.tank.damage.visor_health
		CoreBodyDamage.dozer_visor_bs = true
	end
end)
