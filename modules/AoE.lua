UsefulUtils = UsefulUtils or {}
local UU = UsefulUtils

UU.Aoe = {}
local UU_A = UU.Aoe

local EM = GetEventManager()

local format = string.format
local min = math.min
local max = math.max

local red = 255
local green = 0
local blue = 0

local turbo = 1

local function setColor()
	if ( red == 255) and (green < 255) and (blue == 0 ) then
		green = min((green + (5 * turbo)), 255)
	elseif (red > 0) and ( green == 255) and ( blue == 0 ) then
		red = max((red - (5 * turbo)), 0)
	elseif (red == 0) and (green == 255) and (blue < 255) then
		blue = min((blue + (5 * turbo)), 255)
	elseif (red == 0) and (green > 0) and (blue == 255) then
		green = max((green - (5 * turbo)), 0)
	elseif (red < 255) and (green == 0) and (blue == 255) then
		red = min((red + (5 * turbo)), 255)
	elseif (red == 255) and (green == 0) and (blue > 0) then
		blue = max((blue - (5 * turbo)), 0)
	end

	SetSetting(SETTING_TYPE_COMBAT, COMBAT_SETTING_MONSTER_TELLS_ENEMY_COLOR, format("%02x%02x%02x", red, green, blue))
end

function UU_A.setState(state, SV)
	if state then
		turbo = SV.turbo
		EM:RegisterForUpdate(UU.name.."Cycle", SV.speed, setColor)
	else
		EM:UnregisterForUpdate(UU.name.."Cycle")
		SetSetting(SETTING_TYPE_COMBAT, COMBAT_SETTING_MONSTER_TELLS_ENEMY_COLOR, SV.defaultColor)
	end
end

function UU_A.init(SV)
	UU_A.setState(SV.modules.aoe, SV.AoE)
end
