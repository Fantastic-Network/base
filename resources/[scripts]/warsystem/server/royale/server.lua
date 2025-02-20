local RoyaleStarted = false
local RoyaleInfo = {}

RegisterCommand("startroyale",function(source,args,rawCommand)
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport, "Admin", 3) then
        local Keyboard = vKEYBOARD.keyDouble(source,"Centro:","Raio:")
        if Keyboard and Keyboard[2] then
            local CacheCoords = toVector4(Keyboard[1])
            local Coords = vector2(CacheCoords["x"],CacheCoords["y"])
            local Radius = tonumber(Keyboard[2])
            if Coords and Radius then
                RoyaleInfo["Zone"] = {
                    ["Coords"] = Coords,
                    ["Radius"] = Radius
                }
                StartRoyale()
            end
        end
    end
end)

function GetAmountPlayersRoyale()
    local Count = 0
    local Best = false
    for Group,Table in pairs(RoyaleInfo["Groups"]) do
        if #Table > 0 then
            Count = Count + 1
            Best = Group
        end
    end
    if Count == 1 then
        return Best
    else
        return false
    end
end

function insideCircle(center, radius, point)
    local dx = center.x - point.x
    local dy = center.y - point.y
    local distance = math.sqrt(dx * dx + dy * dy)
    return distance <= radius
end

function StartRoyale()
    RoyaleInfo["Groups"] = {}
    for Group,_ in pairs(RoyaleGroups) do
        RoyaleInfo["Groups"][Group] = {}
        local Service = vRP.NumPermission(Group)
        for Passports,Sources in pairs(Service) do
            async(function()
                if vRP.Request(Sources,"Deseja participar do BattleRoyale?","Sim, por favor","Não, obrigado") then
                    table.insert(InDomination["Groups"][Group],Sources)
                end
            end)
        end
    end
    Wait(60000*1)
    for Group,Table in pairs(RoyaleInfo["Groups"]) do
        local GoToRoyale = {}
        Participants[Group] = {}
        for i=1,#Table do
            local Ped = GetPlayerPed(Table[i])
            local Passport = vRP.Passport(Table[i])
            if Ped ~= 0 and DoesEntityExist(Ped) then
                local Coords = GetEntityCoords(Ped)
                if insideCircle(RoyaleInfo["Zone"]["Coords"],RoyaleInfo["Zone"]["Radius"],Coords) then
                    GoToRoyale[#GoToDomination+1] = Table[i]
                    Participants[Group][#Participants[Group]+1] = Passport
                end
            end
        end
        InDomination["Groups"][Group] = GoToRoyale
    end
    for Group,Table in pairs(InDomination["Groups"]) do
        for i=1,#Table do
            local Source = Table[i]
            StartClientRoyale(Source,Group)
        end
    end
    Wait(30000)
    RoyaleStarted = true
    CreateThread(function()
        while InDomination do
            local Amount = GetAmountPlayersDom()
            if Amount then
                InDomination["Winner"] = Amount
                FinishDomination(Zone)
                break
            end
            Wait(1000)
        end
    end)
end