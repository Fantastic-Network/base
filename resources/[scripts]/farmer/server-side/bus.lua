local InJobs = {}
local PaymentCooldown = {}
local PlayerSelected = {}

function GetNextBusRoute(Selected)
    if Selected ==  #BusRoutes then
        return 1
    else
        return Selected + 1
    end
end

function CheckCoordsBus(source,Ped,Route)
    local Coords = GetEntityCoords(Ped)
    local Distance = #(Coords - BusRoutes[Route])
    if Distance > 30.0 then
        TriggerClientEvent("Notify",source,"vermelho","Você não está no local de entrega.",5000,"Entrega")
        -- TriggerClientEvent("Notify2",source,"#nLocalEntrega")
        TriggerClientEvent("farmer:NextRouteBus",source,Route)
        return false
    end
    return true
end


local PaymentBus = {1700,1750}

CreateThread(function()
    Wait(1000)
    PaymentBus = exports['variables']:GetVariable('variables','PaymentBus') or {1700,1750}
end)

RegisterServerEvent("farmer:PaymentBus")
AddEventHandler("farmer:PaymentBus",function()
    local BusPayment = math.random(PaymentBus[1],PaymentBus[2])
    if GlobalState["Restarting"] then
        return false
    end
    local source = source
    if not PlayerSelected[source] then
        PlayerSelected[source] = 1
    end
    if PaymentCooldown[source] and PaymentCooldown[source] > os.time() then
        TriggerClientEvent("Notify",source,"vermelho","Você está realizando entregas muito rápido.",5000,"Entrega")
        -- TriggerClientEvent("Notify2",source,"#calmaEntrega")
        TriggerClientEvent("farmer:NextRouteBus",source,PlayerSelected[source])
        return
    end
    local source = source
    local Passport = vRP.Passport(source)
    local Ped = GetPlayerPed(source)
    if Ped and Ped ~= 0 then
        if not CheckCoordsBus(source,Ped,PlayerSelected[source]) then
            return
        end
    else
        return
    end
    if Passport then
        PaymentCooldown[source] = os.time() + 7
        vRP.GiveBank(Passport, BusPayment,"Bus Payment",true)
        TriggerClientEvent("Notify",source,"verde","Você recebeu "..BusPayment.." reais.",5000,"Motorista")
        local Selected = GetNextBusRoute(PlayerSelected[source])
        PlayerSelected[source] = Selected
        TriggerClientEvent("farmer:NextRouteBus",source,Selected)
    end
end)