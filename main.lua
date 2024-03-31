UsefulUtils = UsefulUtils or {}
local UU = UsefulUtils

UU.name = "UsefulUtils"
UU.version = "2.0"

local EM = GetEventManager()

--- @type table default settings for saved variables
local defaults = {
	modules = {
		guildHalls = true,
		zones = true,
		groupFrame = true,
		frames = true,
	},
	guildHallsData = {},
	framesData = {
		compass = true,
		target = true,
		ozezan = true,
	},
}

--- Init function
--- @return nil
local function init()
	local SV = ZO_SavedVars:NewAccountWide('UsefulUtilsSV', 1, nil, defaults)

	if SV.modules.guildHalls then
		UU.GuildHalls.init(SV.guildHallsData)
	end

	if SV.modules.zones then
		UU.Zones.init()
	end

	if SV.modules.groupFrame then
		UU.GroupFrame.init()
	end

	if SV.modules.frames then
		UU.Frames.init(SV.framesData)
	end

	UU.Menu.init(SV, defaults)
end

--- Function for EVENT_ADD_ON_LOADED callback
--- @return nil
function UU.OnAddOnLoaded(_, addonName)
	if addonName == UU.name then
		EM:UnregisterForEvent(UU.name, EVENT_ADD_ON_LOADED)
		init()
	end
end

EM:RegisterForEvent(UU.name, EVENT_ADD_ON_LOADED, UU.OnAddOnLoaded)
