local module = ... or D:module("fgo")

local NetworkMember = module:hook_class("NetworkMember")
module:post_hook(NetworkMember, "spawn_unit", function(self, spawn_point_id, is_drop_in, spawn_as)
	if Network:is_client() or not alive(self._unit) or not self._peer:synched() then
		return
	end

	local equipment_id = _M.ElementSpy._synced_equipment
	if is_drop_in and equipment_id and equipment_id ~= "none" then
		managers.network:session():send_to_peer_synched(self._peer, "give_equipment", equipment_id)
	end
end)
