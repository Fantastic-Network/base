-- Player = GetPlayerServerId(PlayerId())
-- local CachePlayerList = 0

-- AddEventHandler('onClientResourceStart', function(resName)
--     Wait(1000*math.random(5,10))
--     if(resName == GetCurrentResourceName()) then
--         CreateThread(function()
--             while true do
--                 if LocalPlayer["state"]["Active"] then
--                     local activePlayerList = GetActivePlayers()
--                     if CachePlayerList < #activePlayerList then
--                         CachePlayerList = #activePlayerList
--                         TriggerServerEvent("UpdateCulling", CachePlayerList)
--                     end
--                 end
--                 Wait(7500)
--             end
--         end)
--     end
-- end)


-- AddStateBagChangeHandler('Route',('player:%s'):format(Player) , function(_, _, Value)
--     local activePlayerList = GetActivePlayers()
--     CachePlayerList = #activePlayerList
--     TriggerServerEvent("UpdateCulling", CachePlayerList)
-- end)