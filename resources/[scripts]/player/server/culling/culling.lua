-- local maxCulling = 424.0
-- local minCulling = 280.0
-- local stepCulling = 5.5
-- local TooMuch = 280.0
-- local PlayersCullingCache = {}

-- RegisterNetEvent("UpdateCulling")
-- AddEventHandler("UpdateCulling", function(PlayersAround)
--     local source = source
--     local Passport = vRP.Passport(source)
--     local Bucket = GetPlayerRoutingBucket(source)

--     -- DEBUG
--     -- for i=1,math.random(70,100) do
--     --     PlayersAround = PlayersAround + 1
--     -- end

--     if Bucket ~= 1 then
--         SetPlayerCullingRadius(source, 0.0)
--         local playerEntity = NetworkGetEntityFromNetworkId(source)
--         if playerEntity ~= nil then
--             SetEntityDistanceCullingRadius(playerEntity, 0.0)
--         end
--         PlayersCullingCache[source] = maxCulling
--         return
--     elseif PlayersAround <= 10 then
--         SetPlayerCullingRadius(source, 0.0)
--         local playerEntity = NetworkGetEntityFromNetworkId(source)
--         if playerEntity ~= nil then
--             SetEntityDistanceCullingRadius(playerEntity, 0.0)
--         end
--         PlayersCullingCache[source] = maxCulling
--         return
--     end

--     if not PlayersCullingCache[source] then
--         PlayersCullingCache[source] = maxCulling
--     end

--     local CurrentCulling = PlayersCullingCache[source]

--     if PlayersAround >= 30 then
--         CurrentCulling = maxCulling - (stepCulling * (PlayersAround - 30))
--         if CurrentCulling < minCulling then
--             CurrentCulling = minCulling
--         end
--     else
--         CurrentCulling = maxCulling
--     end

--     if CurrentCulling ~= PlayersCullingCache[source] then
--         if source ~= nil then
--             PlayersCullingCache[source] = CurrentCulling
--             SetPlayerCullingRadius(source, CurrentCulling)
--             if Passport == 1 or Passport == 139 then
--                 print("CurrentCulling: " ..CurrentCulling, "PlayersAround: " ..PlayersAround, "Passport: " ..Passport, "Bucket: " ..Bucket)
--             end
--             local playerEntity = NetworkGetEntityFromNetworkId(source)
--             if playerEntity ~= nil then
--                 SetEntityDistanceCullingRadius(playerEntity, CurrentCulling)
--             end
--         end
--     end
-- end)

-- AddEventHandler("Disconnect", function(Passport,Source)
--     PlayersCullingCache[source] = nil
-- end)