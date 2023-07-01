if RequiredScript == "lib/managers/missionmanager" then
	local MissionManager = module:hook_class("MissionManager")

	local ElementSpy
	module:pre_hook(MissionManager, "client_run_mission_element", function(self, id, unit)
		ElementSpy = ElementSpy or rawget(_G, "ElementSpy")
		if Network:is_client() and ElementSpy then
			ElementSpy:on_executed(self:get_element_by_id(id))
		end
	end)
end

if RequiredScript == "lib/managers/mission/missionscriptelement" then
	local MissionScriptElement = module:hook_class("MissionScriptElement")

	local ElementSpy
	module:pre_hook(MissionScriptElement, "on_executed", function(self, ...)
		ElementSpy = ElementSpy or rawget(_G, "ElementSpy")
		if Network:is_server() and ElementSpy then
			ElementSpy:on_executed(self)
		end
	end)
end
