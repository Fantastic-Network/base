-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Mode,Group = nil,nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOMINATION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("domination:StartDomClient")
AddEventHandler("domination:StartDomClient",function(Table)
    local Ped = PlayerPedId()
    Zone = Table["Zone"]
    DoubleZone = PolyZone:Create(dominationConfig[Zone]["DoublePoint"],dominationConfig[Zone]["optionsD"])
    PointsZone = PolyZone:Create(dominationConfig[Zone]["Point"],dominationConfig[Zone]["optionsP"])
    TriggerEvent("hoverfy:removeHoverfy")
    TriggerEvent("domination:StartNui",Table)
    FreezeEntityPosition(Ped,true)
    LocalPlayer["state"]["Invincible"] = true
    SetEntityInvincible(ped,true)

    Wait(11000)
    
    SetEntityInvincible(ped,false)
    LocalPlayer["state"]["Invincible"] = false
    FreezeEntityPosition(Ped,false)


    SetRunSprintMultiplierForPlayer(PlayerId(),1.15)
    InsideDomination()
end)

RegisterNetEvent("domination:Update")
AddEventHandler("domination:Update",function(Table)
    TriggerEvent("domination:updateNui",Table)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.15)
end)

RegisterNetEvent("domination:Exit")
AddEventHandler("domination:Exit",function(Table)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.10)
    Zone = nil
    DoubleZone:destroy()
    PointsZone:destroy()
    TriggerEvent("domination:ExitNui")
    TriggerEvent("Notify:Remkey",false)
    TriggerEvent("safezone:remPromo",false)
    TriggerEvent("hud:Active",true)
    SetNuiFocus(false,false)
    SendNUIMessage({
        action = "setVisible",
        data = false
    })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD POINTS
-----------------------------------------------------------------------------------------------------------------------------------------
function InsideDomination()
    CreateThread(function()
        while LocalPlayer["state"]["Domination"] do
            local Coords = GetEntityCoords(PlayerPedId())
            local Health = GetEntityHealth(PlayerPedId())
            if Health <= 100 then
                LocalPlayer["state"]:set("Domination",false,true)
            end
            if DoubleZone and PointsZone then
                if DoubleZone:isPointInside(Coords) then
                    if LocalPlayer["state"]["Domination"] and LocalPlayer["state"]["Domination"] ~= 2 then
                        LocalPlayer["state"]:set("Domination",2,true)
                    end
                elseif PointsZone:isPointInside(Coords) then
                    if LocalPlayer["state"]["Domination"] and LocalPlayer["state"]["Domination"] ~= 1 then
                        LocalPlayer["state"]:set("Domination",1,true)
                    end
                else
                    LocalPlayer["state"]:set("Domination",false,true)
                end
            end
            Wait(500)
        end
    end)

    CreateThread(function()
        local Ped = PlayerPedId()
        while LocalPlayer["state"]["Domination"] do
            local Health = parseInt(GetEntityHealth(Ped))
            SendNUIMessage({
                action = 'UpdateHealth',
                data = Health
            })
            Wait(250)
        end
    end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("getDominationAreaAndGroups",function(data,cb)
    local Areas = {}
    local Groups = {}
    local Types = DominationType()
    local Config = DominationConfig()
    for Type,_ in pairs(Types) do
        table.insert(Groups,Type)
    end
    for Area,Data in pairs(Config) do
        table.insert(Areas,Area)
    end
    table.sort(Areas, function(a, b)
        return a < b
    end)
    table.sort(Groups, function(a, b)
        return a < b
    end)
    cb({areas = Areas,groups = Groups})
end)

RegisterNUICallback("saveDataDom",function(data,cb)
    TriggerServerEvent("domination:start",data["area"],data["playersAmount"],data["interval"],data["points"],data["groups"][1])
end)

RegisterNetEvent("domination:ShowNui")
AddEventHandler("domination:ShowNui",function()
    SetNuiFocus(true,true)
    SendNUIMessage({
        action = "setVisible",
        data = "form-dom"
    })
end)

RegisterNUICallback("hideFrame",function(data,cb)
    if LocalPlayer["state"]["Spectate"] then
        return
    end
    SetNuiFocus(false,false)
    SendNUIMessage({
        action = "setVisible",
        data = false
    })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEAD EVENT
-----------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler("gameEventTriggered",function(name,args)
    if name ~= "CEventNetworkEntityDamage" then
        return
    end
    local Victim = PlayerPedId()
    
    if args[1] ~= Victim then
        return
    end
    
    if not LocalPlayer["state"]["Domination"] then
        return
    end

    if not Zone then
        return
    end

    local Attacker = tonumber(args[2])
    local VictimDied = GetEntityHealth(Victim) <= 100
    local Weapon = tostring(args[7])
    if VictimDied then
        if IsEntityAPed(Victim) then
            if IsPedAPlayer(Attacker) then
                local KillerServerId = GetPlayerServerId((NetworkGetPlayerIndexFromPed(Attacker)))
                local VictimServerId = GetPlayerServerId(PlayerId())
                local KillerCoordinate = GetEntityCoords(Attacker)
                vSERVER.killFeedDom(KillerServerId,VictimServerId,Weapon)
            end
        end
    end
end)

RegisterNetEvent("domination:Blip")
AddEventHandler("domination:Blip",function(Zone)
    DoubleZone = PolyZone:Create(dominationConfig[Zone]["DoublePoint"],dominationConfig[Zone]["optionsD"])
    PointsZone = PolyZone:Create(dominationConfig[Zone]["Point"],dominationConfig[Zone]["optionsP"])
    local Coords = getPolygonCenter(dominationConfig[Zone]["Point"])
    Blip = AddBlipForCoord(Coords["x"],Coords["y"],20 )
    RequestNamedPtfxAsset(Blip)
    SetBlipSprite(Blip,630)
    SetBlipAsShortRange(Blip,true)
    SetBlipColour(Blip,1)
    SetBlipScale(Blip,1.5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("~r~Dominacao~w~")
    EndTextCommandSetBlipName(Blip)
    TriggerEvent("Notify","dominacao","Area de dominação foi marcada no seu mapa.","Dominacao")
    -- TriggerEvent("Notify2","#dominationAreaMarked")
end)

RegisterNetEvent("domination:RemBlip")
AddEventHandler("domination:RemBlip",function()
    RemoveBlip(Blip)
    DoubleZone:destroy()
    PointsZone:destroy()
end)
