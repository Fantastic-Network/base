vRP.Prepare("arena/getFacRank", [[
    SELECT 
    p.`name` as `name`, 
    sub.`amount` as `value`
    FROM (
        SELECT 
            `group`, 
            `amount`, 
            ROW_NUMBER() OVER(PARTITION BY `group` ORDER BY `date` DESC) as rn
        FROM `players_amount_group`
        WHERE DATE(`date`) = CURDATE()
    ) sub
    LEFT JOIN `painel` p ON p.`name` = sub.`group`
    WHERE p.`name` IS NOT NULL
    AND sub.rn = 1
    ORDER BY sub.`amount` DESC 
    LIMIT 5;
]])

local FacRankCache = {}

local function displayFacRank()
    local data = vRP.Query("arena/getFacRank", {})
    if data then
        local data_parsed = {}
        for k,v in pairs(data) do
            table.insert(data_parsed, { name = v.name, score = v.value })
        end
        FacRankCache = data_parsed
        if GlobalState["Ranking-Facs"] then
            TriggerClientEvent("arena:DisplayFacRank", -1, data_parsed,"teams")
            TriggerClientEvent("hideNotifys",-1)
        end
    end
end

RegisterCommand("ranking",function(source,Message,History)
    TriggerClientEvent("arena:DisplayFacRank", source, FacRankCache,"teams")
    TriggerClientEvent("hideNotifys",source)
end)

Citizen.CreateThread(function()
    while true do
        displayFacRank()
        Citizen.Wait(60000 * 60)
    end
end)