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

	RedirectTexture(textures[1], FRAME)
	RedirectTexture(textures[2], FRAME_DOWN)
end

--- Hide compass frame
--- @return nil
function Frames.hideCompassFrame(isHidden)
	COMPASS_FRAME_FRAGMENT:SetHiddenForReason("UsefulUtils", isHidden)
end

--- Hide target frame
--- @return nil
function Frames.hideTargetFrame(isHidden)
	UNIT_FRAMES:SetFrameHiddenForReason("reticleover", "combatstate", isHidden)
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
--- @param SV table SV.framesData
--- @return nil
function Frames.init(SV)
	if GetDisplayName() == "@wnkbll" then
		setTextures()
	end

	Frames.hideCompassFrame(SV.compass)

	Frames.hideTargetFrame(SV.target)

	if SV.ozezan then
		hideOzezanFrame()
	end
end
