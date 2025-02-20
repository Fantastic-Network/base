-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.AddCrown(Table)
    Table["Coords"] = toVector3(Table["Coords"])
	Blips[Table["Serial"]] = AddBlipForCoord(Table["Coords"])
	SetBlipSprite(Blips[Table["Serial"]],Table["Sprite"])
	SetBlipDisplay(Blips[Table["Serial"]],4)
	SetBlipAsShortRange(Blips[Table["Serial"]],true)
	SetBlipColour(Blips[Table["Serial"]],Table["Color"])
	SetBlipScale(Blips[Table["Serial"]],0.5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Table["Name"])
	EndTextCommandSetBlipName(Blips[Table["Serial"]])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.RemoveCrown(Serial)
	if Blips[Serial] and DoesBlipExist(Blips[Serial]) then
		RemoveBlip(Blips[Serial])
		Blips[Serial] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FULL
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.FullCrown(Table)
    for i=1,#Table do
        local Coords = toVector3(Table[i]["Coords"])
        local Info = Table[i]
        Blips[Info["Serial"]] = AddBlipForCoord(Coords)
		SetBlipSprite(Blips[Info["Serial"]],Info["Sprite"])
		SetBlipDisplay(Blips[Info["Serial"]],4)
		SetBlipAsShortRange(Blips[Info["Serial"]],true)
		SetBlipColour(Blips[Info["Serial"]],Info["Color"])
		SetBlipScale(Blips[Info["Serial"]],1.0)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Info["Name"])
		EndTextCommandSetBlipName(Blips[Info["Serial"]])
    end
end

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)