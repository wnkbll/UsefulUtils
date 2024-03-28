UsefulUtils = UsefulUtils or {}
local UU = UsefulUtils

UU.Zones = {}
local Zones = UU.Zones

--- Init function
--- @return nil
function Zones.init()
	SLASH_COMMANDS["/cords"] = zoning.getCords
	SLASH_COMMANDS["/nodes"] = zoning.getNodeIndex
end
