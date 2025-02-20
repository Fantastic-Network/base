cityName = GetConvar("cityName", "Base")

local Bonus = 1.0
local BonusCount = 0.20
local BonusTime = 60*5

AutoDominationCache = {
    Selected = 1,
    Groups = {},
    LastGroupDom = { Group = false, Count = 0 },
    Running = true,
    BonusTime = os.time() + BonusTime,
    Bonus = Bonus
}

WinnersCache = {}

function StartAutoDom()
    AutoDominationCache["Start"] = os.time()
end


function CheckAutoDom()
    local Winner = false
    local WinnerPlayers = 0
    local PlayersData = {}
    local Selected = AutoDominationCache["Selected"]
    for Group,Data in pairs(AutoDominationCache["Groups"]) do
        for i = 1, #Data do
            local Passport = Data[i]
            local Source = vRP.Source(Passport)
            if Source then
                local Health = vRP.GetHealth(Source)
                if Health and Health <= 100 then
                    RemovePlayerAutoDom(Passport,Group)
                end
            end
        end

        if #Data > WinnerPlayers then
            Winner = Group
            WinnerPlayers = #Data
            PlayersData = Data
        end
    end
    if Winner then
        return Winner
    end
    return false
end

function isWithinTimeRange()
    local hour = tonumber(os.date("%H"))
    if hour >= 2 and hour <= 13 then
        return false
    else
        return true
    end
end

function SendNotifyPlayers(Text)
    for Group, Data in pairs(AutoDominationCache["Groups"]) do
        for i = 1, #Data do
            local Passport = Data[i]
            local Source = vRP.Source(Passport)
            if Source then
                TriggerClientEvent("Announce", Source, "adminNew", Text ,30000,"DOMINACAO")
            end
        end
    end
end

function FinishAutoDom()
    local Winner = false
    local WinnerPlayers = 0
    local PlayersData = {}
    local Selected = AutoDominationCache["Selected"]
    for Group,Data in pairs(AutoDominationCache["Groups"]) do
        if #Data > 0 and #Data > WinnerPlayers then
            Winner = Group
            WinnerPlayers = #Data
            PlayersData = Data
        end
    end
    if Winner then
        WinnersCache[autoDomination[Selected]["Name"]] = {Name = Winner, Coords = autoDomination[Selected]["Coords"] }
        TriggerClientEvent("Announce", -1, "adminNew", "O grupo "..Winner.." venceu a dominação de "..autoDomination[Selected]["Name"].." com "..WinnerPlayers.." jogadores.",60000,"DOMINACAO")
        GiveRewardsAutoDom(PlayersData)
    else
        WinnersCache[autoDomination[Selected]["Name"]] = {Name = "Sem Dominante", Coords = autoDomination[Selected]["Coords"] }
        TriggerClientEvent("Announce", -1, "adminNew", "Nenhum grupo venceu a dominação de "..autoDomination[Selected]["Name"]..".",60000,"DOMINACAO")
    end
    AutoDominationCache["Running"] = false
    AutoDominationCache["Finish"] = false
    TriggerClientEvent("autodomination:Finish", -1)
    TriggerClientEvent("autodomination:updateBlips", -1, WinnersCache)
    NextAutoDom()
end

function NextAutoDom()
    local Selected = AutoDominationCache["Selected"]
    if Selected >= #autoDomination then
        Selected = 1
    else
        Selected = Selected + 1
    end
    Bonus = 1.0
    BonusCount = 0.20
    BonusTime = 60*5
    AutoDominationCache = {
        Selected = Selected,
        Groups = {},
        LastGroupDom = { Group = false, Count = 0 },
        Start = os.time(),
        Running = false,
        Finish = false,
        BonusTime = os.time() + BonusTime,
        Bonus = Bonus
    }
    TriggerClientEvent("Announce", -1, "adminNew", "A dominação de "..autoDomination[Selected]["Name"].." começou.",60000,"DOMINACAO")
    TriggerClientEvent("autodomination:Start", -1, AutoDominationCache["Selected"])
end

function GiveRewardsAutoDom(Data)
    local Selected = AutoDominationCache["Selected"]
    local Rewards = autoDomination[Selected]["Rewards"][cityName]
    for i = 1, #Data do
        local Passport = Data[i]
        for Type, Info in pairs(Rewards) do
            local Amount = Info["Amount"]
            AutoDomReward[Type](Passport,Info)
        end
    end
end

function UpdateRanking()
    local Table = {}
    local Sources = {}
    for Group,Data in pairs(AutoDominationCache["Groups"]) do
        table.insert(Table,{name = Group, score = #Data})
        for i = 1, #Data do
            local Passport = Data[i]
            local Source = vRP.Source(Passport)
            if Source then
                table.insert(Sources,Source)
            end
        end
    end
    table.sort(Table, function(a,b) return a.score > b.score end)
    for i = 1, #Sources do
        TriggerClientEvent("arena:DisplayRankUpdate", Sources[i], Table, "domination")
    end
end

CreateThread(function()
    Wait(1000)
    if not GlobalState["AutoDomination"] then
        return
    end
    if GlobalState["AutoDomination"] then
        StartAutoDom()
        TriggerClientEvent("autodomination:Start", -1, AutoDominationCache["Selected"])
        Wait(100)
        while true do
            if not isWithinTimeRange() then
                TriggerClientEvent("autodomination:Finish", -1)
                return
            end
            local Winner = CheckAutoDom()
            local Selected = AutoDominationCache["Selected"]
            if Winner and AutoDominationCache["Running"] then
                if AutoDominationCache["LastGroupDom"] then
                    if AutoDominationCache["LastGroupDom"]["Group"] == Winner then
                        AutoDominationCache["LastGroupDom"]["Count"] = AutoDominationCache["LastGroupDom"]["Count"] + 1
                        if AutoDominationCache["LastGroupDom"]["Count"] == 5 then
                            SendNotifyPlayers("Faltam 10 minutos para o grupo "..Winner.." vencer a dominação de "..autoDomination[Selected]["Name"]..".")
                        end
                    else
                        AutoDominationCache["LastGroupDom"]["Group"] = Winner
                        AutoDominationCache["LastGroupDom"]["Count"] = 1
                    end

                    if AutoDominationCache["LastGroupDom"]["Count"] then
                        if AutoDominationCache["LastGroupDom"]["Count"] >= autoDomination[Selected]["TimeDom"] then
                            FinishAutoDom()
                            Wait(5000)
                        end
                    end
                    local Text = "O grupo "..AutoDominationCache["LastGroupDom"]["Group"].." esta dominando a área de "..autoDomination[Selected]["Name"].." com "..AutoDominationCache["LastGroupDom"]["Count"].." / "..autoDomination[Selected]["TimeDom"].." minutos."
                    for Group, Data in pairs(AutoDominationCache["Groups"]) do
                        for i = 1, #Data do
                            local Passport = Data[i]
                            local Source = vRP.Source(Passport)
                            if Source then
                                TriggerClientEvent("Announce", Source, "adminNew", Text ,30000,"DOMINACAO")
                            end
                        end
                    end
                end 
            end

            if AutoDominationCache["Start"] + 60*60 <= os.time() then
                NextAutoDom()
            end

            if not AutoDominationCache["Running"] then
                if AutoDominationCache["BonusTime"] <= os.time() then
                    Bonus = Bonus + BonusCount
                    AutoDominationCache["Bonus"] = Bonus
                    AutoDominationCache["BonusTime"] = os.time() + 60*5
                end
            end
            Wait(60000)
        end
    end
end)


AutoDomReward = {
    ["Item"] = function(Passport,Data)
        for Item,Amount in pairs(Data) do
            local Amount = parseInt(AutoDominationCache["Bonus"] * Amount)
            vRP.GenerateItem(Passport,Item,parseInt(Amount),true,false,"autoDom",Passport)
        end
    end,
    ["Group"] = function(Passport,Data)
        for Group,Info in pairs(Data) do
            local Permission = Info[1]
            local Days = Info[2]
            if Days == 0 then
                vRP.SetPermission(Passports,Group,Permission,false,false)
            else
                vRP.SetPermission(Passports,Group,Permission,false,false,Days)
            end
        end
    end,
    ["Vehicle"] = function(Passport,Data)
        for Vehicle,Info in pairs(Data) do
            local Days = Info
            local Plate = vRP.GeneratePlate()
            if Days == 0 then
                vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Vehicle, plate = Plate, work = "false" })
            else
                vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, vehicle = Vehicle, rental = 60*60*24*Days, plate = Plate, work = "false" })
            end
        end
    end,
}


function AddPlayerAutoDom(Passport,Group)
    if not AutoDominationCache["Groups"][Group] then
        AutoDominationCache["Groups"][Group] = {}
    end
    table.insert(AutoDominationCache["Groups"][Group],Passport)
    UpdateRanking()
end

function RemovePlayerAutoDom(Passport,Group)
    if AutoDominationCache["Groups"][Group] then
        for i = 1, #AutoDominationCache["Groups"][Group] do
            if AutoDominationCache["Groups"][Group][i] == Passport then
                table.remove(AutoDominationCache["Groups"][Group],i)
                break
            end
        end
        if #AutoDominationCache["Groups"][Group] == 0 then
            AutoDominationCache["Groups"][Group] = nil
        end
    end
    UpdateRanking()
end

local BlacklistJobs = {
    ["Desempregado"] = true,
    ["Iniciante"] = true,
}

RegisterServerEvent("autodomination:Entered")
AddEventHandler("autodomination:Entered",function()
    local source = source
    local Passport = vRP.Passport(source)
    local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
    local Bucket = GetPlayerRoutingBucket(source)
    if Bucket ~= 1 then
        return
    end
    if not isWithinTimeRange() then
        return
    end
    if Job and not BlacklistJobs[Job] then
        if not AutoDominationCache["Running"] and not AutoDominationCache["Finish"] then
            AutoDominationCache["Running"] = true
        end
        AddPlayerAutoDom(Passport,Job)
        TriggerClientEvent("Notify", source, "sucesso", "Você entrou na dominação de "..autoDomination[AutoDominationCache["Selected"]]["Name"]..".",5000,"DOMINACAO")
    end
end)

RegisterServerEvent("autodomination:Exited")
AddEventHandler("autodomination:Exited",function()
    local source = source
    local Passport = vRP.Passport(source)
    local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
    local Bucket = GetPlayerRoutingBucket(source)
    if Bucket ~= 1 then
        return
    end
    if not isWithinTimeRange() then
        return
    end
    if Job then
        RemovePlayerAutoDom(Passport,Job)
        TriggerClientEvent("arena:DisplayRank", source, false)
        TriggerClientEvent("Notify", source, "sucesso", "Você saiu da dominação de "..autoDomination[AutoDominationCache["Selected"]]["Name"]..".",5000,"DOMINACAO")
    end
end)

AddEventHandler("Connect",function(Passport,source)
    if not GlobalState["AutoDomination"] then
        return
    end
    if not isWithinTimeRange() then
        TriggerClientEvent("autodomination:Start", source, AutoDominationCache["Selected"])
        TriggerClientEvent("autodomination:Finish", -1)
        return
    end
end)