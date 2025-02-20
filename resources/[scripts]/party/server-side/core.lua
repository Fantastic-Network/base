-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("party",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Party = {
	["Room"] = {},
	["Users"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Players(Table)
	local Amount = 0
	for _,v in pairs(Table) do
		Amount = Amount + 1
	end

	return Amount
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.List()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Current = nil
		local Name = Party["Users"][Passport]
		if Name then
			Current = {
				["name"] = Party["Users"][Passport],
				["created"] = Party["Room"][Name]["Created"],
				["players"] = Players(Party["Room"][Name]["List"])
			}
		end

		local Rooms = {}
		for Index,v in pairs(Party["Room"]) do
			Rooms[#Rooms + 1] = {
				["name"] = Index,
				["created"] = v["Created"],
				["players"] = Players(v["List"]),
				["isLocked"] = v["Password"]
			}
		end

		return {
			["current"] = Current,
			["list"] = Rooms
		}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Create(Name,Password,Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Name and not Party["Users"][Passport] and not Party["Room"][Name] then
			local Identity = vRP.Identity(Passport)
			if Identity then
				Party["Room"][Name] = {
					["List"] = {},
					["Mode"] = Mode,
					["Password"] = Password,
					["Created"] = Identity["name"].." "..Identity["name2"]
				}

				Party["Users"][Passport] = Name
				Party["Room"][Name]["List"][Passport] = source
				return Identity["name"].." "..Identity["name2"]
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXIT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Exit()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Party["Users"][Passport] then
		local Name = Party["Users"][Passport]

		if Party["Room"][Name] and Party["Room"][Name]["List"][Passport] then
			Party["Users"][Passport] = nil
			Party["Room"][Name]["List"][Passport] = nil

			if Players(Party["Room"][Name]["List"]) <= 0 then
				Party["Room"][Name] = nil
			end

			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Enter(Name,Password)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Party["Users"][Passport] and Party["Room"][Name] then
		if (Party["Room"][Name]["Password"] and Party["Room"][Name]["Password"] ~= Password) or Players(Party["Room"][Name]["List"]) >= 5 then
			return false
		end

		Party["Users"][Passport] = Name
		Party["Room"][Name]["List"][Passport] = source

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Party["Users"][Passport] then
		local Name = Party["Users"][Passport]
		if Party["Room"][Name]["List"][Passport] then
			Party["Room"][Name]["List"][Passport] = nil
			Party["Users"][Passport] = nil

			if Players(Party["Room"][Name]["List"]) <= 0 then
				Party["Room"][Name] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROOM
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Room",function(Passport,source,Radius)
	local Members = {}
	local Radius = Radius or 10
	local Name = Party["Users"][Passport]

	if Name and Party["Room"][Name] then
		local Ped = GetPlayerPed(source)
        if Ped ~= 0 and DoesEntityExist(Ped) then
            local Coords = GetEntityCoords(Ped)

            for OtherPassport,Sources in pairs(Party["Room"][Name]["List"]) do
                local OtherPed = GetPlayerPed(Sources)
                if OtherPed ~= 0 and DoesEntityExist(OtherPed) then
                    local OtherCoords = GetEntityCoords(OtherPed)

                    if #(Coords - OtherCoords) <= Radius then
                        Members[#Members + 1] = {
                            ["Passport"] = OtherPassport,
                            ["Source"] = source
                        }
                    end
                end
            end
        end
	end

	return Members
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPASSPORTROOM
-----------------------------------------------------------------------------------------------------------------------------------------
exports("GetPassportRoom",function(Passport)
	local Name = false
	if Party["Users"][Passport] then
		Name = Party["Users"][Passport]
	end

	return Name
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROOM
-----------------------------------------------------------------------------------------------------------------------------------------
exports("GetRoomMembers",function(Name)
	local Members = false
	if Party["Room"][Name] then
		Members = Party["Room"][Name]["List"]
	end

	return Members
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROOM
-----------------------------------------------------------------------------------------------------------------------------------------
exports("RemoveMember",function(Name,Passport)
	if Party["Room"][Name] and Party["Room"][Name]["List"][Passport] then
		Party["Users"][Passport] = nil
		Party["Room"][Name]["List"][Passport] = nil

		if Players(Party["Room"][Name]["List"]) <= 0 then
			Party["Room"][Name] = nil
		end

		return true
	end

	return false
end)