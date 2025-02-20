AddEventHandler("gameEventTriggered",function(name,args)
    if name ~= "CEventNetworkEntityDamage" then
        return
    end

    -- if not LocalPlayer["state"]["WarMode"] then 
    --     return
    -- end

    local Killer = PlayerPedId()
    if args[2] ~= Killer then
        return
    end

    if LocalPlayer["state"]["PVP"] then
        return
    end

    local Victim = args[1]
    local Attacker = tonumber(args[2])
    local VictimDied = GetEntityHealth(Victim) <= 100
    local Weapon = tostring(args[7])
    if VictimDied then
        if IsEntityAPed(Victim) then
            if IsPedAPlayer(Victim) then
                local VictimName = Entity(Victim)["state"]["Name"]
                local VictimServerId = GetPlayerServerId((NetworkGetPlayerIndexFromPed(Victim)))
                SendNUIMessage({ Action = "warKillFeed", weapon = Weapon, killerName = VictimName })
                TriggerServerEvent("hud:KillFeed",VictimServerId,Weapon)
            end
        end
    end
end)


-- AddEventHandler("gameEventTriggered",function(name,args)
--     if name ~= "CEventNetworkEntityDamage" then
--         return
--     end

--     -- if not LocalPlayer["state"]["WarMode"] then 
--     --     return
--     -- end

--     local Killer = args[2]
--     local Victim = args[1]

--     if Victim ~= PlayerPedId() then
--         return
--     end

--     if LocalPlayer["state"]["PVP"] then
--         return
--     end

--     local Attacker = tonumber(args[2])
--     local VictimDied = GetEntityHealth(Victim) <= 100
--     local Weapon = tostring(args[7])
--     if VictimDied then
--         if IsEntityAPed(Attacker) then
--             if IsPedAPlayer(Attacker) then
--                 local AttackerServerId = GetPlayerServerId((NetworkGetPlayerIndexFromPed(Attacker)))
--                 TriggerServerEvent("hud:UpdateHealthInformation",AttackerServerId,Weapon)
--             end
--         end
--     end
-- end)