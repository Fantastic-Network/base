MaxTotem = 25
Totems = {}
CreateThread(function()
    local Row = vRP.Query("totem/GetAll")
    if Row then
        for k,v in pairs(Row) do
            table.insert(Totems,v["totem_id"])
        end
    end
end)

function remTotem(Totem)
    --Removes a totem from the Totems table when it is destroyed
    for k,v in pairs(Totems) do
        if v == Totem then
            table.remove(Totems,k)
        end
    end
end

function existTotem(Totem)
    --Checks if the totem exists
    for k,v in pairs(Totems) do
        if v == Totem then
            return true
        end
    end
    return false
end

RegisterCommand("addtotem",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keySingle(source,"1 >> 25")
            if Keyboard and Keyboard[1] then
                local Totem = parseInt(Keyboard[1])
                if Totem <= MaxTotem then
                    if not existTotem(Totem) then
                        vRP.Query("totem/Add",{totem = Totem })
                        table.insert(Totems,Totem)
                        TriggerClientEvent("Totems:Load",-1,Totems)
                        TriggerClientEvent("Notify",source,"verde","Totem adicionado com sucesso.",5000,"Totem")
                        -- TriggerClientEvent("Notify2",source,"#addTotem")
                    else
                        TriggerClientEvent("Notify",source,"vermelho","Este Totem já existe.",5000,"Totem")
                        -- TriggerClientEvent("Notify2",source,"#totemExist")
                    end
                else
                    TriggerClientEvent("Notify",source,"vermelho","Totem não encontrado.",5000,"Totem")
                    -- TriggerClientEvent("Notify2",source,"#totemNotFound")
                end
            end
        end
    end
end)

RegisterCommand("remtotem",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keySingle(source,"1 >> 25")
            if Keyboard and Keyboard[1] then
                local Totem = parseInt(Keyboard[1])
                if Totem <= MaxTotem then
                    vRP.Query("totem/Rem",{totem = Totem })
                    remTotem(Totem)
                    TriggerClientEvent("Totems:Rem",-1,Totem)
                    TriggerClientEvent("Notify",source,"verde","Totem removido com sucesso.",5000,"Totem")
                    -- TriggerClientEvent("Notify2",source,"#totemRemoved")
                else
                    TriggerClientEvent("Notify",source,"vermelho","Totem não encontrado.",5000,"Totem")
                    -- TriggerClientEvent("Notify2",source,"#totemNotFound")
                end
            end
        end
    end
end)

AddEventHandler("Connect",function(Passport,source)
    TriggerClientEvent("Totems:Load",source,Totems)
end)