local module = ... or D:module("fgo")

if RequiredScript == "lib/managers/mission/missionscriptelement" then
	local MissionScriptElement = module:hook_class("MissionScriptElement")

	module:pre_hook(MissionScriptElement, "on_executed", function(self, ...)
		if Network:is_server() then
			_M.ElementSpy:add(self)
		end
	end)
end

if RequiredScript == "lib/managers/missionmanager" then
	local MissionManager = module:hook_class("MissionManager")

	module:pre_hook(MissionManager, "client_run_mission_element", function(self, id, unit)
		if Network:is_client() then
			_M.ElementSpy:run_as_client(self:get_element_by_id(id))
		end
	end)
end
