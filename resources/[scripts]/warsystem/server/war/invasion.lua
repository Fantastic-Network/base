-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
InWarSystem = {}
local StartTimer = 7500
local Mode = false
SourceGroup = {}
SourceKills = {}
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- START CLIENT DOMINATION
-----------------------------------------------------------------------------------------------------------------------------------------
function StartClientWarSystem(Source,Group)
    local Passport = vRP.Passport(Source)
    if DoesPlayerExist(Source) then
        SourceGroup[Source] = Group
        exports["vrp"]:ChangePlayerBucket(Source,15)
        Player(Source)["state"]["WarSystem"] = true
        Player(Source)["state"]["WarSystemSpec"] = true
        SourceKills[Source] = 0
        TriggerClientEvent("warsystem:Start",Source,InWarSystem["Info"],InWarSystem["GasZone"])
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXIT DOMINATION
-----------------------------------------------------------------------------------------------------------------------------------------
function ExitWarSystem(Source,Reason)
    local Passport = vRP.Passport(Source)
    local Job = vRP.UserGroupByType(Passport,"Job")
    local Ped = GetPlayerPed(Source)
    if Job and InWarSystem and InWarSystem["Groups"] and InWarSystem["Groups"][Job] then
        for i=1,#InWarSystem["Groups"][Job] do
            if InWarSystem["Groups"][Job][i] == Source then
                table.remove(InWarSystem["Groups"][Job],i)
            end
        end
    end
    if Reason == "Finish" then
        EndSpectate(Source,true)
        Player(Source)["state"]["WarSystemSpec"] = false
        vRP.Revive(Source,400)
        Wait(100)
        TriggerClientEvent("admin:Teleport",Source,vector3(-1537.06,-941.47,11.56))
        Player(Source)["state"]["Spectate"] = false
        TriggerClientEvent("warsystem:Exit",Source)
        local Bucket = 1
        exports["vrp"]:ChangePlayerBucket(Source,Bucket)
    end
    Player(Source)["state"]["WarSystem"] = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE CLIENT INFO
-----------------------------------------------------------------------------------------------------------------------------------------
function UpdateClientInfoWar()
    local Table = {}
    if InWarSystem then
        for Group,Players in pairs(InWarSystem["Groups"]) do
            if not Table["myTeam"] then
                Table["myTeam"] = {
                    name = Group,
                    score = #InWarSystem["Groups"][Group],
                }
            else
                Table["theirTeam"] = {
                    name = Group,
                    score = #InWarSystem["Groups"][Group],
                }
            end
        end
        InWarSystem["Info"] = Table
        for Group,Players in pairs(InWarSystem["Groups"]) do
            for i=1,#Players do
                xpcall(function()
                    async(function()
                        local Source = Players[i]
                        TriggerClientEvent("warsystem:Update",Source,InWarSystem["Info"])
                    end)
                end,function(err)
                    print(err)
                end)
            end
        end
        for Source,_ in pairs(PlayerSpectate) do
            xpcall(function()
                async(function()
                    TriggerClientEvent("warsystem:UpdateSpectateInfo",Source,InWarSystem["Info"])
                end)
            end,function(err)
                print(err)
            end)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISH DOMINATION
-----------------------------------------------------------------------------------------------------------------------------------------
function FinishWarSystem(Zone)
    for Group,Table in pairs(InWarSystem["Groups"]) do
        async(function()
            for i=1,#Table do
                local Source = Table[i]
                xpcall(function()
                    async(function()
                        ExitWarSystem(Source,"Finish")
                    end)
                end,function(err)
                    print(err)
                end)
            end
        end)
    end
    print("Finish Exiting All Alive Players")
    for Source,_ in pairs(PlayerSpectate) do
        xpcall(function()
            async(function()
                local Ped = GetPlayerPed(Source)
                SetEntityDistanceCullingRadius(Ped,0.0)
                EndSpectate(Source,true)
                Player(Source)["state"]["WarSystem"] = false
                Player(Source)["state"]["WarSystemSpec"] = false
                vRP.Revive(Source,400)
                Wait(100)
                TriggerClientEvent("admin:Teleport",Source,vector3(-1537.06,-941.47,11.56))
                Player(Source)["state"]["WarSystem"] = false
                Player(Source)["state"]["Spectate"] = false
                TriggerClientEvent("warsystem:Exit",Source)
                exports["vrp"]:ChangePlayerBucket(source,Bucket)
            end)
        end,function(err)
            print(err)
        end)
    end
    print("Finish Exiting All Spectators Players")
    TriggerClientEvent("Notify",-1,"dominacao","O Grupo <b>"..InWarSystem["BestGroup"].."</b> GANHOU a invasão <b>"..Zone.."</b>.",15000,"INVASAO")
    -- TriggerClientEvent("Notify2",-1,"#invasionGroupWinner",{msg=InWarSystem["bestGroup"],msg2=Zone})
    Wait(15000)
    InWarSystem = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET GROUP POINT
-----------------------------------------------------------------------------------------------------------------------------------------
function GetAmountPlayersWar()
    local Count = 0
    local Best = false
    for Group,Table in pairs(InWarSystem["Groups"]) do
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
-- START DOMINATION
-----------------------------------------------------------------------------------------------------------------------------------------
function StartWarSystem(Zone,Timer,Mode,TimerStart)
    local Finish = Timer + warSystemConfig[Zone]["maxTime"]
    local ZonePoint = warSystemConfig[Zone]["Point"]
    local ZoneDouble = warSystemConfig[Zone]["DoublePoint"]
    local Start = false
    InWarSystem["Mode"] = Mode
    local MaxPlayers = InWarSystem["MaxPlayers"]
    TriggerClientEvent("Notify",-1,"dominacao","Invasão de <b>"..warSystemConfig[Zone]["Name"].."</b>. irá iniciar as <b>"..os.date("%H:%M:%S",Timer).."</b>.",(Timer-os.time())*1000,"INVASAO")
    -- TriggerClientEvent("Notify2",-1,"#zoneInvasionWillStart",{msg=warSystemConfig[Zone]["Name"],msg2=os.date("%H:%M:%S",Timer),msg3=(Timer-os.time())*1000})
    while not Start do
        if os.time() >= Timer then
            TriggerClientEvent("warsystem:Blip",-1,Zone)
            TriggerClientEvent("Notify",-1,"dominacao","Invasão de <b>"..warSystemConfig[Zone]["Name"].."</b>. irá iniciar, Todos dentro da area!.",StartTimer,"INVASAO")
            -- TriggerClientEvent("Notify2",-1,"#zoneInvasionStarted",{msg=warSystemConfig[Zone]["Name"],msg2=StartTimer})
            Wait(StartTimer)
            for Group,Table in pairs(InWarSystem["Groups"]) do
                
                local GoToWarSystem = {}
                
                for i=1,#Table do
                    local Ped = GetPlayerPed(Table[i])
                    if Ped ~= 0 and DoesEntityExist(Ped) then
                        local Coords = GetEntityCoords(Ped)
                        if insidePolygon(ZonePoint,Coords) and IsEntityVisible(Ped) and GetPlayerRoutingBucket(Table[i]) == 6 then
                            GoToWarSystem[#GoToWarSystem+1] = Table[i]
                        end
                    end
                end
                
                InWarSystem["Groups"][Group] = GoToWarSystem
            end
            Start = true
        end
        
        Wait(1000)
    end
    TriggerClientEvent("warsystem:RemBlip",-1)
    Wait(1000)
    
    local Table2 = {}
    for Group,Table in pairs(InWarSystem["Groups"]) do
        if not Table2["myTeam"] then
            Table2["myTeam"] = {
                name = Group,
                score = #InWarSystem["Groups"][Group],
            }
        else
            Table2["theirTeam"] = {
                name = Group,
                score = #InWarSystem["Groups"][Group],
            }
        end
        Table2["Zone"] = InWarSystem["Zone"]
    end

    InWarSystem["Info"] = Table2
    
    for Group,Table in pairs(InWarSystem["Groups"]) do
        for i=1,#Table do
            xpcall(function()
                async(function()
                    local Source = Table[i]
                    StartClientWarSystem(Source,Group)
                end)
            end,function(err)
                print(err)
            end)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- START EVENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("warsystem:CreateInvasion")
AddEventHandler("warsystem:CreateInvasion",function(Area,MaxPlayers,Interval,Points,Groups)
    local source = source
    local Passport = vRP.Passport(source)
    -- local Area,MaxPlayers,Interval,Points,Groups = "Paleto",10,3,500,{"Ballas","Vagos"}
    if vRP.HasGroup(Passport,"Admin",3) then
        if warSystemConfig[Area] then
            InWarSystem = {}
            InWarSystem["Zone"] = Area
            InWarSystem["Mode"] = "Invasão"
            InWarSystem["BestGroup"] = nil
            InWarSystem["Groups"] = {}
            InWarSystem["Points"] = {}
            InWarSystem["Deaths"] = {}
            InWarSystem["Winner"] = false
            local Timer = os.time() + parseInt(Interval)
            InWarSystem["GasZone"] = false
            if vRP.Request(source,"Deseja inserir area toxica? (Necessita de coordenada)",30) then
                local Keyboard = vKEYBOARD.keySingle(source,"Coordenadas de finalização:")
                if Keyboard and Keyboard[1] then
                    local Split = splitString(Keyboard[1],",")
                    InWarSystem["GasZone"] = vector2(tonumber(Split[1]) or 0,tonumber(Split[2]) or 0)
                end
            end
            for _,Group in pairs(Groups) do
                InWarSystem["Groups"][Group] = {}
                InWarSystem["Deaths"][Group] = {}
                InWarSystem["Points"][Group] = 0
                local Service = vRP.NumPermission(Group)
                for Passports,Sources in pairs(Service) do
                    async(function()
                        table.insert(InWarSystem["Groups"][Group],Sources)
                    end)
                end
            end
            StartWarSystem(Area,Timer,Groups,Timer)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- START EVENT
-----------------------------------------------------------------------------------------------------------------------------------------
function TriggerKillFeedWar(Killer,Victim,Weapon)
    for Group,Table in pairs(InWarSystem["Groups"]) do
        async(function()
            for i=1,#Table do
                local Source = Table[i]
                if DoesPlayerExist(Source) then
                    TriggerClientEvent("warsystem:KillFeed",Source,Killer,Victim,Weapon)
                end
            end
        end)
    end
    for Source,_ in pairs(PlayerSpectate) do
        if DoesPlayerExist(Source) then
            TriggerClientEvent("warsystem:KillFeed",Source,Killer,Victim,Weapon)
        end
    end
end

function Server.killFeedInvasion(Killer,Victim,Weapon)
    if InWarSystem and Killer and Victim and Weapon  then
        if DoesPlayerExist(Killer) and DoesPlayerExist(Victim) then
            local Zone = InWarSystem["Zone"]
            local Group = SourceGroup[Killer]
            local GroupVictim = SourceGroup[Victim]
            local KillerPed = GetPlayerPed(Killer)
            local VictimPed = GetPlayerPed(Victim)
            local KillerName = Entity(KillerPed)["state"]["Name"]
            local VictimName = Entity(VictimPed)["state"]["Name"]
            local Point = warSystemConfig[Zone]["Points"]["DeathPoint"]
            local DoubleZone = Player(Victim)["state"]["WarSystem"]
            if DoubleZone == 2 then
                Point = warSystemConfig[Zone]["Points"]["DoubleDeathPoint"]
            end
            if SourceKills[Killer] then
                SourceKills[Killer] = SourceKills[Killer] + 1
            end
            if GroupVictim and KillerName and VictimName and InWarSystem["Deaths"][GroupVictim] then
                table.insert(InWarSystem["Deaths"][GroupVictim],Victim)
                TriggerKillFeedWar(KillerName,VictimName,Weapon)
            end
            if Victim and DoesPlayerExist(Victim) then
                ExitWarSystem(Victim,"Finish")
            else
                if GroupVictim then
                    for i=1,#InWarSystem["Groups"][GroupVictim] do
                        if tostring(InWarSystem["Groups"][GroupVictim][i]) == tostring(Victim) then
                            table.remove(InWarSystem["Groups"][GroupVictim],i)
                        end
                    end
                end
            end
            Wait(500)
            UpdateClientInfoWar()
            local Amount = GetAmountPlayersWar()
            if Amount then
                Wait(1000)
                if InWarSystem then
                    InWarSystem["BestGroup"] = Amount
                    FinishWarSystem(Zone)
                end
                if Victim and DoesPlayerExist(Victim) then
                    vRP.Revive(Victim,400)
                    Wait(100)
                    TriggerClientEvent("admin:Teleport",Victim,vector3(-1537.06,-941.47,11.56))
                    Player(Victim)["state"]["WarSystem"] = false
                    Player(Victim)["state"]["WarSystemSpec"] = false
                    TriggerClientEvent("warsystem:Exit",Victim)
                    local Bucket = 1
                    exports["vrp"]:ChangePlayerBucket(Victim,Bucket)
                    vRP.Revive(Victim,400)
                    Wait(100)
                    TriggerClientEvent("admin:Teleport",Killer,vector3(-1537.06,-941.47,11.56))
                    Player(Killer)["state"]["WarSystem"] = false
                    Player(Killer)["state"]["WarSystemSpec"] = false
                    TriggerClientEvent("warsystem:Exit",Killer)
                    exports["vrp"]:ChangePlayerBucket(Killer,Bucket)
                end
            else
                if Victim and DoesPlayerExist(Victim) then
                    TriggerClientEvent("warsystem:Death",Victim)
                end
            end
        end
    else
        if not Victim or not DoesPlayerExist(Victim) then
            local Job = SourceGroup[Victim]
            if Job then
                for i=1,#InWarSystem["Groups"][Job] do
                    if tostring(InWarSystem["Groups"][Job][i]) == tostring(Victim) then
                        table.remove(InWarSystem["Groups"][Job],i)
                    end
                end
            end
        elseif not Killer or not DoesPlayerExist(Killer) then
            local Job = SourceGroup[Killer]
            if Job then
                for i=1,#InWarSystem["Groups"][Job] do
                    if tostring(InWarSystem["Groups"][Job][i]) == tostring(Killer) then
                        table.remove(InWarSystem["Groups"][Job],i)
                    end
                end
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- START EVENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("startinvasion",function(source,args,rawCommand)
    local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport, "Admin", 3) then
            TriggerClientEvent("warsystem:ShowNui",source)
        end
    end
end)

RegisterCommand("kickinvasion",function(source,args,rawCommand)
    local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport, "Admin", 3) then
            local Source = vRP.Source(parseInt(args[1]))
            if Source then
                TriggerClientEvent("Notify",source,"sucesso","Você kickou o jogador <b>"..parseInt(args[1]).."</b> do evento.",8000)
                ExitWarSystem(Source,"Finish")
                Wait(100)
                UpdateClientInfoWar()
                Wait(100)
                local Amount = GetAmountPlayersWar()
                if Amount then
                    Wait(1000)
                    if InWarSystem and InWarSystem["Zone"] then
                        InWarSystem["BestGroup"] = Amount
                        FinishWarSystem(InWarSystem["Zone"])
                    end
                end
                Wait(100)
                -- TriggerClientEvent("Notify2",source,"#kickinvasion",{msg=parseInt(args[1])})
            end
        end
    end
end)

-- CreateThread(function()
--     Wait(1000)
--     TriggerEvent("warsystem:start")
-- end)

AddEventHandler("playerDropped",function(Reason)
    local source = source
    if InWarSystem then
        local Zone = InWarSystem["Zone"]
        local Job = SourceGroup[source]
        if SourceGroup[source] and InWarSystem then
            if Job and InWarSystem["Groups"] and InWarSystem["Groups"][Job] then
                for i=1,#InWarSystem["Groups"][Job] do
                    if InWarSystem["Groups"][Job][i] == source then
                        table.remove(InWarSystem["Groups"][Job],i)
                    end
                end
                local Amount = GetAmountPlayersWar()
                if Amount then
                    Wait(1000)
                    if InWarSystem and InWarSystem["Zone"] then
                        InWarSystem["BestGroup"] = Amount
                        FinishWarSystem(InWarSystem["Zone"])
                    end
                end
                UpdateClientInfoWar()
            end
        end
        if PlayerSpectate[source] then
            PlayerSpectate[source] = nil
        end
    end
end)


RegisterServerEvent("warsystem:ExitInvasion")
AddEventHandler("warsystem:ExitInvasion",function()
    local source = source
    Wait(1000)
    if InWarSystem then
        ExitWarSystem(source,"Finish")
        local Amount = GetAmountPlayersWar()
        if Amount then
            Wait(1000)
            if InWarSystem and InWarSystem["Zone"] then
                InWarSystem["BestGroup"] = Amount
                FinishWarSystem(InWarSystem["Zone"])
            end
        end
    end
end)