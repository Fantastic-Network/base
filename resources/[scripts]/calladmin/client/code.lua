RegisterNUICallback("getFollowers",function(Data,Callback)
    Callback(vSERVER.GetPlayerInfo() or {})
end)