_M.ElementSpy = { _ENV = _M }

local ElementSpy = _M.ElementSpy
function ElementSpy:setup()
	if self._initialized then
		return
	end

	self._initialized = true

	self.filters = loadfile(module:path() .. "data/elements.lua")()[Global.level_data.level_id] or {}
	self.queue = {}
	self._synced_equipment = "none"
end

function ElementSpy:get_filter(id)
	return self.filters[id]
end

function ElementSpy:add(element)
	self:setup()

	local filter = self:get_filter(element._id)
	if not filter then
		return
	end

	element:add_execute_callback(function()
		return self:execute(filter)
	end)
end

function ElementSpy:run_as_client(element)
	self:setup()

	local filter = self:get_filter(element._id)
	if not filter then
		return
	end

	return self:execute(filter)
end

function ElementSpy:execute(filter)
	if type(filter) == "function" then
		return filter(self)
	end

	return self:output(filter)
end

function ElementSpy:output(text)
	Util:chat_message(tostring(text), false, "-")
end
