local SavefileManager = module:hook_class("SavefileManager")

if Global._current_save_slot then
	SavefileManager.PROGRESS_SLOT = Global._current_save_slot
	return
end

local fgo_save = 69

do
	local path = Application:windows_user_folder() .. "\\saves\\" .. Steam:userid()
	local save_file = function(id)
		return string.format("%s\\save%03d.sav", path, id)
	end

	if not osx.file_exists(save_file(fgo_save)) then
		osx.copy_file(save_file(99), save_file(fgo_save))
	end
end

-- apply our current selected save slot
SavefileManager.PROGRESS_SLOT = fgo_save
Global._current_save_slot = SavefileManager.PROGRESS_SLOT
