PlayerQueue = {}
LobbyInfo = {}
PlayerInQueue = {}
PlayerInfo = {}
Infox1 = {}
Event = {}
PlayersEvent = {}
PlayerKillsX1 = {}
PlayersInfox1 = {}
LobbysX1 = 0
vRP.Prepare("rank_1x1/InsertWinner","INSERT INTO rank_1x1 (winner, loser) VALUES (@winner, @loser)")

function RemovePlayerFromQueue(Passport)
    local source = vRP.Source(Passport)
    for i = 1, #PlayerQueue do
        if PlayerQueue[i] == Passport then
            table.remove(PlayerQueue,i)
            break
        end
    end
    PlayerInQueue[Passport] = nil
    if source then
        TriggerClientEvent("Notify",source,"vermelho","Você saiu da fila do x1.")
    end
end

function IsPlayerInQueue(Passport)
    return PlayerInQueue[Passport] ~= nil
end

function AddPlayerToQueue(Passport)
    local source = vRP.Source(Passport)
    PlayerQueue[#PlayerQueue + 1] = Passport
    PlayerInQueue[Passport] = true
    TriggerClientEvent("Notify",source,"verde","Você entrou na fila do x1.")
    TriggerClientEvent("1x1:StartQueue",source)
end


RegisterCommand("x1",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if not IsPlayerInQueue(Passport) then
            AddPlayerToQueue(Passport)
        end
    end
end)

function InsertPlayersX1(Player1,Player2)
    local Source1 = vRP.Source(Player1)
    local Source2 = vRP.Source(Player2)
    local Bucket = parseInt(900000 + (Source1 + Source2))
    LobbysX1 = LobbysX1 + 1
    local LobbyId = LobbysX1
    Infox1[LobbyId] = {Rounds = 0, Teams = {}}
    local Info = {}
    Info["Name"] = vRP.FullName(Player1):sub(1,20)
    Info["Players"] = {Source1}
    Info["Score"] = 0
    Infox1[LobbyId]["Teams"][1] = Info
    local Info = {}
    Info["Name"] = vRP.FullName(Player2):sub(1,20)
    Info["Players"] = {Source2}
    Info["Score"] = 0
    Infox1[LobbyId]["Teams"][2] = Info
    Infox1[LobbyId]["Type"] = "1x1"
    Infox1[LobbyId]["Bucket"] = Bucket
    PlayersInfox1[tostring(Source1)] = {Team = 1, LobbyId = LobbyId}
    PlayerKillsX1[tostring(Source1)] = 0
    PlayersInfox1[tostring(Source2)] = {Team = 2, LobbyId = LobbyId}
    PlayerKillsX1[tostring(Source2)] = 0
    PreStartRoundX1(LobbyId,true)
    Wait(2500)
    StartRoundX1(LobbyId,true)
end

function TriggerKillFeed1x1(Killer,Victim,Weapon,LobbyId)
    if LobbyId then
        if Infox1[LobbyId] and Infox1[LobbyId]["Teams"] then
            for Group,Table in pairs(Infox1[LobbyId]["Teams"]) do
                async(function()
                    for i=1,#Table["Players"] do
                        local Source = Table["Players"][i]
                        local Kills = PlayerKillsX1[tostring(Source)]
                        TriggerClientEvent("1x1:KillFeed",Source,Killer,Victim,Weapon,Kills)
                    end
                end)
            end
        end
    end
end

function Server.killFeed1x1(Killer,Victim,Weapon)
    if PlayersInfox1[tostring(Killer)] then
        local LobbyId = PlayersInfox1[tostring(Killer)]["LobbyId"]
        local Group = SourceGroup[Killer]
        local GroupVictim = SourceGroup[Victim]
        local KillerPed = GetPlayerPed(Killer)
        local VictimPed = GetPlayerPed(Victim)
        local KillerName = Entity(KillerPed)["state"]["Name"]
        local VictimName = Entity(VictimPed)["state"]["Name"]
        PlayerKillsX1[tostring(Killer)] = PlayerKillsX1[tostring(Killer)] + 1
        TriggerKillFeed1x1(KillerName,VictimName,Weapon,LobbyId)
        Wait(1000)
        local KillerHealth = vRP.GetHealth(Killer)
        if KillerHealth and KillerHealth == 100 then
            StartRoundX1(LobbyId)
            return
        end
        local Group = GetAmountPlayersX1(LobbyId)
        if Group and not Infox1[LobbyId]["RoundDone"] then
            Infox1[LobbyId]["RoundDone"] = true
            AddPointX1(LobbyId,parseInt(Group))
        end
    end
end

CreateThread(function()
    while true do
        xpcall(function()
            for i=1,#PlayerQueue do
                local Source = vRP.Source(PlayerQueue[i])
                if Source then
                    TriggerClientEvent("1x1:UpdateQueue",Source,{ queue = i, total = #PlayerQueue})
                else
                    RemovePlayerFromQueue(Passport)
                end
            end
            if PlayerQueue[1] and PlayerQueue[2] then
                local Passport1 = PlayerQueue[1]
                local Passport2 = PlayerQueue[2]
                InsertPlayersX1(Passport1,Passport2)
                RemovePlayerFromQueue(Passport1)
                RemovePlayerFromQueue(Passport2)
            end
        end,function(err)
            print(err)
        end)
        Wait(5000)
    end
end)

-- CreateThread(function()
--     Wait(500)
--     AddPlayerToQueue(48369)
--     AddPlayerToQueue(121)
-- end)


RegisterServerEvent("1x1:LeaveQueue")
AddEventHandler("1x1:LeaveQueue",function()
    local Source = source
    local Passport = vRP.Passport(Source)
    if Passport then
        RemovePlayerFromQueue(Passport)
    end
end)

AddEventHandler("Disconnect",function(Passport,source)
    RemovePlayerFromQueue(Passport)
    if PlayersInfox1[tostring(source)] then
        local LobbyId = PlayersInfox1[tostring(source)]["LobbyId"]
        if LobbyId and Infox1[LobbyId] and Infox1[LobbyId] ~= nil then
            if Infox1[LobbyId]["Teams"] then
                for Group,Table in pairs(Infox1[LobbyId]["Teams"]) do
                    for i=1,#Table["Players"] do
                        local Source = parseInt(Table["Players"][i])
                        local Passport = vRP.Passport(Source)
                        vRP.ApplyTemporary(Passport,Source)
                        local Ped = GetPlayerPed(Source)
                        if Ped ~= 0 and DoesEntityExist(Ped) then
                            SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),0)
                            RemoveWeaponFromPed(Ped,GetSelectedPedWeapon(Ped))
                            TriggerClientEvent("1x1:Finish",Source)
                        end
                    end
                end
            end
        end
    end
end)