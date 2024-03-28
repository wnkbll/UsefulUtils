UsefulUtils = UsefulUtils or {}
local UU = UsefulUtils

UU.GroupFrame = {}
local GroupFrame = UU.GroupFrame

--- Disable default in-game group frames
--- @return nil
local function DisableZoFrames()
    ZO_UnitFramesGroups:SetHidden(true)
    zo_callLater(function () UNIT_FRAMES:DisableGroupAndRaidFrames() end, 1000)

    ZO_UnitFrames:UnregisterForEvent(EVENT_LEADER_UPDATE)
    ZO_UnitFrames:UnregisterForEvent(EVENT_GROUP_SUPPORT_RANGE_UPDATE)
    ZO_UnitFrames:UnregisterForEvent(EVENT_GROUP_UPDATE)
    ZO_UnitFrames:UnregisterForEvent(EVENT_GROUP_MEMBER_LEFT)
    ZO_UnitFrames:UnregisterForEvent(EVENT_GROUP_MEMBER_CONNECTED_STATUS)
    ZO_UnitFrames:UnregisterForEvent(EVENT_GROUP_MEMBER_ROLE_CHANGED)
end

--- Init function
--- @return nil
function GroupFrame.init()
	DisableZoFrames()
end
