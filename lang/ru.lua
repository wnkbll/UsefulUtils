local language = {
	-- modules/GuildHalls.lua
	UU_GH_HOME = "Домой",
	UU_GH_GUILDHALLS = "Гильдхоллы",
	UU_GH_RELOAD = "Reload UI",

	-- menu.lua
	UU_M_MODULES = "Модули",

	-- GuildHalls submenu
	UU_M_GUILDHALL_ADD = "Добавить новый гильдхолл",
	UU_M_GUILDHALL_REMOVE = "Удалить гильдхолл",

	UU_M_GUILDHALL_NAME = "Имя",
	UU_M_GUILDHALL_OWNER = "Владелец",
	UU_M_GUILDHALL_HOUSE = "Название дома",

	UU_M_GUILDHALL_BUTTON_QUEUE = "В очередь",
	UU_M_GUILDHALL_BUTTON_ADD = "Добавить",
	UU_M_GUILDHALL_BUTTON_REMOVE = "Удалить",
	UU_M_GUILDHALL_BUTTON_WARNING = "Это действие перезагрузит интерфейс.",

	UU_M_GUILDHALL_REMOVE_LIST_NAME = "Гильдхоллы",
	UU_M_GUILDHALL_REMOVE_LIST_NO_SELECTION = "Выберете гильдхоллы",
	UU_M_GUILDHALL_REMOVE_LIST_FORMATTER = "<<1[$d Item/$d Items]>>",

	-- RGB AOE submenu
	UU_M_AOE_DEFAULT_COLOR = "Стандартный цвет",
	UU_M_AOE_CYCLE_SPEED  = "Скорость цикла",
	UU_M_AOE_TURBO = "Ускоренный режим",
}

for key, value in pairs(language) do
	SafeAddVersion(key, 1)
	ZO_CreateStringId(key, value)
end
