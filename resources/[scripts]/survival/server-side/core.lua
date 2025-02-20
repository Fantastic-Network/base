-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local Creative = {}
Tunnel.bindInterface("survival",Creative)

function Creative.GroupVIP()
	local source = source
    local Passport = vRP.Passport(source)
    local Job = vRP.UserGroupByType(Passport,"Job")
    if vRP.GroupVIP(nil, Job) then
        return true
    else
        local VIPs = vRP.GetGroup(Passport,"VIP")
        if VIPs and (VIPs["Premium"] and VIPs["Premium"][1] == 1) or (VIPs and VIPs["Blacks"]) then
            return true
        end
    end
    return false
end

local TimerAdmin = {
    [1] = 1,
    [2] = 1,
    [3] = 10,
    [4] = 30,
}

function Creative.GroupAdmin()
	local source = source
    local Passport = vRP.Passport(source)
    local Job = vRP.UserGroupByType(Passport,"Job")
    local Number = vRP.HasPermission(Passport,"Admin")
    if Number < 4 then
        if TimerAdmin[Number] then
            return TimerAdmin[Number]
        end
    end
    return false
end

function Creative.GetUserVip()
    local Source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local NewVips = vRP.HasVip(Passport)
        local List = {}
        if NewVips then
            for Group,_ in pairs(NewVips) do
                table.insert(List,Group)
            end
            return List
        end
        return List
    end
end

vRP.Prepare("painel/GetWithoutLeader","SELECT * FROM painel WHERE leader <> 0")
local Facs = {}
function ChangeBlips()
    local Query = vRP.Query("painel/GetWithoutLeader",{})
    if Query and Query[1] then
        for i=1,#Query do
            if not Query[i]["alias"] then
                Facs[Query[i]["name"]] = true
            else
                Facs[Query[i]["name"]] = Query[i]["alias"]
            end
        end
    end
    Wait(500)
    TriggerClientEvent("survival:Facs",-1,Facs)
end

CreateThread(function()
    ChangeBlips()
end)

AddEventHandler("Connect",function(Passport,source)
    TriggerClientEvent("survival:Facs",source,Facs)
end)

AddEventHandler("ChangeFacBlips",function(Passport,source)
    ChangeBlips()
end)