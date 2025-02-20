cityName = GetConvar("cityName", "Base")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local Partys = {}
local PlayerRoute = {}
local Cooldown = {}
GlobalState["WipeBonus"] = 0
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local EconomyItens = {}
local EconomyRoutes = 1

CreateThread(function()
    EconomyItens = exports['variables']:GetVariable('variables','EconomyRoutesItens') or {}
    EconomyRoutes = exports['variables']:GetVariable('variables','EconomyRoutes') or 1
end)

function GiveRouteItem(Passport,Item,Amount)
    if EconomyItens[Item] then
        Amount = parseInt(Amount * EconomyItens[Item])
    end
    if EconomyRoutes then
        Amount = parseInt(Amount * EconomyRoutes)
    end
    vRP.GenerateItem(Passport,Item,Amount,true)
end

RegisterCommand("bonusfarm",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
        if vRP.HasGroup(Passport,"Admin",2) then
            local Keyboard = vKEYBOARD.keySingle(source,"Vezes de farm:")
            if Keyboard and Keyboard[1] then
                GlobalState["WipeBonus"] = parseInt(Keyboard[1])
                TriggerClientEvent("Notify",source,"sucesso","Bonus de "..GlobalState["WipeBonus"].."x setado com sucesso!",5000)
                -- TriggerClientEvent("Notify2",source,"#bonusfarm",{msg=GlobalState["WipeBonus"]})
            end
        end
    end
end)

function Creative.GetRoutes(Position,HasRoutes)
    local Source = source
    local Passport = vRP.Passport(Source)
    local Job,Rank,Group,Hyerarchy = vRP.UserGroupByType(Passport,"Job")

    local Route = false
    if GlobalState["HasBucket"] then
        exports["vrp"]:ChangePlayerBucket(source,7)
    end

    if Job then
        for Farm,Data in pairs(RoutesCoordinates) do
            if Data["Permissions"][Job] then
                Route = Farm
                break
            end
        end
    else
        TriggerClientEvent("Notify",Source,"vermelho","Nenhuma rota disponivel para seu emprego!",5000,"Rotas")
        -- TriggerClientEvent("Notify2",Source,"#semRota")
        return false
    end
    if HasRoutes then
        Route = HasRoutes
    end
    if Route then
        local PartyName = exports["party"]:GetPassportRoom(Passport)
        if PartyName then
            if not Partys[PartyName] then
                local RoomMembers = exports["party"]:GetRoomMembers(PartyName)
                if RoomMembers then
                    Partys[PartyName] = { Paying = false, Members = RoomMembers, Job = Job, Route = Route, Position = Position, Step = 1 }
                    for Passports,Sources in pairs(RoomMembers) do
                        local MembersJob = vRP.UserGroupByType(Passports,"Job")
                        if Job ~= MembersJob then
                            exports["party"]:RemoveMember(PartyName,Passports)
                        end
                        TriggerClientEvent("routes:StartRoutes",Sources,Route,Position,Partys[PartyName]["Step"])
                        if GlobalState["HasBucket"]  then
                            exports["vrp"]:ChangePlayerBucket(Sources,7)
                        end
                    end
                    return true
                else
                    TriggerClientEvent("Notify",Source,"vermelho","Rotas compartilhadas com problemas, tente recriar o grupo.",5000,"Rotas")
                    -- TriggerClientEvent("Notify2",Source,"#erroRotaCompart")
                end
            else
                TriggerClientEvent("routes:StartRoutes",Source,Route,Position,Partys[PartyName]["Step"])
            end
        else
            PlayerRoute[Passport] = { Route = Route, Position = Position, Step = 1 }
            TriggerClientEvent("routes:StartRoutes",Source,Route,Position,1)
            return true
        end
    else
        TriggerClientEvent("Notify",Source,"vermelho","Nenhuma rota disponivel para seu emprego!",5000,"Rotas")
        -- TriggerClientEvent("Notify2",Source,"#semRota")
        return false
    end
end

local CountLog = {}
function Creative.PayRoutes()
    local source = source
    local Passport = vRP.Passport(source)
    local License = vRP.Identities(source)
    local reason = "Hack 101"
    if License then
        local Account = vRP.Account(License)
        if Account and Account["id"] then
            vRP.Query("banneds/InsertBanned",{ accountId = Account["id"], reason = reason })
            vRP.Kick(source,"Você foi banido")
            exports["vrp"]:SendWebHook("ban","**Ban:** "..Passport.." ".. vRP.FullName(Passport) .."\n**Account id:** "..Account["id"].."\n**Motivo:** "..reason.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
        end
    end
end

function Creative.GiveFarm()
    local Source = source
    local Passport = vRP.Passport(Source)
    local PartyName = exports["party"]:GetPassportRoom(Passport)
    if GlobalState["Restarting"] then
        return false
    end
    if Passport then
        if Cooldown[Source] and Cooldown[Source] > os.time() then
            if not CountLog[Source] then
                CountLog[Source] = 1
            end
            CountLog[Source] = CountLog[Source] + 1
            if CountLog[Source] == 5 then
                exports["vrp"]:SendWebHook("rotas","**Passaporte:** "..Passport.." ".. vRP.FullName(Passport) .."\n**Pagando rotas muito rapido 5x**\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),2123412)
            elseif CountLog[Source] == 10 then
                exports["vrp"]:SendWebHook("rotas","**Passaporte:** "..Passport.." ".. vRP.FullName(Passport) .."\n**Pagando rotas muito rapido 10x**\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),2123412)
            end
            return false
        end
        if PartyName then
            if Partys[PartyName] and not Partys[PartyName]["Paying"] then
                Partys[PartyName]["Paying"] = true
                local Route = Partys[PartyName]["Route"]
                local Items = RoutesCoordinates[Route]["Items"]
                local RouteBonus = RoutesCoordinates[Route]["Bonus"] or 1.2
                local Position = Partys[PartyName]["Position"]
                local Members = exports["party"]:Room(Passport,Source,50.0)
                local Total = #RoutesCoordinates[Route]["Coordinates"][Position]
                local FarmCoords = RoutesCoordinates[Route]["Coordinates"][Position][Partys[PartyName]["Step"]]
                local Ped = GetPlayerPed(Source)
                local Coords = GetEntityCoords(Ped)
                local Coords2 = vector3(FarmCoords.x,FarmCoords.y,FarmCoords.z)
                local Distance = #(Coords-Coords2)
                if Distance > 10.0 then
                    TriggerClientEvent("Notify",Source,"vermelho","Você está muito longe da rota!",5000)
                    -- TriggerClientEvent("Notify2",Source,"#longeRota")
                    Partys[PartyName]["Paying"] = false
                    return false
                end
                async(function()
                    local Members2 = exports["party"]:Room(Passport,Source,5000.0)
                    for i=1,#Members2 do
                        local MemberSource = Members2[i]["Source"]
                        TriggerClientEvent("routes:Farming",MemberSource)
                    end
                end)
                if Partys[PartyName]["Step"] == Total then
                    Partys[PartyName]["Step"] = 1
                else
                    Partys[PartyName]["Step"] = Partys[PartyName]["Step"] + 1
                end
                
                async(function()
                    for i=1,#Members do
                        local MemberPassport = Members[i]["Passport"]
                        local MemberSource = Members[i]["Source"]
                        TriggerClientEvent("routes:NextRoute",MemberSource,Route,Position,Partys[PartyName]["Step"])
                        local Bonus = RouteBonus*#Members
                        if #Members == 1 then
                            Bonus = 0
                        end
                        if not vRP.hasGroup(MemberPassport,Partys[PartyName]["Job"]) then
                            exports["party"]:RemoveMember(PartyName,MemberPassport)
                            table.remove(Members,i)
                            return
                        end

                        for Item,Amount in pairs(Items) do 
                            local RandomAmount = parseInt(math.random(Amount[1],Amount[2])+Bonus)
                            -- if vRP.HasGroup(Passport, "Dominador") then
                            --     RandomAmount = RandomAmount * 2
                            -- end
                            
                            if vRP.CompareWeight(Passport,Item,RandomAmount) then
                                -- if vRP.HasGroup(Passport,"Dominador2") then
                                --     RandomAmount = RandomAmount * 2
                                -- end
                                if GlobalState["WipeBonus"] and GlobalState["WipeBonus"] > 0 then
                                    RandomAmount = RandomAmount * GlobalState["WipeBonus"]
                                end
                                local Job = vRP.UserGroupByType(MemberPassport,'Job')
                                local GroupBuff = exports["crafting"]:getGroupFarmBuff(Job) or 1
                                RandomAmount = parseInt(RandomAmount * GroupBuff)
                                GiveRouteItem(MemberPassport,Item,RandomAmount)
                            else
                                TriggerClientEvent("Notify",MemberSource,"vermelho","Mochila cheia!",5000)
                                -- TriggerClientEvent("Notify2",MemberSource,"#mochilaFull")
                            end
                        end
                    end
                end)
                
                Cooldown[Source] = os.time() + 15
                Partys[PartyName]["Paying"] = false
            end
        else
            if PlayerRoute[Passport] then
                local Route = PlayerRoute[Passport]["Route"]
                local Position = PlayerRoute[Passport]["Position"]
                local Total = #RoutesCoordinates[Route]["Coordinates"][Position]
                local FarmingCoords = RoutesCoordinates[Route]["Coordinates"][Position][PlayerRoute[Passport]["Step"]]
                local Ped = GetPlayerPed(Source)
                local Coords = GetEntityCoords(Ped)
                local Coords2 = vector3(FarmingCoords.x,FarmingCoords.y,FarmingCoords.z)
                local Distance = #(Coords-Coords2)
                if Distance > 10.0 then
                    TriggerClientEvent("Notify",Source,"vermelho","Você está muito longe da rota!",5000)
                    -- TriggerClientEvent("Notify2",Source,"#longeRota")
                    if Partys[PartyName] then
                        Partys[PartyName]["Paying"] = false
                    end
                    return false
                end
                if PlayerRoute[Passport]["Step"] == Total then
                    PlayerRoute[Passport]["Step"] = 1
                else
                    PlayerRoute[Passport]["Step"] = PlayerRoute[Passport]["Step"] + 1
                end

                TriggerClientEvent("routes:NextRoute",Source,Route,Position,PlayerRoute[Passport]["Step"])
                local Items = RoutesCoordinates[Route]["Items"]
                for Item,Amount in pairs(Items) do 
                    local RandomAmount = parseInt(math.random(Amount[1],Amount[2]))
                    -- if vRP.HasGroup(Passport, "Dominador") then
                    --     RandomAmount = RandomAmount * 2
                    -- end
                    if vRP.CompareWeight(Passport,Item,RandomAmount) then
                        -- if vRP.HasGroup(Passport,"Dominador2") then
                        --     RandomAmount = RandomAmount * 2
                        -- end
                        if GlobalState["WipeBonus"] and GlobalState["WipeBonus"] > 0 then
                            RandomAmount = RandomAmount * GlobalState["WipeBonus"]
                        end
                        local Job = vRP.UserGroupByType(Passport,'Job')
                        local GroupBuff = exports["crafting"]:getGroupFarmBuff(Job) or 1
                        RandomAmount = parseInt(RandomAmount * GroupBuff)
                        GiveRouteItem(Passport,Item,RandomAmount)
                    else
                        TriggerClientEvent("Notify",Source,"vermelho","Mochila cheia!",5000)
                        -- TriggerClientEvent("Notify2",Source,"#mochilaFull")
                    end
                end
                Cooldown[Source] = os.time() + 3
            end
        end
    end
    return false
end

function Creative.ExitRoutes()
    local Source = source
    local Passport = vRP.Passport(Source)

    if (Passport) then
        local PartyName = exports["party"]:GetPassportRoom(Passport)
        local Bucket = 1
        exports["vrp"]:ChangePlayerBucket(Source,Bucket)
        if PartyName then
            if Partys[PartyName] then
                exports["party"]:RemoveMember(PartyName,Passports)
                PlayerRoute[Passport] = nil
            end
        end
        if GlobalState["HasBucket"] then
            TriggerEvent("vRP:BucketCreative",Source,"Enter",1)
        end
    end
end