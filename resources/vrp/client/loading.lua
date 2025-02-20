AddEventHandler("CloseLoadingScreen",function()
    SendLoadingScreenMessage(json.encode({
        action = "Close",
        name = GetCurrentResourceName()
    }))
end)

RegisterNUICallback("ShutdownLoading",function(data,cb)
    ShutdownLoadingScreenNui()
    ShutdownLoadingScreen()
end)