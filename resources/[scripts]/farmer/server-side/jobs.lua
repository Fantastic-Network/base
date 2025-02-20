local InJobs = {}
local PaymentCooldown = {}
local NextPlayer = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- START JOB
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:StartJob")
AddEventHandler("farmer:StartJob",function()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if not InJobs[Passport] then
            InJobs[Passport] = true
            TriggerClientEvent("farmer:StartJob",source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetNextJob(Job,Selected)
    if Selected ==  #Jobs[Job]["Routes"] then
        return 1
    else
        return Selected + 1
    end
end

function CheckCoords(source,Ped,Job,Route)
    local Coords = vCLIENT.GetCoords(source)
    local Distance = #(Coords - Jobs[Job]["Routes"][Route])
    if Distance > 50.0 then
        TriggerClientEvent("Notify",source,"negado","Você não está no local de entrega.",5000,"Entrega")
        -- TriggerClientEvent("Notify2",source,"#nLocalEntrega")
        TriggerClientEvent("farmer:NextJob",source,Route)
        return false
    end
    return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:PaymentJob")
AddEventHandler("farmer:PaymentJob",function(Job)
    if GlobalState["Restarting"] then
        return false
    end
    if not NextPlayer[source] then
        NextPlayer[source] = 1
    end
    local Route = NextPlayer[source] or 1
    if PaymentCooldown[source] and PaymentCooldown[source] > os.time() then
        TriggerClientEvent("Notify",source,"negado","Você está realizando entregas muito rápido.",5000,"Entrega")
        -- TriggerClientEvent("Notify2",source,"#calmaEntrega")
        TriggerClientEvent("farmer:NextJob",source,Route)
        return
    end
    PaymentCooldown[source] = os.time() + 5
    local source = source
    local Passport = vRP.Passport(source)
    local Ped = GetPlayerPed(source)
    if Ped and Ped ~= 0 then
        if Job and Route then
            if not CheckCoords(source,Ped,Job,Route) then
                return
            end
        end
    end
    if Passport then
        local Type = Jobs[Job]["Payment"]["Type"]
        PaymentFunctions[Type](Passport,Jobs[Job]["Payment"])
        local Title = Jobs[Job]["Texts"]["Notify"]["Title"]
        local Message = Jobs[Job]["Texts"]["Notify"]["Message"]
        local Color = Jobs[Job]["Texts"]["Notify"]["Color"]
        TriggerClientEvent("Notify",source,Color,Message,5000,Title)
        local Selected = GetNextJob(Job,Route)
        NextPlayer[source] = Selected
        TriggerClientEvent("farmer:NextJob",source,Selected)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
PaymentFunctions = {
    ["Money"] = function(Passport,Table)
        if Table["Amount"][2] then
            local Amount = parseInt(math.random(Table["Amount"][1],Table["Amount"][2]))
            --vRP.GenerateItem(Passport,"dollars",Amount,true)
            vRP.GiveBank(Passport, Amount,"Fire Payment",true)
        end
    end,
    ["Item"] = function(Passport,Table)
        if Table["Amount"][2] then
            local Amount = parseInt(math.random(Table["Amount"][1],Table["Amount"][2]))
            local Item = Table["Item"]
            vRP.GenerateItem(Passport,Table["Item"],Amount,true)
        end
    end,
}