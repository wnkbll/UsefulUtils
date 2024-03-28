UsefulUtils = UsefulUtils or {}
local UU = UsefulUtils

UU.GuildHalls = {}
local GuildHalls = UU.GuildHalls

local WM = GetWindowManager()

--- @type table Collection of textures used in the module
local textures = {
	homeUp = "esoui/art/journal/leaderboard_tabicon_home_up.dds",
	homeDown = "esoui/art/journal/leaderboard_tabicon_home_down.dds",
	menu = "|t25:25:esoui/art/journal/leaderboard_tabicon_home_up.dds|t",
	reload = "|t25:25:esoui/art/ava/ava_keepstatus_icon_collectionrate.dds|t",
}

--- Check if house info is empty
--- @param guildHallData table SV.guildHallsData.house table
--- @return nil
local function tryToPort(guildHallData)
	if guildHallData[1] == "" or guildHallData[2] == 0 then return end

	porting.portToHouse(unpack(guildHallData))
end

--- Init custom menu for MB1 click on chat button
--- @param button object Control created with WindowManager
--- @param entries table Content of submenu
--- @return nil
local function menu(button, entries)
	if button == 1 then
		ClearMenu()

		AddCustomMenuItem("" .. textures.menu .. GetString(UU_GH_HOME), function() RequestJumpToHouse(GetHousingPrimaryHouse()) end)
		AddCustomMenuItem("-", function() end)
		AddCustomSubMenuItem("" .. textures.menu .. GetString(UU_GH_GUILDHALLS), entries)
		AddCustomMenuItem("-", function() end)
		AddCustomMenuItem("" .. textures.reload .. GetString(UU_GH_RELOAD), function() ReloadUI() end)

		ShowMenu()
	end
end

--- Init chat button
--- @param controls object Control created with WindowManager
--- @param entries table Content of submenu. It will through into menu function
--- @param isChatMax boolean Flag to check if chat maximized or minimized
--- @return nil
local function showChatButton(controls, entries, isChatMax)
	controls:SetDimensions(23, 23)
	if isChatMax then
		controls:SetAnchor(TOPLEFT, ZO_ChatOptionsSectionLabel, TOPLEFT, 200, 13)
	else
		controls:SetAnchor(TOPLEFT, ZO_ChatWindowMinBar, nil, 0, 423)
	end
	controls:SetNormalTexture(textures.homeUp)
    controls:SetPressedTexture(textures.homeUp)
    controls:SetMouseOverTexture(textures.homeDown)
	controls:SetHandler("OnMouseUp", function(_, button) menu(button, entries) end)
end

--- Get data from saved variables
--- @param SV table SV.guildHallsData
--- @return table
local function getData(SV)
	local guildHallsEntries = {{label = "" .. textures.menu .. "...", callback = function() return end, }}

	if #SV ~= 0 then
		table.remove(guildHallsEntries)
		local divider = {label = "-", }
		for i = 1, #SV do
			local guildHall = {label = "" .. textures.menu .. SV[i].tooltip, callback = function() tryToPort(SV[i].house) end, }
			table.insert(guildHallsEntries, guildHall)
			table.insert(guildHallsEntries, divider)
		end

		table.remove(guildHallsEntries)
	end

	return guildHallsEntries
end

--- Init function
--- @param SV table SV.guildHallsData
--- @return nil
function GuildHalls.init(SV)
	local guildHallsEntries = getData(SV)

	maxChatButton = WM:CreateControl("maxChatButton", ZO_ChatWindow, CT_BUTTON)
	showChatButton(maxChatButton, guildHallsEntries, true)

	minChatButton = WM:CreateControl("minChatButton", ZO_ChatWindowMinBar, CT_BUTTON)
    showChatButton(minChatButton, guildHallsEntries, false)
end
