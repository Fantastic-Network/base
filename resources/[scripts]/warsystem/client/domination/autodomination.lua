local Selected = 1
local Blips = {}
local Area = false
local WinnersBlip = {}

function DeleteBlips()
    for i=1,#Blips do
        RemoveBlip(Blips[i])
    end
end

function CreateBlipAD(Selected)
    DeleteBlips()
    Wait(100)
    local Ped = PlayerPedId()
    local DominationCoords = autoDomination[Selected]["Coords"]
    local Coords = GetEntityCoords(Ped)
    local Blip = AddBlipForRadius(DominationCoords["x"],DominationCoords["y"],Coords["z"],autoDomination[Selected]["Radius"])
    SetBlipColour(Blip, 2)
    SetBlipAlpha(Blip, 125)
    SetBlipAsShortRange(Blip, true)
    table.insert(Blips,Blip)
    local Blip = AddBlipForCoord(DominationCoords["x"],DominationCoords["y"],0.0)
    SetBlipSprite(Blip,164)
    SetBlipDisplay(Blip,4)
    SetBlipAsShortRange(Blip,true)
    SetBlipColour(Blip,2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Área de Dominação")
    EndTextCommandSetBlipName(Blip)
    table.insert(Blips,Blip)
end

RegisterNetEvent("autodomination:Finish")
AddEventHandler("autodomination:Finish",function()
    DeleteBlips()
    if Area then
        Area:destroy()
    end
    Selected = 1
    Blips = {}
    Area = false
end)

RegisterNetEvent("autodomination:Start")
AddEventHandler("autodomination:Start",function(Number)
    if Area then
        Area:destroy()
    end
    Selected = Number
    local Ped = PlayerPedId()
    local DominationCoords = autoDomination[Selected]["Coords"]
    local Coords = GetEntityCoords(Ped)
    local Radius = autoDomination[Selected]["Radius"]
    local Options = autoDomination[Selected]["Options"]
    CreateBlipAD(Selected)
    InsideArea = false
    Area = CircleZone:Create(DominationCoords, Radius,Options)
end)

local InsideArea = false
CreateThread(function()
    Wait(1000)
    if GlobalState["AutoDomination"] then
        while true do
            local Idle = 1000
            local Ped = PlayerPedId()
            local Coords = GetEntityCoords(Ped)
            local Health = GetEntityHealth(Ped)
            if Area then
                if Health > 100 and Area:isPointInside(Coords) then
                    if InsideArea == false then
                        InsideArea = true
                        TriggerServerEvent("autodomination:Entered")
                    end
                else
                    if InsideArea == true then
                        TriggerServerEvent("autodomination:Exited")
                    end
                    InsideArea = false
                end
            end
            Wait(Idle)
        end
    end
end)


RegisterNetEvent("autodomination:updateBlips")
AddEventHandler("autodomination:updateBlips",function(BlipsData)
    local Ped = PlayerPedId()
    local Coords = GetEntityCoords(Ped)
    for i=1,#WinnersBlip do
        RemoveBlip(WinnersBlip[i])
    end
    WinnersBlip = {}
    for Blip2, BlipData in pairs(BlipsData) do
        local Blip = AddBlipForCoord(BlipData["Coords"],0.0)
        local Text = BlipData["Name"]
        SetBlipSprite(Blip,546)
        SetBlipDisplay(Blip,4)
        SetBlipAsShortRange(Blip,true)
        SetBlipColour(Blip,4)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Text)
        EndTextCommandSetBlipName(Blip)
        table.insert(WinnersBlip,Blip)
    end
end)