-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Zone = {}
local Select = {}
local Active = false
local TextActive = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GRIDCHUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function gridChunk(x)
	return math.floor((x + 8192) / 128)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOCHANNEL
-----------------------------------------------------------------------------------------------------------------------------------------
function toChannel(v)
	return (v["x"] << 8) | v["y"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETGRIDZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function getGridzone(x,y)
	local gridChunk = vector2(gridChunk(x),gridChunk(y))
	return toChannel(gridChunk)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)

			if not Active then
				local gridZone = getGridzone(Coords["x"],Coords["y"])

				if Zone[gridZone] then
					for _,Table in pairs(Zone[gridZone]) do
						if #(Coords - Table["Coords"]) < Table["Distance"] then
							SendNUIMessage({ page = "hoverfy", action = "show", key = Table["key"], title = Table["title"], legend = Table["legend"] })
							Select = Table
							Active = true
						end
					end
				end
			else
				if #(Coords - Select["Coords"]) > Select["Distance"] then
					SendNUIMessage({ page = "hoverfy", action = "hide" })
					TimeDistance = 100
					Active = false
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOVERFY:INSERT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hoverfy:Insert")
AddEventHandler("hoverfy:Insert",function(innerTable)
	for _,v in pairs(innerTable) do
		local gridZone = getGridzone(v[1],v[2])

		if not Zone[gridZone] then
			Zone[gridZone] = {}
		end

		Zone[gridZone][#Zone[gridZone] + 1] = {
			["Coords"] = vec3(v[1],v[2],v[3]),
			["Distance"] = v[4],
			["key"] = v[5],
			["title"] = v[6],
			["legend"] = v[7]
		}
	end
end)

RegisterNetEvent("hoverfy:InsertText")
AddEventHandler("hoverfy:InsertText",function(Open,Table)
    if not TextActive then
        TextActive = true
    else
        SendNUIMessage({ page = "hoverfy", action = "hideText" })
    end

    if Open then
        SendNUIMessage({ page = "hoverfy", action = "showText", key = Table["key"], title = Table["title"], legend = Table["legend"] })
    else
        SendNUIMessage({ page = "hoverfy", action = "hideText" })
    end
end)

RegisterNetEvent("hoverfy:toggle")
AddEventHandler("hoverfy:toggle",function(Open,Table)
    if Open then
        SendNUIMessage({ page = "hoverfy", action = "show", key = Table["key"], title = Table["title"], legend = Table["legend"] })
    else
        SendNUIMessage({ page = "hoverfy", action = "hide" })
    end
end)

RegisterNetEvent("hoverfy:removeHoverfy")
AddEventHandler("hoverfy:removeHoverfy",function(Time)
    SendNUIMessage({ page = "hoverfy", action = "hide" })
    if Time then
        Wait(Time)
    end
    Wait(500)
    if not Active then
        TimeDistance = 100
        Active = false
    end
end)

RegisterNetEvent("hoverfy:returnHoverfy")
AddEventHandler("hoverfy:returnHoverfy",function()
    TimeDistance = 100
    Active = false
end)