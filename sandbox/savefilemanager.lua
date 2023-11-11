local SavefileManager = module:hook_class("SavefileManager")
local fgo_save = 69

do
	local path = Application:windows_user_folder() .. "\\saves\\" .. Steam:userid()
	local save_file = function(id)
		return string.format("%s\\save%03d.sav", path, id)
	end

	os.execute(string.format('if not exist "%s" copy %s %s', save_file(fgo_save), save_file(99), save_file(fgo_save)))
end

SavefileManager.PROGRESS_SLOT = fgo_save
