UsefulUtils = UsefulUtils or {}
local UU = UsefulUtils

UU.GuildHalls = {}
local UU_GH = UU.GuildHalls

local WM = GetWindowManager()

local textures = {
	homeUp = "esoui/art/journal/leaderboard_tabicon_home_up.dds",
	homeDown = "esoui/art/journal/leaderboard_tabicon_home_down.dds",
	menu = "|t25:25:esoui/art/journal/leaderboard_tabicon_home_up.dds|t",
	reload = "|t25:25:esoui/art/ava/ava_keepstatus_icon_collectionrate.dds|t",
}

local function tryToPort(guildHallsData)
	if guildHallsData[1] == "" or guildHallsData[2] == 0 then
		d("House info is empty!")
		return
	end

	porting.portToHouse(unpack(guildHallsData))
end

local function menu(_, button, entries)
	if button == 1 then
		ClearMenu()

		AddCustomMenuItem("" .. textures.menu .. "Home", function() RequestJumpToHouse(GetHousingPrimaryHouse()) end)
		AddCustomMenuItem("-", function() end)
		AddCustomSubMenuItem("" .. textures.menu .. "Guildhalls", entries)
		AddCustomMenuItem("-", function() end)
		AddCustomMenuItem("" .. textures.reload .. "ReloadUI", function() ReloadUI() end)

		ShowMenu()
	end
end

local function showChatButton(controls, isChatMax, entries)
	controls:SetDimensions(23, 23)
	if isChatMax then
		controls:SetAnchor(TOPLEFT, ZO_ChatOptionsSectionLabel, TOPLEFT, 200, 13)
	else
		controls:SetAnchor(TOPLEFT, ZO_ChatWindowMinBar, nil, 0, 423)
	end
	controls:SetNormalTexture(textures.homeUp)
    controls:SetPressedTexture(textures.homeUp)
    controls:SetMouseOverTexture(textures.homeDown)
	controls:SetHandler("OnMouseUp", function(control, button) menu(control, button, entries) end)
end

local function getData(SV)
	local guildHallsData = SV
	local guildHallsEntries = {}

	if #guildHallsData ~= 0 then
		local divider = {label = "-", }
		for i = 1, #guildHallsData do
			local guildHall = {label = "" .. textures.menu .. guildHallsData[i].tooltip, callback = function() tryToPort(guildHallsData[i].house) end, }
			table.insert(guildHallsEntries, guildHall)
			table.insert(guildHallsEntries, divider)
		end

		table.remove(guildHallsEntries)
	end

	return guildHallsEntries
end

function UU_GH.init(SV)
	local guildHallsEntries = getData(SV)

	maxChatButton = WM:CreateControl("maxChatButton", ZO_ChatWindow, CT_BUTTON)
	showChatButton(maxChatButton, true, guildHallsEntries)

	minChatButton = WM:CreateControl("minChatButton", ZO_ChatWindowMinBar, CT_BUTTON)
    showChatButton(minChatButton, false, guildHallsEntries)
end
