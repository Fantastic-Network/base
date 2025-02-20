cityName = GetConvar("cityName", "Base")
local WMCooldown = 300

if cityName == "Base" then
    WMCooldown = 60
end

RegisterServerEvent("WarMode:Enter")
AddEventHandler("WarMode:Enter",function(entity,RedZone)
    local source = source
    if entity and type(entity) ~= "string" then
        -- local Cooldown = vRP.WarModeCooldown(entity)
        -- if Cooldown then
        --     if os.time() - Cooldown < WMCooldown then
        --         TriggerClientEvent("Notify",entity,"vermelho","Você precisa esperar "..(WMCooldown - (os.time() - Cooldown)).." segundos para entrar no Modo Guerra novamente.",5000,"NEGADO")
        --         return
        --     end
        -- end
            
        local Passport = vRP.Passport(entity)
        if Passport then
            local Ped = GetPlayerPed(entity)
            local entity = vRP.Source(Passport)
            if not Ped or Ped == 0 then 
                return
            end
            if entity then
                -- if vRP.HasGroup(Passport,"Iniciante") then
                --     TriggerClientEvent("Notify",entity,"vermelho","Você não pode entrar no Modo Guerra sendo iniciante. Seja contratado para entrar!",10000,"NEGADO")
                -- else
                    TriggerClientEvent("Progress",entity,"Modo Guerra",2000)
                    Wait(2000)
                    Player(entity)["state"]["GreenMode"] = false
                    TriggerClientEvent("Notify",entity,"vermelho","Você entrou no modo guerra.",5000,"MODO DE GUERRA")
                    -- TriggerClientEvent("Notify2",entity,"#enteredWarMode")
                    Entity(Ped)["state"]:set("WarMode",true,true)
                    if GlobalState["WarModeBucket"] then
                        TriggerEvent("Safe:Bucket",2,source)
                    end
                -- end
            end
        end
    else
        local Ped = GetPlayerPed(source)
        local Passport = vRP.Passport(source)
        -- if vRP.HasGroup(Passport,"Iniciante") then
        --     TriggerClientEvent("Notify",source,"vermelho","Você não pode entrar no Modo Guerra sendo iniciante. Seja contratado para entrar!",10000,"NEGADO")
        -- else
            if not RedZone then
                -- local Cooldown = vRP.WarModeCooldown(source)
                -- if Cooldown then
                --     if os.time() - Cooldown < WMCooldown then
                --         TriggerClientEvent("Notify",source,"vermelho","Você precisa esperar "..(WMCooldown - (os.time() - Cooldown)).." segundos para entrar no Modo Guerra novamente.",5000,"NEGADO")
                --         return
                --     end
                -- end
                Player(source)["state"]["Buttons"] = true
                vRPC.playAnim(source,false,{"anim@deathmatch_intros@unarmed","intro_male_unarmed_d"},true)
                TriggerClientEvent("Progress",source,"Modo Guerra",5000)
                Wait(5000)
                Player(source)["state"]["Buttons"] = false
                Player(source)["state"]["GreenMode"] = false
                TriggerClientEvent("Notify",source,"vermelho","Você entrou no modo de guerra.",5000,"MODO DE GUERRA")
                -- TriggerClientEvent("Notify2",source,"#enteredWarMode")
                Entity(Ped)["state"]:set("WarMode",true,true)
                Player(source)["state"]["WarMode"] = true
                if GlobalState["WarModeBucket"] then
                    TriggerEvent("Safe:Bucket",2,source)
                end
                vRPC.stopAnim(source,false)
            else
                TriggerClientEvent("Progress",source,"Modo Guerra",5000)
                Wait(5000)
                if vCLIENT.isInsideZone(source) then
                    Player(source)["state"]["GreenMode"] = false
                    TriggerClientEvent("Notify",source,"vermelho","Você entrou no modo de guerra.",5000,"MODO DE GUERRA")
                    -- TriggerClientEvent("Notify2",source,"#enteredWarMode")
                    Entity(Ped)["state"]:set("WarMode",true,true)
                    Player(source)["state"]["WarMode"] = true
                    if GlobalState["WarModeBucket"] then
                        TriggerEvent("Safe:Bucket",2,source)
                    end
                end
                TriggerClientEvent("Safezone:DoneEntering",source)
            end
        -- end
    end
end)

local cityWarmode = {
    ["Base"] = true,
}

local cityWarmodeBucket = {
    ["Base"] = true,
}

GlobalState["WarMode"] = false
GlobalState["WarModeBucket"] = false

CreateThread(function()
    Wait(500)
    if cityWarmode[cityName] then
        GlobalState["WarMode"] = true
    end
    if cityWarmodeBucket[cityName] then
        GlobalState["WarModeBucket"] = true
    end
    -- local players = GetPlayers()
    -- for i=1,#players do
    --     local serverId = players[i]
    --     local Ped = GetPlayerPed(serverId)
    --     Player(serverId)["state"]["Active"] = 1
    --     Wait(100)
    --     Player(serverId)["state"]["Active"] = true
    --     Entity(Ped)["state"]["Source"] = serverId
    --     Entity(Ped)["state"]["WarMode"] = false
    -- end
end)

RegisterServerEvent("WarMode:Exit")
AddEventHandler("WarMode:Exit",function()
    local source = source
    local Ped = GetPlayerPed(source)
    TriggerClientEvent("Progress",source,"Modo Guerra",5000)
    Wait(5000)
    TriggerClientEvent("Notify",source,"verde","Você saiu do modo de guerra.",5000,"MODO DE GUERRA")
    -- TriggerClientEvent("Notify2",source,"#leaveWarMode")
    if DoesEntityExist(Ped) then
        Entity(Ped)["state"]["WarMode"] = false
    end
    Player(source)["state"]["GreenMode"] = true
    TriggerEvent("Safe:Bucket",1,source)
end)