local PayAmount = {1000,3000}

CreateThread(function()
    Wait(1000)
    PayAmount = exports['variables']:GetVariable('variables','PaymentFireMan') or {1000,3000}
end)
function Creative.FireDepartment()
    local source = source
    local Passport = vRP.Passport(source)
    if GlobalState["Restarting"] then
        return false
    end
    if Passport then
        if vRP.HasGroup(Passport, "Bombeiros") then
            local Amount = math.random(PayAmount[1],PayAmount[2])
            --vRP.GenerateItem(Passport,"dollars",parseInt(Amount),true,false,"ItemCMD",Passport)
            vRP.GiveBank(Passport, Amount,"Fire Payment",true)
            TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..parseInt(Amount).."</b> dólares por apagar o incêndio.")
        end
    end
end