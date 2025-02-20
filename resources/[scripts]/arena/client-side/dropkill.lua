Player = GetPlayerServerId(PlayerId())
local inDropKill = false
local PlayerVehicle = { Network = 0, Entity = 0 }
local LastCoord
local StartCoords = {
    vector3(-1593.79,-970.33,13.08),
}

CreateThread(function()
    local Table = {}

    for i=1, #StartCoords do
        Table[i] = {
            StartCoords[i].x,
            StartCoords[i].y,
            StartCoords[i].z,
            2.0,
            "E",
            "Entrar no Desce Quebra",
            "Pressione para abrir",
        }
    end

    TriggerEvent("hoverfy:Insert",Table)

    while true do 
        local idle = 2500
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        for i=1, #StartCoords do
            if #(Coords - StartCoords[i]) <= 2.0 then
                idle = 5
                if IsControlJustPressed(0,38) and not LocalPlayer["state"]["Newbie"] then
                    LastCoord = Coords
                    vSERVER.StartDropKill()
                    SetRunSprintMultiplierForPlayer(PlayerId(),1.15)
                end
            end
        end
        Wait(idle)
    end
    
end)

RegisterNetEvent("dropkill:SpawnVehicle")
AddEventHandler("dropkill:SpawnVehicle",function(NetWork,Vehicle)
    PlayerVehicle = { Network = NetWork, Entity = Vehicle }
end)

RegisterNetEvent("dropkill:KillFeed")
AddEventHandler("dropkill:KillFeed",function(VictimName,KillerName,Weapon)
    SendNUIMessage({
        action = 'killFeed',
        data = { 
            killFeed = { 
                victim = VictimName,
                killer = KillerName
            },
        image = Weapon,
        }
    })
end)

AddStateBagChangeHandler('DropKill',('player:%s'):format(Player) , function(_, _, Value)
    local Ped = PlayerPedId()
    if Value then
        if not inDropKill then
            inDropKill = true
            SendNUIMessage({
                action = 'router',
                data = {
                    path = "/Arena"
                }
            })
            Wait(1)
            SendNUIMessage({
                action = 'setText',
                data = {
                    enter = "",
                    exit = "E"
                }
            })
            Wait(1)
            SendNUIMessage({
                action = 'setVisible',
                data = true
            })
            DropKillDeath()
            CreateThread(function()
                while inDropKill do
                    local Coords = GetEntityCoords(Ped)
                    DisableControlAction(0,345, true)
                    DisableControlAction(0,24) -- INPUT_ATTACK
                    DisableControlAction(0,69) -- INPUT_VEH_ATTACK
                    DisableControlAction(0,92) -- INPUT_VEH_PASSENGER_ATTACK
                    SetPedCanBeKnockedOffVehicle(Ped, 1)
                    local PlayerVehicle = GetVehiclePedIsIn(Ped)
                    local Vehicles = GetGamePool('CVehicle')
                    local Peds = GetGamePool('CPed')

                    for i=1, #Vehicles do
                        local Vehicle = Vehicles[i]
                        if #(Coords - GetEntityCoords(Vehicle)) < 60.0 then
                            SetEntityNoCollisionEntity(Vehicle, PlayerVehicle, true)
                            if Vehicle ~= PlayerVehicle then
                                SetEntityNoCollisionEntity(Vehicle, Ped, true)
                            end
                        end
                    end

                    for i=1,#Peds do
                        local SelectedPed = Peds[i]
                        if #(Coords - GetEntityCoords(SelectedPed)) < 60.0 then
                            SetEntityNoCollisionEntity(SelectedPed, Ped, true)
                        end
                    end

                    Wait(1)
                end
            end)
            local offVehicleCD = GetGameTimer() + 30000
            CreateThread(function()
                while inDropKill do
                    local Coords = GetEntityCoords(Ped)
                    if IsPedInAnyVehicle(Ped) then
                        offVehicleCD = GetGameTimer() + 30000
                    end
                    if not IsPedInAnyVehicle(Ped) and offVehicleCD < GetGameTimer() then
                        DropKillDeath()
                    end
                    Wait(1)
                end
            end)

            Wait(3000)
            CreateThread(function()
                Wait(10000)
                while inDropKill do
                    if IsControlJustPressed(0,38) then
                        local Ped = PlayerPedId()
                        SendNUIMessage({
                            action = 'setVisible',
                            data = false
                        })
                        Wait(1)
                        SendNUIMessage({
                            action = 'router',
                            data = {
                                path = "/"
                            }
                        })
                        vSERVER.ExitDropKill(PlayerVehicle["Entity"])
                        SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
                        SetEntityCoords(Ped,LastCoord,false,false,false,false)
                        inDropKill = false
                        PlayerVehicle = { Network = 0, Entity = 0 }
                    end
                    Wait(1)
                end
            end)

        end
    end
end)


AddEventHandler("gameEventTriggered",function(name,args)
    if name ~= "CEventNetworkEntityDamage" then
        return
    end

    if not inDropKill then
        return
    end

    local Victim = PlayerPedId()

    if args[1] ~= Victim then
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
                TriggerServerEvent("dropkill:KillFeed",VictimServerId,KillerServerId,Weapon,PlayerVehicle["Entity"])
                Wait(2500)
                exports["survival"]:Revive(200,false)
                DropKillDeath()
            end
        end
    end
end)

function DropKillDeath()
    local Ped = PlayerPedId()
    local Test = vector3(-217.51,-880.65,29.75)
    local randomx = math.random(parseInt(Test["x"]-500),parseInt(Test["x"]+500))+0.15
    local randomy = math.random(parseInt(Test["y"]-500),parseInt(Test["y"]+500))+0.15
    local road,cds1,cds2 = GetClosestRoad(randomx,randomy,15.0)
    TriggerEvent("hoverfy:removeHoverfy")
    SetEntityCoords(Ped,cds1[1],cds1[2],cds1[3]-0.1,0,0,0)
    Wait(1000)
    TriggerServerEvent("dropkill:coolDownVeh",PlayerVehicle["Entity"])
end

CreateThread(function()
    while true do 
        local idle = 2500
        if LocalPlayer["state"]["GunGame"] or LocalPlayer["state"]["Arena"] or LocalPlayer["state"]["Rolling"] or LocalPlayer["state"]["Domination"] or LocalPlayer["state"]["DropKill"] or LocalPlayer["state"]["FFA"] then
            idle = 1
            RestorePlayerStamina(PlayerId(),1.0)
		end
        Wait(idle)
    end
end)