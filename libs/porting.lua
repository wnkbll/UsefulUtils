porting = {}

function porting.portToHouse(name, houseId)
	 if (GetDisplayName() == name) then
        RequestJumpToHouse(houseId)
    else
        JumpToSpecificHouse(name, houseId)
    end
end
