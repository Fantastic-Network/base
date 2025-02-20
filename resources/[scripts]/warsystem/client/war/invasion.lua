-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Mode,Group = nil,nil
local InvasionZone =  false
local circleZone = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- WarSystem
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("warsystem:Start")
AddEventHandler("warsystem:Start",function(Table,GasZone)
    local Ped = PlayerPedId()
    InvasionZone = Table["Zone"]
    LocalPlayer["state"]["WarSystem"] = true

    TriggerEvent("hoverfy:removeHoverfy")
    TriggerEvent("warsystem:StartNui",Table)
    FreezeEntityPosition(Ped,true)
    LocalPlayer["state"]["Invincible"] = true
    SetEntityInvincible(ped,true)
    PointsZoneWar = PolyZone:Create(warSystemConfig[InvasionZone]["Point"],warSystemConfig[InvasionZone]["optionsP"])
    Wait(5500)
    
    SetEntityInvincible(ped,false)
    LocalPlayer["state"]["Invincible"] = false
    FreezeEntityPosition(Ped,false)

    if GasZone then
        local Radius = 500.00
        circleZone = CircleZone:Create(vector2(GasZone.x,GasZone.y), Radius, {
            name="Zone",
            debugPoly=true,
            debugColor = {0,0,255}
        })

        CreateThread(function()
            while LocalPlayer["state"]["WarSystem"] do
                Radius = Radius - 0.4164
                if circleZone then
                    circleZone:setRadius(Radius)
                end
                Wait(1)
            end
        end)
    end
    SetRunSprintMultiplierForPlayer(PlayerId(),1.15)
    InsideInvasion()
end)

RegisterNetEvent("warsystem:Update")
AddEventHandler("warsystem:Update",function(Table)
    TriggerEvent("warsystem:updateNui",Table)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.15)
end)

RegisterNetEvent("warsystem:Exit")
AddEventHandler("warsystem:Exit",function(Table)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.10)
    InvasionZone = nil
    PointsZoneWar:destroy()
    if circleZone then
        circleZone:destroy()
    end
    TriggerEvent("warsystem:ExitNui")
    circleZone = false
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD POINTS
-----------------------------------------------------------------------------------------------------------------------------------------
function InsideInvasion()
    Wait(5000)
    CreateThread(function()
        local Ped = PlayerPedId()
        while LocalPlayer["state"]["WarSystem"] do
            local Coords = GetEntityCoords(Ped)
            local Health = GetEntityHealth(Ped)
            if Health <= 100 then
                LocalPlayer["state"]:set("WarSystem",false,true)
                TriggerServerEvent("warsystem:ExitInvasion")
            end
            if PointsZoneWar then
                if PointsZoneWar:isPointInside(Coords) then
                    LocalPlayer["state"]:set("WarSystem",true,true)
                else
                    print("Leave")
                    LocalPlayer["state"]:set("WarSystem",false,true)

                    TriggerServerEvent("warsystem:ExitInvasion")
                end
            end
            Wait(500)
        end
    end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("getData",function(data,cb)
    local Areas = {}
    local Groups = {}
    local Types = warSytemGroups
    local Config = warSystemConfig
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

RegisterNUICallback("saveData",function(data,cb)
    TriggerServerEvent("warsystem:CreateInvasion",data["area"],data["playersAmount"],data["interval"],data["points"],data["groups"])
end)

RegisterNetEvent("warsystem:ShowNui")
AddEventHandler("warsystem:ShowNui",function()
    SetNuiFocus(true,true)
    SendNUIMessage({
        action = "setVisible",
        data = "form"
    })
end)

RegisterNUICallback("hideFrame",function(data,cb)
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
    
    if not LocalPlayer["state"]["WarSystem"] then
        return
    end

    if not InvasionZone then
        return
    end
    print("1")
    local Attacker = tonumber(args[2])
    local VictimDied = GetEntityHealth(Victim) <= 100
    local Weapon = tostring(args[7])
    if VictimDied then
        print("2")
        if IsEntityAPed(Victim) then
            print("3")
            if IsPedAPlayer(Attacker) then
                print("4")
                local KillerServerId = GetPlayerServerId((NetworkGetPlayerIndexFromPed(Attacker)))
                local VictimServerId = GetPlayerServerId(PlayerId())
                local KillerCoordinate = GetEntityCoords(Attacker)
                vSERVER.killFeedInvasion(KillerServerId,VictimServerId,Weapon)
            end
        end
    end
end)

RegisterNetEvent("warsystem:Blip")
AddEventHandler("warsystem:Blip",function(Zone)
    PointsZoneWar = PolyZone:Create(warSystemConfig[Zone]["Point"],warSystemConfig[Zone]["optionsP"])
    local Coords = getPolygonCenter(warSystemConfig[Zone]["Point"])
    BlipWar = AddBlipForCoord(Coords["x"],Coords["y"],20 )
    RequestNamedPtfxAsset(BlipWar)
    SetBlipSprite(BlipWar,630)
    SetBlipAsShortRange(BlipWar,true)
    SetBlipColour(BlipWar,1)
    SetBlipScale(BlipWar,1.5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("~r~Dominacao~w~")
    EndTextCommandSetBlipName(BlipWar)
    TriggerEvent("Notify","dominacao","Area de dominação foi marcada no seu mapa.","Dominacao")
    -- TriggerEvent("Notify2","#dominationAreaMarked")
end)

RegisterNetEvent("warsystem:Death")
AddEventHandler("warsystem:Death",function()
    if not LocalPlayer["state"]["WarSystemSpec"] then
        return
    end
    local Ped = PlayerPedId()
    Wait(100)
    exports["survival"]:Revive(400)
    LocalPlayer["state"]["Invincible"] = true
    LocalPlayer["state"]["Invisible"] = true
    FreezeEntityPosition(Ped, true)
    SetEntityInvincible(Ped,true)
    SetEntityVisible(Ped,false,false)
    SetEntityCollision(Ped,false,false)
    Wait(100)
    TriggerServerEvent("warsystem:NextSpectate")
end)

RegisterNetEvent("warsystem:RemBlip")
AddEventHandler("warsystem:RemBlip",function()
    RemoveBlip(BlipWar)
    PointsZoneWar:destroy()
end)

RegisterNUICallback('GetServerInfos', function(_, cb)
    cb({logo = Logos[cityName], discord = DiscordConv[cityName]})
end)

RegisterNetEvent("warsystem:KillFeed")
AddEventHandler("warsystem:KillFeed",function(KillerName,VictimName,Weapon)
    SendNUIMessage({
        action = 'KillFeed',
        data = { 
            killerName = KillerName,
            victimName = VictimName,
            weapon = Weapon,
            duration = 2500,
        }
    })
end)

AddEventHandler("warsystem:ExitNui",function()
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
end)

AddEventHandler("warsystem:updateNui",function(Table)
    SendNUIMessage({
        action = 'UpdateGameStats',
        data = Table
    })
end)

AddEventHandler("warsystem:StartNui",function(Table)
    local CountDown = 10
    
    SendNUIMessage({
        action = 'setVisible',
        data = "countdown"
    })
    
    Wait(5000)

    SendNUIMessage({
        action = 'NavigatePath',
        data = "gameplay-invasion"
    })

    Wait(100)
    SendNUIMessage({
        action = 'UpdateGameStats',
        data = Table
    })

    CreateThread(function()
        local Ped = PlayerPedId()
        while LocalPlayer["state"]["WarSystem"] do
            if circleZone then
                local Coords = GetEntityCoords(Ped)
                if not circleZone:isPointInside(Coords) then
                    local Health = GetEntityHealth(Ped)
                    SetEntityHealth(Ped, Health - 10)
                end
            end
            Wait(1000)
        end
    end)
    CreateThread(function()
        local Ped = PlayerPedId()
        while LocalPlayer["state"]["WarSystem"] do
            local Health = parseInt(GetEntityHealth(Ped))
            SendNUIMessage({
                action = 'UpdateHealth',
                data = Health
            })
            Wait(250)
        end
    end)
end)


AddStateBagChangeHandler('WarSystem',('player:%s'):format(Player) , function(_, _, Value)
    local Ped = PlayerPedId()
    Wait(100)
    if Value then
        TriggerEvent("hud:Active",false)
        TriggerEvent("Notify:Remkey" ,true)
        TriggerEvent("safezone:remPromo",true)
    else
        SetPedInfiniteAmmoClip(Ped, false)
        SetRunSprintMultiplierForPlayer(Player,1.10)
        Wait(500)
        TriggerEvent("Notify:Remkey",false)
        TriggerEvent("safezone:remPromo",false)
        TriggerEvent("hud:Active",true)
    end
end)