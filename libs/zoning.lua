zoning = {}

--- Log into in-game chat current zone ID and cords of player
--- @return nil
function zoning.getCords()
	local zone, x, y, z = GetUnitWorldPosition("player")
	d('zone: ' .. zone .. ' x: ' .. x .. ' y: ' .. y .. ' z: ' .. z )
end

--- Log into in-game chat nodeIndex of location
--- @param locationName string Name of the location
function zoning.getNodeIndex(locationName)
	local totalNodes = GetNumFastTravelNodes()
	local i = 1
	while i <= totalNodes do
		local _, name, _, _, _, _, _, _, _ = GetFastTravelNodeInfo(i)
		if name:find(locationName) ~= nil then
			d(name .. ' --Index: ' .. i)
		end
		i = i + 1
	end
end

--- Collect names and ids of all houses
--- @return table
function zoning.getHouseData()
	local function mySort(a, b)
		if a[1] < b[1] then
			return true
		end

		return false
	end

	local totalNodes = GetNumFastTravelNodes()
	local i = 1
	local houseData = {}
	while i <= totalNodes do
		local houseId = GetFastTravelNodeHouseId(i)
		if houseId ~= 0 then
			local _, name, _, _, _, _, _, _, _ = GetFastTravelNodeInfo(i)
			table.insert(houseData, {houseId, name})
		end
		i = i + 1
	end
	table.sort(houseData, mySort)

	return houseData
end
