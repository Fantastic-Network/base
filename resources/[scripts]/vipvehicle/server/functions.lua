-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetVehicleString(String)
    local Vehicles = {}
    for number in string.gmatch(String, '([^,]+)') do
        table.insert(Vehicles,number)
    end
    return Vehicles
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VALIDATE PLAYER CHOICES
-----------------------------------------------------------------------------------------------------------------------------------------
function ValidatePlayerChoices(Player,Choices)
    local Validated = {}
    if PlayerList[Player] then
        for Type,Data in pairs(PlayerList[Player]) do
            for i=1,#Data["List"] do
                for j=1,#Choices do
                    if Data["List"][i] == Choices[j] then
                        Validated[Choices[j]] = true
                    end
                end
            end
        end
        for i=1,#Choices do
            if not Validated[Choices[i]] then
                Validated[Choices[i]] = false
            end
        end
        return Validated
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET THE VEHICLE TYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetVehicleType(Player,Spawn)
    local VehicleType = false
    for Type,Data in pairs(PlayerList[Player]) do
        if Data["List"] then
            for i=1,#Data["List"] do
                if Data["List"][i] == Spawn then
                    VehicleType = Type
                end
            end
        end
    end
    return VehicleType
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE VEHICLE FROM PLAYER LIST
-----------------------------------------------------------------------------------------------------------------------------------------
function RemoveVehicle(Player,Type,Spawn)
    if PlayerList[Player][Type] then
        for i=1,#PlayerList[Player][Type]["List"] do
            if PlayerList[Player][Type]["List"][i] == Spawn then
                table.remove(PlayerList[Player][Type]["List"],i)
                PlayerList[Player][Type]["Amount"] = PlayerList[Player][Type]["Amount"] - 1
                if PlayerList[Player][Type]["Amount"] == 0 then
                    PlayerList[Player][Type] = nil
                end
                if PlayerList[Player][Type] and #PlayerList[Player][Type]["List"] == 0 then
                    PlayerList[Player][Type] = nil
                end
                -- if json.encode(PlayerList[Player]) == "{}" or son.encode(PlayerList[Player]) == "[]" then
                --     PlayerList[Player] = nil
                --     vRP.Query("vipvehicle/RemoveVip",{ Passport = Player })
                --     Player(source)["state"]["VehicleVip"] = false
                -- end
                vRP.Query("vipvehicle/updateVip",{ Passport = parseInt(Player), Vehlist = json.encode(PlayerList[Player]) })
                return true
            end
        end
    end
end 