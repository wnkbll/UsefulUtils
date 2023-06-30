porting = {}

--- Make request to port into house
--- @param name string Name of the character that makes request
--- @param houseId number ID of the house
--- @return nil
function porting.portToHouse(name, houseId)
	 if (GetDisplayName() == name) then
        RequestJumpToHouse(houseId)
    else
        JumpToSpecificHouse(name, houseId)
    end
end
