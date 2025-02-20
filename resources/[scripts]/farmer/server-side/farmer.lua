local InJobs = {}
local PaymentCooldown = {}

local function GetNextRoute(Selected)
    if Selected ==  #FarmerInfo["Routes"] then
        return 1
    else
        return Selected + 1
    end
end

local function CheckCoordsFarmer(source,Ped,Route)
    local Coords = GetEntityCoords(Ped)
    local Distance = #(Coords - vector3(FarmerInfo["Routes"][Route]["x"],FarmerInfo["Routes"][Route]["y"],FarmerInfo["Routes"][Route]["z"]))
    if Distance > 30.0 then
        TriggerClientEvent("Notify",source,"vermelho","Você não está no local de entrega.",5000,"Entrega")
        -- TriggerClientEvent("Notify2",source,"#nLocalEntrega")
        TriggerClientEvent("farmer:NextRouteFarmer",source,Route)
        return false
    end
    return true
end

local BusPayment = math.random(1700,1750)
RegisterServerEvent("farmer:PaymentFarmer")
AddEventHandler("farmer:PaymentFarmer",function(Route)
    if GlobalState["Restarting"] then
        return false
    end
    if PaymentCooldown[source] and PaymentCooldown[source] > os.time() then
        TriggerClientEvent("Notify",source,"vermelho","Você está realizando entregas muito rápido.",5000,"Entrega")
        -- TriggerClientEvent("Notify2",source,"#calmaEntrega")
        TriggerClientEvent("farmer:NextRouteFarmer",source,Route)
        return
    end
    local source = source
    local Passport = vRP.Passport(source)
    local Ped = GetPlayerPed(source)
    if Ped and Ped ~= 0 then
        if Route then
            if not CheckCoordsFarmer(source,Ped,Route) then
                return
            end
        end
    end
    if Passport then
        PaymentCooldown[source] = os.time() + 2
        for Item,Amount in pairs(FarmerInfo["Itens"]["Route"]["Give"]) do
            vRP.GenerateItem(Passport,Item,Amount,true)
        end
        local Selected = GetNextRoute(Route)
        TriggerClientEvent("farmer:NextRouteFarmer",source,Selected)
    end
end)


RegisterServerEvent("farmer:SeparateAll")
AddEventHandler("farmer:SeparateAll",function()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        vRPC.playAnim(source,false,{FarmerInfo["Separate"]["Anim"]["Dict"],FarmerInfo["Separate"]["Anim"]["Anim"]},true)
        TriggerClientEvent("Progress",source,"Mundo",20000)
        Wait(20000)
        for Item,Info in pairs(FarmerInfo["Itens"]["Separate"]["Consume"]) do
            local ItemInventory = vRP.InventoryItemAmount(Passport,Item)
            local ItemAmount = ItemInventory[1]
            if ItemAmount > 0 then
                if vRP.TakeItem(Passport,Item,ItemAmount,true) then
                    for ItemGive,Amount in pairs(Info["Give"]) do
                        vRP.GenerateItem(Passport,ItemGive,Amount*ItemAmount,true)
                    end
                end
            end
        end
        vRPC.DestroyObjects(source)
    end
end)