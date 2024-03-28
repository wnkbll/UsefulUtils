UsefulUtils = UsefulUtils or {}
local UU = UsefulUtils

UU.Frames = {}
local Frames = UU.Frames

--- Set custom textures
--- @return nil
local function setTextures()
	local FRAME = '/UsefulUtils/textures/abilityFrame64_up.dds'
	local FRAME_DOWN = '/UsefulUtils/textures/abilitynoframe64_down.dds'

	local textures = {'/esoui/art/actionbar/abilityframe64_up.dds', '/esoui/art/actionbar/abilityframe64_down.dds'}

	local synergy = ZO_SynergyTopLevel
	local synergyContainer = synergy:GetNamedChild('Container')
	local synergyIcon = synergyContainer:GetNamedChild('Icon')
	local synergyFrame	= synergyIcon:GetNamedChild('Frame')

	synergyFrame:SetHidden(true)

	local synergyEdge = WINDOW_MANAGER:CreateControl('$(parent)Edge', synergyIcon, CT_TEXTURE)
	synergyEdge:SetDimensions(50, 50)
	synergyEdge:ClearAnchors()
	synergyEdge:SetAnchor(TOPLEFT, synergyIcon, TOPLEFT, 0, 0)
	synergyEdge:SetTexture(FRAME)
	synergyEdge:SetDrawLayer(2)

	RedirectTexture(textures[1], FRAME)
	RedirectTexture(textures[2], FRAME_DOWN)
end

--- Remove frames of target and compass
--- @return nil
local function hideSomeFrames()
	UNIT_FRAMES:SetFrameHiddenForReason("reticleover", "combatstate", true)
	COMPASS_FRAME_FRAGMENT:SetHiddenForReason("UsefulUtils", true)
end

--- Remove Ozezan frame on health bar
--- @return nil
local function hideOzezanFrame()
    local function emptyFunction()
        return
    end

    ZO_UnitVisualizer_ArmorDamage.InitializeBarValues = emptyFunction
end

--- Init function
--- @return nil
function Frames.init()
    setTextures()
    hideSomeFrames()
    hideOzezanFrame()
end
