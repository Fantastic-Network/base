Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")

cityName = GetConvar("cityName", "Base")
Player = GetPlayerServerId(PlayerId())
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("mdt")
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN - CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("mdt",function(source,args,rawCommand)
    if vSERVER.IsPlayerACop() then
        SetNuiFocus(true,true)
        SendNUIMessage({
            action = "setVisible",
            data = true
        })
    end
end)

RegisterNetEvent("police:Mdt")
AddEventHandler("police:Mdt",function()
    if vSERVER.IsPlayerACop() then
        SetNuiFocus(true,true)
        SendNUIMessage({
            action = "setVisible",
            data = true
        })
    end
    TriggerEvent("dynamic:closeSystem")
end)
RegisterNUICallback("hideFrame",function(data,cb)
    SetNuiFocus(false,false)
    SendNUIMessage({
        action = "setVisible",
        data = false
    })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("getCityName",function(Data,Callback)
    Callback(string.lower(cityName))
end)

RegisterNUICallback("getLogo",function(Data,Callback)
    Callback(vSERVER.GetLogo())
end)

RegisterNUICallback("getOfficerData",function(Data,Callback)
    Callback(vSERVER.GetOfficerData())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET PLAYER NAME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GetPlayerName",function(Data,Callback)
    Callback(vSERVER.GetPassportName(parseInt(Data)))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GetNews",function(Data,Callback)
    Callback(vSERVER.GetNews())
end)

RegisterNUICallback("createNews",function(Data,Callback)
    Callback(vSERVER.AddNews(Data))
end)

RegisterNUICallback("DeleteNews",function(Data,Callback)
    Callback(vSERVER.DelNews(Data))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCH USER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("searchUser",function(Data,Callback)
    if Data then
        local Info = vSERVER.GetUserInfo(parseInt(Data))
        Callback(Info)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATE PRISON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("createPrison",function(Data,Callback)
    if Data then
        vSERVER.SetArrested(Data["infractorId"],Data["description"],Data["reductionOfSentence"] * 0.01 or 0,Data["reductionOfBill"] * 0.01 or 0,Data["infractions"])
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET INFRACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("getPrisonsInfractions",function(Data,Callback)
    Callback(Infractions)
end)

RegisterNuiCallback("getBillInfractions",function(Data,Callback)
    if Data then
        Callback(Infractions)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OCCURENCES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("deleteOccurance",function(Data,Callback)
    vSERVER.DeleteReport(Data)
end)

RegisterNUICallback("getOccurences",function(Data,Callback)
    local Info = vSERVER.GetReports(Data["page"])
    Callback(Info)
end)

RegisterNUICallback("reportRegister",function(Data,Callback)
    if Data then
        vSERVER.CreateReport(Data["requester"],Data["description"],Data["title"],Data["suspectId"])
    end
end)

RegisterNUICallback("reportEdit",function(Data,Callback)
    if Data then
        vSERVER.CreateReport(Data["id"],Data["requester"],Data["description"],Data["title"],Data["suspectId"],Data["status"])
    end
end)

RegisterNUICallback("getOccurence",function(Data,Callback)
    local Info = vSERVER.GetReport(parseInt(Data["id"]))
    Callback(Info)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET GRAPH DATAS  
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("getGraphDatas",function(Data,Callback)
    Callback(vSERVER.GetGraphData())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("wantedUsers",function(Data,Callback)
    local Info = vSERVER.GetWanteds(Data["page"])
    Callback(Info)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SET WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("setUserAsWanted",function(Data,Callback)
    if Data and Data["userid"] then
        vSERVER.SetWanted(Data["userid"],Data["reason"])
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLE WEAPON PASSPORT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("giveWeaponPassport",function(Data,Callback)
    if Data then
        vSERVER.ToggleWeapon(parseInt(Data))
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("removeWanted",function(Data,Callback)
    if Data then
        vSERVER.RemoveWanted(parseInt(Data))
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATE BILLS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNuiCallback("createBill",function(Data,Callback)
    if Data then
        vSERVER.CreateBill(Data["infractorId"],Data["infractions"],Data["description"])
    end
end)