local Player = GetPlayerServerId(PlayerId())
local LastCoords
local FFAType
local inFFA = false
local lastWeapon 
local StartCoords = {
    { vector3(-1613.39,-1034.63,13.14), "Fuzil"},
    { vector3(-1610.07,-1031.4,13.13), "Pistola"}
}
CreateThread(function()
    local Table = {}

    for i=1, #StartCoords do
        Table[i] = {
            StartCoords[i][1]["x"],
            StartCoords[i][1]["y"],
            StartCoords[i][1]["z"],
            2.0,
            "E",
            "Entrar no FFA "..StartCoords[i][2],
            "Pressione para abrir",
        }
    end

    TriggerEvent("hoverfy:Insert",Table)

    while true do 
        local idle = 2500
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        for i=1, #StartCoords do
            if #(Coords - StartCoords[i][1]) <= 2.0 then
                idle = 5
                if IsControlJustPressed(0,38) and not LocalPlayer["state"]["Newbie"] then
                    LastCoord = Coords
                    vSERVER.StartFFA(StartCoords[i][2])
                end
            end
        end
        Wait(idle)
    end
    
end)

AddStateBagChangeHandler("FFA",("player:%s"):format(Player) , function(_, _, Value)
    local Ped = PlayerPedId()
    if Value then
        FFAType = Value["Type"]
        inFFA = true
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
                exit = "G"
            }
        })
        Wait(1)
        SendNUIMessage({
            action = 'setVisible',
            data = true
        })
        local Random = math.random(1,#FFACoordinates[FFAType][GlobalState["FFA"][FFAType]])
        SetEntityCoords(Ped,FFACoordinates[FFAType][GlobalState["FFA"][FFAType]][Random],false,false,false,false)
        LastCoords = FFACoordinates[FFAType][GlobalState["FFA"][FFAType]][Random]
        SetRunSprintMultiplierForPlayer(PlayerId(),1.15)
        TriggerEvent("hoverfy:removeHoverfy")
        CreateThread(function()
            Wait(500)
            while inFFA do
                local Coords = GetEntityCoords(Ped)
                local Distance = #(Coords - LastCoords)
                if Distance >= 150.0 then
                    SetEntityCoords(Ped,LastCoords,false,false,false,false)
                end
                Wait(1)
            end
        end)
        CreateThread(function()
            Wait(10000)
            while inFFA do
                if IsControlJustPressed(0,47) then
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
                    SetEntityCoords(Ped,LastCoord,false,false,false,false)
                    vSERVER.ExitFFA(FFAType)
                    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
                    LastCoords = nil
                    FFAType =  nil
                    inFFA = false
                    lastWeapon = nil
                end
                Wait(1)
            end
        end)
    end
end)

AddEventHandler("gameEventTriggered",function(name,args)
    if name ~= "CEventNetworkEntityDamage" then
        return
    end

    if not inFFA then
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
        lastWeapon = GetSelectedPedWeapon(Victim)
        if IsPedAPlayer(Attacker) then
            local KillerServerId = GetPlayerServerId((NetworkGetPlayerIndexFromPed(Attacker)))
            local VictimServerId = GetPlayerServerId(PlayerId())
            TriggerServerEvent("freeforall:SetKillFeed",VictimServerId,KillerServerId,Weapon,FFAType)
            Wait(2500)
            exports["survival"]:Revive(400)
            FFADeath()
        end
    end
end)

function FFADeath()
	if inFFA then
		local Ped = PlayerPedId()
        local Random = math.random(1,#FFACoordinates[FFAType][GlobalState["FFA"][FFAType]])
		SetEntityCoords(Ped,FFACoordinates[FFAType][GlobalState["FFA"][FFAType]][Random]["x"],FFACoordinates[FFAType][GlobalState["FFA"][FFAType]][Random]["y"],FFACoordinates[FFAType][GlobalState["FFA"][FFAType]][Random]["z"],false,false,false,false)
        LastCoords = FFACoordinates[FFAType][GlobalState["FFA"][FFAType]][Random]
        SetEntityHeading(Ped,FFACoordinates[FFAType][GlobalState["FFA"][FFAType]][Random]["w"])
        TriggerServerEvent("freeforall:SpawnFFA")
	end
end


RegisterNetEvent("freeforall:UpdateKill")
AddEventHandler("freeforall:UpdateKill",function(Kills)
	if inFFA then
        SendNUIMessage({
            action = 'killCount',
            data = Kills
        })
	end
end)

RegisterNetEvent("freeforall:KillFeed")
AddEventHandler("freeforall:KillFeed",function(VictimName,KillerName,Weapon)
	if inFFA then
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
	end
end)