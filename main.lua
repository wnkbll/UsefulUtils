UsefulUtils = UsefulUtils or {}
local UU = UsefulUtils

UU.name = "UsefulUtils"
UU.version = "2.0"

local EM = GetEventManager()

local defaults = {
	modules = {
		guildHalls = true,
		zones = true,
		aoe = true,
	},
	guildHallsData = {},
	AoE = {
		defaultColor = GetSetting(SETTING_TYPE_COMBAT, COMBAT_SETTING_MONSTER_TELLS_ENEMY_COLOR),
		speed = 50,
		turbo = 1,
	},
}

local function init()
	local SV = ZO_SavedVars:NewAccountWide('UsefulUtilsSV', 1, nil, defaults)

	if SV.modules.guildHalls then
		UU.GuildHalls.init(SV.guildHallsData)
	end

	if SV.modules.zones then
		UU.Zones.init()
	end

	if SV.modules.aoe then
		UU.Aoe.init(SV)
	end

	UU.menu.init(SV, defaults)
end

function UU.OnAddOnLoaded(_, addonName)
	if addonName == UU.name then
		EM:UnregisterForEvent(UU.name, EVENT_ADD_ON_LOADED)
		init()
	end
end

EM:RegisterForEvent(UU.name, EVENT_ADD_ON_LOADED, UU.OnAddOnLoaded)
