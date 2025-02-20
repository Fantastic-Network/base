-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local InDomination = {}
local StartTimer = 15000
local Mode = false
local SourceGroup = {}
local Participants = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- START CLIENT DOMINATION
-----------------------------------------------------------------------------------------------------------------------------------------
function StartClientDomination(Source,Group)
    local Passport = vRP.Passport(Source)
    local Winning = InDomination["BestGroup"] or Group
    SourceGroup[Source] = Group
    exports["vrp"]:ChangePlayerBucket(Source,8)
    local Table = {
        Remains = #InDomination["Groups"][Group],
        Points = InDomination["Points"][Group],
        MaxPoints = InDomination["MaxPoints"],
        Mode = Mode,
        Group = Group,
        Zone = InDomination["Zone"],
        Mode = InDomination["Mode"],
        Teams = GetGroupsPointsDom(),
        Winning = Winning
    }
    Player(Source)["state"]["Domination"] = 1
    TriggerClientEvent("domination:StartDomClient",Source,Table)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXIT DOMINATION
-----------------------------------------------------------------------------------------------------------------------------------------
function ExitDomination(Source)
    local Passport = vRP.Passport(Source)
    local Job = vRP.UserGroupByType(Passport,"Job")
    if Job and InDomination["Groups"] and InDomination["Groups"][Job] then
        for i=1,#InDomination["Groups"][Job] do
            if InDomination["Groups"][Job][i] == Source then
                table.remove(InDomination["Groups"][Job],i)
            end
        end
    end
    TriggerClientEvent("domination:Exit",Source)
    Player(Source)["state"]["Domination"] = false
    local Bucket = 1
    exports["vrp"]:ChangePlayerBucket(Source,Bucket)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE CLIENT INFO
-----------------------------------------------------------------------------------------------------------------------------------------
function GetGroupsPointsDom()
    local Groups = {}
    local Result = {}

    for Group,Points in pairs(InDomination["Points"]) do
        local Table = { name = Group, score = Points }
        table.insert(Groups,Table)
    end

    table.sort(Groups, function(a, b) return a.score > b.score end)

    for i = 1, 5 do
        table.insert(Result, Groups[i])
    end

    return Result
end

function UpdateClientInfoDom()
    for Group,Players in pairs(InDomination["Groups"]) do
        for i=1,#Players do
            async(function()
                local Source = Players[i]
                local Winning = InDomination["BestGroup"] or Group
                local Table = {
                    Remains = #InDomination["Groups"][Group],
                    Points = InDomination["Points"][Group],
                    MaxPoints = InDomination["MaxPoints"],
                    Mode = Mode,
                    Group = Group,
                    Zone = InDomination["Zone"],
                    Mode = InDomination["Mode"],
                    Teams = GetGroupsPointsDom(),
                    Winning = Winning
                }
                TriggerClientEvent("domination:Update",Source,Table)
            end)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISH DOMINATION
-----------------------------------------------------------------------------------------------------------------------------------------
function FinishDomination(Zone)
    exports["painel"]:addGroupPoints(InDomination["BestGroup"],250)
    for Group,Table in pairs(InDomination["Groups"]) do
        async(function()
            for i=1,#Table do
                async(function()
                    local Source = parseInt(Table[i])
                    ExitDomination(Source)
                end)
            end
        end)
    end

    if InDomination and InDomination["Dominador"] then
        local Service = vRP.NumPermission(InDomination["BestGroup"])
        local Group = "Dominador"
        local Days = 3
        for Passports,Sources in pairs(Service) do
            async(function()
                vRP.SetPermission(Passports,Group,1,false,false,Days)
                --vRP.Query("temporary_groups/inserTemporaryGroup",{ Passport = Passports, Group = Group, Days = Days })
            end)
        end
    end
    Wait(5000)
    TriggerClientEvent("Notify",-1,"dominacao","O Grupo <b>"..InDomination["BestGroup"].."</b> GANHOU a dominção de <b>"..Zone.."</b>.",15000,"DOMINACAO")
    -- TriggerClientEvent("Notify2",-1,"#dominationWinnerGroup",{msg=InDomination["BestGroup"],msg2=Zone})
    InDomination = false
    Wait(1000*15)
    InDomination = {}
    Mode = false
    SourceGroup = {}
    Participants = {}
    print("Dominação finalizada.")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET GROUP POINT
-----------------------------------------------------------------------------------------------------------------------------------------
function GetAmountPlayersDom()
    local Count = 0
    local Best = false
    for Group,Table in pairs(InDomination["Groups"]) do
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET GROUP POINT
-----------------------------------------------------------------------------------------------------------------------------------------
function GetGroupPointDom(Zone,Table,Group)
    for i=1,#Table do
        local Ped = GetPlayerPed(Table[i])
        local Coords = GetEntityCoords(Ped)
        local Point = dominationConfig[Zone]["Points"]["Point"]
        local State = Player(Table[i])["state"]["Domination"]
        if State and State ~= 0 then
            local isDouble = (State == 2)
            if isDouble then
                Point = dominationConfig[Zone]["Points"]["DoublePoint"]
            end
            InDomination["Points"][Group] = InDomination["Points"][Group] + Point
        else
            ExitDomination(Table[i],"Você saiu da area de dominação.")
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- START DOMINATION
-----------------------------------------------------------------------------------------------------------------------------------------
function StartDomination(Zone,Timer,Mode,TimerStart)
    local Finish = Timer + dominationConfig[Zone]["maxTime"]
    local ZonePoint = dominationConfig[Zone]["Point"]
    local ZoneDouble = dominationConfig[Zone]["DoublePoint"]
    local Start = false
    InDomination["Mode"] = Mode
    local MaxPlayers = InDomination["MaxPlayers"]
    TriggerClientEvent("Notify",-1,"dominacao","Dominação de <b>"..dominationConfig[Zone]["Name"].."</b>. irá iniciar as <b>"..os.date("%H:%M:%S",Timer).."</b>.",(Timer-os.time())*1000,"DOMINACAO")
    -- TriggerClientEvent("Notify2",-1,"#dominationZoneTimer",{msg=dominationConfig[zone]["name"],msg2=os.date("%H:%M:%S",Timer),msg3=(Timer-os.time())*1000})
    InDomination["BestGroup"] = ""
    while not Start do
        if os.time() >= Timer then
            TriggerClientEvent("domination:Blip",-1,Zone)
            TriggerClientEvent("Notify",-1,"dominacao","Dominação de <b>"..dominationConfig[Zone]["Name"].."</b>. irá iniciar, Todos dentro da area!.",StartTimer,"DOMINACAO")
            -- TriggerClientEvent("Notify2",-1,"#dominationZoneStart",{msg=dominationConfig[Zone]["name"],msg2=StartTimer})
            Wait(StartTimer)
            if InDomination and InDomination["BestGroup"] then
                InDomination["BestGroup"] = dictionaryWithHigherValue(InDomination["Points"])
                
                for Group,Table in pairs(InDomination["Groups"]) do
                    
                    local GoToDomination = {}
                    Participants[Group] = {}
                    for i=1,#Table do
                        local Ped = GetPlayerPed(Table[i])
                        local Passport = vRP.Passport(Table[i])
                        if Ped ~= 0 and DoesEntityExist(Ped) then
                            local Coords = GetEntityCoords(Ped)
                            if insidePolygon(ZonePoint,Coords) then
                                GoToDomination[#GoToDomination+1] = Table[i]
                                Participants[Group][#Participants[Group]+1] = Passport
                            end
                        end
                    end
                    InDomination["BestGroup"] = Group
                    InDomination["Groups"][Group] = GoToDomination
                end
                Start = true
            end
        end
        
        Wait(1000)
    end
    TriggerClientEvent("domination:RemBlip",-1)
    Wait(1000)
    
    for Group,Table in pairs(InDomination["Groups"]) do
        for i=1,#Table do
            local Source = Table[i]
            StartClientDomination(Source,Group)
        end
    end
    
    Wait(StartTimer)
    
    Finish += StartTimer
    -- COUNT POINTS
    CreateThread(function()
        while InDomination do
            local idle = 1000
            local Amount = GetAmountPlayersDom()
            if Amount then
                InDomination["BestGroup"] = Amount
                vRP.Query("painel/addDomination",{ name = InDomination["BestGroup"] })
                print(InDomination["BestGroup"].." WINNER")
                FinishDomination(Zone)
                break
            end
            
            for Group,Table in pairs(InDomination["Groups"]) do
                async(function()
                    GetGroupPointDom(Zone,Table,Group)
                end)
            end
            
            UpdateClientInfoDom()
            
            if InDomination then
                InDomination["BestGroup"] = dictionaryWithHigherValue(InDomination["Points"])
                if InDomination["Points"][InDomination["BestGroup"]] >= InDomination["MaxPoints"] then
                    InDomination["Winner"] = InDomination["BestGroup"]
                end
            end
            
            if InDomination["Winner"] then
                FinishDomination(Zone)
                break
            end
            
            idle = 10000
            Wait(idle)
        end
    end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- START EVENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("domination:start")
AddEventHandler("domination:start",function(Area,MaxPlayers,Interval,Points,Groups)
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Admin",3) then
        if dominationConfig[Area] and dominationType[Groups] then
            
            InDomination = {}
            InDomination["Zone"] = Area
            InDomination["Mode"] = Groups
            InDomination["BestGroup"] = nil
            InDomination["Groups"] = {}
            InDomination["Points"] = {}
            InDomination["Winner"] = false
            InDomination["MaxPoints"] = parseInt(Points)
            InDomination["MaxPlayers"] = parseInt(MaxPlayers)
            InDomination["Dominador"] = false
            local Timer = os.time() + parseInt(Interval)
            if vRP.Request(source,"Essa dominação vai setar grupo DOMINADOR aos vencedores ?","Sim, por favor","Não, obrigado") then
                InDomination["Dominador"] = true
            end
            for Group,_ in pairs(dominationType[Groups]) do
                InDomination["Groups"][Group] = {}
                InDomination["Points"][Group] = 0
                local Service = vRP.NumPermission(Group)
                for Passports,Sources in pairs(Service) do
                    async(function()
                        if vRP.Request(Sources,"Deseja participar da dominação da area <b>"..Area.."</b> Horario: <b>"..os.date("%H:%M:%S",Timer).."</b>?","Sim, por favor","Não, obrigado") then
                            table.insert(InDomination["Groups"][Group],Sources)
                        end
                    end)
                end
            end
            StartDomination(Area,Timer,Groups,Timer)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- START EVENT
-----------------------------------------------------------------------------------------------------------------------------------------
function TriggerKillFeedDom(Killer,Victim,Weapon)
    for Group,Table in pairs(InDomination["Groups"]) do
        async(function()
            for i=1,#Table do
                async(function()
                    local Source = Table[i]
                    TriggerClientEvent("domination:KillFeed",Source,Killer,Victim,Weapon)
                end)
            end
        end)
    end
end

function Server.killFeedDom(Killer,Victim,Weapon)
    if InDomination then
        local Zone = InDomination["Zone"]
        if Zone and dominationConfig[Zone] then
            local Group = SourceGroup[Killer]
            local KillerPed = GetPlayerPed(Killer)
            local VictimPed = GetPlayerPed(Victim)
            local KillerName = Entity(KillerPed)["state"]["Name"]
            local VictimName = Entity(VictimPed)["state"]["Name"]
            local Point = dominationConfig[Zone]["Points"]["DeathPoint"]
            local DoubleZone = Player(Victim)["state"]["Domination"]
            if DoubleZone == 2 then
                Point = dominationConfig[Zone]["Points"]["DoubleDeathPoint"]
            end
            if InDomination["Points"] and InDomination["Points"][Group] then
                InDomination["Points"][Group] = InDomination["Points"][Group] + Point
            end
            ExitDomination(Victim,"Você morreu.")
            TriggerKillFeedDom(KillerName,VictimName,Weapon)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- START EVENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("startdomination",function(source,args,rawCommand)
    TriggerClientEvent("domination:ShowNui",source)
end)

function dictionaryWithHigherValue(dict)
    
    local highest = 0
    local highestKey = nil
    
    for k,v in pairs(dict) do
        if v > highest then
            highest = v
            highestKey = k
        end
    end
    
    return highestKey
end