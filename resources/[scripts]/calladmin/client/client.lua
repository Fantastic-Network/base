-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("calladmin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local CallTypes = {
    ["denounce"] = 1,
    ["staff"] =  2,
}

Player = GetPlayerServerId(PlayerId())
local Statistics, Ranking, TicketsInfo = {}, {}, {}
local isAdmin = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------
local ActiveTicket = false
RegisterNUICallback("sendCall",function(Data,Callback)
    if #Data["text"] > 255 then
        TriggerEvent("Notify","vermelho","A descrição não pode ultrapassar 255 caracteres.",5000,"CHAMADOS")
        -- TriggerEvent("Notify2","#sendCall")
        cb(false)
        return
    end
    ActiveTicket = vSERVER.CreateTicket(CallTypes[Data["type"]],Data["text"])
    Wait(200)
    Callback(ActiveTicket)
end)

RegisterNUICallback("getCallData",function(Data,Callback)
    Wait(200)
    if not isAdmin then
        SetNuiFocus(false,false)
    end
    TransitionFromBlurred(50)
    Callback({
        time = SecondsToMinutes(parseInt(GlobalState["AnswerTime"])),
        id = ActiveTicket
    })
end)

RegisterNUICallback("cancelCall",function(Data,Callback)
    local Cancelled = vSERVER.CancellTicket(parseInt(Data["id"]))
    if Cancelled then
        TransitionFromBlurred(50)
        if not isAdmin then
            SetNuiFocus(false,false)
        end
        ActiveTicket = false
    end
    Callback(Cancelled)
end)

RegisterNUICallback("callInProgress",function(Data,Callback)
    Callback(vSERVER.AnswerTicket(parseInt(Data["id"])))
end)

RegisterNUICallback("callConcluded",function(Data,Callback)
    Callback(vSERVER.FinishTicket(parseInt(Data["id"])))
end)

RegisterNUICallback("callFeedback",function(Data,Callback)
    TransitionFromBlurred(500)
    if not isAdmin then
        SetNuiFocus(false,false)
    end
    ActiveTicket = false
    Callback(vSERVER.isSolved(Data["id"],Data["isCallResolved"]))
end)

RegisterNUICallback("closeCallModal",function(Data,Callback)
    TransitionFromBlurred(1000)
    if not isAdmin then
        SetNuiFocus(false,false)
    end
end)

RegisterNUICallback("AC:Suspect",function(Data,Callback)
    local List = vSERVER.GetLastSuspects()
    Callback(List or {})
end)

RegisterNUICallback("actionSuspect",function(Data,Callback)
    print(json.encode(Data))
    vSERVER.ActionSuspect(Data)
end)

RegisterNUICallback("getRanking",function(Data,Callback)

    local Stats = {
        Answered = parseInt(TicketsInfo["Total"] / TicketsInfo["Answered"]).."%",
        Finished = parseInt(TicketsInfo["Total"] / TicketsInfo["Finished"]).."%",
        Cancelled = parseInt(TicketsInfo["Total"] / TicketsInfo["Cancelled"]).."%",
    }

    if TicketsInfo["Cancelled"] == 0 then
        Stats["Cancelled"] = "0%"
    end

    Callback({ranking = Ranking, statistics = Stats})
end)

RegisterNUICallback("close",function(Data,Callback)
    if not ActiveTicket or isAdmin then
        TransitionFromBlurred(1000)
        SetNuiFocus(false,false)
        SendNUIMessage({
            action = 'setVisible',
            data = false
        })
        TriggerServerEvent("calladmin:closeDashBoard")
        isAdmin = false
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function SecondsToMinutes(seconds)
    local minutes = math.floor(seconds / 60)
    local seconds = seconds % 60
    return string.format("%02d:%02d", minutes, seconds)
end

RegisterCommand("opendashboard",function(source,args,rawCommand)
    Player = GetPlayerServerId(PlayerId())
    Statistics, Ranking, TicketsInfo , List = vSERVER.openDashboard()
    local Influ = vSERVER.GetInfluencer()

    if Statistics then
        for i=1,#List do
            if List[i] and List[i]["Status"] ~= 0 and List[i]["Admin"] ~= Player then
                table.remove(List,i)
            end
        end
        TransitionToBlurred(1000)
        SetNuiFocus(true,true)
        SendNUIMessage({
            action = 'openDashboard',
            data = {
                ["callsList"] = List,
                ["statistics"] = Statistics
            }
        })
        isAdmin = true
        Wait(1)
        for i=1,#List do
            if List[i] and List[i]["Status"] ~= 0 and List[i]["Admin"] ~= Player then
                table.remove(List,i)
            end
        end
        Wait(1)
        SendNUIMessage({
            action = 'getRanking',
            data = {
                ["callsList"] = List,
                ["statistics"] = WeekStats
            }
        })
        SendNUIMessage({
            action = 'verifyInfluencer',
            data = Influ
        })
    else
        TransitionToBlurred(1000)
        SetNuiFocus(true,true)
        SendNUIMessage({
            action = 'openCodes',
            data = "",
        })

    end
end)

RegisterKeyMapping("opendashboard","Abrir o painel de chamados","keyboard","F1")

RegisterCommand("call",function(source,args,rawCommand)
    openTicket()
end)

RegisterCommand("chamaradm",function(source,args,rawCommand)
    openTicket()
end)

RegisterCommand("chamar",function(source,args,rawCommand)
    openTicket()
end)

RegisterCommand("help",function(source,args,rawCommand)
    openTicket()
end)

RegisterCommand("ajuda",function(source,args,rawCommand)
    openTicket()
end)

RegisterCommand("calladm",function(source,args,rawCommand)
    openTicket()
end)

RegisterCommand("calladmin",function(source,args,rawCommand)
    openTicket()
end)

RegisterCommand("report",function(source,args,rawCommand)
    openTicket()
end)

RegisterCommand("denunciar",function(source,args,rawCommand)
    openTicket()
end)

function openTicket()
    if not ActiveTicket then
        if not isAdmin then
            SetNuiFocus(true,true)
        end
        TransitionToBlurred(1000)
        SendNUIMessage({
            action = 'getHelpItems',
            data = {
                ["items"] = FAQConfig,
            }
        })
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("calladmin:AnswerTicket")
AddEventHandler("calladmin:AnswerTicket",function(Data)
    SendNUIMessage({
        action = 'callAccepted',
        data = Data
    })
    ActiveTicket = false
end)

RegisterNetEvent("calladmin:FinishTicket")
AddEventHandler("calladmin:FinishTicket",function()
    SendNUIMessage({
        action = 'openCallModal',
        data = true
    })
    ActiveTicket = 2
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATEBAG HANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("cancelCall","Cancelar Chamado","keyboard","F7")
RegisterKeyMapping("calladm","Abrir Chamado ou Promoção","keyboard","F5")
RegisterCommand("cancelCall",function(source,args,rawCommand)
    if ActiveTicket then
        if ActiveTicket == 2 then
            TransitionFromBlurred(1000)
            if not isAdmin then
                SetNuiFocus(true,false)
            end
            SendNUIMessage({
                action = 'openFinishModal',
                data = true
            })
        else
            TransitionFromBlurred(1000)
            SetNuiFocus(true,false)
            SendNUIMessage({
                action = 'openCallModal',
                data = false
            })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATEBAG HANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('calladmin:UpdateList')
AddEventHandler('calladmin:UpdateList',function(List)
    local Player = GetPlayerServerId(PlayerId())

    for i=1,#List do
        if List[i] and List[i]["Status"] ~= 0 and List[i]["Admin"] ~= Player then
            table.remove(List,i)
        end
    end
    Wait(100)
    SendNUIMessage({
        action = 'updateList',
        data = List
    })
end)

local PlayerList = {}
RegisterNetEvent('callAdmin:PlayerList')
AddEventHandler('callAdmin:PlayerList',function(List)
    local Formated = {}
    PlayerList = List
    for i=1,#List do
        local Message = List[i]["id"].." | "..List[i]["name"]
        table.insert(Formated,Message)
    end
    SendNUIMessage({ action = "setVisible", data = true })
    Wait(1)
    SendNUIMessage({
        action = 'getPlayersList',
        data = Formated
    })
    SetNuiFocus(true,true)
end)

RegisterNUICallback("teleportID",function(Data,Callback)
    TriggerServerEvent("calladmin:teleportId",Data)
end)

RegisterNetEvent('register:Open')
AddEventHandler('register:Open',function()
    SendNUIMessage({ action = "setVisible", data = false })
    SetNuiFocus(false,false)
    TriggerServerEvent("calladmin:closeDashBoard")
end)

RegisterNetEvent('calladmin:adminDrop')
AddEventHandler('calladmin:adminDrop',function()
    SendNUIMessage({ action = "CallRevert", data = true })
    ActiveTicket = true
end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)

RegisterNUICallback("getDashboardData",function(Data,Callback)
    Statistics, Ranking, TicketsInfo , List = vSERVER.openDashboard()
    if List and Statistics then
        Callback({
            ["callsList"] = List,
            ["statistics"] = Statistics
        })
    else
        Callback({
            ["callsList"] = {},
            ["statistics"] = {}
        })
    end
end)

RegisterNetEvent('callAdmin:OpenPlayerList')
AddEventHandler('callAdmin:OpenPlayerList',function(group)
    SetNuiFocus(true,true)
    SendNUIMessage({
        action = 'openPlayerList',
        data = group
    })
end)

RegisterNUICallback("getGroupsList",function(Data,Callback)
    local Test = vSERVER.getGroups()
    Callback(Test)
end)

RegisterNUICallback("queryGroup",function(Data,Callback)
    local Formated = {}
    PlayerList = vSERVER.getGroupInfo(Data) or {}
    Callback(PlayerList)
end)