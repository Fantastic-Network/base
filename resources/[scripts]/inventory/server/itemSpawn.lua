local CachedSpawn = {}
exports("CreateItem",function(ItemId,Amount)
    -- if not CachedSpawn[ItemId] then
    --     CachedSpawn[ItemId] = Amount
    -- else
    --     CachedSpawn[ItemId] = CachedSpawn[ItemId] + Amount
    -- end
end)

-- CreateThread(function()
--     while true do
--         for ItemId,Amount in pairs(CachedSpawn) do
--             MySQL.query.await("INSERT INTO `item_spawn`(`itemId`,`Amount`) VALUES(?, ?)",{ ItemId,Amount })
--             CachedSpawn[ItemId] = nil
--         end
--         Wait(60000)
--     end
-- end)