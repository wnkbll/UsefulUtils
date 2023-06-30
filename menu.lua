UsefulUtils = UsefulUtils or {}
local UU = UsefulUtils

UU.menu = {}
local UU_M = UU.menu

local LAM = LibAddonMenu2

local tooltipData, ownerData, idData = "", "", 0
local queuedData, dataToRemove = {}, {}
local currentHouses = {{}, {}}

--- Check if inputs empty
--- @return boolean
local function isInputsEmpty()
	return tooltipData == "" or ownerData == "" or ownerData:find("@") == nil or idData == 0
end

--- Append data to queuedData after that reset tooltipData, ownerData and idData
--- @return nil
local function setDataToQueue()
	if isInputsEmpty() then return end

	queuedData[#queuedData + 1] = {tooltip = tooltipData, house = {ownerData, idData},}
	tooltipData, ownerData, idData = "", "", 0
end

--- Append data from queuedData to SV
--- @param SV table SV.guildHallsData
--- @return nil
local function pushDataToSV(SV)
	if #queuedData == 0 and isInputsEmpty() then return end

	if not isInputsEmpty() then
		SV[#SV + 1] = {tooltip = tooltipData, house = {ownerData, idData},}
		ReloadUI()
	end

	for _, data in pairs(queuedData) do
		SV[#SV + 1] = data
	end

	ReloadUI()
end

--- Remove data from SV
--- @param SV table SV.guildHallsData
--- @return nil
local function removeDataFromSV(SV)
	if #dataToRemove == 0 then return end

	table.sort(dataToRemove)

	for i = #dataToRemove, 1, -1 do
		table.remove(SV, dataToRemove[i])
	end

	ReloadUI()
end

--- Format house data and separate house ids and names to 2 tables
--- @return table
local function formatHouseData()
	local houseData = zoning.getHouseData()

	local ids = {}
	local names = {}
	for i = 1, #houseData do
		local id, name = houseData[i][1], houseData[i][2]
		table.insert(ids, id)
		table.insert(names, id .. "." .. " " .. name)
	end

	return ids, names
end

--- Collect data from SV to currentHouses
--- @param SV table SV.guildHallsData
--- @return nil
local function collectCurrentHouses(SV)
	if #SV == 0 then return end

	for i = 1, #SV do
		currentHouses[1][#currentHouses[1] + 1] = i
		currentHouses[2][#currentHouses[2] + 1] = SV[i].tooltip
	end
end

--- Init LAM panel control
--- @return table
local function constructPanel()
	local panel = {
		type = "panel",
		name = "UsefulUtils",
		displayName = "Useful Utils",
		author = "wnkbll",
		version = UU.version,
		slashCommand = "/uum",
		registerForRefresh = true,
		registerForDefaults = true,
	}

	return panel
end

--- Init LAM options control
--- @param SV table SV
--- @param defaults table Default states and settings of addon
--- @param ids table Collection of house ids
--- @param names table Collection of house names
--- @return table
local function constructOptions(SV, defaults, ids, names)
	local GuildHalls = {
		type = "checkbox",
		name = "GuildHalls",
		getFunc = function() return SV.modules.guildHalls end,
		setFunc = function(value) SV.modules.guildHalls = value end,
		default = defaults.modules.guildHalls,
		requiresReload = true,
	}

	local Zones = {
		type = "checkbox",
		name = "Zones",
		getFunc = function() return SV.modules.zones end,
		setFunc = function(value) SV.modules.zones = value end,
		default = defaults.modules.zones,
		requiresReload = true,
	}

	local AoE = {
		type = "checkbox",
		name = "RGB AoE",
		getFunc = function() return SV.modules.aoe end,
		setFunc = function(value) SV.modules.aoe = value end,
		default = defaults.modules.aoe,
		requiresReload = true,
	}

	local dividerAdd = {
		type = "header",
		name = GetString(UU_M_GUILDHALL_ADD),
	}

	local dividerRemove = {
		type = "header",
		name = GetString(UU_M_GUILDHALL_REMOVE),
	}

	local guildHallsAdd = {
		tooltip = {
			type = "editbox",
			name = GetString(UU_M_GUILDHALL_NAME),
			getFunc = function() return tooltipData end,
			setFunc = function(value) tooltipData = value end,
			disabled = not SV.modules.guildHalls,
		},
		owner = {
			type = "editbox",
			name = GetString(UU_M_GUILDHALL_OWNER),
			getFunc = function() return ownerData end,
			setFunc = function(value) ownerData = value end,
			disabled = not SV.modules.guildHalls,
		},
		houseID = {
			type = "dropdown",
			name = GetString(UU_M_GUILDHALL_HOUSE),
			choices = names,
			choicesValues = ids,
			scrollable = true,
			getFunc = function() return idData end,
			setFunc = function(value) idData = value end,
			disabled = not SV.modules.guildHalls,
		},
		queueButton = {
			type = "button",
			name = GetString(UU_M_GUILDHALL_BUTTON_QUEUE),
			width = "half",
			func = function() setDataToQueue() end,
		},
		addButton = {
			type = "button",
			name = GetString(UU_M_GUILDHALL_BUTTON_ADD),
			width = "half",
			func = function() pushDataToSV(SV.guildHallsData) end,
			warning = GetString(UU_M_GUILDHALL_BUTTON_WARNING),
		}
	}

	local guildHallsRemove = {
		guildHalls = {
    		type = "multiselectdropdown",
    		name = GetString(UU_M_GUILDHALL_REMOVE_LIST_NAME),
    		noSelectionText = GetString(UU_M_GUILDHALL_REMOVE_LIST_NO_SELECTION),
    		multiSelectionTextFormatter = GetString(UU_M_GUILDHALL_REMOVE_LIST_FORMATTER),
    		multiSelectType = "normal",
    		choices =  currentHouses[2],
    		choicesValues = currentHouses[1],
    		getFunc = function() return end,
    		setFunc = function(value) dataToRemove = value end,
		},
		button = {
			type = "button",
			name = GetString(UU_M_GUILDHALL_BUTTON_REMOVE),
			func = function() removeDataFromSV(SV.guildHallsData) end,
			warning = GetString(UU_M_GUILDHALL_BUTTON_WARNING),
		},
	}

	local defaultColor = {
		type = "colorpicker",
		name = GetString(UU_M_AOE_DEFAULT_COLOR),
		getFunc = function()
			local c = SV.AoE.defaultColor
			return tonumber("0x" .. c:sub(1, 2)) / 255, tonumber("0x" .. c:sub(3, 4)) / 255, tonumber("0x" .. c:sub(5, 6)) / 255
		end,
		setFunc = function(red,green,blue,_)
			local newColor = string.format("%02x%02x%02x", red*255, green*255, blue*255)
			SV.AoE.defaultColor = newColor
			SetSetting(SETTING_TYPE_COMBAT, COMBAT_SETTING_MONSTER_TELLS_ENEMY_COLOR, newColor)
		end,
		disabled = not SV.modules.aoe,
	}

	local cycleSpeed = {
		type = "slider",
		name = GetString(UU_M_AOE_CYCLE_SPEED),
		min = 10,
		max = 75,
		step = 1,
		getFunc = function() return SV.AoE.speed end,
		setFunc = function(value)
			SV.AoE.speed = value
			UU.Aoe.setState(false, SV.AoE)
			UU.Aoe.setState(true, SV.AoE)
		end,
		disabled = not SV.modules.aoe,
	}

	local turboMode = {
		type = "checkbox",
		name = GetString(UU_M_AOE_TURBO),
		getFunc = function() return SV.AoE.turbo == 2 end,
		setFunc = function(value)
			if value then
				SV.AoE.turbo = 2
			else
				SV.AoE.turbo = 1
			end
		end,
		disabled = not SV.modules.aoe,
	}

	local options = {
		{
			type = "submenu",
			name = GetString(UU_M_MODULES),
			controls = {GuildHalls, Zones, AoE},
		},
		{
			type = "submenu",
			name = "GuildHalls",
			controls = {
				dividerAdd, guildHallsAdd.tooltip, guildHallsAdd.owner, guildHallsAdd.houseID, guildHallsAdd.queueButton, guildHallsAdd.addButton,
				dividerRemove, guildHallsRemove.guildHalls, guildHallsRemove.button
			},
		},
		{
			type = "submenu",
			name = "RGB AOE",
			controls = {defaultColor, cycleSpeed, turboMode},
		},
	}

	return options
end

--- Init function
--- @param SV table SV
--- @param defaults table Default states and settings of addon
--- @return nil
function UU_M.init(SV, defaults)
	local name = UU.name .. 'Menu'
	local ids, names = formatHouseData()
	collectCurrentHouses(SV.guildHallsData)

	local panel, options = constructPanel(), constructOptions(SV, defaults, ids, names)
    LAM:RegisterAddonPanel(name, panel)
    LAM:RegisterOptionControls(name, options)
end
