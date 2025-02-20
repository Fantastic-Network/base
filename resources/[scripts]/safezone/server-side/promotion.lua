
ActivePromotions = {}
PlayerPromotions = {}
HasToTrigger = {}
cityName = GetConvar("cityName", "Base")

local JobsPromo = {
    ["Policia"] = 1,
    ["Ilegal"] = 2,
    ["Hospital"] = 3,
    ["Kids"] = 4,
    ["Iniciantes"] = 5,
}

local PromoProducts = {
    ["Base"] = {
        [1] = 47076,
        [2] = 47076,
        [3] = 47076,
        [4] = 47075,
        [5] = 40780,
    },
}
local PromoInfo = {}

vRP.Prepare("promotion_system/GetPromotions","SELECT * FROM promotion_system")
GlobalState["HasPromo"] = false
CreateThread(function()
    local result = vRP.Query("promotion_system/GetPromotions")
    for k,v in pairs(result) do
        ActivePromotions[v["id"]] = v["image"] or ""
    end
    local Consult = vRP.Query("promo/Check")
    if Consult[1] and os.time() < Consult[1]["timer"] then
        local Table = {
            ["time"] = Consult[1]["timer"] - os.time(),
            ["description"] = Consult[1]["description"],
            ["cronometro"] = Consult[1]["cronometro"],
            ["timer"] = Consult[1]["timer"],
        }
        Promo = Consult[1]["cupom"]
        PromoInfo = Table
        GlobalState["HasPromo"] = true
        Wait(1000)
    end
    TriggerClientEvent("Promo",-1,Table)
end)

AddEventHandler("Connect",function(Passport,source)
    Wait(5000)
    local Job = vRP.UserGroupByType(Passport,'Job')
    local Ped = GetPlayerPed(source)
    if Job then
        Player(source)["state"]["Job"] = Job
        if Ped and Ped ~= 0 then
            Entity(Ped)["state"]["Job"] = Job
        end
    end
    if not PlayerPromotions[Passport] then
        PlayerPromotions[Passport] = {}
    end
    HasToTrigger[Passport] = {}
    for Id,Image in pairs(ActivePromotions) do
        if not PlayerPromotions[Passport][Id] then
            HasToTrigger[Passport][Id] = Image
        end
    end
end)


local VIDEOS_URL = {
    "https://www.youtube.com/watch?v=D0hbG-m7uxw",
    "https://www.youtube.com/watch?v=BjTItSqpwyI",
    "https://www.youtube.com/watch?v=G16Ky5vG2wc"
}

-- RegisterServerEvent("






-- ")
AddEventHandler("promotion_system/SetRandomPromo",function()
    local source = source
    if (#VIDEOS_URL == 0) then
        return
    end
    local randomVideoUrl = VIDEOS_URL[math.random(1,#VIDEOS_URL)]
    
    TriggerClientEvent("promotion_button:OpenVideo", source, randomVideoUrl, true)
end)

RegisterServerEvent("promotion_system/SetPromo")
AddEventHandler("promotion_system/SetPromo",function()
    local source = source
    local Passport = vRP.Passport(source)
    local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
    local Id =  false
    if not HasToTrigger[Passport] then
        HasToTrigger[Passport] = {}
    end
    if Job then
        if Job == "Iniciante" or "Desempregado" then
            if HasToTrigger[Passport][5] then
                Id = 5
                goto FinishPromo
            end
        end
        if Job == "Policia" then
            if HasToTrigger[Passport][1] then
                Id = 1
                goto FinishPromo
            end
        end
        if Job == "Paramedic" then
            if HasToTrigger[Passport][3] then
                Id = 3
                goto FinishPromo
            end
        end
        if vRP.HasGroup(Passport,"Ilegal") then
            if HasToTrigger[Passport][2] then
                Id = 2
                goto FinishPromo
            end
        end
        if vRP.HasGroup(Passport,"Kids") then
            if HasToTrigger[Passport][2] then
                Id = 4
                goto FinishPromo
            end
        end
    end
    ::FinishPromo::
    if Id then
        if not PlayerPromotions[Passport] then
            PlayerPromotions[Passport] = {}
        end
        if PromoProducts[cityName] then
            local URL = vRP.generateFastCheckout(Passport,PromoProducts[cityName][Id]) or "test"
            if URL then
                PlayerPromotions[Passport][Id] = true
                HasToTrigger[Passport][Id] = nil
                TriggerClientEvent("promotion_button:open",source,URL,ActivePromotions[Id])
                for Id,Image in pairs(ActivePromotions) do
                    if not PlayerPromotions[Passport][Id] then
                        HasToTrigger[Passport][Id] = Image
                    end
                end
            end
        end
    end
end)

vRP.Prepare("promo/Delete","DELETE FROM promos WHERE id = '1'")
vRP.Prepare("promo/Check","SELECT * FROM promos WHERE id = '1'")
vRP.Prepare("promo/New","INSERT INTO promos(id,timer,description,cupom,cronometro) VALUES('1',@timer,@description,@cupom,@cronometro)")

local Promo = false
RegisterCommand("promo",function(source,args,rawCommand)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local keyboard = vKEYBOARD.keyFourth(source,"Dias:","Horas:","Minutos:","Descrição:")
            if keyboard and not keyboard[1] then
                TriggerClientEvent("Notify",source,"vermelho","Não deixe nenhum campo vazio.",5000)
                -- TriggerClientEvent("Notify2",source,"#emptyFieldWarning")
                return
            end
            
            local Dias = parseInt(keyboard[1])
            local Horas = parseInt(keyboard[2])
            local Minutos = parseInt(keyboard[3])
            
            local Total = os.time() + (60 * Minutos) + (60 * 60 * Horas) + (60 * 60 * 24 * Dias)
            local Cupom = vKEYBOARD.keySingle(source,"Cupom:")

            if not Cupom[1] then
                TriggerClientEvent("Notify",source,"vermelho","Não deixe nenhum campo vazio.",5000)
                -- TriggerClientEvent("Notify2",source,"#emptyFieldWarning")
                return
            end

            vRP.Query("promo/Delete")
            local keyboard2 = vKEYBOARD.keySingle(source,"Mostrar Cronometro:(true/false)")
            if keyboard2 and not keyboard2[1] then
                TriggerClientEvent("Notify",source,"vermelho","Não deixe nenhum campo vazio.",5000)
                -- TriggerClientEvent("Notify2",source,"#emptyFieldWarning")
                return
            end
            if keyboard2[1] == "true" then
                local Table = {
                    ["time"] = Total - os.time(),
                    ["description"] = keyboard[4],
                    ["cupom"] = Cupom[1],
                    ["cronometro"] = true
                }
                TriggerClientEvent("Promo",-1,Table)
                PromoInfo = Table
                Promo = Cupom[1]
                vRP.Query("promo/New",{ timer = Total, description = keyboard[4], cupom = Cupom[1] or "",cronometro = 1 } )
            else
                local Table = {
                    ["time"] = Total - os.time(),
                    ["description"] = keyboard[4],
                    ["cupom"] = Cupom[1],
                    ["cronometro"] = false
                }
                TriggerClientEvent("Promo",-1,Table)
                PromoInfo = Table
                Promo = Cupom[1]
                vRP.Query("promo/New",{ timer = Total, description = keyboard[4], cupom = Cupom[1] or "",cronometro = 0 } )
            end
            GlobalState["HasPromo"] = true
        end
    end
end)

vRP.Prepare("new_player_promo/getExistPromo","SELECT id, token, UNIX_TIMESTAMP(expires) as expires FROM new_player_promo WHERE accountID = @id AND expires < CURDATE()")
AddEventHandler("Connect",function(Passport,source)
    local Identity = vRP.Identity(Passport)
    local Ped = GetPlayerPed(source)
    if vRP.HasGroup(Passport,"Iniciante") then
        Player(source)["state"]["Iniciante"] = true
        Entity(Ped)["state"]["Iniciante"] = true
    end

    if vRP.HasGroup(Passport,"Iniciante") then
        Player(source)["state"]["Iniciante"] = true
    end
    if GlobalState["HasPromo"] then
        TriggerClientEvent("Promo",source,PromoInfo)
        return
    end
    local Consult = vRP.Query("new_player_promo/getExistPromo",{ id = Identity["accountId"] })
    if Consult[1] then
        local Total = Consult[1]["expires"] - os.time()
        if Total > 0 then
            Wait(5000)
            TriggerClientEvent("Promo_newbie",source,{["time"] =  Total,["coupon"] = Consult[1]["token"], ["hasTimer"] = true, ["discount"] = Consult[1]["discount"] or 50})
        end
    end
end)

AddEventHandler("Disconnect",function(Passport)
    PlayerPromotions[Passport] = nil
end)

exports("HasPromo",function()
    return Promo
end)