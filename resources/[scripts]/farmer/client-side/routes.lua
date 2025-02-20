-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local inRoute = false
local Next = 0
local isFarming = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- EVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("routes:NPCStart")
AddEventHandler("routes:NPCStart",function(Position,Route)
    if vSERVER.GetRoutes(Position,Route) then
        -- TriggerEvent("Notify:Text","F7 Para Cancelar Rotas")
        LocalPlayer["state"]:set("inSafeMode",true,true)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("routes:StartRoutes")
AddEventHandler("routes:StartRoutes",function(Route,Position,Step)
    inRoute = true
    isFarming = false
    Next = RoutesCoordinates[Route]["Coordinates"][Position][Step]
    Next = vector3(Next["x"],Next["y"],Next["z"])
    CreateBlip(Next)
    local Ped = PlayerPedId()
    TriggerEvent("talknpc:closeTalkWSound")
    TriggerEvent("Notify:Text","F7 Para Cancelar Rotas")
    CreateThread(function()
        while inRoute do
            local idle = 1500
            local Coords = GetEntityCoords(Ped)
            local Distance = #(Coords-Next)
            if Distance <= 50.0 then
                idle = 1
                if not isFarming then
                    DrawText3D(Next.x,Next.y,Next.z,"[~g~E~w~] Para Coletar")
                end
                if Distance <= 5.0 and not isFarming then -- and IsControlJustPressed(0,38)
                    isFarming = true
                    isFarming = vSERVER.GiveFarm()
                end
            end
            Wait(idle)
        end
    end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("routes:NextRoute")
AddEventHandler("routes:NextRoute",function(Route,Position,Step)
    Next = RoutesCoordinates[Route]["Coordinates"][Position][Step]
    Next = vector3(Next["x"],Next["y"],Next["z"])
    CreateBlip(Next)
    isFarming = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("routes:Farming")
AddEventHandler("routes:Farming",function(Route,Position,Step)
    isFarming = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = string.len(text) / 160 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,38,42,56,200)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
function CreateBlip(Coordinates)
    if blips then
        RemoveBlip(blips)
    end
    local Ped = PlayerPedId()
    -- SetEntityCoords(Ped,Coordinates)
	blips = AddBlipForCoord(Coordinates)
    LocalPlayer["state"]["AnyJob"] = Coordinates
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.6)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coleta")
	EndTextCommandSetBlipName(blips)
end

function ExitRoutes()
    -- SetEntityCoords(PlayerPedId(),-1841.98,-1228.74,13.01)
    if inRoute then
        TriggerEvent("talknpc:closeTalkWSound")
        LocalPlayer["state"]:set("inSafeMode",false,true)
        inRoute = false
        isFarming = false
        if blips then
            RemoveBlip(blips)
        end
        vSERVER.ExitRoutes()
        TriggerEvent("Notify:Text","")
    end
end

RegisterCommand("ExitRoutes",ExitRoutes)
RegisterKeyMapping("ExitRoutes","ExitRoutes","keyboard","F7")

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)