UsefulUtils = UsefulUtils or {}
local UU = UsefulUtils

UU.Zones = {}
local UU_Z = UU.Zones

--- Init function
--- @return nil
function UU_Z.init()
	SLASH_COMMANDS["/cords"] = zoning.getCords
	SLASH_COMMANDS["/nodes"] = zoning.getNodeIndex
end
