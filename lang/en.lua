local language = {
	-- modules/GuildHalls.lua
	UU_GH_HOME = "Home",
	UU_GH_GUILDHALLS = "Guildhalls",
	UU_GH_RELOAD = "Reload UI",

	-- menu.lua
	UU_M_MODULES = "Modules",

	-- GuildHalls submenu
	UU_M_GUILDHALL_ADD = "Add new guildhall",
	UU_M_GUILDHALL_REMOVE = "Remove guildhall",

	UU_M_GUILDHALL_NAME = "Name",
	UU_M_GUILDHALL_OWNER = "Owner",
	UU_M_GUILDHALL_HOUSE = "House name",

	UU_M_GUILDHALL_BUTTON_QUEUE = "Queue",
	UU_M_GUILDHALL_BUTTON_ADD = "Add",
	UU_M_GUILDHALL_BUTTON_REMOVE = "Remove",
	UU_M_GUILDHALL_BUTTON_WARNING = "It will reload the UI.",

	UU_M_GUILDHALL_REMOVE_LIST_NAME = "Guildhalls",
	UU_M_GUILDHALL_REMOVE_LIST_NO_SELECTION = "Choose guildhalls",
	UU_M_GUILDHALL_REMOVE_LIST_FORMATTER = "<<1[$d Item/$d Items]>>",

	-- RGB AOE submenu
	UU_M_AOE_DEFAULT_COLOR = "Default Color",
	UU_M_AOE_CYCLE_SPEED  = "Cycle Speed",
	UU_M_AOE_TURBO = "Turbo Mode",
}

for key, value in pairs(language) do
	SafeAddVersion(key, 1)
	ZO_CreateStringId(key, value)
end
