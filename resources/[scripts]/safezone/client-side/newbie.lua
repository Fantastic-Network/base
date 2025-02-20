local NotifyNewbie = GetGameTimer()
local pierCoords = vector3(-1611.36,-972.13,13.01)

CreateThread(function()
    if GlobalState["SafeZone"] then
        while true do
            if not GlobalState["WarMode"] then
                if LocalPlayer["state"]["Newbie"] and GetGameTimer() >= NotifyNewbie then
                    NotifyNewbie = GetGameTimer() + 1000*60*5
                    TriggerEvent("Notify","amarelo","Você está em safemode para sua proteção. Para sair deste modo, basta você entrar para qualquer emprego!",15000,"MODO SAFE")
                    -- TriggerEvent("Notify2","#safeModeWarning")
                end
            end
            Wait(5000)
        end
    end
end)

AddEventHandler("gameEventTriggered",function(name,args)
    if GlobalState["SafeZone"] then
        local ped = PlayerPedId()
        if name == "CEventNetworkEntityDamage" and args[1] == ped then
            if GetEntityHealth(ped) <= 100 then
                if LocalPlayer["state"]["Newbie"] then
                    local Attacker = tonumber(args[2])
                    local Weapon = tostring(args[7])
                    if IsEntityAPed(ped) then
                        if IsPedAPlayer(Attacker) then
                            local KillerServerId = GetPlayerServerId((NetworkGetPlayerIndexFromPed(Attacker)))
                            TriggerServerEvent("player:MenosReputacao",KillerServerId,"KillNewbie")
                        end
                    end
                    Wait(5000)
                    TriggerEvent("Notify","vermelho","Poxa... Que pena ein! Mas fica tranquilo, você não perdeu nada por ainda estar pegando o jeito! Não desanima e vamos pra cima novamente!",35000,"NOVATO")
                    -- TriggerEvent("Notify2","#fNewbie")
                    Wait(5000)
                    SetEntityCoords(ped,pierCoords)
                    Wait(100)
                    exports["survival"]:Revive(400,true)
                end
            end
        end
    end
end)