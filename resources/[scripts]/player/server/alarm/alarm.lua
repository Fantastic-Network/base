local validate = false
local allHomes = false
local allHomesNames = {}
local playersPermissions = {}

function GetAlarms(Chests)
    for i=1,#Chests do
        local Chest = Chests[i]
        local Coords = toVector3(Chest["Coords"])
        for Home,Table in pairs(Homes) do
            if insidePolygon(Table["Zone"],Coords) then
                Homes[Home]["Alarm"] = Chest["Alarm"]
                Homes[Home]["Owner"] = Chest["Owner"]
                Homes[Home]["Perm"] = Chest["Permission"]
                Homes[Home]["Name"] = Chest["Name"]
            end
        end
    end
end

CreateThread(function()
    local Chests = {}
    local Query = vRP.Query("chests/GetCustomChests")
    for i=1,#Query do
        local Table = {
            ["Name"] = Query[i]["Name"],
            ["Coords"] = Query[i]["Coords"],
            ["Owner"] = Query[i]["Owner"],
            ["Permission"] = json.decode(Query[i]["permission"]),
            ["Alarm"] = Query[i]["Alarm"],
        }
        table.insert(Chests,Table)
    end
    Wait(500)
    GetAlarms(Chests)
end)

RegisterServerEvent("mansion_alarm:Add")
AddEventHandler("mansion_alarm:Add",function()
    local Chests = {}
    local Query = vRP.Query("chests/GetCustomChests")
    for i=1,#Query do
        local Table = {
            ["Name"] = Query[i]["Name"],
            ["Coords"] = Query[i]["Coords"],
            ["Owner"] = Query[i]["Owner"],
            ["Permission"] = json.decode(Query[i]["permission"]),
            ["Alarm"] = Query[i]["Alarm"],
        }
        table.insert(Chests,Table)
    end
    Wait(500)
    GetAlarms(Chests)
    TriggerClientEvent("mansion_alarm:Reset",-1)
end)

-- * Get alarm status
function Creative.getAlarmStatus(home)
    local source = source
    if Homes[home] then
        return Homes[home]["Alarm"]
    end
end

function HasHomePermission(Passport,Home)
    local Permission = false
    if Homes[Home] then

        if (vRP.HasGroup(Passport,"Admin") or vRP.HasGroup(Passport,"Policia")) then
            Permission = true
            return true
        end

        if Homes[Home]["Owner"] == Passport then
            Permission = true
            return true
        end
        for k,v in pairs(Homes[Home]["Perm"]) do
            if k == tostring(Passport) then
                Permission = true
            end
        end

    end
    return Permission
end

-- * Notify owner of the house
function Creative.notifyOwner(home,message)
    local source = source
    local Passport = vRP.Passport(source)
    local hasPermission = false
    if Homes[home] then
        if Homes[home]["Alarm"] then
            hasPermission = HasHomePermission(Passport,home)
            if not hasPermission then
                local nplayer = vRP.Source(Homes[home]["Owner"])
                if nplayer then
                    TriggerClientEvent("Notify",nplayer,"vermelho",message,7000,"ALARME")
                    -- TriggerClientEvent("Notify2",nplayer,"#alarme",{msg=message})
                    return hasPermission
                end
            end
        else
            hasPermission = true
        end
        return hasPermission
    end
end

function GetHouseByName(name)
    local House = nil
    for k,v in pairs(Homes) do
        if v["Name"] == name then
            House = k
        end
    end
    return House
end

RegisterServerEvent("mansion_alarm:ToggleAlarm")
AddEventHandler("mansion_alarm:ToggleAlarm",function(name)
    local source = source
    local Passport = vRP.Passport(source)
    local Keyboard = vKEYBOARD.keySingle(source,"Nome da Casa:")
    if Keyboard and Keyboard[1] then
        local Name = Keyboard[1]
        local Home = GetHouseByName(Name)
        if Home then
            if Homes[Home] then
                if HasHomePermission(Passport,Home) then
                    if Homes[Home]["Alarm"] then
                        Homes[Home]["Alarm"] = false
                        TriggerClientEvent("Notify",source,"vermelho","Alarme desativado.",7000,"ALARME")
                        -- TriggerClientEvent("Notify2",source,"#alarmeDesativado")
                    else
                        Homes[Home]["Alarm"] = true
                        TriggerClientEvent("Notify",source,"azul ","Alarme ativado.",7000,"ALARME")
                        -- TriggerClientEvent("Notify2",source,"#alarmeAtivado")
                    end
                    vRP.Query("chests/UpdateAlarm",{Name = Name,Alarm = Homes[Home]["Alarm"]})
                else
                    TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para isso.",7000,"ALARME")
                    -- TriggerClientEvent("Notify2",source,"#permissaoAlarme")
                end
            end
        end
    end
end)