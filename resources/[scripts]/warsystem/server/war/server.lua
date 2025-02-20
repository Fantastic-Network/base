-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local InWar = {}
local GoingWar = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("warsystem/GetWar","SELECT id,attack,defense,UNIX_TIMESTAMP(start) as start ,UNIX_TIMESTAMP(end) as end,killsAttack,killsDefense FROM warsystem WHERE end > CURRENT_TIMESTAMP()")
vRP.Prepare("warsystem/UpdateKills","UPDATE warsystem SET killsAttack = @killsAttack,killsDefense = @killsDefense WHERE id = @id")
vRP.Prepare("warsystem/InsertWar","INSERT INTO warsystem (attack,defense,start,end,killsAttack,killsDefense) VALUES (@attack,@defense,FROM_UNIXTIME(@start),FROM_UNIXTIME(@end),@killsAttack,@killsDefense)")
vRP.Prepare("warsystem/removeWar","DELETE FROM warsystem WHERE id = @WarID")
CreateThread(function()
    Wait(500)
    local Query = vRP.Query("warsystem/GetWar")
    local Table = {}
    if Query[1] then
        for k,v in pairs(Query) do
            local Info = {
                ["id"] = v["id"],
                ["attack"] = v["attack"],
                ["defense"] = v["defense"],
                ["start"] = v["start"],
                ["end"] = v["end"],
                ["killsAttack"] = v["killsAttack"],
                ["killsDefense"] = v["killsDefense"],
                ["Started"] =  false,
                ["Players"] = {}
            }
            GoingWar[v["id"]] = Info
        end
    end
end)

function IsGroupInWar(Group)
    local InWar = false
    for k,v in pairs(GoingWar) do
        if v["Started"] then
            if v["attack"] == Group or v["defense"] == Group then
                InWar = { id = k }
            end
        end
    end
    return InWar
end

function IsPlayerInWar(Passport)
    local Job = vRP.UserGroupByType(Passport,'Job')
    local IsGroupWar = IsGroupInWar(Job)
    if IsGroupWar then
        IsGroupWar["group"] = Job
        return IsGroupWar
    end
end

AddEventHandler("Connect",function(Passport,Source)
    local inWar = IsPlayerInWar(Passport)
    local Ped = GetPlayerPed(Source)
    if inWar then
        Wait(5000)
        if DoesPlayerExist(Source) then
            local Table = {
                Attacker = {
                    name = GoingWar[inWar["id"]]["attack"],
                    kills = GoingWar[inWar["id"]]["killsAttack"]
                },
                Defense = {
                    name = GoingWar[inWar["id"]]["defense"],
                    kills = GoingWar[inWar["id"]]["killsDefense"]
                }
            }
            GoingWar[inWar["id"]]["Players"][Source] = true
            Player(Source)["state"]["inWar"] = inWar
            if Ped ~= 0 and DoesEntityExist(Ped) then
                Entity(Ped)["state"]["inWar"] = inWar
            end
            TriggerClientEvent("hud:WarSystem",Source,Table)
        end
    end
end)

CreateThread(function()
    local Players = GetPlayers()
    for i=1,#Players do
        local Source = Players[i]
        local Passport = tostring(vRP.Passport(parseInt(Source)))
        if Passport then
            local inWar = IsPlayerInWar(Passport)
            local Ped = GetPlayerPed(Source)
            if inWar then
                if DoesPlayerExist(Source) then
                    local Table = {
                        Attacker = {
                            name = GoingWar[inWar["id"]]["attack"],
                            kills = GoingWar[inWar["id"]]["killsAttack"]
                        },
                        Defense = {
                            name = GoingWar[inWar["id"]]["defense"],
                            kills = GoingWar[inWar["id"]]["killsDefense"]
                        }
                    }
                    GoingWar[inWar["id"]]["Players"][Source] = true
                    Player(Source)["state"]["inWar"] = inWar
                    if Ped ~= 0 and DoesEntityExist(Ped) then
                        Entity(Ped)["state"]["inWar"] = inWar
                    end
                    TriggerClientEvent("hud:WarSystem",Source,Table)
                end
            end
        end
        Wait(5)
    end
end)

function SendNotifyWar(id)
    local Table = {
        Attacker = {
            name = GoingWar[id]["attack"],
            kills = GoingWar[id]["killsAttack"]
        },
        Defense = {
            name = GoingWar[id]["defense"],
            kills = GoingWar[id]["killsDefense"]
        }
    }
    if GoingWar[id] and GoingWar[id]["Players"] then
        for Sources,_ in pairs(GoingWar[id]["Players"]) do
            TriggerClientEvent("hud:WarSystem",Sources,Table)
        end
    end
end

function SendPublicNotifyWar(id)
    local Table = {
        Attacker = {
            name = GoingWar[id]["attack"],
            kills = GoingWar[id]["killsAttack"]
        },
        Defense = {
            name = GoingWar[id]["defense"],
            kills = GoingWar[id]["killsDefense"]
        }
    }
    TriggerClientEvent("hud:PublicWarSystem",-1,Table)
end

function EndWar(id)
    if GoingWar[id] then
        local Table = GoingWar[id]
        for Sources,_ in pairs(Table["Players"]) do
            async(function()
                local Ped = GetPlayerPed(Sources)
                Player(Sources)["state"]["inWar"] = false
                Entity(Ped)["state"]["inWar"] = false
                TriggerClientEvent("hud:HideWarSystem",Sources)
            end)
        end
        vRP.Query("warsystem/removeWar",{ WarID = id })
        GoingWar[id] = nil
        return true
    end
    return false
end

function StartWar(id)
    local Table = GoingWar[id]
    local Service = vRP.NumPermission(Table["attack"])
    for Passport,Sources in pairs(Service) do
        async(function()
            local Ped = GetPlayerPed(Sources)
            GoingWar[id]["Players"][Sources] = true
            Player(Sources)["state"]["inWar"] = { id = id, group = Table["attack"] }
            Entity(Ped)["state"]["inWar"] = { id = id, group = Table["attack"] }
        end)
    end
    local Service = vRP.NumPermission(Table["defense"])
    for Passport,Sources in pairs(Service) do
        async(function()
            local Ped = GetPlayerPed(Sources)
            GoingWar[id]["Players"][Sources] = true
            Player(Sources)["state"]["inWar"] = { id = id, group = Table["defense"] }
            Entity(Ped)["state"]["inWar"] = { id = id, group = Table["defense"] }
        end)
    end
    SendNotifyWar(id)
end

CreateThread(function()
    while true do
        for id,info in pairs(GoingWar) do
            if not info["Started"] then
                if info["start"] < os.time() then
                    info["Started"] = true
                    StartWar(id)
                end
            end
        end
        Wait(5000)
    end
end)

function Server.StartWar(Start,End,Attack,Defense)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Info = {
                ["attack"] = Attack,
                ["defense"] = Defense,
                ["start"] = Start,
                ["end"] = End,
                ["killsAttack"] = 0,
                ["killsDefense"] = 0,
                ["Players"] = {},
                ["Started"] =  false
            }
            local Query = vRP.Query("warsystem/InsertWar",Info)
            GoingWar[Query["insertId"]] = Info
        end
    end
end

function GetWinning(id)
    local Table = GoingWar[id]
    local Info = {}
    if Table["killsAttack"] > Table["killsDefense"] then
        return {Table["attack"],Table["killsAttack"]},{Table["defense"],Table["killsDefense"] }
    elseif Table["killsAttack"] < Table["killsDefense"] then
        return {Table["defense"],Table["killsDefense"] },{Table["attack"],Table["killsAttack"]}
    else
        return false
    end
end

CreateThread(function()
    local Custom = {
        background = "rgba(178,34,34,.60)",
    }
    Wait(5000)
    while true do
        for id,info in pairs(GoingWar) do
            if info["Started"] then
                local Winning,Losing = GetWinning(id)
                if Winning then
                    TriggerClientEvent("chat:ClientMessage",-1,"GUERRA",Winning[1].." "..Winning[2].." x "..Losing[2].." "..Losing[1],"GUERRA",false,Custom)	
                end
            end
            if info["end"] < os.time() then
                EndWar(parseInt(id))
            end
        end
        Wait(60000*7)
    end
end)

local WarM = {}

function Server.WarKillFeed(Killer,Victim,Weapon)
    local KillerState = Player(Killer)["state"]["inWar"]
    local VictimState = Player(Victim)["state"]["inWar"]

    if Player(Killer)["state"]["WarSystem"] then
        return
    end

    if Player(Killer)["state"]["PVP"] then
        return
    end

    if Player(Victim)["state"]["PVP"] then
        return
    end

    if Player(Victim)["state"]["WarSystem"] then
        return
    end
    if KillerState and VictimState then
        if VictimState["group"] ~= KillerState["group"] then
            if KillerState["id"] == VictimState["id"] then
                local Group = KillerState["group"]
                local Passport = vRP.Passport(Killer)
                local Mult = parseInt(WarM[tostring(Passport)]) or 1
                if Mult < 1 then
                    Mult = 1
                end
                if GoingWar[KillerState["id"]] then
                    if GoingWar[KillerState["id"]]["attack"] == Group then
                        GoingWar[KillerState["id"]]["killsAttack"] = GoingWar[KillerState["id"]]["killsAttack"] + 1 * Mult
                    elseif GoingWar[KillerState["id"]]["defense"] == Group then
                        GoingWar[KillerState["id"]]["killsDefense"] = GoingWar[KillerState["id"]]["killsDefense"] + 1 * Mult
                    end
                    vRP.Query("warsystem/UpdateKills",{ id = KillerState["id"], killsAttack = GoingWar[KillerState["id"]]["killsAttack"], killsDefense = GoingWar[KillerState["id"]]["killsDefense"] })
                end
            end
            SendNotifyWar(KillerState["id"])
        end
    end

end

RegisterCommand("startwar",function(source,_)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            TriggerClientEvent("warsystem:OpenWarForm",source)
        end
    end
end)

RegisterCommand("warm",function(source,Args)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",1) then
            WarM[tostring(Passport)] = Args[1]
            TriggerClientEvent("Notify",source,"sucesso","Multiplicador de kills alterado para "..Args[1].."x.",8000)
        end
    end
end)

RegisterCommand("listwar",function(source,_)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Message = ""
            for Id,Info in pairs(GoingWar) do
                Message = Message.."<br><b>Id:</b> "..Id.." <b>Attack:</b> "..Info["attack"].." <b>Defense:</b> "..Info["defense"]
            end
            TriggerClientEvent("Notify2",source,"#ListWar",{ msg = Message })
        end
    end
end)

RegisterCommand("remwar",function(source,_)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keySingle(source,"War ID:")
            if Keyboard and Keyboard[1] then
                local Id = Keyboard[1]
                if EndWar(parseInt(Id)) then
                    TriggerClientEvent("Notify2",source,"#FinishWar")
                else
                    TriggerClientEvent("Notify2",source,"#FinishWarError")
                end
            end
        end
    end
end)