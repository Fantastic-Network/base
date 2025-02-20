local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPServer = Tunnel.getInterface("vRP")
Client = {}
Tunnel.bindInterface("painel",Client)
vSERVER = Tunnel.getInterface("painel")
cityName = GetConvar("cityName", "Base")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local CachedInfo = {}
local ClickCooldown = GetGameTimer()
Role,Group = nil,nil
local Groups = GetGroups()
local Discord = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function SendReactMessage(action, data)
  SendNUIMessage({
    action = action,
    data = data
  })
end

local function toggleNuiFrame(shouldShow)
  SetNuiFocus(shouldShow, shouldShow)
  SendReactMessage('setVisible', shouldShow)
end

function UpdateNui()
    SendNUIMessage({
        action = 'OpenPainel',
        data = CachedInfo
    })
end

RegisterNUICallback('GetUserInfo', function(data, cb)
    local Info = {
        Role = Role,
        Group = Group,
        Online = Online,
        TotalMembers = Total,
        Pages = Pages,
        Rank = Rank
    }
    cb(Info)
end)

local VipConfig = {
    [0] = {percentage = 0,name = "Nenhum"},
    [1] = {percentage = 100,name = "Premium"},
    [2] = {percentage = 67,name = "Ouro"},
    [3] = {percentage = 34,name = "Prata"},
}

RegisterNUICallback('GetHomePageData', function(data, cb)
    local Messages = vSERVER.getGroupMessages()
    local Leader = vSERVER.getleader()
    local VIP = vSERVER.getVip()
    local Info = {
        news = News[cityName] or {percentage = 0,name = "Nenhum"},
        messages = Messages,
        stats = {
            vip = VipConfig[VIP] or {},
            leaderName = Leader,
            discordLink = Discord,
            onlineMembers = Online,
            totalMembers = Total,
        }
    }
    cb(Info)
end)

RegisterNUICallback('PostNewMessage', function(data, cb)
    if not LocalPlayer["state"]["Active"] then
        return
    end
    if data["message"] and data["message"] ~= "" then
        vSERVER.postNewMessage(data["message"])
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Painel:Open",function(Role1,Group1,Online1,Total1,Pages1,Rank1,Discord1)
    Role,Group,Online,Total,Pages,Rank,Discord = Role1,Group1,Online1,Total1,Pages1,Rank1,Discord1
    if Role and Group and Online and Total and Pages then
        toggleNuiFrame(true)
    else
        print("Wrong data")
    end
end)

RegisterNetEvent("Painel:LowRec",function()
    print("LowRec")
    SendNUIMessage({
		action = 'setFooterWarn',
		data = 'Sua facção está com a média de players <b>abaixo da média</b>'
	})
end)

RegisterNetEvent("Painel:RemLowRec",function()
    print("RemLowRec")
    SendNUIMessage({
		action = 'setFooterWarn',
		data = nil
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('PlayerClickAction', function(data, cb)
    if ClickCooldown > GetGameTimer() then
        TriggerEvent("Notify","vermelho","Aguarde <b>"..math.ceil((ClickCooldown-GetGameTimer())/1000).."</b> segundos para realizar uma nova ação.",2500,"PAINEL")
        -- TriggerEvent("Notify2","#esperaAcao",{msg=math.ceil((ClickCooldown-GetGameTimer())/1000)})
        return
    end
    if data["action"] == "sms" then
        local number = vSERVER.getPhone(parseInt(data["id"]))
        if number then
            exports.smartphone:callPlayer(number)
        end
        return
    end
    ClickCooldown = GetGameTimer() + 60000
    if not LocalPlayer["state"]["Active"] then
        return
    end
    if ActionsConfig[data["action"]] then
        local Data = vSERVER.setUser(data["action"],parseInt(data["id"]))
        if Data then
            cb(vSERVER.setUser(data["action"],parseInt(data["id"])))
        else
            cb({})
        end
        ClickCooldown = GetGameTimer() + 2000
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('PlayerPromote', function(data, cb)
    if ClickCooldown > GetGameTimer() then
        TriggerEvent("Notify","vermelho","Aguarde <b>"..math.ceil((ClickCooldown-GetGameTimer())/1000).."</b> segundos para realizar uma nova ação.",2500,"PAINEL")
        -- TriggerEvent("Notify2","#esperaAcao",{msg=math.ceil((ClickCooldown-GetGameTimer())/1000)})
        return
    end
    ClickCooldown = GetGameTimer() + 1000
    if not LocalPlayer["state"]["Active"] then
        return
    end
    if ActionsConfig[data["action"]] then
        local Data = vSERVER.setUser(data["action"],parseInt(data["id"]))
        Data = FormatMember(Data)
        cb(Data)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('PlayerFire', function(data, cb)
    if ClickCooldown > GetGameTimer() then
        TriggerEvent("Notify","vermelho","Aguarde <b>"..math.ceil((ClickCooldown-GetGameTimer())/1000).."</b> segundos para realizar uma nova ação.",2500,"PAINEL")
        -- TriggerEvent("Notify2","#esperaAcao",{msg=math.ceil((ClickCooldown-GetGameTimer())/1000)})
        return
    end
    ClickCooldown = GetGameTimer() + 2500
    if not LocalPlayer["state"]["Active"] then
        return
    end
    if ActionsConfig[data["action"]] then
        cb(vSERVER.setUser(data["action"],parseInt(data["id"])))
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('PlayerDemote', function(data, cb)
    if ClickCooldown > GetGameTimer() then
        TriggerEvent("Notify","vermelho","Aguarde <b>"..math.ceil((ClickCooldown-GetGameTimer())/1000).."</b> segundos para realizar uma nova ação.",2500,"PAINEL")
        -- TriggerEvent("Notify2","#esperaAcao",{msg=math.ceil((ClickCooldown-GetGameTimer())/1000)})
        return
    end
    if data["action"] == "sms" then
        local number = vSERVER.getPhone(parseInt(data["id"]))
        if number then
            exports.smartphone:callPlayer(number)
        end
        return
    end
    ClickCooldown = GetGameTimer() + 2500
    if not LocalPlayer["state"]["Active"] then
        return
    end
    if ActionsConfig[data["action"]] then
        cb(FormatMember(vSERVER.setUser(data["action"],parseInt(data["id"]))))
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('PlayerCall', function(data, cb)
    if ClickCooldown > GetGameTimer() then
        TriggerEvent("Notify","vermelho","Aguarde <b>"..math.ceil((ClickCooldown-GetGameTimer())/1000).."</b> segundos para realizar uma nova ação.",2500,"PAINEL")
        -- TriggerEvent("Notify2","#esperaAcao",{msg=math.ceil((ClickCooldown-GetGameTimer())/1000)})
        return
    end
    if data["action"] == "sms" then
        local number = vSERVER.getPhone(parseInt(data["id"]))
        if number then
            exports.smartphone:callPlayer(number)
        end
        return
    end
    ClickCooldown = GetGameTimer() + 2500
    if not LocalPlayer["state"]["Active"] then
        return
    end
    if ActionsConfig[data["action"]] then
        vSERVER.setUser(data["action"],parseInt(data["id"]))
    end
end)

RegisterNUICallback('PlayerClickHire', function(data, cb)
    if ClickCooldown > GetGameTimer() then
        TriggerEvent("Notify","vermelho","Aguarde <b>"..math.ceil((ClickCooldown-GetGameTimer())/1000).."</b> segundos para realizar uma nova ação.",2500,"PAINEL")
        -- TriggerEvent("Notify2","#esperaAcao",{msg=math.ceil((ClickCooldown-GetGameTimer())/1000)})
        return
    end
    ClickCooldown = GetGameTimer() + 2500
    if not LocalPlayer["state"]["Active"] then
        return
    end
    if parseInt(data["player"]) > 0 then
        local test = vSERVER.setUser("hire",parseInt(data["player"]))
        cb(FormatMember(test))
    end
end)

RegisterNUICallback('PlayerClickDeposit', function(data, cb)
    if not LocalPlayer["state"]["Active"] then
        return
    end
    local Data = vSERVER.bank("deposit",Group,parseInt(data["deposit"]))
    Data["History"] = FormatBankLogs(Data["History"])
    Wait(100)
    cb(Data)
end)

RegisterNUICallback('PlayerClickWithdraw', function(data, cb)
    if ClickCooldown > GetGameTimer() then
        TriggerEvent("Notify","vermelho","Aguarde <b>"..math.ceil((ClickCooldown-GetGameTimer())/1000).."</b> segundos para realizar uma nova ação.",2500,"PAINEL")
        -- TriggerEvent("Notify2","#esperaAcao",{msg=math.ceil((ClickCooldown-GetGameTimer())/1000)})
        return
    end
    ClickCooldown = GetGameTimer() + 2500
    if not LocalPlayer["state"]["Active"] then
        return
    end
    local Data = vSERVER.bank("withdraw",Group,parseInt(data["withdraw"]))
    Data["History"] = FormatBankLogs(Data["History"])
    Wait(100)
    cb(Data)
end)

RegisterNUICallback('sms', function(data, cb)
    vSERVER.sendSMS(data["id"])
end)

RegisterNUICallback('PlayerClickBuy', function(data, cb)
    if ClickCooldown > GetGameTimer() then
        TriggerEvent("Notify","vermelho","Aguarde <b>"..math.ceil((ClickCooldown-GetGameTimer())/1000).."</b> segundos para realizar uma nova ação.",2500,"PAINEL")
        -- TriggerEvent("Notify2","#esperaAcao",{msg=math.ceil((ClickCooldown-GetGameTimer())/1000)})
        return
    end
    ClickCooldown = GetGameTimer() + 2500
    if not LocalPlayer["state"]["Active"] then
        return
    end
    vSERVER.buyStore(data["classType"],data["itemName"],data["type"],parseInt(data["amount"]))
end)

RegisterNUICallback('PlayerClickBuyGift', function(data, cb)
    if ClickCooldown > GetGameTimer() then
        TriggerEvent("Notify","vermelho","Aguarde <b>"..math.ceil((ClickCooldown-GetGameTimer())/1000).."</b> segundos para realizar uma nova ação.",2500,"PAINEL")
        -- TriggerEvent("Notify2","#esperaAcao",{msg=math.ceil((ClickCooldown-GetGameTimer())/1000)})
        return
    end
    ClickCooldown = GetGameTimer() + 2500
    if not LocalPlayer["state"]["Active"] then
        return
    end
    vSERVER.buyStore(data["classType"],data["itemName"],data["type"],parseInt(data["amount"]),data["id"])
end)

RegisterNUICallback('hideFrame', function(_, cb)
	SendNUIMessage({
		action = 'setDisplay',
		data = false
	})
	toggleNuiFrame(false)
	cb({})
end)

RegisterNUICallback('GetMembersInfo', function(Data, CallBack)
    local MemberInfo = FormatMembers(vSERVER.getMembersInfo(Data["page"]))
    CallBack(MemberInfo)
end)

RegisterNUICallback('SearchUserId', function(Data, CallBack)
    local Player = vSERVER.searchByID(parseInt(Data.player))
    CallBack(FormatMember(Player))
end)

RegisterNUICallback('SearchUserName', function(Data, CallBack)
    local Player = vSERVER.searchByName(Data.player)
    CallBack(FormatMember(Player))
end)

RegisterNUICallback('GetStoreInfo', function(Data, CallBack)
    local Info = {
        config = storeConfig[Group],
        individual = 0,
        organization = parseInt(vSERVER.getGroupPoints(Group))
    }
    CallBack(Info)
end)

RegisterNUICallback('GetBankInfo', function(Data, CallBack)
    local Table = vSERVER.getBankInfo()
    Table["History"] = FormatBankLogs(Table["History"])
    Wait(100)
    CallBack(Table)
end)

RegisterNUICallback('GetAnalyticsInfo', function(Data, CallBack)
    CallBack(vSERVER.getAnalytics())
end)

RegisterNUICallback('GetNewbieInfoPage', function(Data, CallBack)
    local Table,Day = vSERVER.getNewbieInfoPage(Data["page"])
    CallBack(FormatNewbie(Table,Day))
end)

RegisterNUICallback('GetNewbieInfo', function(Data, CallBack)
    local Table,Day,Pages,Total = vSERVER.getNewbieInfo()
    local Info = {
        Newbies = {
            Role = "Membro",
            Group = Group,
            Online = Total,
            TotalMembers = Total,
            Pages = Pages,
            Members = FormatNewbie(Table,Day),
        },
        Pages = Pages
        
    }
    CallBack(Info)
end)

function FormatNewbie(Table,Day)
    for i=1,#Table do
        if Table[i]["role"] == 1 then
            Table[i]["role"] = "iniciante"
            Table[i]["group"] = "iniciante"
        else
            Table[i]["role"] = "Desempregado"
            Table[i]["group"] = "Desempregado"
        end
        Table[i]["online"] = true
        Table[i]["lastlogin"] = Day
    end
    return Table
end

function FormatBankLogs(Table)
    for i=1,#Table do
        Table[i]["type"] = bankType[Table[i]["type"]]
        Table[i]["log"] = bankConfig[bankType[Table[i]["type"]]]
    end
    return Table
end


function FormatMember(Table)
    if Table and Table["role"] then
        local Role = parseInt(Table["role"])
        Table["hierarchy"] = Role
        Table["group"] = Group
        Table["role"] = Groups[Group]["Hierarchy"][Table["role"]]
    end
    return Table
end

function FormatMembers(Table)
    for i=1,#Table do
        local Role = parseInt(Table[i]["role"])
        Table[i]["group"] = Group
        Table[i]["hierarchy"] = Role
        Table[i]["role"] = Groups[Group]["Hierarchy"][Table[i]["role"]]
    end
    return Table
end