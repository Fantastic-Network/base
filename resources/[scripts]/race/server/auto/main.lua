-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local Server = {}
Tunnel.bindInterface("race/auto",Server)
local vCLIENT = Tunnel.getInterface("race/auto")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Races = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
-- function Server.StartRace(Coords,RaceId)
--     StartRace(Coords,RaceId)
--     Races[RaceId]["Started"] = true
--     Wait(5500)
--     CreateThread(function()
--         while Races[RaceId]["Started"] do
--             Wait(1000)
--             GetPlayersDistance(RaceId)
--         end
--     end)
-- end

function Server.SetupRace(Coords,Distance,Opponent,Price)
    local source = source
    local Passport = vRP.Passport(source)
    local Identity = vRP.Identity(Passport)
    local Name = Identity["name"].." "..Identity["name2"]
    table.insert(Races,{Winner = false, Started = false, Players = {}})
    local RaceId = #Races
    local Table = { name = Name, id = Passport, interval = 5000 }
    local OpponentPassport = vRP.Passport(Opponent)
    if vRP.PaymentFull(Passport,Price > 0) then
        if vRP.PaymentFull(OpponentPassport,Price > 0) then
            local Request = vCLIENT.Request(Opponent,Table)
            local Info = {}
            if Request then
                local OpponentPassport = vRP.Passport(Opponent)
                local OpponentIdentity = vRP.Identity(OpponentPassport)
                local OpponentName = OpponentIdentity["name"].." "..OpponentIdentity["name2"]
                local Table = {
                    { Source = Opponent, name = OpponentName, Distance = 1000 },
                    { Source = source, name = Name, Distance = 1000 }
                }
                Races[RaceId]["Players"] = Table
                Races[RaceId]["Price"] = Price
                Info = {
                    Manager = {
                        Name = Name,
                        Source = source
                    },
                    Opponent = {
                        Name = OpponentName,
                        Source = Opponent
                    }
                }
                SetupPlayer(Info,Distance,Price,RaceId,source,true)
                SetupPlayer(Info,Distance,Price,RaceId,Opponent,false)
                return true
            else
                return false
            end
        else
            --vRP.GiveBank(Passport,Price,"Setup Race")
            vRP.GenerateMoney(Passport,Price,"Setup Race")
            TriggerClientEvent("Notify",source,"negado","O jogador não possui dinheiro na carteira.",5000)
            -- TriggerClientEvent("Notify2",source,"#noMoneyWallet")
            return false
        end
    end
end

function SetupPlayer(Info,Distance,Price,RaceId,Source,Manager)
    local Table = {usersData = {}, distance = Distance, price = Price}
    if Manager then
        Table["usersData"]["self"] = {
            name = Info["Manager"]["Name"],
            source = Info["Manager"]["Source"],
            isManager = true
        }
        Table["usersData"]["opponent"] = {
            name = Info["Opponent"]["Name"],
            source = Info["Opponent"]["Source"],
            isManager = false
        }
    else
        Table["usersData"]["self"] = {
            name = Info["Opponent"]["Name"],
            source = Info["Opponent"]["Source"],
            isManager = false
        }
        Table["usersData"]["opponent"] = {
            name = Info["Manager"]["Name"],
            source = Info["Manager"]["Source"],
            isManager = true
        }
    end
    TriggerClientEvent("race:Setup",Source,Table,RaceId)
end

function StartRace(Coords,Race)
    for i=1,#Races[Race]["Players"] do
        async(function()
            local PlayerInfo = Races[Race]["Players"][i]
            local Source = PlayerInfo["Source"]
            TriggerClientEvent("race:Start",Source,Coords)
        end)
    end
end

function Server.FinishRace(RaceId)
    local source = source
    local Passport = vRP.Passport(source)
    local Identity = vRP.Identity(Passport)
    local Name = Identity["name"].." "..Identity["name2"]
    if Races[RaceId] and Races[RaceId]["Started"] then
        Races[RaceId]["Winner"] = Passport
        --vRP.GiveBank(Races[RaceId]["Winner"],Races[RaceId]["Price"],"Finish Race")
        vRP.GenerateMoney(Races[RaceId]["Winner"],Races[RaceId]["Price"],"Finish Race")
        for i=1,#Races[RaceId]["Players"] do
            local PlayerInfo = Races[RaceId]["Players"][i]
            local PlayerSource = PlayerInfo["Source"]
            local PlayerPassport = vRP.Passport(PlayerSource)
            if PlayerPassport ~= Races[RaceId]["Winner"] then
                vRP.RemoveBank(PlayerPassport,Races[RaceId]["Price"])
            end
            TriggerClientEvent("Notify",PlayerSource,"verde","A corrida acabou, o vencedor foi <b>"..Name.." #"..Passport.."</b>.",10000,"Corrida")
            -- TriggerClientEvent("Notify2",PlayerSource,"#raceWinner",{msg=Name,msg2=Passport})
            TriggerClientEvent("race:Finish",PlayerSource)
        end
    end
end

function Server.CancelRace(RaceId)
    local source = source
    local Passport = vRP.Passport(source)
    local Identity = vRP.Identity(Passport)
    local Name = Identity["name"].." "..Identity["name2"]
    if Races[RaceId]["Started"] then
        for i=1,#Races[RaceId]["Players"] do
            local PlayerInfo = Races[RaceId]["Players"][i]
            local PlayerSource = PlayerInfo["Source"]
            local PlayerPassport = vRP.Passport(PlayerSource)
            vRP.GiveBank(PlayerPassport,Races[RaceId]["Price"],"Cancel Race")
            TriggerClientEvent("race:Finish",PlayerSource)
        end
    end
end

function GetPlayersDistance(Race)
    for i=1,#Races[Race]["Players"] do
        local PlayerInfo = Races[Race]["Players"][i]
        local Distance = vCLIENT.Distance(PlayerInfo["Source"])
        Races[Race]["Players"][i]["Distance"] = Distance
    end
    table.sort(Races[Race]["Players"],function(a,b)
        return a["Distance"] < b["Distance"]
    end)
    for i=1,#Races[Race]["Players"] do
        async(function()
            local PlayerInfo = Races[Race]["Players"][i]
            local Source = PlayerInfo["Source"]
            TriggerClientEvent("race:Update",Source,Races[Race]["Players"])
        end)
    end
end