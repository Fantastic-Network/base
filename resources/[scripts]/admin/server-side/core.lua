-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("admin",Creative)
vCLIENT = Tunnel.getInterface("admin")
vKEYBOARD = Tunnel.getInterface("keyboard")
cityName = GetConvar("cityName","Base")
-- local CityRequests = {
--     ["Base"] = "SEU LINK AQUI",
-- }

local Mundos = {
    ["PADRAO"] = 1,
    ["GUERRA"] = 2,
    ["TOXICO"] = 5,
    ["EVENTO"] = 6,
    ["SAFE"] = 7,
    ["DOMINACAO"] = 8,
    ["PRIMARIA"] = 9,
    ["SECUNDARIA"] = 10,
    ["TERCIARIA"] = 11,
    ["INVASAOFUZIL"] = 12
}

local MundoNumber = {
    [1] = "PADRAO",
    [2] = "GUERRA",
    [5] = "TOXICO",
    [6] = "EVENTO",
    [7] = "SAFE",
    [8] = "DOMINACAO",
    [9] = "PRIMARIA",
    [10] = "SECUNDARIA",
    [11] = "TERCIARIA",
    [12] = "INVASAOFUZIL",
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
------------------------------------------------------------------------------------------------------------------------------------------
function getNumberByReason(Reason)
    local Selected = false
    for i = 1,#banConfig["ADV"]["Info"] do
        if Reason == banConfig["ADV"]["Info"][i]["name"] then
            Selected = i
        end
    end
    return Selected
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- RECORD
------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rec",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            vCLIENT.recordingRockstar(source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECORD
------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("vipboost",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            TriggerClientEvent("admin:VIPBoost",source,tonumber(Message[1]))
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECORD
------------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("characters/ChangeId","UPDATE characters SET id = @NewPassport and name = @Name and name2 = @Name2 WHERE id = @Passport")
vRP.Prepare("characters/GetCharacter","SELECT * FROM characters WHERE id = @Passport")
RegisterCommand("changeid",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",1) then
            local Keyboard = vKEYBOARD.keyTriple(source,"Passaporte:","Nome:","Sobrenome:")
            if Keyboard and Keyboard[3] then
                local NewPassport = parseInt(Keyboard[1])
                local Name = Keyboard[2]
                local Name2 = Keyboard[3]
                vRP.Query("characters/ChangeId",{ NewPassport = NewPassport,Name = Name,Name2 = Name2,Passport = Passport })
                Wait(500)
                local Consult = vRP.Query("characters/GetCharacter",{ Passport = NewPassport })
                TriggerClientEvent("Notify",source,"verde","Passaporte alterado para "..NewPassport..".",5000,"CHANGEID")
                local Ped = GetPlayerPed(source)
                local Coords = GetEntityCoords(Ped)
                vRP.CharacterChosen(source,NewPassport,false,Coords,Consult[1])
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- JUMP
------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("jump",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Abuser",1) then
            vCLIENT.superPower(source)
        end
    end
end)

vRP.Prepare("characters/updateBullying","UPDATE characters SET bullying = @bullying WHERE id = @Passport")
RegisterCommand("bullying",function(source,Message)
    Wait(100)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",1) then
            local nSource = vRP.Source(parseInt(Message[1]))
            local License = vRP.Identities(nSource)
            if exports["variables"]:GetLicenses("God")[License] then
                return
            end
            if parseInt(Message[2]) == 1 then
                TriggerClientEvent("admin:bullying2",nSource,true)
            else
                TriggerClientEvent("admin:bullying2",nSource,false)
            end
            vRP.Query("characters/updateBullying",{ bullying = parseInt(Message[2]),Passport = Message[1] })
        end
    end
end)

AddEventHandler("Connect",function(Passport,source)
    local Query = vRP.Query("characters/Person",{ Passport })
    if Query and Query[1] and Query[1]["bullying"] == 1 then
        TriggerClientEvent("admin:bullying2",source,true)
    end
end)
AddEventHandler("Connect",function(Passport,source)
    local License = vRP.Identities(source)
    local Account = vRP.Account(licenseId)
    if Account and Account["id"] then
        if vRP.Banned(Account["id"]) then
            DropPlayer(source,"Você foi banido do(a) "..cityName..". ID: "..account["id"]..".")
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RECORD
------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("mudarnome",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keyTriple(source,"Passaporte:","Nome:","Sobrenome")
            if Keyboard and Keyboard[3] then
                vRP.UpgradeNames(Keyboard[1],Keyboard[2] or " ",Keyboard[3] or " ")
                TriggerClientEvent("Notify",source,"verde","Passaporte atualizado.",5000)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECORD
------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("deathtimer",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            GlobalState["DeathTimer"] = parseInt(Message[1])
            --TriggerClientEvent("Notify",source,"verde","DeathTimer alterado para "..GlobalState["DeathTimer"].." segundos.",5000,"DEATHTIMER")
            TriggerClientEvent("Notify2",source,"#deathTimer",{ Msg = GlobalState["DeathTimer"] })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECORD
------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("peso",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",2) then
            vRP.SetExpWeight(parseInt(Message[1]),parseInt(Message[2]))
            --TriggerClientEvent("Notify",source,"verde","Peso alterado para "..Message[2].." kg.",5000,"PESO")
            TriggerClientEvent("Notify2",source,"#peso",{ Msg = Message[2],Msg2 = Message[1] })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ugroups",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport and parseInt(Message[1]) > 0 then
        local Messages = ""
        local OtherPassport = Message[1]
        if vRP.HasGroup(Passport,"Admin",5) then
            local PlayerGroups = vRP.GetUserGroups(tostring(OtherPassport))
            for Permission,Level in pairs(PlayerGroups) do
                Messages = Messages.."Permissão: "..Permission.." - Level: "..Level.."<br>"
            end
            if Messages ~= "" then
                --TriggerClientEvent("Notify",source,"verde",Messages,10000,"UGROUPS")
                TriggerClientEvent("Notify2",source,"#ugroups",{ Msg = Messages })
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARINV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearinv",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) and parseInt(Message[1]) > 0 then
            --TriggerClientEvent("Notify",source,"verde","Limpeza concluída.",5000,"CLEARINV")
            TriggerClientEvent("Notify2",source,"#clearinv")
            -- exports["vrp"]:SendWebHook("clearinv","**Passaporte:** "..Passport.."\n**Limpou Inventario do Passaport:** "..Message[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
            exports["vrp"]:SendWebHook("clearinv","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Limpou Inventario do Passaport:** "..Message[1].." "..vRP.FullName(Message[1])..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
            vRP.ClearInventory(Message[1])
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARINV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearinvarea",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Range = parseInt(Message[1]) or 10
            local Info = vRPC.ClosestPeds(source,Range)
            for _,Table in pairs(Info) do
                local ClosestPed = parseInt(Table[2])
                local OtherPassport = vRP.Passport(ClosestPed)
                vRP.ClearInventory(OtherPassport)
                exports["vrp"]:SendWebHook("clearinv","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Limpou Inventario do Passaport:** "..OtherPassport.." "..vRP.FullName(OtherPassport)..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
            end
            TriggerClientEvent("Notify2",source,"#clearinv")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gem",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if Message[1] and Message[2] then
            if vRP.HasGroup(Passport,"Admin",1) and parseInt(Message[1]) > 0 and parseInt(Message[2]) > 0 then
                local Amount = parseInt(Message[2])
                local OtherPassport = parseInt(Message[1])
                local License = vRP.License(OtherPassport)
                if License then
                    --TriggerClientEvent("Notify",source,"verde","Diamantes entregues.",5000,"Diamantes")
                    TriggerClientEvent("Notify2",source,"#gem")
                    vRP.Query("accounts/AddGems",{ license = License,gems = Amount })
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local UpdateBlipsTimer = 5 * 1000
local BlipsOn = {}
local CountBlips = 0
local CachedInfo = {}
local NewbiesOn = {}

function round2(num,numDecimalPlaces)
    return tonumber(string.format("%."..(numDecimalPlaces or 0).."f",num))
end

CreateThread(function()
    while true do
        local players = GetPlayers()
        local playersCoords = {}
        local Newbies = {}

        if CountBlips == 0 then
            goto Ignore
        end

        for i = 1,#players do
            local serverId = players[i]
            local playerPed = GetPlayerPed(serverId)
            local Coords = GetEntityCoords(playerPed)
            local Coords = { round2(Coords.x),round2(Coords.y) }
            local Table = { Coords,Player(serverId)["state"]["Blip"] or 57 }
            playersCoords[serverId] = Table
            if Player(serverId)["state"]["Iniciante"] then
                Newbies[serverId] = Table
            end
            if CachedInfo[tonumber(serverId)] then
                local Dist = #(vector2(Coords[1],Coords[2]) - CachedInfo[tonumber(serverId)])
                if Dist < 20 then
                    playersCoords[serverId] = nil
                else
                    CachedInfo[tonumber(serverId)] = vector2(Coords[1],Coords[2])
                end
            else
                CachedInfo[tonumber(serverId)] = vector2(Coords[1],Coords[2])
            end

            for serverId,_ in pairs(Newbies) do
                if not Player(serverId)["state"]["Iniciante"] then
                    Newbies[serverId] = nil
                end
            end
        end

        CreateThread(function()
            for Source,_ in pairs(NewbiesOn) do
                TriggerClientEvent("Blips:Update",Source,Newbies)
            end

            for Source,_ in pairs(BlipsOn) do
                TriggerClientEvent("Blips:Update",Source,playersCoords)
            end
        end)

        ::Ignore::
        Wait(UpdateBlipsTimer)
    end
end)

AddEventHandler("Disconnect",function(Passport,source)
    for Source,_ in pairs(BlipsOn) do
        TriggerClientEvent("Blips:Disconnect",Source,source)
    end
    for Source,_ in pairs(NewbiesOn) do
        TriggerClientEvent("Blips:Disconnect",Source,source)
    end
end)


-- AddEventHandler("Connect",function(Passport,source)
--     local Job,Rank = vRP.UserGroupByType(Passport,'Job')
--     if Job and Rank <= 2 and Job ~= "Iniciante" and Job ~= "Desempregado" then
--         CountBlips = CountBlips + 1
--         NewbiesOn[source] = true
--         TriggerClientEvent("Admin:Blips",source,true)
--         GetPlayersBlips(source,true)
--     end
-- end)

function GetPlayersBlips(Source,Rec)
    local players = GetPlayers()
    local playersCoords = {}
    local Newbies = {}

    for i = 1,#players do
        local serverId = players[i]
        local playerPed = GetPlayerPed(serverId)
        local Coords = GetEntityCoords(playerPed)
        local Coords = { round2(Coords.x),round2(Coords.y) }
        local Table = { Coords,Player(serverId)["state"]["Blip"] or 57 }
        playersCoords[serverId] = Table

        if Player(serverId)["state"]["Iniciante"] then
            Newbies[serverId] = Table
        end
    end

    if Rec then
        TriggerClientEvent("Blips:Update",Source,Newbies)
    else
        TriggerClientEvent("Blips:Update",Source,playersCoords)
    end
end

RegisterCommand("blips2",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        local Job,Rank = vRP.UserGroupByType(Passport,"Job")
        if Rank <= 2 and Job ~= "Iniciante" and Job ~= "Desempregado" then
            if not NewbiesOn[source] then
                CountBlips = CountBlips + 1
                NewbiesOn[source] = true
                TriggerClientEvent("Admin:Blips",source,true)
                GetPlayersBlips(source,true)
            else
                CountBlips = CountBlips - 1
                NewbiesOn[source] = nil
                TriggerClientEvent("Admin:Blips",source,false)
            end
            TriggerEvent("player:Blips",source)
            --vRPC.BlipAdmin(source)
        end
    end
end)

RegisterCommand("blips",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",2) then
            if not BlipsOn[source] then
                CountBlips = CountBlips + 1
                BlipsOn[source] = true
                TriggerClientEvent("Admin:Blips",source,true)
                GetPlayersBlips(source)
            else
                CountBlips = CountBlips - 1
                BlipsOn[source] = nil
                TriggerClientEvent("Admin:Blips",source,false)
            end
            TriggerEvent("player:Blips",source)
            --vRPC.BlipAdmin(source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROMOTER-SCORE
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("nps",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",1) then
            TriggerClientEvent("promoter_score:Open",-1)
        end
    end
end)
RegisterCommand("createobject",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            GlobalState["CreateObject"] = not GlobalState["CreateObject"]
            if GlobalState["CreateObject"] then
                TriggerClientEvent("Notify",source,"verde","Você ativou a criação de objetos.",5000,"CREATEOBJECT")
            else
                TriggerClientEvent("Notify",source,"vermelho","Você desativou a criação de objetos.",5000,"CREATEOBJECT")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god",function(source,Message)
    local Passport = vRP.Passport(source)
    local Ped = GetPlayerPed(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",5) or vRP.HasGroup(Passport,"Influenciador") or vRP.HasGroup(Passport,"Aliado") or vRP.HasGroup(Passport,"InfluenciadorVerificado",5) or vRP.HasGroup(Passport,"QA") then
            if Message[1] then
                local OtherPassport = parseInt(Message[1])
                local ClosestPed = vRP.Source(OtherPassport)
                local Ped = GetPlayerPed(ClosestPed)
                local Coords = GetEntityCoords(Ped)
                if ClosestPed and OtherPassport then
                    --if GlobalState["Hunger"] then
                    vRP.UpgradeThirst(OtherPassport,100)
                    vRP.UpgradeHunger(OtherPassport,100)
                    --end
                    vRP.Revive(ClosestPed,400)
                    if IsEntityVisible(Ped) then
                        TriggerClientEvent("admin:Piscar",ClosestPed)
                    end

                    if Message[2] and Message[2] == "p" then
                        vRP.Teleport(ClosestPed,-1607.34,-1054.58,13.02,323.15)
                    end

                    if Message[2] and Message[2] == "hp" then
                        vRP.Teleport(ClosestPed,1151.94,-1527.99,34.93,331.66)
                    end

                    if Message[2] and Message[2] == "dp" then
                        vRP.Teleport(ClosestPed,2507.73,-384.92,94.12,272.13)
                    end

                    if Message[2] and Message[2] == "pn" then
                        vRP.Teleport(ClosestPed,1426.48,6527.89,18.53,0.0)
                    end

                    if Message[2] and Message[2] == "praca" then
                        vRP.Teleport(ClosestPed,193.1,-936.63,30.68,158.75)
                    end

                    -- if Message[2] and Message[2] == "ch" then
                    -- 	vRP.Teleport(ClosestPed,501.59,5604.47,797.91,300.48)
                    -- end
                    local Name1 = vRP.FullName(Passport) or "Desconhecido"
                    local Name2 = vRP.FullName(OtherPassport) or "Desconhecido"
                    local Local = Message[2] or "Desconhecido"
                    -- exports["vrp"]:SendWebHook("god","\n**Passaporte:** "..Passport.."\n**Deu god no passaporte:** "..OtherPassport.."\n**Cds:** "..Coords.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),2123412)
                    exports["vrp"]:SendWebHook("god","**Passaporte:** "..Passport.." "..Name1.."\n**Deu god no passaporte:** "..OtherPassport.." "..Name2.."\n**Local:** "..Local.."\n**Cds:** "..Coords..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187,{ Passport,OtherPassport })
                end
            else
                vRP.Revive(source,400,true)
                --if GlobalState["Hunger"] then
                vRP.UpgradeThirst(Passport,100)
                vRP.UpgradeHunger(Passport,100)
                --end
                local Ped = GetPlayerPed(source)
                local Coords = GetEntityCoords(Ped)
                -- exports["vrp"]:SendWebHook("god","\n**Passaporte:** "..Passport.." **Se deu god** \n**Cds:** "..Coords.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),3447003)
                exports["vrp"]:SendWebHook("god","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Se deu god:**  "..Coords.." "..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187,{ Passport,OtherPassport })
                TriggerClientEvent("paramedic:Reset",source)
                if IsEntityVisible(Ped) then
                    TriggerClientEvent("admin:Piscar",source)
                end

                vRPC.DestroyObjects(source)
            end
        end
    end
end)

RegisterCommand("pnort",function(source,Message)
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Admin",3) then
        local Range = parseInt(Message[1]) or 10
        local Info = vRPC.ClosestPeds(source,Range)
        for _,Table in pairs(Info) do
            local ClosestPed = parseInt(Table[2])
            local OtherPassport = vRP.Passport(ClosestPed)
            local Ped = GetPlayerPed(ClosestPed)
            vRP.Revive(ClosestPed,400)
            vRP.Teleport(ClosestPed,1426.48,6527.89,18.53,0.0)
        end
    end
end)

RegisterCommand("psul",function(source,Message)
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Admin",4) then
        local Range = parseInt(Message[1]) or 10
        local Info = vRPC.ClosestPeds(source,Range)
        for _,Table in pairs(Info) do
            local ClosestPed = parseInt(Table[2])
            local OtherPassport = vRP.Passport(ClosestPed)
            local Ped = GetPlayerPed(ClosestPed)
            vRP.Revive(ClosestPed,400)
            vRP.Teleport(ClosestPed,-1607.34,-1054.57,13.02,297.64)
        end
    end
end)

RegisterCommand("death",function(source,Message)
    local Passport = vRP.Passport(source)
    local Ped = GetPlayerPed(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",1) then
            if Message[1] then
                local OtherPassport = parseInt(Message[1])
                local ClosestPed = vRP.Source(OtherPassport)
                local Ped = GetPlayerPed(ClosestPed)
                local Coords = GetEntityCoords(Ped)
                if ClosestPed and OtherPassport then
                    vRP.Revive(ClosestPed,100)
                    local Local = Message[2] or "Desconhecido"
                end
            end
        end
    end
end)

RegisterCommand("deatharea",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",1) then
            local Range = parseInt(Message[1]) or 10
            local Info = vRPC.ClosestPeds(source,Range)
            for _,Table in pairs(Info) do
                async(function()
                    local ClosestPed = parseInt(Table[2])
                    vRP.Revive(ClosestPed,100)
                end)
            end
        end
    end
end)


RegisterCommand("freezearea",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",1) then
            local Range = parseInt(Message[1]) or 10
            local Info = vRPC.ClosestPeds(source,Range)
            for _,Table in pairs(Info) do
                async(function()
                    local ClosestPed = parseInt(Table[2])
                    TriggerClientEvent("SetFreeze",ClosestPed)
                end)
            end
        end
    end
end)

RegisterCommand("remfreezearea",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",1) then
            local Range = parseInt(Message[1]) or 10
            local Info = vRPC.ClosestPeds(source,Range)
            for _,Table in pairs(Info) do
                async(function()
                    local ClosestPed = parseInt(Table[2])
                    TriggerClientEvent("RemFreeze",ClosestPed)
                end)
            end
        end
    end
end)

RegisterCommand("godarea",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Range = parseInt(Message[1]) or 10
            local Info = vRPC.ClosestPeds(source,Range)
            for _,Table in pairs(Info) do
                async(function()
                    local ClosestPed = parseInt(Table[2])
                    local OtherPassport = vRP.Passport(ClosestPed)
                    local Ped = GetPlayerPed(ClosestPed)
                    local Coords = GetEntityCoords(Ped)
                    --if GlobalState["Hunger"] then
                    vRP.UpgradeThirst(OtherPassport,100)
                    vRP.UpgradeHunger(OtherPassport,100)
                    --end
                    vRP.Revive(ClosestPed,400)
                    if IsEntityVisible(Ped) then
                        TriggerClientEvent("admin:Piscar",ClosestPed)
                    end
                    exports["vrp"]:SendWebHook("god","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Deu god area:** "..Coords.." "..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
                end)
            end
        end
    end
end)

RegisterCommand("godmode",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if (vRP.HasGroup(Passport,"Abuser",1) or vRP.HasGroup(Passport,"Wallg",1)) then
            TriggerClientEvent("admin:GodMode",source)
        end
    end
end)

local Blockitens = {
    ["premium01"] = true,
    ["premium02"] = true,
    ["premium03"] = true,
    ["premium04"] = true,
    ["premium05"] = true,
    ["vipsorteio"] = true,
    ["gemstone"] = true,
    ["premiumplate"] = true,
    ["phonechange"] = true,
    ["newchars"] = true,
    ["creditcard"] = true,
    ["vehkey"] = true,
    ["propertys"] = true,
    ["money1"] = true,
    ["money2"] = true,
    ["money3"] = true,
    ["money4"] = true,
    ["money5"] = true,
    ["packbasic"] = true,
    ["packelite"] = true,
    ["packpremium"] = true,
    ["kitfogueteiro"] = true,
    ["kitcriminal"] = true,
    ["kitmafioso"] = true,
    ["kitdosraul"] = true,
    ["kitboqueta"] = true,
    ["dollars"] = true,
    ["dinheirosujo"] = true,
    ["WEAPON_GRENADELAUNCHER"] = true,
    ["WEAPON_HOMINGLAUNCHER"] = true,
    ["WEAPON_RAILGUN"] = true,
    ["WEAPON_RPG"] = true,
    ["WEAPON_RPG_AMMO"] = true,
    ["WEAPON_RAYPISTOL"] = true,
    ["WEAPON_RAYCARBINE"] = true,
    ["WEAPON_RAYMINIGUN"] = true,
    ["rolepass"] = true
}

RegisterCommand("itemarea",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        local Keyboard = vKEYBOARD.keyDouble(source,"Item:","Quantidade:")
        if Keyboard and Keyboard[1] and Keyboard[2] then
            if vRP.HasGroup(Passport,"Admin",3) then
                if not Blockitens[Keyboard[1]] then
                    local Range = parseInt(Message[1]) or 10
                    local Info = vRPC.ClosestPeds(source,Range)
                    for _,Table in pairs(Info) do
                        local ClosestPed = parseInt(Table[2])
                        local OtherPassport = vRP.Passport(ClosestPed)
                        local Ped = GetPlayerPed(source)
                        local Coords = GetEntityCoords(Ped)
                        vRP.GenerateItem(OtherPassport,Keyboard[1],parseInt(Keyboard[2]),true,false,"ItemCMD",OtherPassport)
                        exports["vrp"]:SendWebHook("item","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Deu item area:** "..Keyboard[1].." \n**Quem recebeu:** "..OtherPassport.." \n**Quantidade:** "..Keyboard[2].."\n**Distancia:** "..Range.."\n**Local:** "..Coords.." "..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local Block = {
    ["premium01"] = true,
    ["premium02"] = true,
    ["premium03"] = true,
    ["premium04"] = true,
    ["premium05"] = true,
    ["vipsorteio"] = true,
    ["gemstone"] = true,
    ["premiumplate"] = true,
    ["phonechange"] = true,
    ["newchars"] = true,
    ["creditcard"] = true,
    ["vehkey"] = true,
    ["propertys"] = true,
    ["money1"] = true,
    ["money2"] = true,
    ["money3"] = true,
    ["money4"] = true,
    ["money5"] = true,
    ["packbasic"] = true,
    ["packelite"] = true,
    ["packpremium"] = true,
    ["kitfogueteiro"] = true,
    ["kitcriminal"] = true,
    ["kitmafioso"] = true,
    ["kitdosraul"] = true,
    ["kitboqueta"] = true,
    ["dollars"] = true,
    ["dinheirosujo"] = true,
    ["WEAPON_GRENADELAUNCHER"] = true,
    ["WEAPON_HOMINGLAUNCHER"] = true,
    ["WEAPON_RAILGUN"] = true,
    ["WEAPON_RPG"] = true,
    ["WEAPON_RPG_AMMO"] = true,
    ["WEAPON_RAYPISTOL"] = true,
    ["WEAPON_RAYCARBINE"] = true,
    ["WEAPON_RAYMINIGUN"] = true,
    ["rolepass"] = true
}
local Zaralho = {
    ["WEAPON_GRENADELAUNCHER"] = true,
    ["WEAPON_HOMINGLAUNCHER"] = true,
    ["WEAPON_RAILGUN"] = true,
    ["WEAPON_RPG"] = true,
    ["WEAPON_RPG_AMMO"] = true,
    ["WEAPON_RAYPISTOL"] = true,
    ["WEAPON_RAYCARBINE"] = true,
    ["WEAPON_RAYMINIGUN"] = true,
}

RegisterCommand("item",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Number = vRP.HasPermission(Passport,"Admin")
            if Block[Message[1]] and Number ~= 1 then
                return
            end

            if Zaralho[Message[1]] and Number ~= 1 then
                return
            end

            if Message[1] and Message[2] and itemBody(Message[1]) ~= nil then
                vRP.GenerateItem(Passport,Message[1],parseInt(Message[2]),true,false,"ItemCMD",Passport)
                -- exports["vrp"]:SendWebHook("item","**Passaporte:** "..Passport.."\n**Puxou:** "..Message[2].." "..Message[1].."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),3426654)
                exports["vrp"]:SendWebHook("item","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Puxou Item:** "..Message[2].." "..Message[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187,{ Passport })
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item2",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport and Message[1] and Message[2] and Message[3] and itemBody(Message[1]) then
        if vRP.HasGroup(Passport,"Admin",3) then
            if not Zaralho[Message[1]] then
                local Number = vRP.HasPermission(Passport,"Admin")
                if Block[Message[1]] and Number ~= 1 then
                    return
                end

                vRP.GenerateItem(parseInt(Message[3]),Message[1],Message[2],true,false,"Item2CMD",Passport)
                --TriggerClientEvent("Notify",source,"verde","Você setou <b>"..Message[2].."x "..Message[1].."</b> no passaporte <b>"..Message[3].."</b>.",5000,"item2")
                TriggerClientEvent("Notify2",source,"#item2",{ msg = Message[2],msg2 = Message[1],msg3 = Message[3] })
                exports["vrp"]:SendWebHook("item","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n** Setou item no Passaport:** "..Message[3].." "..vRP.FullName(Message[3]).."\n** Item:** "..Message[1].."\n**Quantidade:** "..Message[2]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187,{ Passport,Message[3] })
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("world",function(source,Message)
    -- --TriggerClientEvent("Notify",source,"verde","Mundo: <b>"..GetPlayerRoutingBucket(source).."</b>.",5000,"MUNDO")
    -- TriggerClientEvent("Notify2",source,"#world",{msg=GetPlayerRoutingBucket(source)})
    Wait(1)

    print(GetPlayerRoutingBucket(source))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delete",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport and Message[1] then
        if vRP.HasGroup(Passport,"Admin",2) then
            local OtherPassport = parseInt(Message[1])
            vRP.Query("characters/removeCharacter",{ id = OtherPassport })
            --TriggerClientEvent("Notify",source,"verde","Personagem <b>"..OtherPassport.."</b> deletado.",5000,"Delete")
            TriggerClientEvent("Notify2",source,"#delete",{ msg = OtherPassport })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function Players3()
    local Groups = vRP.Groups()
    local Message = ""
    for Group,Info in spairs(Groups) do
        if Info["Type"] == "Staff" or Info["Type"] == "Job" then
            local _,Count = vRP.NumPermission(Group)
            Count = Count or 0
            Message = Message..""..Group.." - "..Count.."\n"
        end
    end
    exports["vrp"]:SendWebHook("Players3",Message,9317187)
end

RegisterCommand("players3",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",2) then
            Players3()
        end
    end
end)

local Players3Timers = { "20:30","21:00","21:30","22:00" }
local DonePlayers3 = {}
CreateThread(function()
    while true do
        local Time = os.date("%H:%M")
        for i = 1,#Players3Timers do
            if Time == Players3Timers[i] and not DonePlayers3[i] then
                Players3()
                DonePlayers3[i] = true
            end
        end
        if os.date("%H:%M") == "00:00" then
            vRP.Query("accounts/updateWhitelist",{ id = 0 })
        end
        Wait(10000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WHITELIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wl",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport and Message[1] then
        if vRP.HasGroup(Passport,"Admin",5) then
            vRP.Query("accounts/updateWhitelist",{ id = parseInt(Message[1]) })
            --TriggerClientEvent("Notify",source,"verde","WHITELIST PARA A LICENCA <b>"..Message[1].."</b>.",5000,"WHITELIST")
            TriggerClientEvent("Notify2",source,"#wl",{ msg = Message[1] })
            exports["vrp"]:SendWebHook("wl","**Passaporte:** "..Passport.."\n**Deu wl:** "..Message[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WHITELIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unwl",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport and Message[1] then
        if vRP.HasGroup(Passport,"Admin",5) then
            local OtherPassport = parseInt(Message[1])
            local License = vRP.License(OtherPassport)
            local Account = vRP.Account(License)
            vRP.Query("accounts/removeWhitelist",{ id = parseInt(Account["id"]) })
            --TriggerClientEvent("Notify",source,"verde","REMOVIDO WHITELIST PARA A ID <b>"..Message[1].."</b>.",5000,"WHITELIST")
            TriggerClientEvent("Notify2",source,"#unwl",{ msg = Message[1] })
            exports["vrp"]:SendWebHook("wl","**Passaporte:** "..Passport.."\n**Removeu wl:** "..Message[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("debug",function(source,args,rawCommand)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",5) then
            TriggerClientEvent("ToggleDebug",source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("nc",function(source)
    local Passport = vRP.Passport(source)
    local Ped = GetPlayerPed(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",5) or vRP.HasGroup(Passport,"Influenciador") or vRP.HasGroup(Passport,"Aliado") or vRP.HasGroup(Passport,"InfluenciadorVerificado",5) or vRP.HasGroup(Passport,"QA") then
            local Coords = GetEntityCoords(Ped)
            vRPC.noClip(source)
            -- exports["vrp"]:SendWebHook("noclip","**Passaporte:** "..Passport.. " **Deu nc** \n**Cds** "..Coords.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
            exports["vrp"]:SendWebHook("noclip","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Deu nc:** "..Coords.." "..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187,{ Passport })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SOLTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("soltar",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            TriggerEvent("mdt:RemovePrison",parseInt(Message[1]))
            --TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..Message[1].."</b> solto.",5000,"PRISAO")
            TriggerClientEvent("Notify2",source,"#soltar",{ msg = Message[1] })
            -- exports["vrp"]:SendWebHook("remprisao","**Passaporte:** "..Passport.. "\n**Tirou Passaporte:** "..Message[1].. " **da prisão**\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)

            exports["vrp"]:SendWebHook("remprisao","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Tirou Passaporte:** "..Message[1].." "..vRP.FullName(Message[1]).."** da Prisão**"..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187,{ Passport })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,args)
    local Passport = vRP.Passport(source)

    -- Verifica se o usuário tem as permissões necessárias para usar o comando
    if not Passport or not vRP.HasGroup(Passport,"Admin",5 or "Aliado",1) or not tonumber(args[1]) then
        return
    end

    local targetId = tonumber(args[1])
    local target = vRP.Source(targetId)
    local License = vRP.Identities(target)
    if target then
        if not exports["variables"]:GetLicenses("God")[License] then
            vRP.Kick(target,"Expulso da cidade.")

            --TriggerClientEvent("Notify", source, "amarelo", "Passaporte <b>" .. targetId .. "</b> expulso.", 5000, "Kick")
            TriggerClientEvent("Notify2",source,"#kick",{ msg = targetId })
            -- exports["vrp"]:SendWebHook("kick", "**Passaporte:** " .. Passport .. "\n**Deu kick no id:** " .. targetId .. "\n**Data:** " .. os.date("%d/%m/%Y - %H:%M:%S"))
            exports["vrp"]:SendWebHook("kick","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Deu kick no id:** "..targetId.." "..vRP.FullName(args[1])..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187,{ Passport,targetId })
        else
            vRP.Kick(source,"Você realmente tentou kickar um DEUS? MAIS RESPEITO MERO MORTAL.")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kicksource",function(source,args)
    local Passport = vRP.Passport(source)

    -- Verifica se o usuário tem as permissões necessárias para usar o comando
    if not Passport or not vRP.HasGroup(Passport,"Admin",5) or vRP.HasGroup(Passport,"Aliado") or not tonumber(args[1]) then
        return
    end

    local targetId = tonumber(args[1])

    if targetId then
        vRP.Kick(targetId,"Expulso da cidade.")

        --TriggerClientEvent("Notify", source, "amarelo", "Source <b>" .. targetId .. "</b> expulso.", 5000, "Kick")
        TriggerClientEvent("Notify2",source,"#kicksource",{ msg = targetId })
        exports["vrp"]:SendWebHook("kick","**Passaporte:** "..Passport.."\n**Deu kick no Source:** "..targetId.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,args,rawCommand)
    local Passport = vRP.Passport(source)

    -- Verifica se o usuário tem as permissões necessárias para usar o comando
    if not Passport or not vRP.HasGroup(Passport,"Admin",4) or not tonumber(args[1]) then
        return
    end

    local targetId = tonumber(args[1])

    -- Abre o menu de banimento para o usuário-alvo
    TriggerClientEvent("admin:OpenBanMenu",source,"BAN",targetId)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("adv",function(source,args,rawCommand)
    local Passport = vRP.Passport(source)
    if Passport and vRP.HasGroup(Passport,"Admin",4) and parseInt(args[1]) > 0 then
        TriggerClientEvent("admin:OpenBanMenu",source,"ADV",args[1])
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADV
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.applyBan(nuser_id,reason,days,mode,text)
    local source = source
    local Passport = vRP.Passport(source)
    local banMode = "Advertido"
    if mode == "BAN" then
        banMode = "Banido"
    end
    if Passport then
        if vRP.HasGroup(Passport,"Admin",4) then
            nuser_id = parseInt(nuser_id)
            local identity = vRP.Identity(nuser_id)
            local adminIdentity = vRP.Identity(Passport)
            local AdminAccount = vRP.Account(adminIdentity["license"])
            if identity then
                if days == "99999" then
                    local OtherPassport = parseInt(nuser_id)
                    local Identity = vRP.Identity(OtherPassport)
                    if Identity then
                        local Account = vRP.Account(Identity["license"])
                        local OtherSource = vRP.Source(OtherPassport)
                        if exports["variables"]:GetLicenses("God")[Identity["license"]] then
                            vRP.Kick(source,"Você realmente tentou banir um DEUS? MAIS RESPEITO MERO MORTAL.")
                            return
                        end
                        if OtherSource then
                            vRP.Kick(OtherSource,"Banido.")
                        end


                        vRP.Query("banneds/InsertBanned",{ accountId = Account["id"],reason = reason })
                        --TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..OtherPassport.."</b> banido.",5000)
                        TriggerClientEvent("Notify2",source,"#applyBan",{ msg = OtherPassport })
                        -- exports["vrp"]:SendWebHook("ban","**Passaporte:** "..Passport.."\n**Ban:** "..nuser_id.."\n**Account id:** "..Account["id"].."\n**Motivo:** "..reason.."\n**Seleção:** "..text.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
                        exports["vrp"]:SendWebHook("ban","**Aplicou:** "..AdminAccount["discord"].."\n**Recebeu:** "..Account["discord"].."\n**Account id:** "..Account["id"].."\n\n**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Ban:** "..nuser_id.." "..vRP.FullName(nuser_id).."\n**Account id:** "..Account["id"].."\n**Motivo:** "..reason.."\n**Seleção:** "..text.." "..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
                        -- PerformHttpRequest("linkbot",function(err,text,headers)
                        -- end,"POST",
                        -- json.encode({
                        --     { isBanned = true, user = nuser_id, userDiscord = Account["discord"], reason = reason, days = days, admin = Passport, adminDiscord = AdminAccount["discord"] }
                        -- }),{ ["Content-Type"] = "application/json" })

                        -- PerformHttpRequest(CityRequests[cityName],function(err,text,headers)
                        -- end,"POST",
                        -- json.encode({
                        --     city = cityName,
                        --     user = nuser_id,
                        --     userDiscord = Account["discord"],
                        --     userAccount = Account["id"],
                        --     motivo = reason,
                        --     admin = Passport,
                        --     adminDiscord = AdminAccount["discord"],
                        --     adminAccount = AdminAccount["id"],
                        --     type = "add",
                        --     isBanned = true,
                        -- }),{ ["Content-Type"] = "application/json" })

                        --if LicenseGlobal[adminIdentity["license"]] then
                        -- PerformHttpRequest("linkglobal",function(err,text,headers)
                        -- end,"POST",
                        -- json.encode({
                        --     { license = Identity["license"], reason = reason }
                        -- }),{ ["Content-Type"] = "application/json" })
                        --end

                        local Custom = {
                            background = "rgba(255, 0, 0,.55)",
                        }
                        TriggerClientEvent("chat:ClientMessage",-1,"ID: ","["..nuser_id.."] "..identity["name"].." "..identity["name2"].." foi banido. Motivo: "..text.." Descrição: "..reason.." Banido por : "..Passport.." | "..vRP.FullName(Passport),"🚫Banimento",false,Custom)
                    end
                else
                    local identity = vRP.Identity(nuser_id)
                    local Account = vRP.Account(identity["license"])
                    local Selected = getNumberByReason(reason)
                    if exports["variables"]:GetLicenses("God")[identity["license"]] then
                        vRP.Kick(source,"Você realmente tentou banir um DEUS? MAIS RESPEITO MERO MORTAL.")
                        return
                    end
                    if Selected then
                        vRP.RemoveBank(nuser_id,banConfig["ADV"]["Info"][Selected]["fine"])
                    end
                    vRP.Query("temporary_banneds/addBanned",{ id = Account["id"],time = days,reason = reason,Admin = Passport })
                    --TriggerClientEvent("Notify",source,"aviso","Passaporte <b>"..nuser_id.."</b> <b>"..banMode.."</b> Motivo: "..reason,5000,"BAN")
                    TriggerClientEvent("Notify2",source,"#apllyAdv",{ msg = nuser_id,msg2 = banMode,msg3 = reason })
                    vRP.SetTemporaryBan(Account["id"],nuser_id)
                    exports["vrp"]:SendWebHook("adv","**Aplicou:** "..AdminAccount["discord"].."\n**Recebeu:** "..Account["discord"].."\n**Account id:** "..Account["id"].."\n\n**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Deu adv:** "..nuser_id.." "..vRP.FullName(nuser_id).."\n**Account id:** "..Account["id"].."\n**Motivo:** "..reason.."\n**Seleção:** "..text..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)

                    -- PerformHttpRequest(CityRequests[cityName],function(err,text,headers)
                    -- end,"POST",
                    -- json.encode({
                    --     city = cityName,
                    --     user = nuser_id,
                    --     userDiscord = Account["discord"],
                    --     userAccount = Account["id"],
                    --     motivo = reason,
                    --     admin = Passport,
                    --     adminDiscord = AdminAccount["discord"],
                    --     adminAccount = AdminAccount["id"],
                    --     type = "add",
                    --     isBanned = false,
                    -- }),{ ["Content-Type"] = "application/json" })


                    local Custom = {
                        background = "rgba(255, 0, 0,.55)",
                    }
                    TriggerClientEvent("chat:ClientMessage",-1,"ID: [",nuser_id.."] "..identity["name"].." "..identity["name2"].." foi advertido por: "..days.." minutos. Motivo: "..text.." Descrição: "..reason.." advertido por : "..Passport.." | "..vRP.FullName(Passport),"🚫Advertencia",false,Custom)
                    local Amount = parseInt(identity["economy"] * 0.20)
                    if Amount < 1000000 then
                        Amount = 1000000
                    end
                    local Bank = vRP.GetBank(source)
                    if Bank and Bank < Amount then
                        Amount = Bank
                    end
                    exports["bank"]:AddTransactions(nuser_id,"exit",Amount)
                    vRP.RemoveBank(nuser_id,Amount,true)
                end
            end
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source,args,rawCommand)
    local Passport = vRP.Passport(source)

    if Passport and vRP.HasGroup(Passport,"Admin",3) and tonumber(args[1]) > 0 then
        local OtherPassport = tonumber(args[1])
        local Identity = vRP.Identity(OtherPassport)
        local AdminIdentity = vRP.Identity(Passport)

        if Identity then
            local Account = vRP.Account(Identity["license"])
            local AdminAccount = vRP.Account(AdminIdentity["license"])
            vRP.Query("banneds/RemoveBanned",{ accountId = Account["id"] })
            --TriggerClientEvent("Notify", source, "verde", "Passaporte <b>"..OtherPassport.."</b> desbanido.", 5000, "BAN")
            TriggerClientEvent("Notify2",source,"#unban",{ msg = OtherPassport })
            -- exports["vrp"]:SendWebHook("ban", "**Passaporte:** "..Passport.."\n**Retirou ban:** "..OtherPassport.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"), 10038562)
            exports["vrp"]:SendWebHook("unban","**Removeu:** "..AdminAccount["discord"].."\n**Recebeu:** "..Account["discord"].."\n**Account id:** "..Account["id"].."\n\n**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Retirou ban:** "..OtherPassport.." "..vRP.FullName(args[1])..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
            -- PerformHttpRequest(CityRequests[cityName],function(err,text,headers)
            -- end,"POST",
            -- json.encode({
            --     city = cityName,
            --     user = nuser_id,
            --     userDiscord = Account["discord"],
            --     userAccount = Account["id"],
            --     motivo = reason,
            --     admin = Passport,
            --     adminDiscord = AdminAccount["discord"],
            --     adminAccount = AdminAccount["id"],
            --     type = "rem",
            --     isBanned = true,
            -- }),{ ["Content-Type"] = "application/json" })
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- remadv
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("remadv",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) and parseInt(Message[1]) > 0 then
            local OtherPassport = parseInt(Message[1])
            local Identity = vRP.Identity(OtherPassport)
            local adminIdentity = vRP.Identity(Passport)
            if Identity then
                local Account = vRP.Account(Identity["license"])
                local Source = vRP.Source(OtherPassport)
                local AdminAccount = vRP.Account(adminIdentity["license"])
                --TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..OtherPassport.."</b> adv removida.",5000,"BAN")
                TriggerClientEvent("Notify2",source,"#remadv",{ msg = OtherPassport })
                vRP.Query("temporary_banneds/deleteBanned",{ id = Account["id"] })
                vRP.ResetTemporaryBanneds(Account["id"],OtherPassport)
                exports["vrp"]:SendWebHook("remadv","**Removeu:** "..AdminAccount["discord"].."\n**Recebeu:** "..Account["discord"].."\n**Account id:** "..Account["id"].."\n\n**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Retirou adv:** "..OtherPassport.." "..vRP.FullName(OtherPassport).." "..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187,{ Passport })

                -- PerformHttpRequest(CityRequests[cityName],function(err,text,headers)
                -- end,"POST",
                -- json.encode({
                --     city = cityName,
                --     user = OtherPassport,
                --     userDiscord = Account["discord"],
                --     motivo = reason,
                --     admin = Passport,
                --     adminDiscord = AdminAccount["discord"],
                --     type = "rem",
                --     isBanned = false,
                -- }),{ ["Content-Type"] = "application/json" })

                if Source then
                    TriggerClientEvent("temp_banned:Rem",Source)
                end
            end
        end
    end
end)

function RemAdv(OtherPassport)
    local Identity = vRP.Identity(OtherPassport)
    if Identity then
        local Account = vRP.Account(Identity["license"])
        local Source = vRP.Source(OtherPassport)
        vRP.Query("temporary_banneds/deleteBanned",{ id = Account["id"] })
        vRP.ResetTemporaryBanneds(Account["id"],OtherPassport)
        if Source then
            TriggerClientEvent("temp_banned:Rem",Source)
        end
    end
end

function RemBan(Passport)
    local Identity = vRP.Identity(Passport)
    if Identity then
        local Account = vRP.Account(Identity["license"])
        vRP.Query("banneds/RemoveBanned",{ accountId = Account["id"] })
        vRP.Query("temporary_banneds/deleteBanned",{ id = Account["id"] })
        vRP.ResetTemporaryBanneds(Account["id"],Passport)
        TriggerClientEvent("Notify2",source,"#AdminUnban",{ msg = Passaport })
        if Source then
            TriggerClientEvent("temp_banned:Rem",Source)
        end
    end
end

exports("RemAdv",RemAdv)
exports("RemBan",RemBan)
-----------------------------------------------------------------------------------------------------------------------------------------
--

-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Admin:Unban",function(Source)
    local Passport = vRP.Passport(Source)
    local Identity = vRP.Identity(Passport)
    if Identity then
        local Account = vRP.Account(Identity["license"])
        vRP.Query("banneds/RemoveBanned",{ accountId = Account["id"] })
        vRP.Query("temporary_banneds/deleteBanned",{ id = Account["id"] })
        vRP.ResetTemporaryBanneds(Account["id"],Passport)
        --TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..Passport.."</b> desbanido.",5000,"BAN")
        TriggerClientEvent("Notify2",source,"#AdminUnban",{ msg = Passaport })
        if Source then
            TriggerClientEvent("temp_banned:Rem",Source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unbanid",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) and parseInt(Message[1]) > 0 then
            local adminIdentity = vRP.Identity(Passport)
            local AdminAccount = vRP.Account(adminIdentity["license"])
            vRP.Query("banneds/RemoveBanned",{ accountId = parseInt(Message[1]) })
            local Discord = vRP.Query("accounts/GetDiscord",{ accountId = parseInt(Message[1]) })
            --TriggerClientEvent("Notify",source,"verde","Id conta <b>"..Message[1].."</b> desbanido.",5000,"BAN")
            TriggerClientEvent("Notify2",source,"#unbanid",{ msg = Message[1] })
            -- exports["vrp"]:SendWebHook("ban","**Passaporte:** "..Passport.."\n**Retirou ban:** "..parseInt(Message[1]).."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),10038562)
            exports["vrp"]:SendWebHook("unban","**Removeu:** "..AdminAccount["discord"].."\n**Recebeu:** "..Discord[1]["discord"].."\n**Account id:** "..parseInt(Message[1]).."\n\n**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Retirou ban da conta:** "..Message[1].." "..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
local Speech = {}
RegisterCommand("speech",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            if not Speech[Passport] then
                TriggerClientEvent("PMA:ProximityOverride",source,4)
                Speech[Passport] = true
                TriggerClientEvent("Notify",source,"verde","Speech ativado.",5000,"SPEECH")
            else
                TriggerClientEvent("PMA:ProximityOverride",source,1)
                Speech[Passport] = nil
                TriggerClientEvent("Notify",source,"vermelho","Speech desativado.",5000,"SPEECH")
            end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- APAGAO
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("apagao",function(source,args,rawCommand)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            TriggerClientEvent("SetBlackout",-1,parseInt(args[1]))
            GlobalState["Blackout"] = parseInt(args[1])
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("bansource",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",4) and parseInt(Message[1]) > 0 then
            local OtherSource = parseInt(Message[1])
            local License = vRP.Identities(OtherSource)
            if License then
                local Account = vRP.Account(License)
                vRP.Query("banneds/InsertBanned",{ accountId = Account["id"],reason = "U are banned my brotha" })
                TriggerClientEvent("Notify2",source,"#bansource",{ msg = OtherSource })
                exports["vrp"]:SendWebHook("ban","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Baniu pela source o Account id:** "..Account["id"].."\n**Source:** "..OtherSource..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
                vRP.Kick(OtherSource,"Banido.")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addslot",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",2) and parseInt(Message[1]) > 0 then
            local Identity = vRP.Identity(parseInt(Message[1]))
            if Identity then
                vRP.Query("accounts/infosUpdatechars",{ license = Identity["license"] })
                --TriggerClientEvent("Notify",source,"amarelo","Voce aumentou os slots de personagem do Passaporte <b>"..Message[1].."</b>.",5000,"SLOTS")
                TriggerClientEvent("Notify2",source,"#addslot",{ msg = Message[1] })
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOKEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("token",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        local License = vRP.Identities(source)
        if License then
            local Account = vRP.Account(License)
            if Account["token"] then
                TriggerClientEvent("Announce",source,"admin","Seu Token: "..Account["token"]..".",5000,"TOKEN")
            else
                --TriggerClientEvent("Notify",source,"verde","Você já vinculou seu token.",5000,"TOKEN")
                TriggerClientEvent("Notify2",source,"#token")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpcds",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",4) then
            local Keyboard = vKEYBOARD.keySingle(source,"Cordenadas:")
            if Keyboard and Keyboard[1] then
                local Split = splitString(Keyboard[1],",")
                vRP.Teleport(source,tonumber(Split[1]) or 0,tonumber(Split[2]) or 0,tonumber(Split[3]) or 0)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",4) then
            local Ped = GetPlayerPed(source)
            if Ped ~= 0 and DoesEntityExist(Ped) then
                local Coords = GetEntityCoords(Ped)
                local heading = GetEntityHeading(Ped)

                vKEYBOARD.keyCopy(source,"Cordenadas:",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(heading))
            end
        end
    end
end)

RegisterCommand("cdsc",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",4) then
            local Ped = GetPlayerPed(source)
            if Ped ~= 0 and DoesEntityExist(Ped) then
                local Coords = GetEntityCoords(Ped)
                local heading = GetEntityHeading(Ped)
                TriggerClientEvent("copyToClipboard",source,mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(heading))
            end
        end
    end
end)

RegisterCommand("cdst",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",4) then
            local Ped = GetPlayerPed(source)
            if Ped ~= 0 and DoesEntityExist(Ped) then
                local Coords = GetEntityCoords(Ped)
                local heading = GetEntityHeading(Ped)
                vRP.Archive("oiesoubaianosim",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(heading))
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
local blackListGroups = {
    ["Abuser"] = 1,
    ["Base"] = 1,
    ["Black"] = 1,
    ["Ouro"] = 1,
    ["Prata"] = 1,
    ["VipSorteio"] = 1,
    ["Iniciante"] = 1,
    ["ClienteEspecial"] = 1,
    ["ClienteBlack"] = 1,
    ["Bronze"] = 1,
    ["Wallg"] = 1,
}
local AdminSet = {
    [1] = 1,
    [2] = 1,
    [3] = 3,
    [4] = 3,
    [5] = 3,
}
local grupoCommand = {}
RegisterCommand("group",function(source,Message)
    local passport = vRP.Passport(source)
    local args = vKEYBOARD.keyTriple(source,"Passaporte:","Grupo:","Nivel:",{ Message[1],Message[2],Message[3] })
    if args and args[1] and args[2] then
        if not vRP.HasGroup(passport,"Admin",3) then
            return
        end
        local Group = args[2]
        local nPassport = parseInt(args[1])
        local permissionLevel = parseInt(args[3])
        local Number = vRP.HasPermission(passport,"Admin")

        if blackListGroups[Group] and Number > blackListGroups[Group] then
            --TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para definir este grupo.",5000,"GROUP")
            TriggerClientEvent("Notify2",source,"#group")
            return
        end
        if Group == "Admin" then
            if AdminSet[permissionLevel] and Number > AdminSet[permissionLevel] then
                --TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para definir este grupo.",5000,"GROUP")
                TriggerClientEvent("Notify2",source,"#group")
                return
            end
        end
        vRP.SetPermission(args[1],Group,permissionLevel)
        --TriggerClientEvent("Notify", source, "verde", "Adicionado <b>" .. Group .. "</b> ao passaporte <b>" ..nPassport.. "</b>.", 5000, "GROUP")
        TriggerClientEvent("Notify2",source,"#groupPass",{ msg = Group,msg2 = nPassport })
        exports["vrp"]:SendWebHook("group","**Passaporte:** "..passport.." "..vRP.FullName(passport).."\n**Setou:** "..nPassport.." "..vRP.FullName(nPassport).."\n**Group:** "..Group.." "..permissionLevel..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187,{ passport })
    end
end)

local grupoCommand = {}
RegisterCommand("groupadd", function(source, Message)
    local passport = vRP.Passport(source)
    local args = vKEYBOARD.keyTriple(source, "Passaporte:", "Grupo:", "Nivel:", { Message[1], Message[2], Message[3] })
    
    if args and args[1] and args[2] then
        local Group = args[2]
        local nPassport = parseInt(args[1])
        local permissionLevel = parseInt(args[3])
        
        vRP.SetPermission(nPassport, Group, permissionLevel)
        
        -- Envia notificação para o cliente
        TriggerClientEvent("Notify2", source, "#groupPass", { msg = Group, msg2 = nPassport })
        
        -- Envia webhook
        exports["vrp"]:SendWebHook("group", "**Passaporte:** " .. passport .. " " .. vRP.FullName(passport) .. "\n**Setou:** " .. nPassport .. " " .. vRP.FullName(nPassport) .. "\n**Group:** " .. Group .. " " .. permissionLevel .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187, { passport })
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) and parseInt(Message[1]) > 0 and Message[2] then
            --TriggerClientEvent("Notify",source,"verde","Removido <b>"..Message[2].."</b> ao passaporte <b>"..Message[1].."</b>.",5000,"UNGROUP")
            TriggerClientEvent("Notify2",source,"#ungroup",{ msg = Message[2],msg2 = Message[1] })
            exports["vrp"]:SendWebHook("group","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Removeu:** "..Message[1].." "..vRP.FullName(Message[1]).."\n**Group:** "..Message[2].." "..Message[3]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187,{ Passport,Message[1] })

            vRP.RemovePermission(Message[1],Message[2],Message[3])
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- uncuff
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("desalgemar",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            if Player(source)["state"]["Handcuff"] then
                Player(source)["state"]["Handcuff"] = false
                Player(source)["state"]["Commands"] = false
                TriggerClientEvent("sounds:Private",source,"uncuff",0.5)

                vRPC.DestroyObjects(source)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UCAPUZ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ucapuz",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            TriggerClientEvent("hud:toggleHood",source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source,args)
    local passport = vRP.Passport(source)

    if passport and vRP.HasGroup(passport,"Aliado") then
        local targetId = tonumber(args[1])
        local target = vRP.Source(targetId)
        if vRP.Request(target,"Você deseja ir até o Aliado?",30) then
            local ped = GetPlayerPed(source)
            if ped ~= 0 and DoesEntityExist(ped) then
                local coords = GetEntityCoords(ped)
                local bucket = GetPlayerRoutingBucket(source)
                TriggerEvent("vRP:BucketServer",target,"Enter",bucket)
                -- vRP.Teleport(target, coords.x, coords.y, coords.z)
                TriggerClientEvent("admin:Teleport",target,coords)
                exports["vrp"]:SendWebHook("tptome","**Passaporte:** "..passport.." "..vRP.FullName(passport).."\n**Puxou Passaporte:** "..targetId.." "..vRP.FullName(args[1])..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187,{ Passport,args[1] })
            end
        end
        return
    end

    -- Verifica se o usuário tem as permissões necessárias para usar o comando
    if not passport or (not vRP.HasGroup(passport,"Admin",5) and not vRP.HasGroup(passport,"Influenciador") and not vRP.HasGroup(passport,"InfluenciadorVerificado",5) and not vRP.HasGroup(passport,"Comercial") and not vRP.HasGroup(passport,"QA")) or not tonumber(args[1]) then
        return
    end

    local targetId = tonumber(args[1])
    local target = vRP.Source(targetId)

    if target then
        local ped = GetPlayerPed(source)
        if ped ~= 0 and DoesEntityExist(ped) then
            local coords = GetEntityCoords(ped)
            local bucket = GetPlayerRoutingBucket(source)

            -- Teleporta o jogador para perto do usuário-alvo
            TriggerEvent("vRP:BucketServer",target,"Enter",bucket)
            -- vRP.Teleport(target, coords.x, coords.y, coords.z)
            TriggerClientEvent("admin:Teleport",target,coords)
            exports["vrp"]:SendWebHook("tptome","**Passaporte:** "..passport.." "..vRP.FullName(passport).."\n**Puxou Passaporte:** "..targetId.." "..vRP.FullName(args[1])..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
        end
    end
end)
function nPrint(text)
    print(text)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpto",function(source,args)
    local source   = source
    local passport = vRP.Passport(source)

    if passport and vRP.HasGroup(passport,"Aliado") then
        local nPassport = parseInt(args[1])
        local closestPed = vRP.Source(parseInt(nPassport))
        local sPed = GetPlayerPed(source)
        if closestPed then
            local coords = vCLIENT.GetCoords(closestPed)
            -- SetEntityCoords(sPed, coords)
            -- vRP.Teleport(source, coords.x, coords.y, coords.z)
            --s
            TriggerClientEvent("admin:Teleport",source,coords)
            -- Teleportar o jogador para a posição do ped mais próximo
            local routingBucket = GetPlayerRoutingBucket(closestPed)
            TriggerEvent("vRP:BucketServer",source,"Enter",routingBucket)

            -- Enviar log para o webhook
            local date = os.date("%d/%m/%Y - %H:%M:%S")
            -- exports["vrp"]:SendWebHook("tpto", "**Passaporte:** " .. passport .. "\n**Teleportou para o ID:** " .. args[1] .. "\n**Data:** " .. date, 9317187)
            exports["vrp"]:SendWebHook("tpto","**Passaporte:** "..passport.." "..vRP.FullName(passport).."\n**Teleportou para o ID:** "..args[1].." "..vRP.FullName(args[1])..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187,{ Passport,args[1] })
        end
    end

    Wait(100)
    if passport and vRP.HasGroup(passport,"Admin",5) or vRP.HasGroup(Passport,"InfluenciadorVerificado",5) or vRP.HasGroup(Passport,"QA") or vRP.HasGroup(Passport,"Comercial") and tonumber(args[1]) then
        local nPassport = parseInt(args[1])
        local closestPed = vRP.Source(parseInt(nPassport))
        local sPed = GetPlayerPed(source)
        if closestPed then
            local coords = vCLIENT.GetCoords(closestPed)
            -- SetEntityCoords(sPed, coords)
            -- vRP.Teleport(source, coords.x, coords.y, coords.z)
            --s
            TriggerClientEvent("admin:Teleport",source,coords)
            -- Teleportar o jogador para a posição do ped mais próximo
            local routingBucket = GetPlayerRoutingBucket(closestPed)
            TriggerEvent("vRP:BucketServer",source,"Enter",routingBucket)

            -- Enviar log para o webhook
            local date = os.date("%d/%m/%Y - %H:%M:%S")
            -- exports["vrp"]:SendWebHook("tpto", "**Passaporte:** " .. passport .. "\n**Teleportou para o ID:** " .. args[1] .. "\n**Data:** " .. date, 9317187)
            exports["vrp"]:SendWebHook("tpto","**Passaporte:** "..passport.." "..vRP.FullName(passport).."\n**Teleportou para o ID:** "..args[1].." "..vRP.FullName(args[1])..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpway",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",5) or vRP.HasGroup(Passport,"Influenciador") or vRP.HasGroup(Passport,"Aliado") or vRP.HasGroup(Passport,"Comercial") then
            local Coords = vCLIENT.teleportWay(source)

            -- exports["vrp"]:SendWebHook("tpway","**Passaporte:** "..Passport.."\n**Cds:** "..Coords.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
            exports["vrp"]:SendWebHook("tpway","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Cds:** "..Coords.." "..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187,{ Passport })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand("limbo",function(source)
-- 	local Passport = vRP.Passport(source)
-- 	if Passport and vRP.GetHealth(source) <= 100 then
-- 		vCLIENT.teleportLimbo(source)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local vehicle = vRPC.VehicleHash(source)
            if vehicle then
                vRP.Archive("hash.txt",vehicle)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) or vRP.HasGroup(Passport,"Comercial") or vRP.HasGroup(Passport,"InfluenciadorVerificado",5) then
            TriggerClientEvent("admin:vehicleTuning",source)
            -- exports["vrp"]:SendWebHook("tuning","**Passaporte:** "..Passport.." ".. vRP.FullName(Passport) .."\n**Usou Tuning**\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),10181046)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fix",function(source)
    local Passport = vRP.Passport(source)
    local Ped = GetPlayerPed(source)

    if Passport then
        if vRP.HasGroup(Passport,"Admin",5) or vRP.HasGroup(Passport,"InfluenciadorVerificado",5) or vRP.HasGroup(Passport,"QA") or vRP.HasGroup(Passport,"Comercial") then
            local Vehicle,Network,Plate = vRPC.VehicleList(source,10)
            if Vehicle then
                SetVehicleDirtLevel(Vehicle,0.0)
                local Players = vRPC.Players(source)
                local Coords = GetEntityCoords(Ped)
                -- local OtherCoords = GetEntityCoords(OtherPed)
                for _,v in ipairs(Players) do
                    async(function()
                        TriggerClientEvent("inventory:repairAdmin",v,Network,Plate)
                    end)
                end
                exports["vrp"]:SendWebHook("fix","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Usou fix** \n**Cds:** "..Coords.." \n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),10181046)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limparea",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",4) then
            local Ped = GetPlayerPed(source)
            if Ped ~= 0 and DoesEntityExist(Ped) then
                local Coords = GetEntityCoords(Ped)
                TriggerClientEvent("syncarea",source,Coords["x"],Coords["y"],Coords["z"],100)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cleanareaglobal",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",4) then
            local Ped = GetPlayerPed(source)
            if Ped ~= 0 and DoesEntityExist(Ped) then
                local Coords = GetEntityCoords(Ped)
                TriggerClientEvent("syncarea",-1,Coords["x"],Coords["y"],Coords["z"],1000)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("players",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",5) then
            --TriggerClientEvent("Notify",source,"azul","<b>Jogadores Conectados:</b> "..GetNumPlayerIndices(),5000,"ONLINE")
            TriggerClientEvent("Notify2",source,"#players",{ msg = parseInt(GetNumPlayerIndices() * 1.55) })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:Coords")
AddEventHandler("admin:Coords",function(Coords)
    vRP.Archive("coordenadas.txt",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.buttonTxt()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",4) then
            local Ped = GetPlayerPed(source)
            if Ped ~= 0 and DoesEntityExist(Ped) then
                local Coords = GetEntityCoords(Ped)
                local heading = GetEntityHeading(Ped)

                vRP.Archive(Passport..".txt",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(heading))
            end
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("announce",function(source,Message,History)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",4) and Message[1] then
            TriggerClientEvent("chat:ClientMessage",-1,"Governador",History:sub(9),"aviso")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("console",function(source,Message,History)
    if source == 0 then
        TriggerClientEvent("chat:ClientMessage",-1,"Governador",History:sub(9),"aviso")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kickall",function(source)
    if source ~= 0 then
        local Passport = vRP.Passport(source)
        if not vRP.HasGroup(Passport,"Admin",2) then
            return
        end
    end

    local List = vRP.Players()
    for _,Sources in pairs(List) do
        vRP.Kick(Sources,"Desconectado, a cidade reiniciou.")
        Wait(100)
    end

    TriggerEvent("SaveServer",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("save",function(source)
    if source ~= 0 then
        local Passport = vRP.Passport(source)
        if not vRP.HasGroup(Passport,"Admin",2) then
            return
        end
    end

    TriggerEvent("SaveServer",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemall",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",1) then
            local playerList = vRP.Players()
            for PassportPlayer,_ in pairs(playerList) do
                async(function()
                    vRP.GenerateItem(PassportPlayer,tostring(Message[1]),parseInt(Message[2]),true)
                end)
            end

            --TriggerClientEvent("Notify",source,"verde","Envio concluído.",10000,"ItemALL")
            TriggerClientEvent("Notify2",source,"#itemall")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("lista",function(source,Message)
    local Passport = vRP.Passport(source)
    local GroupName = Message[1] or "Iniciante"
    if Passport and GroupName then
        if vRP.HasGroup(Passport,"Admin") then
            local Table,TotalOnline = vRP.NumPermission(GroupName)
            if Table and TotalOnline then
                TriggerClientEvent("callAdmin:OpenPlayerList",source,GroupName)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("adm",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",4) then
            local Keyboard = vKEYBOARD.keySingle(source,"Mensagem:")
            if Keyboard and Keyboard[1] then
                local Keyboard2 = vKEYBOARD.keySingle(source,"Mundo (PRIMARIA/SECUNDARIA/EVENTO) Sem nada = TODOS:")
                if Keyboard2 and Keyboard2[1] then
                    local Mundo = Keyboard2[1]:upper()
                    if Mundos[Mundo] then
                        local Players = GetPlayers()
                        for i = 1,#Players do
                            local Source = Players[i]
                            local Bucket = parseInt(GetPlayerRoutingBucket(Source))
                            if Bucket == parseInt(Mundos[Mundo]) then
                                TriggerClientEvent("Announce",Source,"adminNew",Keyboard[1],40000,"ADMINISTRACÃO")
                                TriggerClientEvent("sounds:Private",Source,"anuncioadm",0.2)
                            end
                        end
                    end
                else
                    TriggerClientEvent("Announce",-1,"adminNew",Keyboard[1],40000,"ADMINISTRACÃO")
                    TriggerClientEvent("sounds:Private",-1,"anuncioadm",0.2)
                end
                exports["vrp"]:SendWebHook("anuncio-adm","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Mandou a msg:** "..Keyboard[1].."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limparmultas",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",4) then
            local Keyboard = vKEYBOARD.keySingle(source,"Passaport:")
            if Keyboard and Keyboard[1] then
                local nPassport = parseInt(Keyboard[1])
                vRP.Query("characters/ClearFines",{ id = nPassport })
                vRP.Query("mdt_bills/ClearBills",{ passport = nPassport })
                vRP.Query("fines/ClearFines",{ Passport = nPassport })
                TriggerClientEvent("Notify2",source,"#ClearFines")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anuncio",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Policia",4) then
            local Keyboard = vKEYBOARD.keySingle(source,"Mensagem:")
            if Keyboard and Keyboard[1] then
                print(Passport,Keyboard[1])
                TriggerClientEvent("Announce",-1,"policeNew",Keyboard[1],15000,"AVISO POLICIA")
                -- exports["vrp"]:SendWebHook("anuncio-policia","**Passaporte:** "..Passport.."\n**Mandou a msg:** "..Keyboard[1].."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
                exports["vrp"]:SendWebHook("anuncio-policia","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Mandou a msg:** "..Keyboard[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
            end
        elseif vRP.HasGroup(Passport,"Paramedic") then
            local Keyboard = vKEYBOARD.keySingle(source,"Mensagem:")
            if Keyboard and Keyboard[1] then
                print(Passport,Keyboard[1])
                TriggerClientEvent("Announce",-1,"paramedicNew",Keyboard[1],15000,"AVISO HOSPITAL")
                -- exports["vrp"]:SendWebHook("anuncio-paramedico","**Passaporte:** "..Passport.."\n**Mandou a msg:** "..Keyboard[1].."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
                exports["vrp"]:SendWebHook("anuncio-paramedico","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Mandou a msg:** "..Keyboard[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
            end
        elseif vRP.HasGroup(Passport,"Mechanic") then
            local Keyboard = vKEYBOARD.keySingle(source,"Mensagem:")
            if Keyboard and Keyboard[1] then
                print(Passport,Keyboard[1])
                TriggerClientEvent("Announce",-1,"mechanicNew",Keyboard[1],15000,"AVISO MECÂNICA")
                --exports["vrp"]:SendWebHook("anuncio-paramedico", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Mandou a msg:** " .. Keyboard[1] .. "" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anunciopolicia",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Policia") then
            local Keyboard = vKEYBOARD.keySingle(source,"Mensagem:")
            if Keyboard and Keyboard[1] then
                local Service = vRP.NumPermission("Policia")
                for Passports,Sources in pairs(Service) do
                    async(function()
                        TriggerClientEvent("Announce",Sources,"policeNew",Keyboard[1],15000,"AVISO INTERNO")
                    end)
                end
                -- exports["vrp"]:SendWebHook("anuncio-policia","**Passaporte:** "..Passport.."\n**Mandou a msg:** "..Keyboard[1].."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
                exports["vrp"]:SendWebHook("anuncio-policia","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Mandou a msg:** "..Keyboard[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("adminterno",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keySingle(source,"Mensagem:")
            if Keyboard and Keyboard[1] then
                local Service = vRP.NumPermission("Admin")
                for Passports,Sources in pairs(Service) do
                    async(function()
                        if not vRP.HasGroup(Passports,"Abuser",1) then
                            TriggerClientEvent("Announce",Sources,"admin",Keyboard[1],15000,"AVISO INTERNO")
                        end
                    end)
                end
                -- exports["vrp"]:SendWebHook("anuncio-policia","**Passaporte:** "..Passport.."\n**Mandou a msg:** "..Keyboard[1].."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
                -- exports["vrp"]:SendWebHook("anuncio-policia", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Mandou a msg:** " .. Keyboard[1] .. "" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("id",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        local ClosestPed = vRPC.ClosestPed(source,2)
        if ClosestPed then
            local cPassport = vRP.Passport(ClosestPed)
            --TriggerClientEvent("Notify",source,"azul","ID: "..cPassport,10000,"ID")
            TriggerClientEvent("Notify2",source,"#id",{ msg = cPassport })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACECOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Checkpoint = 0
function Creative.raceCoords(vehCoords,leftCoords,rightCoords)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        Checkpoint = Checkpoint + 1

        vRP.Archive("races.txt","["..Checkpoint.."] = {")

        vRP.Archive("races.txt","{ "..mathLength(vehCoords["x"])..","..mathLength(vehCoords["y"])..","..mathLength(vehCoords["z"]).." },")
        vRP.Archive("races.txt","{ "..mathLength(leftCoords["x"])..","..mathLength(leftCoords["y"])..","..mathLength(leftCoords["z"]).." },")
        vRP.Archive("races.txt","{ "..mathLength(rightCoords["x"])..","..mathLength(rightCoords["y"])..","..mathLength(rightCoords["z"]).." }")

        vRP.Archive("races.txt","},")
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENVIDEO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("openvideo",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keyDouble(source,"Link do Video:","Rodar para todo mundo:")
            if Keyboard and Keyboard[1] and Keyboard[2] then
                if Keyboard[2] == "true" then
                    Keyboard[2] = true
                else
                    Keyboard[2] = false
                end
                TriggerClientEvent("promotion_button:OpenVideo",-1,Keyboard[1],Keyboard[2])
            end
        end
    end
end)
RegisterCommand("openaudio",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keySingle(source,"Link do Video:")
            if Keyboard and Keyboard[1] then
                TriggerClientEvent("promotion_button:OpenAudio",-1,Keyboard[1])
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Quake"] = false
RegisterCommand("quake",function(source,Message)
    if source == 0 then
        GlobalState["Quake"] = true
    end
end)

RegisterCommand("s1mple",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",2) then
            local FF = false
            if Message[2] and parseInt(Message[2]) == 1 then
                FF = true
            end
            vCLIENT.spawnPeds(source,Message[1],FF)
        end
    end
end)

RegisterCommand("s1mplebots",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",2) then
            local Admins = vRP.NumPermission(Message[1])
            local List = {}
            for _,Sources in pairs(Admins) do
                List[tostring(Sources)] = true
            end
            TriggerClientEvent("admin:AddFriends",source,List)
        end
    end
end)

RegisterCommand("remcar",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keyDouble(source,"Passaporte","Nome do veículo:")
            if Keyboard and Keyboard[1] then
                vRP.Query("vehicles/removeVehicles",{ Passport = parseInt(Keyboard[1]),vehicle = Keyboard[2] })
                --TriggerClientEvent("Notify",source,"verde","Veículo removido com sucesso.",5000,"ADDCAR")
                TriggerClientEvent("Notify2",source,"#remcar")
            end
        end
    end
end)

RegisterCommand("copyall",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        local nPASSPORT = parseInt(Message[1])
        if vRP.HasGroup(Passport,"Admin",2) then
            TriggerClientEvent("skinshop:Apply",source,vRP.UserData(nPASSPORT,"Clothings"))
            TriggerClientEvent("tattooshop:Apply",source,vRP.UserData(nPASSPORT,"Tattooshop"))
            TriggerClientEvent("barbershop:Apply",source,vRP.UserData(nPASSPORT,"Barbershop"))
        end
    end
end)

RegisterCommand("setboneco",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        local nPASSPORT = parseInt(Message[1])
        local nPASSPORT2 = parseInt(Message[2])
        if vRP.HasGroup(Passport,"Admin",2) then
            local nSource = vRP.Source(nPASSPORT2)
            if nSource then
                TriggerClientEvent("skinshop:Apply",nSource,vRP.UserData(nPASSPORT,"Clothings"))
                TriggerClientEvent("tattooshop:Apply",nSource,vRP.UserData(nPASSPORT,"Tattooshop"))
                TriggerClientEvent("barbershop:Apply",nSource,vRP.UserData(nPASSPORT,"Barbershop"))
            end
        end
    end
end)

RegisterCommand("copypreset1",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        local nPASSPORT = parseInt(Message[1])
        if vRP.HasGroup(Passport,"Admin",3) then
            TriggerClientEvent("skinshop:Apply",source,vRP.UserData(nPASSPORT,"Clothings"))
        end
    end
end)

RegisterCommand("setpreset",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        local nPASSPORT = parseInt(Message[1])
        local nPASSPORT2 = parseInt(Message[2])
        if vRP.HasGroup(Passport,"Admin",3) then
            local nSource = vRP.Source(nPASSPORT2)
            if nSource then
                TriggerClientEvent("skinshop:Apply",nSource,vRP.UserData(nPASSPORT,"Clothings"))
            end
        end
    end
end)

RegisterCommand("setpresetarea",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        local nPASSPORT = parseInt(Message[1])
        local Range = parseInt(Message[2]) or 10
        if vRP.HasGroup(Passport,"Admin",3) then
            local Identity = vRP.Identity(nPASSPORT)
            local Info = vRPC.ClosestPeds(source,Range)
            local Clothings = vRP.UserData(nPASSPORT,"Clothings")
            for _,Table in pairs(Info) do
                local nSource = parseInt(Table[2])
                local Ped = GetPlayerPed(nSource)
                if GetEntityModel(Ped) == GetHashKey(Identity["skin"]) then
                    TriggerClientEvent("skinshop:Apply",nSource,Clothings)
                end
            end
        end
    end
end)

RegisterCommand("idarea",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        local Range = parseInt(Message[1]) or 10
        if vRP.HasGroup(Passport,"Admin",5) then
            local Identity = vRP.Identity(nPASSPORT)
            local Info = vRPC.ClosestPeds(source,Range)
            local Message = ""
            for _,Table in pairs(Info) do
                local nSource = parseInt(Table[2])
                local nPassport = vRP.Passport(nSource)
                local Name = vRP.FullName(nPassport)
                Message = Message.."<b>"..Name.." # "..nPassport.."<br>"
            end
            TriggerClientEvent("Notify",source,"azul",Message,30000,"IDAREA")
        end
    end
end)

RegisterCommand("getsource",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Source = vRP.Source(parseInt(Message[1]))
            if Source then
                TriggerClientEvent("Notify",source,"azul","Source: "..Source,30000,"GETSOURCE")
            end
        end
    end
end)

RegisterCommand("title",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",1) then
            local Ped = GetPlayerPed(source)
            if Ped ~= 0 and DoesEntityExist(Ped) then
                Entity(Ped)["state"]["Title"] = "Calvao"
            end
        end
    end
end)

vRP.Prepare("characters/GetByLicense","SELECT id FROM characters WHERE license = @license")

local MutedPlayer = {}
RegisterCommand("mute",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            -- local Keyboard = vKEYBOARD.keySingle(source,"Passaporte:")
            -- if not Keyboard and not Keyboard[1] then
            --     return
            -- end
            local Player = parseInt(Message[1])
            local PlayerSource = vRP.Source(Player)
            if not PlayerSource then
                --TriggerClientEvent("Notify",source,"vermelho","Jogador não está na cidade.",5000,"OFFLINE")
                TriggerClientEvent("Notify2",source,"#mute")
                return
            end
            if not MutedPlayer[Player] then
                MutedPlayer[Player] = true
                --TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..Player.."</b> foi MUTADO.",5000,"ADMIN")
                TriggerClientEvent("Notify2",source,"#passMute",{ msg = Player })
                --TriggerClientEvent("Notify",PlayerSource,"vermelho","Voce foi mutado.",5000,"ADMIN")
                TriggerClientEvent("Notify2",PlayerSource,"#muteAdv")
            else
                MutedPlayer[Player] = false
                TriggerClientEvent("admin:Mute",PlayerSource,false)
                --TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..Player.."</b> foi DESMUTADO.",5000,"ADMIN")
                TriggerClientEvent("Notify2",source,"#passUnmute",{ msg = Player })
                --TriggerClientEvent("Notify",PlayerSource,"vermelho","Voce foi desmutado.",5000,"ADMIN")
                TriggerClientEvent("Notify2",PlayerSource,"#unmuteAdv")
            end
            TriggerClientEvent("admin:Mute",PlayerSource,MutedPlayer[Player] or false)
        end
    end
end)

AddEventHandler("Connect",function(Passport,source)
    if MutedPlayer[Passport] then
        TriggerClientEvent("admin:Mute",source,true)
    end
end)

local CooldownMundo = {}
local MundoZaralho = {}
RegisterCommand("mundo",function(Source,Message)
    Wait(1)
    local Passport = vRP.Passport(Source)

    if not Message[1] then
        local Bucket = GetPlayerRoutingBucket(Source)
        if Bucket == 5 then
            Bucket = MundoNumber[1]
            TriggerClientEvent("Notify2",Source,"#mundo",{ msg = Bucket })
            return
        end
        if MundoNumber[Bucket] then
            Bucket = MundoNumber[Bucket]
        end
        TriggerClientEvent("Notify2",Source,"#mundo",{ msg = Bucket })
        return
    end
    local Health = vRP.GetHealth(Source)
    if Health and vRP.GetHealth(Source) <= 100 then
        TriggerClientEvent("Notify2",Source,"#mundoNAO")
        return
    end

    if MundoZaralho[tostring(Passport)] then
        vRP.ApplyTemporary(Passport,Source)
    end

    local Admin = vRP.HasGroup(Passport,"Admin",5)
    Message[1] = string.upper(Message[1])
    if Passport then
        local Bucket = GetPlayerRoutingBucket(Source)
        if not Admin then
            if MundoNumber[Bucket] and MundoNumber[Bucket] == "TOXICO" then
                return
            end
            if Message[1] == "PADRAO" then
                if Bucket == Mundos["EVENTO"] then
                    CooldownMundo[Source] = os.time() + 60 * 10
                    local Ped = GetPlayerPed(Source)
                    FreezeEntityPosition(Ped,true)
                    TriggerClientEvent("Progress",Source,"Mundo",60000)
                    Wait(60000)
                    FreezeEntityPosition(Ped,false)
                    TriggerClientEvent("Notify2",Source,"#entrouAdv",{ msg = Message[1] })
                    TriggerEvent("vRP:BucketServer",Source,"Enter",Mundos[Message[1]])
                    exports["vrp"]:SendWebHook("mundo","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Entrou no mundo:** "..Message[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
                    return
                elseif Bucket == Mundos["PRIMARIA"] then
                    if vRP.HasGroup(Passport,"Iniciante") then
                        return
                    end
                    CooldownMundo[Source] = os.time() + 60 * 10
                    local Ped = GetPlayerPed(Source)
                    FreezeEntityPosition(Ped,true)
                    TriggerClientEvent("Progress",Source,"Mundo",60000)
                    Wait(60000)
                    FreezeEntityPosition(Ped,false)
                    TriggerClientEvent("Notify2",Source,"#entrouAdv",{ msg = Message[1] })
                    TriggerEvent("vRP:BucketServer",Source,"Enter",Mundos[Message[1]])
                    exports["vrp"]:SendWebHook("mundo","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Entrou no mundo:** "..Message[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
                    return
                elseif Bucket == Mundos["SECUNDARIA"] then
                    CooldownMundo[Source] = os.time() + 60 * 10
                    local Ped = GetPlayerPed(Source)
                    FreezeEntityPosition(Ped,true)
                    TriggerClientEvent("Progress",Source,"Mundo",60000)
                    Wait(60000)
                    FreezeEntityPosition(Ped,false)
                    TriggerClientEvent("Notify2",Source,"#entrouAdv",{ msg = Message[1] })
                    TriggerEvent("vRP:BucketServer",Source,"Enter",Mundos[Message[1]])
                    exports["vrp"]:SendWebHook("mundo","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Entrou no mundo:** "..Message[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
                    return
                elseif Bucket == Mundos["TERCIARIA"] then
                    CooldownMundo[Source] = os.time() + 60 * 10
                    local Ped = GetPlayerPed(Source)
                    FreezeEntityPosition(Ped,true)
                    TriggerClientEvent("Progress",Source,"Mundo",60000)
                    Wait(60000)
                    FreezeEntityPosition(Ped,false)
                    TriggerClientEvent("Notify2",Source,"#entrouAdv",{ msg = Message[1] })
                    TriggerEvent("vRP:BucketServer",Source,"Enter",Mundos[Message[1]])
                    exports["vrp"]:SendWebHook("mundo","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Entrou no mundo:** "..Message[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
                    return
                else
                    TriggerClientEvent("Notify2",Source,"#mundoNAGORA")
                    return
                end
            elseif Message[1] == "EVENTO" then
                local Bucket = GetPlayerRoutingBucket(Source)
                if Bucket == Mundos["PADRAO"] then
                    local Ped = GetPlayerPed(Source)
                    FreezeEntityPosition(Ped,true)
                    TriggerClientEvent("Progress",Source,"Mundo",60000)
                    Wait(60000)
                    FreezeEntityPosition(Ped,false)
                    TriggerEvent("vRP:BucketServer",Source,"Enter",Mundos[Message[1]])
                    TriggerClientEvent("Notify2",Source,"#entrouAdv",{ msg = Message[1] })
                    exports["vrp"]:SendWebHook("mundo","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Entrou no mundo:** "..Message[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
                    return
                else
                    TriggerClientEvent("Notify2",Source,"#mundoNAGORA")
                    return
                end
            elseif Message[1] == "GUERRA" then
                if Bucket == Mundos["PADRAO"] then
                    CooldownMundo[Source] = os.time() + 60 * 10
                    TriggerEvent("vRP:BucketServer",Source,"Enter",Mundos[Message[1]])
                    TriggerClientEvent("Notify2",Source,"#entrouAdv",{ msg = Message[1] })
                    exports["vrp"]:SendWebHook("mundo","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Entrou no mundo:** "..Message[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
                    return
                else
                    TriggerClientEvent("Notify2",Source,"#mundoNAGORA")
                    return
                end
            elseif Message[1] == "PRIMARIA" then
                if Bucket == Mundos["PADRAO"] then
                    CooldownMundo[Source] = os.time() + 60 * 10
                    TriggerEvent("vRP:BucketServer",Source,"Enter",Mundos[Message[1]])
                    TriggerClientEvent("Notify2",Source,"#entrouAdv",{ msg = Message[1] })
                    exports["vrp"]:SendWebHook("mundo","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Entrou no mundo:** "..Message[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
                    return
                else
                    TriggerClientEvent("Notify2",Source,"#mundoNAGORA")
                    return
                end
            elseif Message[1] == "SECUNDARIA" then
                if Bucket == Mundos["PADRAO"] then
                    CooldownMundo[Source] = os.time() + 60 * 10
                    TriggerEvent("vRP:BucketServer",Source,"Enter",Mundos[Message[1]])
                    TriggerClientEvent("Notify2",Source,"#entrouAdv",{ msg = Message[1] })
                    exports["vrp"]:SendWebHook("mundo","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Entrou no mundo:** "..Message[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
                    return
                else
                    TriggerClientEvent("Notify2",Source,"#mundoNAGORA")
                    return
                end
            elseif Message[1] == "TERCIARIA" then
                if Bucket == Mundos["PADRAO"] then
                    CooldownMundo[Source] = os.time() + 60 * 10
                    TriggerEvent("vRP:BucketServer",Source,"Enter",Mundos[Message[1]])
                    TriggerClientEvent("Notify2",Source,"#entrouAdv",{ msg = Message[1] })
                    exports["vrp"]:SendWebHook("mundo","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Entrou no mundo:** "..Message[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
                    return
                else
                    TriggerClientEvent("Notify2",Source,"#mundoNAGORA")
                    return
                end
            elseif Message[1] == "INVASAOFUZIL" then
                if Bucket == Mundos["PADRAO"] then
                    if MundoZaralho[tostring(Passport)] > os.time() then
                        return
                    end
                    CooldownMundo[Source] = os.time() + 60 * 10
                    TriggerEvent("vRP:BucketServer",Source,"Enter",Mundos[Message[1]])
                    vRP.SaveTemporary(Passport,Source,12,"InvasaoFuzil")
                    TriggerClientEvent("Notify2",Source,"#entrouAdv",{ msg = Message[1] })
                    exports["vrp"]:SendWebHook("mundo","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Entrou no mundo:** "..Message[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
                    MundoZaralho[tostring(Passport)] = os.time() + 60 * 30
                    return
                else
                    TriggerClientEvent("Notify2",Source,"#mundoNAGORA")
                    return
                end
            end
        end

        if Admin then
            local Bucket = Message[1]
            if Bucket then
                if Mundos[Bucket] then
                    if Message[1] == "INVASAOFUZIL" then
                        vRP.SaveTemporary(Passport,Source,12,"InvasaoFuzil")
                    end
                    TriggerEvent("vRP:BucketServer",Source,"Enter",Mundos[Bucket])
                    TriggerClientEvent("Notify2",Source,"#entrouAdv",{ msg = Message[1] })
                    exports["vrp"]:SendWebHook("mundo","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Entrou no mundo:** "..Message[1]..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
                end
            end
        end
    end
end)

RegisterCommand("mundoarea",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Range = parseInt(Message[2]) or 10
            local Info = vRPC.ClosestPeds(source,Range)
            local Bucket = string.upper(Message[1])
            if Bucket then
                if Mundos[Bucket] then
                    TriggerClientEvent("Notify2",source,"#entrouAdv",{ msg = Message[1] })
                    TriggerEvent("vRP:BucketServer",source,"Enter",Mundos[Bucket])
                    for _,Table in pairs(Info) do
                        local ClosestPed = parseInt(Table[2])
                        TriggerEvent("vRP:BucketServer",ClosestPed,"Enter",Mundos[Bucket])
                        TriggerClientEvent("Notify2",ClosestPed,"#entrouAdv",{ msg = Message[1] })
                    end
                end
            end
        end
    end
end)

RegisterCommand("mundotoxico",function(Source,Message)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            TriggerEvent("vRP:BucketServer",Source,"Enter",5)
            --TriggerClientEvent("Notify",Source,"verde","Você entrou no mundo tóxico.",5000,"ADMIN")
            TriggerClientEvent("Notify2",Source,"#mundotoxico")
        end
    end
end)

RegisterCommand("resetseasonpass",function(Source,Message)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",2) then
            vRP.Query("season_pass/ResetSeasonPass",{})
            --TriggerClientEvent("Notify",Source,"verde","Você resetou o passe de batalha",5000,"ADMIN")
            TriggerClientEvent("Notify2",Source,"#resetseasonpass")
        end
    end
end)

RegisterCommand("skinstock",function(Source,Message)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",2) then
            local Keyboard = vKEYBOARD.keyDouble(Source,"Skin:","Stock:")
            if Keyboard and Keyboard[1] then
                vRP.Query("skinweapon/updateStock",{ model = Keyboard[1],stock = parseInt(Keyboard[2]) })
                --TriggerClientEvent("Notify",Source,"verde","Você atualizou o stock da skin <b>"..Keyboard[1].."</b> para <b>"..Keyboard[2].."</b>.",5000,"ADMIN")
                TriggerClientEvent("Notify2",Source,"#skinstock",{ msg = Keyboard[1],msg2 = Keyboard[2] })
            end
        end
    end
end)

vRP.Prepare("skinweapon/updateAllStock","UPDATE skinstock SET stock = @stock")

RegisterCommand("allstock",function(Source,Message)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",2) then
            local Keyboard = vKEYBOARD.keySingle(Source,"Stock:")
            if Keyboard and Keyboard[1] then
                vRP.Query("skinweapon/updateAllStock",{ stock = parseInt(Keyboard[1]) })
                --TriggerClientEvent("Notify",Source,"verde","Você atualizou o stock das skins para <b>"..Keyboard[1].."</b>.",5000,"ADMIN")
                TriggerClientEvent("Notify2",Source,"#allstock",{ msg = Keyboard[1] })
            end
        end
    end
end)

vRP.Prepare("skinweapon/getSkins","SELECT model FROM skinstock")

RegisterCommand("getskins",function(Source,Message)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",2) then
            local Query = vRP.Query("skinweapon/getSkins",{})
            local Message = "Skins: <br>"
            if Query and Query[1] then
                for i = 1,#Query do
                    local Model = Query[i]["model"]
                    Message = Message..Model.."<br>"
                end
                TriggerClientEvent("BigNotify",Source,"azul",Message,30000,"Skins")
            end
        end
    end
end)

RegisterCommand("mundopadrao",function(Source,Message)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            TriggerEvent("vRP:BucketServer",Source,"Exit")
            exports["vrp"]:ChangePlayerBucket(Source,1)
            --TriggerClientEvent("Notify",Source,"verde","Você entrou no mundo padrão.",5000,"ADMIN")
            TriggerClientEvent("Notify2",Source,"#mundopadrao")
        end
    end
end)

RegisterCommand("toxico",function(Source,Message)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) or vRP.HasGroup(Passport,"Aliado") then
            vRP.Query("characters/updateToxic",{ Passport = parseInt(Message[1]),Toxic = 1 })
            TriggerEvent("vRP:SetToxic",parseInt(Message[1]),true)
            --TriggerClientEvent("Notify",Source,"verde","Você setou o passaporte <b>"..Message[1].."</b> como tóxico.",5000,"ADMIN")
            TriggerClientEvent("Notify2",Source,"#toxico",{ msg = Message[1] })
        end
    end
end)

RegisterCommand("verificar",function(Source,Message)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keySingle(Source,"Passport:")
            if Keyboard and Keyboard[1] then
                local OtherPassport = parseInt(Keyboard[1])
                local Identity = vRP.Identity(OtherPassport)
                if Identity then
                    local Account = vRP.Account(Identity["license"])
                    local AccountInfo = vRP.Query("accounts/AccountId",{ id = Account["id"] })
                    if AccountInfo and AccountInfo[1] then
                        local License = AccountInfo[1]["license"]
                        local Characters = vRP.Query("characters/GetLicense",{ license = License })
                        local CharactersList = ""
                        for i = 1,#Characters do
                            local Toxic = (Characters[i]["toxic"] == 1 and "Tóxico" or "Normal")
                            CharactersList = CharactersList.."<b>"..Characters[i]["name"].." "..Characters[i]["name2"].."</b> | <b>"..Characters[i]["id"].."</b> | <b>"..Toxic.."</b><br>"
                        end
                        --TriggerClientEvent("Notify",Source,"verde","<b>Discord:</b> "..AccountInfo[1]["discord"].."<br><b>Personagens:</b><br>"..CharactersList,5000,"Informacoes")
                        TriggerClientEvent("Notify2",Source,"#verificar",{ msg = AccountInfo[1]["discord"],msg2 = CharactersList })
                    end
                end
            end
        end
    end
end)

RegisterCommand("putaria",function(Source,Message)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",4) then
            local Keyboard = vKEYBOARD.keySingle(Source,"Passport:")
            if Keyboard and Keyboard[1] then
                local OtherPassport = parseInt(Keyboard[1])
                vRP.SetPermission(OtherPassport,"Putaria",1)
                TriggerClientEvent("Notify2",Source,"#groupPass",{ msg = "Putaria",msg2 = OtherPassport })
            end
        end
    end
end)

vRP.Prepare("whitelist_kd/InsertPassport","INSERT INTO `whitelist_kd`(`passport`) VALUES (@Passport) ON DUPLICATE KEY UPDATE `passport` = VALUES(`passport`)")
RegisterCommand("untoxico",function(Source,Message)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) and Message[1] and Message[1] ~= 0 then
            vRP.Query("characters/updateToxic",{ Passport = parseInt(Message[1]),Toxic = 0 })
            vRP.Query("whitelist_kd/InsertPassport",{ Passport = parseInt(Message[1]) })
            TriggerEvent("vRP:SetToxic",parseInt(Message[1]),false)
            --TriggerClientEvent("Notify",Source,"verde","Você setou o passaporte <b>"..Message[1].."</b> como normal.",5000,"ADMIN")
            TriggerClientEvent("Notify2",Source,"#untoxico",{ msg = Message[1] })
            TriggerEvent("AddKDWhitelist",parseInt(Message[1]))
            exports["vrp"]:SendWebHook("untoxico","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n** Tirou:** "..Message[1].." "..vRP.FullName(Message[1]).." **do mundo tóxico**"..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
        end
    end
end)


local BoxReported = {}
-- RegisterServerEvent("admin:Report")
-- AddEventHandler("admin:Report",function(Passport)
--     local Source = source
--     ReportBox = GetConvar("ReportBox", "")
--     if ReportBox == "false" then
--         --TriggerClientEvent("Notify",Source,"aviso","Sistema temporariamente desativado",5000,"REPORT BOX")
--         return
--     end
--     if not BoxReported[Passport] then
--         local PlayerReport = vRP.Passport(Source)
--         local Identity = vRP.Identity(Passport)
--         if Identity then
--             local PlayerIdentity = vRP.Identity(Passport)
--             local Account = vRP.Account(Identity["license"])
--             local PlayerAccount = vRP.Account(Identity["license"])
--             local Selected = getNumberByReason("Combat Loggin (BOX)")
--             if Selected then
--                 vRP.RemoveBank(Passport,banConfig["ADV"]["Info"][Selected]["fine"])
--             end
--             vRP.Query("temporary_banneds/addBanned",{ id = Account["id"], time = 720, reason = "Combat Loggin (BOX)", Admin = PlayerReport })
--             vRP.SetTemporaryBan(Account["id"],Passport)		
--             --TriggerClientEvent("Notify",Source,"aviso","Passaporte <b>"..Passport.."</b> <b>ADV</b> Motivo: Combat Loggin (BOX)",5000,"REPORT BOX")
--             exports["vrp"]:SendWebHook("adv","**Passaporte:** "..PlayerReport.."\n**Deu adv:** "..Passport.."\n**Motivo:** Combat Loggin (BOX)\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
--             exports["vrp"]:SendWebHook("advbot","Aplicou: "..PlayerAccount["discord"].."\nRecebeu: "..Account["discord"].."\nAccount id: "..Account["id"].."",9317187)
--             BoxReported[Passport] = true
--             TriggerClientEvent("chat:ClientMessage",-1,"O usuário",Passport.." "..Identity["name"].." "..Identity["name2"].. "foi advertido pós report de: "..PlayerReport.." por: 720 Meses Motivo: Combat Loggin (BOX)","advertencia")		
--         end
--     end
-- end)

AddEventHandler("admin:CL",function(Passport)
    local Identity = vRP.Identity(Passport)
    if Identity then
        local Account = vRP.Account(Identity["license"])
        vRP.Query("temporary_banneds/addBanned",{ id = Account["id"],time = 720,reason = "Combat Loggin (BOX)",Admin = Passport })
        vRP.SetTemporaryBan(Account["id"],Passport)
    end
end)



local orders = { "VIP Ouro x1","VIP Prata x1","VIP Bronze x1" }
local names = { "Claudemir","Baiano","Betin","BetinBeto","Bianca","Biel","Cassie","Cartola","Chaika","Charada","Chibau","Chico","Clara","Clarice","Dominic","Gui","Guilherme","Guizin","Isabela","Jao","Jammal","Jorge","JP","Juliana","Luiz","Mandrake","Maya","Melo","Mendy","Tulio","Tyler","Valentino","Yellow","ZePequeno","Adabaldir","Juvenal","Agatha","Bob","Calleri","LuisFabiano","Aninha","Aquiles","Teofilo","William","Frederico","Dede","Aurora","Nebulosa","Johnny Bravo","Hera","Thor","Dandara",
    "Thanos","Gambit","Jax","Brutus","Rambo","Hermes","Minerva","Eros","Apolo","Ajax","Édipo","Barbecue","Xerife","Sullivan","Catatau","Mufasa","Pérola","Aurora","Mirtilo","Luma","Gio","Malu","Maggie","Julie","Spielberg","Tom","Morgan","Russel","Tyler" }

CreateThread(function()
    while true do
        Wait(60000 * math.random(20,40))
        local name = names[math.random(1,#names)]
        local order = orders[math.random(1,#orders)]
        local Message = name.." Comprou "..order.."."
        -- --TriggerClientEvent("Notify",-1,"compras",Message,7500,"COMPRAS")
        local Custom = {
            background = "rgba(238,0,182,.75)",
        }
        TriggerClientEvent("chat:ClientMessage",-1,"",Message,"🏷️ LOJA VIP",false,Custom)
        TriggerClientEvent("sounds:Private",-1,"compras",0.02)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local CustomBlips = {}
vRP.Prepare("blips/addBlip","INSERT INTO blips(owner,name,blip_id,coordinates,color) VALUES(@owner,@name,@blip_id,@coordinates,@color)")
vRP.Prepare("blips/newName","UPDATE blips SET name = @newName WHERE name = @oldName")
CreateThread(function()
    local Rows = vRP.Query("blips/getBlips")
    for k,v in pairs(Rows) do
        table.insert(CustomBlips,v)
    end
    Wait(500)
    TriggerClientEvent("blips:LoadBlips",-1,CustomBlips)
end)

RegisterCommand("newblip",function(Source,Args)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keyFourth(Source,"Nome do Blip:","Dono:","Cor:","ID do Blip:")
            if Keyboard and Keyboard[1] then
                local Coords = GetEntityCoords(GetPlayerPed(Source))
                local FormatCoords = tD(Coords.x)..","..tD(Coords.y)..","..tD(Coords.z)
                local Query = vRP.Query("blips/addBlip",{ name = Keyboard[1],owner = Keyboard[2],color = Keyboard[3],blip_id = Keyboard[4],coordinates = FormatCoords })
                local Blip = { id = Query["insertId"],name = Keyboard[1],owner = parseInt(Keyboard[2]),color = parseInt(Keyboard[3]),blip_id = parseInt(Keyboard[4]),coordinates = FormatCoords }
                table.insert(CustomBlips,Blip)
                --TriggerClientEvent("Notify",Source,"verde","Você criou o blip <b>"..Keyboard[1].."</b>.",7500,"BLIPS")
                TriggerClientEvent("Notify2",Source,"#newblip",{ msg = Keyboard[1] })
                TriggerClientEvent("blips:NewBlip",-1,Blip)
            end
        end
    end
end)

RegisterCommand("removeblip",function(Source,Args)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keySingle(Source,"Nome do Blip:")
            if Keyboard and Keyboard[1] then
                for k,v in pairs(CustomBlips) do
                    if v["name"] == Keyboard[1] then
                        TriggerClientEvent("blips:RemoveBlip",-1,v["id"])
                        vRP.Query("blips/removeBlip",{ name = v["name"] })
                        table.remove(CustomBlips,k)
                        --TriggerClientEvent("Notify",Source,"verde","Você removeu o blip <b>"..v["name"].."</b>.",7500,"BLIPS")
                        TriggerClientEvent("Notify2",Source,"#removeblip",{ msg = v["name"] })
                    end
                end
            end
        end
    end
end)

RegisterCommand("blipname",function(Source,Args)
    local Passport = vRP.Passport(Source)
    if Passport then
        local Keyboard = vKEYBOARD.keySingle(Source,"Nome do Blip:")
        if Keyboard and Keyboard[1] then
            for k,v in pairs(CustomBlips) do
                if v["name"] == Keyboard[1] and Passport == v["owner"] or vRP.HasGroup(Passport,"Admin",3) then
                    local NewName = vKEYBOARD.keySingle(Source,"Novo Nome:")
                    vRP.Query("blips/newName",{ newName = NewName[1],oldName = v["name"] })
                    --TriggerClientEvent("Notify",Source,"verde","Você alterou o nome do blip <b>"..v["name"].."</b> para <b>"..NewName[1].."</b>.",7500,"BLIPS")
                    TriggerClientEvent("Notify2",Source,"#blipname",{ msg = v["name"],msg2 = NewName[1] })
                    CustomBlips[k]["name"] = NewName[1]
                    TriggerClientEvent("blips:UpdateBlip",-1,CustomBlips[k])
                end
            end
        end
    end
end)

AddEventHandler("Connect",function(Passport,source)
    TriggerClientEvent("blips:LoadBlips",source,CustomBlips)
end)

RegisterCommand("recrutamento",function(Source,Args)
    if not GlobalState["RecruitmentCommand"] then
        return
    end
    local Passport = vRP.Passport(Source)
    if Passport then
        local Job,Rank = vRP.UserGroupByType(Passport,"Job")
        if Job and Rank <= 3 then
            local Keyboard = vKEYBOARD.keyDouble(Source,"Titulo:","Mensagem:")
            if Keyboard and Keyboard[1] then
                local Identity = vRP.Identity(Passport)
                local Ped = GetPlayerPed(Source)
                local Coords = GetEntityCoords(Ped)
                local FormatCoords = vector3(tD(Coords.x),tD(Coords.y),tD(Coords.z))
                local Name = Identity.name.." "..Identity.name2
                local Table = vRP.GetNewbies()
                async(function()
                    for i = 1,#Table do
                        for Passport,Sources in pairs(Table[i]) do
                            TriggerClientEvent("notify:Recruit",Sources,Keyboard[1],Keyboard[2],Name,60000,FormatCoords)
                            TriggerClientEvent("sounds:Private",Sources,"recrutamento",0.09)
                        end
                    end
                end)
                TriggerClientEvent("notify:Recruit",Source,Keyboard[1],Keyboard[2],Name,60000,FormatCoords)
                exports["vrp"]:SendWebHook("recrutamento","**Passaporte:** "..Passport.." "..Name.." \n**Mandou mensagem:** "..Keyboard[2].."\n**CDS:** "..FormatCoords.." "..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
            end
        end
    end
end)

RegisterCommand("events",function(Source,Args)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keyDouble(Source,"Titulo:","Mensagem:")
            if Keyboard and Keyboard[1] then
                local Identity = vRP.Identity(Passport)
                local Ped = GetPlayerPed(Source)
                local Coords = GetEntityCoords(Ped)
                local FormatCoords = vector3(tD(Coords.x),tD(Coords.y),tD(Coords.z))
                local Name = Identity.name.." "..Identity.name2
                TriggerClientEvent("notify:Events",-1,Keyboard[1],Keyboard[2],Name,60000,FormatCoords)
                TriggerClientEvent("sounds:Private",-1,"recrutamento",0.09)
            end
        end
    end
end)

RegisterCommand("festa",function(Source,Args)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Festeiro") then
            local Keyboard = vKEYBOARD.keyDouble(Source,"Titulo:","Mensagem:")
            if Keyboard and Keyboard[1] then
                local Identity = vRP.Identity(Passport)
                local Ped = GetPlayerPed(Source)
                local Coords = GetEntityCoords(Ped)
                local FormatCoords = vector3(tD(Coords.x),tD(Coords.y),tD(Coords.z))
                local Name = Identity.name.." "..Identity.name2
                local Players = GetPlayers()
                async(function()
                    for i = 1,#Players do
                        local Sources = Players[i]
                        if not Player(Sources)["state"]["Iniciante"] or not Player(Sources)["state"]["Desempregado"] then
                            TriggerClientEvent("notify:CustomRecruit",Sources,Keyboard[1],Keyboard[2],Name,60000,FormatCoords,"Festinha","Festeiro(a)")
                        end
                    end
                end)
            end
        end
    end
end)

RegisterCommand("wipe",function(Source,Args)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keySingle(Source,"Passaporte:")
            if Keyboard and Keyboard[1] then
                local nPassport = parseInt(Keyboard[1])
                vRP.Query("investments/Remove",{ Passport = nPassport })
                vRP.Query("characters/wipeBank",{ Passport = nPassport })
                --TriggerClientEvent("Notify",Source,"verde","Passaporte "..nPassport.." Wipado.",7500,"Wipe")
                TriggerClientEvent("Notify2",Source,"#wipe",{ msg = nPassport })
            end
        end
    end
end)

local CustomAds = {}
vRP.Prepare("release_promotion/Add","INSERT INTO release_promotion (content, endAt, timer) VALUES (@Content, STR_TO_DATE(@endAt, '%d/%m/%Y'),@Timer)")
RegisterCommand("createads",function(Source,Args)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keyTriple(Source,"Mensagem","Data de expiração DD/MM/AAAA","Tempo entre cada notify em segundos")
            if Keyboard and Keyboard[1] then
                vRP.Query("release_promotion/Add",{ Content = Keyboard[1],endAt = Keyboard[2],Timer = Keyboard[3] })
                Wait(500)
                local Query = vRP.Query("release_promotion/Get")
                CustomAds = Query
            end
        end
    end
end)

-- CreateThread(function()
--     local Query = vRP.Query("release_promotion/Get")
--     CustomAds = Query
--     local Time = 1
--     while true do
--         for i=1,#CustomAds do
--             local v = CustomAds[i]
--             if Query then
--                 Time = Query[1]["timer"]*1000
--                 local name = names[math.random(1,#names)]
--                 --TriggerClientEvent("Notify",-1,"compras","<b>"..name.."</b> Comprou <b>"..v["content"]..".",7500,"COMPRAS")
--                 TriggerClientEvent("sounds:Private",-1,"purchase",0.09)
--                 Wait(Time)
--             end
--         end
--         Wait(Time)
--     end
-- end)

local Timer = GlobalState["newbieTimer"] or 60 * 1

CreateThread(function()
    local Start = os.time() + Timer
    while true do
        if os.time() >= Start then
            local Newbies = vRP.GetOnlyNewbies()
            local Max = GlobalState["newbieConfig"] or 30
            if #Newbies >= Max then
                local Table = vRP.GetAllTypeOnline("Job",3,true)
                if Table then
                    for i = 1,#Table do
                        local Source = Table[i]
                        --TriggerClientEvent("Notify",Source,"amarelo",#Newbies.." <b>Novatos</b> pela cidade!<br/>Você precisa ajudar no recrutamento!",7500,"Novatos")
                        TriggerClientEvent("Notify2",Source,"#ajudaRec",{ msg = #Newbies })
                        TriggerClientEvent("sounds:Private",Source,"calladmin",0.1)
                    end
                end
            end

            Start = os.time() + Timer
        end
        Wait(60000)
    end
end)

AddEventHandler("Connect",function(Passport,source)
    Wait(500)
    local License = vRP.Identities(source)
    if License then
        local Identity = vRP.Identity(Passport)
        if Identity then
            local Account = vRP.Account(Identity["license"])
            if Account["license"] ~= License then
                vRP.Kick(source,"Conta Incorreta.")
            end
        end
    end
end)

-- CreateThread(function()
--     print("Verificando contas...")
--     local players = GetPlayers()
--     for i=1,#players do
--         local source = parseInt(players[i])
--         local Passport = vRP.Passport(source)
--         if Passport then
--             local License = vRP.Identities(source)
--             if License then
--                 local Identity = vRP.Identity(Passport)
--                 if Identity then
--                     local Account = vRP.Account(Identity["license"])
--                     if Account["license"] ~= License then
--                         print("Kick Conta Incorreta: ",License)
--                         vRP.Kick(source,"Conta Incorreta.")
--                     end
--                 end
--             end
--         end
--         Wait(10)
--     end
--     print("Verificação de contas concluída.")
-- end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ABUSERS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("rgbc",function(Source,Message)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",1) then
            TriggerClientEvent("admin:RGB",Source)
        else
            local Allowed = false
            local AllowedVips = {
                ["Black"] = true,
                ["Ouro"] = true,
                ["VipSorteio"] = true,
                ["VipLancamento"] = true,
            }
            local NewVips = vRP.HasVip(Passport)
            if NewVips then
                for Group,_ in pairs(NewVips) do
                    if AllowedVips[Group] then
                        Allowed = true
                    end
                end
            end
            if Allowed then
                TriggerClientEvent("admin:RGB",Source)
            else
                --TriggerClientEvent("Notify",Source,"vermelho","Você não tem permissão para usar esse comando, adquira já um vip em nossa loja.",7500,"Permissão")
                TriggerClientEvent("Notify2",Source,"#comandoNpermitido")
            end
        end
    end
end)

local CanPunch = {}
RegisterCommand("punch",function(Source,Message)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",1) then
            CanPunch[Source] = true
            TriggerClientEvent("admin:Punch",Source,parseInt(Message[1]))
        end
    end
end)

RegisterCommand("remspectate",function(Source,Message)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            TriggerClientEvent("pma-voice:Teste",-1)
        end
    end
end)

RegisterCommand("spunch",function(Source,Message)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Abuser",1) then
            CanPunch[Source] = true
            TriggerClientEvent("admin:SPunch",Source,parseInt(Message[1]),parseInt(Message[2]))
        end
    end
end)

RegisterServerEvent("admin:PunchAdd")
AddEventHandler("admin:PunchAdd",function(Vehicle,ForWard,Force)
    local Source = source
    -- if not vRP.HasGroup(Passport,"Admin", 1) then
    --     DropPlayer(Source,"698")
    --     return
    -- end
    if CanPunch[Source] then
        local forceMultiplier = Force

        local forceX = ForWard.x * forceMultiplier
        local forceY = ForWard.y * forceMultiplier

        local Network = NetworkGetEntityFromNetworkId(Vehicle)
        if DoesEntityExist(Network) then
            ApplyForceToEntity(Network,0,forceX,forceY,0.0,0.0,0.0,0.0,0,false,true,true,false,true)
        end
    end
end)

local knockForce = 1800.0
RegisterServerEvent("admin:Bullying")
AddEventHandler("admin:Bullying",function()
    local source = source
    local Ped = GetPlayerPed(source)
    if DoesEntityExist(Ped) then
        SetPedCanRagdoll(PlayerPedId(),true)
        SetPedToRagdoll(Ped,5000,5000,0,0,0,0)
        Wait(100)
        ApplyForceToEntity(Ped,0,0.0,0.0,knockForce,0.0,0.0,0.0,0,false,true,true,false,true)
        Wait(5000)
        SetPedCanRagdoll(PlayerPedId(),false)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SKATE
-----------------------------------------------------------------------------------------------------------------------------------------

-- RegisterCommand("skate",function(Source,Message)
--     local Passport = vRP.Passport(Source)
--     if Passport then
--         if vRP.HasGroup(Passport,"Admin",3) or vRP.HasGroup(Passport,"Aliado") then
--             if Message[1] == "on" then
--                 local Exist,Network,Vehicle = exports["garages"]:CreateVehicle(Source,'rcbandito')
--                 local PedSource = GetPlayerPed(Source)
--                 local Coords = GetEntityCoords(PedSource) + vector3(0.0,0.0,1.0)
--                 local ExistPed,Ped = SkateCreatePed(Source,68070371,Coords,0.0,12)
--                 if Exist and ExistPed then
--                     TriggerClientEvent("skate:spawn",Source,Message[1],{Network,Ped})
--                 end
--             else
--                 TriggerClientEvent("skate:spawn",Source,Message[1])
--             end
--         end
--     end
-- end)

function SkateCreatePed(source,Model,x,y,z,heading,typ)
    local mHash = GetHashKey(Model)
    local Ped = CreatePed(typ,mHash,x,y,z,heading,true,false)
    local Count = 0
    while not DoesEntityExist(Ped) do
        Count = Count + 1
        if Count > 1000 then
            break
        end
        Wait(100)
    end

    if DoesEntityExist(Ped) then
        local Bucket = GetPlayerRoutingBucket(source)
        SetEntityRoutingBucket(Ped,Bucket)

        return true,NetworkGetNetworkIdFromEntity(Ped)
    end

    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("roupas",function(source)
    if GetPlayerRoutingBucket(source) < 900000 then
        local Passport = vRP.Passport(source)
        local VIPs = vRP.GetGroup(Passport,"VIP")
        if VIPs and (VIPs["Premium"] and VIPs["Premium"][1] and VIPs["Premium"][1] <= 4) or (VIPs and VIPs["Blacks"]) or (VIPs and VIPs["Lancamento"]) then
            TriggerClientEvent("skinshop:Open",source,true)
            return
        elseif vRP.HasGroup(Passport,"Admin",5) then
            TriggerClientEvent("skinshop:Open",source,true)
            return
        end
        local Allowed = false
        local AllowedVips = {
            ["Prata"] = true,
            ["Ouro"] = true,
            ["Black"] = true,
            ["VipSorteio"] = true,
            ["VipLancamento"] = true,
        }

        local NewVips = vRP.HasVip(Passport)

        if NewVips then
            for Group,_ in pairs(NewVips) do
                if AllowedVips[Group] then
                    Allowed = true
                end
            end
        end

        if Allowed then
            TriggerClientEvent("skinshop:Open",source,true)
            return
        else
            --TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para usar esse comando, adquira já um vip em nossa loja.",7500,"Permissão")
            TriggerClientEvent("Notify2",source,"#comandoNpermitido")
        end
    end
end)

RegisterCommand("barbearia",function(source)
    if GetPlayerRoutingBucket(source) < 900000 then
        local Passport = vRP.Passport(source)
        if vRP.HasGroup(Passport,"Admin",5) then
            TriggerClientEvent("barbershop:Open",source,"barber")
            return
        end
        local Allowed = false
        local AllowedVips = {
            ["Ouro"] = true,
            ["Black"] = true,
            ["VipSorteio"] = true,
            ["VipLancamento"] = true,
        }

        local NewVips = vRP.HasVip(Passport)

        if NewVips then
            for Group,_ in pairs(NewVips) do
                if AllowedVips[Group] then
                    Allowed = true
                end
            end
        end

        if Allowed then
            TriggerClientEvent("barbershop:Open",source,"barber")
            return
        else
            --TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para usar esse comando, adquira já um vip em nossa loja.",7500,"Permissão")
            TriggerClientEvent("Notify2",source,"#comandoNpermitido")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cor",function(source,Message)
    local Passport = vRP.Passport(source)
    local VIPs = vRP.GetGroup(Passport,"VIP")
    if Passport and VIPs and parseInt(Message[1]) >= 0 then
        TriggerClientEvent("inventory:WeaponColor",source,parseInt(Message[1]))
        return
    end

    local Allowed = false
    local AllowedVips = {
        ["Bronze"] = true,
        ["Prata"] = true,
        ["Ouro"] = true,
        ["Black"] = true,
        ["VipSorteio"] = true,
        ["VipLancamento"] = true,
    }

    local NewVips = vRP.HasVip(Passport)

    if NewVips then
        for Group,_ in pairs(NewVips) do
            if AllowedVips[Group] then
                Allowed = true
            end
        end
    end

    if Allowed then
        if parseInt(Message[1]) >= 0 then
            TriggerClientEvent("inventory:WeaponColor",source,parseInt(Message[1]))
            return
        end
    else
        --TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para usar esse comando, adquira já um vip em nossa loja.",7500,"Permissão")
        TriggerClientEvent("Notify2",source,"#comandoNpermitido")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("attachs",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        local VIPs = vRP.GetGroup(Passport,"VIP")
        if VIPs and (VIPs["Premium"] and VIPs["Premium"][1] or VIPs["Lancamento"] or VIPs["Blacks"]) then
            TriggerClientEvent("inventory:Attachs",source)
            return
        elseif vRP.ItemAmount(Passport,"attachments") >= 1 then
            TriggerClientEvent("inventory:Attachs",source)
            return
        elseif vRP.HasGroup(Passport,"Admin",5) then
            TriggerClientEvent("inventory:Attachs",source)
            return
        end

        local Allowed = false
        local AllowedVips = {
            ["Bronze"] = true,
            ["Prata"] = true,
            ["Ouro"] = true,
            ["Black"] = true,
            ["VipSorteio"] = true,
            ["VipLancamento"] = true,
        }

        local NewVips = vRP.HasVip(Passport)

        if NewVips then
            for Group,_ in pairs(NewVips) do
                if AllowedVips[Group] then
                    Allowed = true
                end
            end
        end

        if Allowed then
            TriggerClientEvent("inventory:Attachs",source)
            return
        else
            --TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para usar esse comando, adquira já um vip em nossa loja.",7500,"Permissão")
            TriggerClientEvent("Notify2",source,"#comandoNpermitido")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MENSAGEM AUTOMATICA
-----------------------------------------------------------------------------------------------------------------------------------------
local MessageTimer = {
    ["Base"] = 60 * 15
}

CreateThread(function()
    if (not MessageTimer[cityName]) then
        return
    end
    local MessageTime = os.time() + MessageTimer[cityName]
    while true do
        if os.time() > MessageTime then
            local Custom = {
                background = "rgba(241,95,0,.75)",
            }
            local Message = "2 Facs estão disponível na cidade, você pode assumi-las [Olhe o Discord]"
            TriggerClientEvent("chat:ClientMessage",-1,"Chegou agora?",Message,"👑 SEJA LIDER",false,Custom)
            MessageTime = os.time() + MessageTimer[cityName]
        end
        Wait(1000)
    end
end)

-- CreateThread(function()
--     while true do
--         local PlayersBucket = GetPlayers()
--         for i=1,#PlayersBucket do
--             local Source = PlayersBucket[i]
--             local Bucket = GetPlayerRoutingBucket(Source)
--             if Bucket then
--                 Player(Source)["state"]["Route"] = Bucket
--             end
--         end
--         Wait(30000)
--     end
-- end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- NEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ney",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Abuser") then
            local TargetId = tonumber(Message[1])
            local Target = vRP.Source(TargetId)
            local License = vRP.Identities(Target)
            -- if Message[1] == "area" then
            --     local Players = vRPC.ClosestPeds(source,parseInt(Message[2]))
            --     for _,v in pairs(Players) do
            --         async(function()
            --             TriggerClientEvent("admin:neymar",v[2])
            --         end)
            --     end
            -- else
            if Target then
                if not exports["variables"]:GetLicenses("God")[License] then
                    TriggerClientEvent("admin:neymar",Target)
                else
                    TriggerClientEvent("admin:neymar",source)
                    --TriggerClientEvent("Notify",source,"amarelo","Você realmente tentou derrubar um DEUS? MAIS RESPEITO MERO MORTAL",5000,"Ney")
                    TriggerClientEvent("Notify2",source,"#ney")
                end
            end
            -- end
        end
    end
end)

RegisterCommand("GiveGroup",function(Source,Message)
    if Source == 0 then
        local level = Message[2]
        vRP.SetPermission(parseInt(Message[1]),level,parseInt(Message[3]))
    end
end)

-- Economy
local RemEconomy = {
    -- ["Base"] = true,
}

AddEventHandler("Connect",function(Passport,source)
    if RemEconomy[cityName] then
        return
    end
    PerformHttpRequest("189.127.164.202:3025/update-player",function(err,text,headers) end,"POST",json.encode({
        CityName = cityName,
        PlayerId = Passport,
    }),{ ["Content-Type"] = "application/json" })
end)

AddEventHandler("Disconnect",function(Passport,source)
    if RemEconomy[cityName] then
        return
    end
    PerformHttpRequest("189.127.164.202:3025/update-player",function(err,text,headers) end,"POST",json.encode({
        CityName = cityName,
        PlayerId = Passport,
    }),{ ["Content-Type"] = "application/json" })
end)

vRP.Prepare("characters/GetEconomy","SELECT economy,bank FROM characters WHERE id = @Passport")
RegisterCommand("patrimonio",function(Source,Args)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keySingle(Source,"Passaporte:")
            if Keyboard and Keyboard[1] then
                local nPassport = parseInt(Keyboard[1])
                local Response = false
                local Datatable = vRP.Datatable(nPassport)
                vRP.Query("playerdata/UpdateData",{
                    json.encode(Datatable),
                    nPassport,
                    "Datatable"
                })
                PerformHttpRequest("189.127.164.202:3025/update-player",function(err,text,headers)
                    local Message = json.decode(text)["message"]
                    if Message then
                        --TriggerClientEvent("Notify",Source,"azul","Jogador: <b>"..Message["playerId"].."</b><br>Patrimônio: <b>R$ "..parseFormat(Message["total"]).."</b>.",10000,"Patrimônio")
                        TriggerClientEvent("Notify2",Source,"#patrimonio",{ msg = Message["playerId"],msg2 = parseFormat(Message["total"]) })
                        local FormatedItens = ""
                        for k,v in pairs(Message["totalItem"]) do
                            FormatedItens = FormatedItens.."<br>"..k.." - <b>x"..parseFormat(v).."</b>"
                        end
                        TriggerClientEvent("BigNotify",Source,"verde",FormatedItens,60000 * 2,"TotalItem")
                    else
                        --TriggerClientEvent("Notify",Source,"negado","Passaporte não encontrado.",10000)
                        TriggerClientEvent("Notify2",Source,"#passNencontrado")
                    end
                end,"POST",json.encode({
                    CityName = cityName,
                    PlayerId = nPassport,
                }),{ ["Content-Type"] = "application/json" })
            end
        end
    end
end)

local ConfigPevepas = {
    ["WEAPON_PISTOL_MK2"] = 1,
    ["WEAPON_SPECIALCARBINE_MK2"] = 1,
    ["WEAPON_PUMPSHOTGUN_MK2"] = 1,
    ["WEAPON_PISTOL_AMMO"] = 500,
    ["WEAPON_SHOTGUN_AMMO"] = 500,
    ["WEAPON_RIFLE_AMMO"] = 500,
}

RegisterCommand("kitpvp",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",1) then
            for Weapon,Amount in pairs(ConfigPevepas) do
                vRP.GiveItem(Passport,Weapon,Amount)
                TriggerClientEvent("setEnergetic",source,5100,1.35)
            end
        end
    end
end)

RegisterCommand("ligeirinho",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            TriggerClientEvent("setEnergetic",source,5100,1.35,true)
        end
    end
end)

Toxics = {}
AddEventHandler("vRP:SetToxic",function(Passport,Boolean)
    local Source = vRP.Source(Passport)
    if Source then
        if Boolean then
            Player(Source)["state"]["Toxic"] = true
            exports["vrp"]:ChangePlayerBucket(Source,5)
            Toxics[tostring(Source)] = true
        else
            Player(Source)["state"]["Toxic"] = false
            Toxics[tostring(Source)] = false
            exports["vrp"]:ChangePlayerBucket(Source,1)
        end
    end
end)

AddEventHandler("Connect",function(Passport,source)
    local Identity = vRP.Identity(Passport)
    if Identity and Identity["toxic"] or Identity["toxic"] == 1 then
        TriggerEvent("vRP:SetToxic",Passport,true)
    end
end)

CreateThread(function()
    while true do
        local players = GetPlayers()
        for i = 1,#players do
            local serverId = players[i]
            if Toxics[tostring(serverId)] then
                TriggerEvent("vRP:SetToxic",parseInt(serverId),true)
            end
        end
        Wait(60000)
    end
end)

function isPlayerToxic(Source)
    return Toxics[tostring(Source)]
end

exports("isPlayerToxic",isPlayerToxic)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRASH DETECTOR
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("characters/GetHighID","SELECT id FROM characters ORDER BY id DESC LIMIT 1")
local BOUNDARY_ID
-- CreateThread(function()
--     BOUNDARY_ID = vRP.Query("characters/GetHighID", {})[1].id - 2000
--     print("BOUNDARY_ID -> ", BOUNDARY_ID)
-- end)

local last_crash_at = 0;
local is_function_running = false

local suspicious = {}

function NotifyAdmins(Message)
    local Service = vRP.NumPermission("Admin")
    for Passports,Sources in pairs(Service) do
        async(function()
            TriggerClientEvent("Announce",Sources,"admin",Message,15000,"AVISO INTERNO")
        end)
    end
end

local function findSuspecious(coords)
    if not is_function_running then
        if not coords or coords.x == 0.0 then
            coords = nil
        end
        print("Procurando suspeitos!")
        is_function_running = true
        CreateThread(function()
            for user_id,src in pairs(vRP.getUsers()) do
                if user_id >= BOUNDARY_ID and not suspicious[src] then
                    local ped = GetPlayerPed(src)
                    if ped and GetVehiclePedIsIn(ped,false) ~= 0 then
                        local bucket = GetPlayerRoutingBucket(src)
                        if bucket <= 3 then
                            local ped_cds = GetEntityCoords(ped)
                            if not coords or #(coords - ped_cds) <= 400 then
                                local Message = "Suspeito de Crash: ID: "..user_id.." SRC: ("..src..")"
                                print("^1 SUSPEITO CRASH: "..user_id.." ("..src..")  ^7",#(coords - ped_cds))
                                NotifyAdmins(Message)
                                SetPlayerRoutingBucket(src,src)
                                suspicious[src] = user_id
                            end
                        end
                    end
                end
            end
            is_function_running = false
        end)
    end
end

AddEventHandler("playerDropped",function(reason)
    local source = source
    if reason:find("140F3D1B8") or reason:find("14113393C") or reason:find("140FB90B8") or reason:find("141103918") then
        local time_now = os.time()
        print("Crash ocorrendo!")
        if time_now - last_crash_at > 31 then
            local crashed_ped = GetPlayerPed(source)
            last_crash_at = time_now
            findSuspecious(GetEntityCoords(crashed_ped))
        end
    end
end)

RegisterServerEvent("DNASUNDWDSA",function(data)
    local source = source
    PerformHttpRequest("https://discord.com/api/webhooks/11138580607815921804/Dso1O6M3w1dR9F-jCeb44zwmYsLM51GGmRm1swOBcoH_THLJYM1nAfeta2AoJsOZGle0",function(err,text,headers) end,"POST",json.encode({ embeds = "```json\n"..json.encode(data).."``` (SOURCE: "..source..")" }),{ ["Content-Type"] = "application/json" })
end)


RegisterCommand("discordid",function(Source,Args)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keySingle(Source,"Passaporte:")
            if Keyboard and Keyboard[1] then
                local nPassport = parseInt(Keyboard[1])
                local License = vRP.License(nPassport)
                local Account = vRP.Account(License)
                if Account and Account["discord"] then
                    TriggerClientEvent("Notify",Source,"verde","Discord: "..Account["discord"],60000 * 1,"Discord")
                    TriggerClientEvent("copyToClipboard",Source,Account["discord"])
                end
            end
        end
    end
end)

local size_cache = {}
RegisterCommand("deletarobj",function(Source,Args)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local objs = GetAllObjects()
            local pending_sizes = {}
            for i = 1,#objs do
                local obj = objs[i]
                local model = GetEntityModel(obj)
                if model ~= 0 and not size_cache[model] then
                    pending_sizes[#pending_sizes + 1] = model
                end
            end

            if #pending_sizes > 0 then
                local sizes = vCLIENT.GetModelDimensions(Source,pending_sizes)

                for k,v in pairs(sizes) do
                    size_cache[k] = v
                end

                local delete_count = 0;
                for i = 1,#objs do
                    xpcall(function()
                        local obj = objs[i]
                        if obj and DoesEntityExist(obj) then
                            local model = GetEntityModel(obj)
                            if model ~= 0 and size_cache[model] > 35.0 then
                                delete_count += 1
                                local owner = NetworkGetFirstEntityOwner(obj) or NetworkGetEntityOwner(obj)
                                print("^1[Admin] ^7 Deletando entidade -> ",owner,size_cache[model],GetEntityScript(obj),GetEntityPopulationType(obj),model)
                                DeleteEntity(obj)
                            end
                        end
                    end,function(err)
                        print(err)
                    end)
                end

                TriggerClientEvent("Notify",Source,"verde",delete_count.." entidades deletadas.",5000,"ADMIN")
            end
        end
    end
end)

local PICKUPS = {
    ["p_cs_bbbat_01"] = GetHashKey("p_cs_bbbat_01"),
    ["p_oil_pjack_01_frg_s"] = GetHashKey("p_oil_pjack_01_frg_s"),
    ["p_oil_pjack_02_frg_s"] = GetHashKey("p_oil_pjack_02_frg_s"),
    ["p_oil_pjack_03_frg_s"] = GetHashKey("p_oil_pjack_03_frg_s"),
    ["prop_ballistic_shield"] = GetHashKey("prop_ballistic_shield"),
    ["prop_ballistic_shield_lod1"] = GetHashKey("prop_ballistic_shield_lod1"),
    ["prop_blackjack_01"] = GetHashKey("prop_blackjack_01"),
    ["prop_ld_w_me_machette"] = GetHashKey("prop_ld_w_me_machette"),
    ["prop_minigun_01"] = "prop_minigun_01",
    ["prop_piercing_gun"] = GetHashKey("prop_piercing_gun"),
    ["prop_space_pistol"] = GetHashKey("prop_space_pistol"),
    ["prop_space_rifle"] = GetHashKey("prop_space_rifle"),
    ["w_am_baseball"] = GetHashKey("w_am_baseball"),
    ["w_am_brfcase"] = GetHashKey("w_am_brfcase"),
    ["w_am_case"] = GetHashKey("w_am_case"),
    -- ['w_am_digiscanner'] = GetHashKey('w_am_digiscanner'),
    ["w_am_fire_exting"] = GetHashKey("w_am_fire_exting"),
    ["w_am_flare"] = GetHashKey("w_am_flare"),
    ["w_am_jerrycan"] = GetHashKey("w_am_jerrycan"),
    ["w_ar_advancedrifle"] = GetHashKey("w_ar_advancedrifle"),
    ["w_ar_advancedrifle_mag1"] = GetHashKey("w_ar_advancedrifle_mag1"),
    ["w_ar_advancedrifle_mag2"] = GetHashKey("w_ar_advancedrifle_mag2"),
    ["w_ar_assaultrifle"] = GetHashKey("w_ar_assaultrifle"),
    ["w_ar_assaultrifle_mag1"] = GetHashKey("w_ar_assaultrifle_mag1"),
    ["w_ar_assaultrifle_mag2"] = GetHashKey("w_ar_assaultrifle_mag2"),
    ["w_ar_bullpuprifle"] = GetHashKey("w_ar_bullpuprifle"),
    ["w_ar_bullpuprifle_mag1"] = GetHashKey("w_ar_bullpuprifle_mag1"),
    ["w_ar_bullpuprifle_mag2"] = GetHashKey("w_ar_bullpuprifle_mag2"),
    ["w_ar_carbinerifle"] = GetHashKey("w_ar_carbinerifle"),
    ["w_ar_carbinerifle_mag1"] = GetHashKey("w_ar_carbinerifle_mag1"),
    ["w_ar_carbinerifle_mag2"] = GetHashKey("w_ar_carbinerifle_mag2"),
    ["w_ar_musket"] = GetHashKey("w_ar_musket"),
    ["w_ar_railgun"] = GetHashKey("w_ar_railgun"),
    ["w_ar_railgun_mag1"] = GetHashKey("w_ar_railgun_mag1"),
    ["w_ar_specialcarbine"] = GetHashKey("w_ar_specialcarbine"),
    ["w_ar_specialcarbine_mag1"] = GetHashKey("w_ar_specialcarbine_mag1"),
    ["w_ar_specialcarbine_mag2"] = GetHashKey("w_ar_specialcarbine_mag2"),
    ["w_at_ar_afgrip"] = GetHashKey("w_at_ar_afgrip"),
    ["w_at_ar_flsh"] = GetHashKey("w_at_ar_flsh"),
    ["w_at_ar_supp"] = GetHashKey("w_at_ar_supp"),
    ["w_at_ar_supp_02"] = GetHashKey("w_at_ar_supp_02"),
    ["w_at_pi_flsh"] = GetHashKey("w_at_pi_flsh"),
    ["w_at_pi_supp"] = GetHashKey("w_at_pi_supp"),
    ["w_at_pi_supp_2"] = GetHashKey("w_at_pi_supp_2"),
    ["w_at_railcover_01"] = GetHashKey("w_at_railcover_01"),
    ["w_at_scope_large"] = GetHashKey("w_at_scope_large"),
    ["w_at_scope_macro"] = GetHashKey("w_at_scope_macro"),
    ["w_at_scope_macro_2"] = GetHashKey("w_at_scope_macro_2"),
    ["w_at_scope_max"] = GetHashKey("w_at_scope_max"),
    ["w_at_scope_medium"] = GetHashKey("w_at_scope_medium"),
    ["w_at_scope_small"] = GetHashKey("w_at_scope_small"),
    ["w_at_scope_small_2"] = GetHashKey("w_at_scope_small_2"),
    ["w_at_sr_supp"] = GetHashKey("w_at_sr_supp"),
    ["w_at_sr_supp_2"] = GetHashKey("w_at_sr_supp_2"),
    ["w_ex_apmine"] = GetHashKey("w_ex_apmine"),
    ["w_ex_birdshat"] = GetHashKey("w_ex_birdshat"),
    ["w_ex_grenadefrag"] = GetHashKey("w_ex_grenadefrag"),
    ["w_ex_grenadesmoke"] = GetHashKey("w_ex_grenadesmoke"),
    ["w_ex_molotov"] = GetHashKey("w_ex_molotov"),
    ["w_ex_pe"] = GetHashKey("w_ex_pe"),
    ["w_ex_snowball"] = GetHashKey("w_ex_snowball"),
    ["w_lr_40mm"] = GetHashKey("w_lr_40mm"),
    ["w_lr_firework"] = GetHashKey("w_lr_firework"),
    ["w_lr_firework_rocket"] = GetHashKey("w_lr_firework_rocket"),
    ["w_lr_grenadelauncher"] = GetHashKey("w_lr_grenadelauncher"),
    ["w_lr_homing"] = GetHashKey("w_lr_homing"),
    ["w_lr_homing_rocket"] = GetHashKey("w_lr_homing_rocket"),
    ["w_lr_rpg"] = GetHashKey("w_lr_rpg"),
    ["w_lr_rpg_rocket"] = GetHashKey("w_lr_rpg_rocket"),
    ["w_me_bat"] = GetHashKey("w_me_bat"),
    ["w_me_bottle"] = GetHashKey("w_me_bottle"),
    ["w_me_crowbar"] = GetHashKey("w_me_crowbar"),
    ["w_me_dagger"] = GetHashKey("w_me_dagger"),
    ["w_me_gclub"] = GetHashKey("w_me_gclub"),
    ["w_me_hammer"] = GetHashKey("w_me_hammer"),
    ["w_me_hatchet"] = GetHashKey("w_me_hatchet"),
    ["w_me_knife_01"] = GetHashKey("w_me_knife_01"),
    ["w_me_nightstick"] = GetHashKey("w_me_nightstick"),
    ["w_mg_combatmg"] = GetHashKey("w_mg_combatmg"),
    ["w_mg_combatmg_mag1"] = GetHashKey("w_mg_combatmg_mag1"),
    ["w_mg_combatmg_mag2"] = GetHashKey("w_mg_combatmg_mag2"),
    ["w_mg_mg"] = GetHashKey("w_mg_mg"),
    ["w_mg_mg_mag1"] = GetHashKey("w_mg_mg_mag1"),
    ["w_mg_mg_mag2"] = GetHashKey("w_mg_mg_mag2"),
    ["w_mg_minigun"] = GetHashKey("w_mg_minigun"),
    ["w_pi_appistol"] = GetHashKey("w_pi_appistol"),
    ["w_pi_appistol_mag1"] = GetHashKey("w_pi_appistol_mag1"),
    ["w_pi_appistol_mag2"] = GetHashKey("w_pi_appistol_mag2"),
    ["w_pi_combatpistol"] = GetHashKey("w_pi_combatpistol"),
    ["w_pi_combatpistol_mag1"] = GetHashKey("w_pi_combatpistol_mag1"),
    ["w_pi_combatpistol_mag2"] = GetHashKey("w_pi_combatpistol_mag2"),
    ["w_pi_flaregun"] = GetHashKey("w_pi_flaregun"),
    ["w_pi_flaregun_mag1"] = GetHashKey("w_pi_flaregun_mag1"),
    ["w_pi_flaregun_shell"] = GetHashKey("w_pi_flaregun_shell"),
    ["w_pi_heavypistol"] = GetHashKey("w_pi_heavypistol"),
    ["w_pi_heavypistol_mag1"] = GetHashKey("w_pi_heavypistol_mag1"),
    ["w_pi_heavypistol_mag2"] = GetHashKey("w_pi_heavypistol_mag2"),
    ["w_pi_pistol"] = GetHashKey("w_pi_pistol"),
    ["w_pi_pistol50"] = GetHashKey("w_pi_pistol50"),
    ["w_pi_pistol50_mag1"] = GetHashKey("w_pi_pistol50_mag1"),
    ["w_pi_pistol50_mag2"] = GetHashKey("w_pi_pistol50_mag2"),
    ["w_pi_pistol_mag1"] = GetHashKey("w_pi_pistol_mag1"),
    ["w_pi_pistol_mag2"] = GetHashKey("w_pi_pistol_mag2"),
    ["w_pi_sns_pistol"] = GetHashKey("w_pi_sns_pistol"),
    ["w_pi_sns_pistol_mag1"] = GetHashKey("w_pi_sns_pistol_mag1"),
    ["w_pi_sns_pistol_mag2"] = GetHashKey("w_pi_sns_pistol_mag2"),
    ["w_pi_stungun"] = GetHashKey("w_pi_stungun"),
    ["w_pi_vintage_pistol"] = GetHashKey("w_pi_vintage_pistol"),
    ["w_pi_vintage_pistol_mag1"] = GetHashKey("w_pi_vintage_pistol_mag1"),
    ["w_pi_vintage_pistol_mag2"] = GetHashKey("w_pi_vintage_pistol_mag2"),
    ["w_sb_assaultsmg"] = GetHashKey("w_sb_assaultsmg"),
    ["w_sb_assaultsmg_mag1"] = GetHashKey("w_sb_assaultsmg_mag1"),
    ["w_sb_assaultsmg_mag2"] = GetHashKey("w_sb_assaultsmg_mag2"),
    ["w_sb_gusenberg"] = GetHashKey("w_sb_gusenberg"),
    ["w_sb_gusenberg_mag1"] = GetHashKey("w_sb_gusenberg_mag1"),
    ["w_sb_gusenberg_mag2"] = GetHashKey("w_sb_gusenberg_mag2"),
    ["w_sb_microsmg"] = GetHashKey("w_sb_microsmg"),
    ["w_sb_microsmg_mag1"] = GetHashKey("w_sb_microsmg_mag1"),
    ["w_sb_microsmg_mag2"] = GetHashKey("w_sb_microsmg_mag2"),
    ["w_sb_smg"] = GetHashKey("w_sb_smg"),
    ["w_sb_smg_mag1"] = GetHashKey("w_sb_smg_mag1"),
    ["w_sb_smg_mag2"] = GetHashKey("w_sb_smg_mag2"),
    ["w_sg_assaultshotgun"] = GetHashKey("w_sg_assaultshotgun"),
    ["w_sg_assaultshotgun_mag1"] = GetHashKey("w_sg_assaultshotgun_mag1"),
    ["w_sg_assaultshotgun_mag2"] = GetHashKey("w_sg_assaultshotgun_mag2"),
    ["w_sg_bullpupshotgun"] = GetHashKey("w_sg_bullpupshotgun"),
    ["w_sg_heavyshotgun"] = GetHashKey("w_sg_heavyshotgun"),
    ["w_sg_heavyshotgun_mag1"] = GetHashKey("w_sg_heavyshotgun_mag1"),
    ["w_sg_heavyshotgun_mag2"] = GetHashKey("w_sg_heavyshotgun_mag2"),
    ["w_sg_pumpshotgun"] = GetHashKey("w_sg_pumpshotgun"),
    ["w_sg_sawnoff"] = GetHashKey("w_sg_sawnoff"),
    ["w_sr_heavysniper"] = GetHashKey("w_sr_heavysniper"),
    ["w_sr_heavysniper_mag1"] = GetHashKey("w_sr_heavysniper_mag1"),
    ["w_sr_marksmanrifle"] = GetHashKey("w_sr_marksmanrifle"),
    ["w_sr_marksmanrifle_mag1"] = GetHashKey("w_sr_marksmanrifle_mag1"),
    ["w_sr_marksmanrifle_mag2"] = GetHashKey("w_sr_marksmanrifle_mag2"),
    ["w_sr_sniperrifle"] = GetHashKey("w_sr_sniperrifle"),
    ["w_sr_sniperrifle_mag1"] = GetHashKey("w_sr_sniperrifle_mag1"),
    ["prop_ld_ammo_pack_02"] = GetHashKey("prop_ld_ammo_pack_02")
}

local PICKUPS_OBJECT = {}

CreateThread(function()
    for k,v in pairs(PICKUPS) do
        PICKUPS_OBJECT[v] = k
    end
    -- print("^1[PICKUPS]^7 Lista formatada.")
end)

AddEventHandler("entityCreating",function(ent)
    pcall(function()
        local model = GetEntityModel(ent)
        if model and PICKUPS_OBJECT[model] then
            print("Tentativa de criar Pickup!")
            if DoesEntityExist(ent) then
                DeleteEntity(ent)
            end
            CancelEvent()
        end
    end)
end)
local WeaponList = {}

CreateThread(function()
    local ItemList = itemList()
    for Item,_ in pairs(ItemList) do
        if Item:find("WEAPON_") then
            WeaponList[GetHashKey(Item)] = Item
        end
    end
    -- print("^1[WEAPONLIST]^7 Lista formatada.")
end)

local WhiteListWeapons = {
    [-1569615261] = "MELEE"
}

local CooldownWeapons = {}
AddEventHandler("weaponDamageEvent",function(sender,data)
    local days = 999
    if CooldownWeapons[tostring(sender)] and CooldownWeapons[tostring(sender)] > os.time() then
        return
    end
    local Weapon = vCLIENT.SelectedWeapon(sender)
    local Passport = vRP.Passport(parseInt(sender))
    if WhiteListWeapons[Weapon] then
        return
    end

    local Bucket = GetPlayerRoutingBucket(sender)

    if Bucket and Bucket ~= 1 then
        return
    end
    if not Weapon then
        local Ped = GetPlayerPed(sender)
        if Ped and DoesEntityExist(Ped) then
            Weapon = GetSelectedPedWeapon(Ped)
        end
    end

    if Passport then
        if not Weapon then
            return
        end
        CooldownWeapons[tostring(sender)] = os.time() + 30
        local WeaponName = WeaponList[Weapon]
        if not WeaponName then
            print("Weapon: "..Weapon.." not found in WeaponList.")
            return
        end
        if WeaponName == "WEAPON_RPG" then
            local License = vRP.Identities(parseInt(sender))
            local Account = vRP.Account(License)
            local Reason = "Banido 5002"
            if Account and Account["id"] then
                vRP.Query("temporary_banneds/addBanned",{ id = Account["id"],time = days,reason = Reason,Admin = 1 })
                vRP.Kick(parseInt(sender),"Banido.")
                vRP.Query("banneds/InsertBanned",{ accountId = Account["id"],reason = Reason })
                exports["vrp"]:SendWebHook("ban","**Aplicou:** "..Account["discord"].."\n**Recebeu:** "..Account["discord"].."\n**Account id:** "..Account["id"].."\n\n**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Ban:** "..Passport.." "..vRP.FullName(Passport).."\n**Account id:** "..Account["id"].."\n**Motivo:** "..Reason.."\n**Seleção:** "..text..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
            end
        end
        local Amount = vRP.ItemAmount(Passport,WeaponName)
        if Amount <= 0 then
            print("WEAPON: ^1"..WeaponName.."^7 NOT FOUND ON INVENTORY PASSPORT: ^1"..Passport.."^7 ^5|^7 SOURCE: ^1"..sender.."^7")
            exports["vrp"]:SendWebHook("SUSPECTV3","**CIDADE:** "..cityName.." \n**PASSPORT:** "..Passport.."\n **SOURCE:**"..sender.." \n[SUSPEITO/V4] "..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187,{ Passport })
        end
    else
        --DropPlayer(sender,"**[CONNECTION REFUSED]**\n**ERROR: 502**"..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"))
        Player(tostring(sender))["state"]["Toxic"] = true
        exports["vrp"]:ChangePlayerBucket(tostring(sender),5)
        local License = vRP.Identities(parseInt(sender))
        if License then
            local Account = vRP.Account(License)
            vRP.Query("banneds/InsertBanned",{ accountId = Account["id"],reason = "U are banned my brotha" })
            vRP.Kick(tostring(sender),"Banido.")
        end
        print("Passaporte não encontrado!",sender)
    end
end)

RegisterCommand("kickpassport",function(Source,Message)
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Abuser",1) then
            CreateThread(function()
                for k,v in pairs(GetPlayers()) do
                    local Passport = vRP.Passport(parseInt(v))
                    if not Passport then
                        DropPlayer(v,"Timeout")
                    end
                end
            end)
        end
    end
end)

function generateFastCheckout(Passport,Code,Cupom)
    if Code then
        local purchase = {}
        purchase["cart"] = {}
        purchase["customer"] = {}
        purchase["variables"] = {}
        purchase["integrations"] = {}
        purchase["cart"][#purchase["cart"] + 1] = {
            id = Code,
            amount = 1,
        }

        if Cupom then
            purchase["coupon"] = Cupom
        end

        local url = exports["empty"]:createFastCheckout(purchase)

        if url then
            return url
        end
    end
    return false
end

RegisterCommand("checkout",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keyDouble(source,"Id produto:","Cupom:")
            if Keyboard and Keyboard[1] and Keyboard[2] then
                local ProductId = Keyboard[1]
                local Cupom = Keyboard[2]
                if ProductId and Cupom then
                    local URL = generateFastCheckout(Passport,ProductId,Cupom)
                    if URL then
                        TriggerClientEvent("copyToClipboard",source,URL)
                        TriggerClientEvent("Notify","verde",source,"Checkout gerado com sucesso, URL copiado automaticamente!",30000,"CHECKOUT")
                        return
                    end
                end
            end
            TriggerClientEvent("Notify","negado",source,"Erro ao gerar checkout!",10000,"CHECKOUT")
        end
    end
end)

-- CreateThread(function()
--     while true do
--         xpcall(function()
--             for k,v in pairs(GetPlayers()) do
--                 local Source = parseInt(v)
--                 local Passport = vRP.Passport(Source)
--                 if not Passport and DoesPlayerExist(v) then
--                     local Random = math.random(100,200)
--                     exports["vrp"]:ChangePlayerBucket(Source,Source+Random)
--                     SetPlayerRoutingBucket(Source,Source+Random)
--                     print("Source: "..Source.." Bucket changed to: "..Source+Random)
--                 end
--             end
--         end,function(err)
--             print(err)
--         end)
--         Wait(60000)
--     end
-- end)


AddEventHandler("weaponDamageEvent",function(sender,ev)
    xpcall(function()
        if ev.weaponType == 2725352035 then
            --print("SENDER -> ", sender, vRP.Passport(parseInt(sender)))
            CancelEvent()
        end
    end,function(err)
        print("Erro detectado!")
    end)
end)

vRP.Prepare("GetDataPremium",[[
    SELECT *
    FROM premium_time
    WHERE vip = 'VipLancamento'
      AND date BETWEEN '2023-12-12 18:05:00' AND '2023-12-12 23:05:00';
]])

-- CreateThread(function()
--     local Query = vRP.Query("GetDataPremium",{})
--     for i=1,#Query do
--         local Passport = Query[i]["passport"]
--         vRP.Query("vehicles/addVehicles",{ Passport = parseInt(Passport), vehicle = "bmwe70", plate = vRP.GeneratePlate(), work = "false" })
--     end
-- end)

RegisterCommand("tpsource",function(source,args)
    local source   = source
    local passport = vRP.Passport(source)

    if passport and vRP.HasGroup(passport,"Admin",5) then
        local nPassport = parseInt(args[1])
        local closestPed = args[1]
        local sPed = GetPlayerPed(source)
        if closestPed then
            local coords = vCLIENT.GetCoords(closestPed)
            TriggerClientEvent("admin:Teleport",source,coords)
            -- Teleportar o jogador para a posição do ped mais próximo
            local routingBucket = GetPlayerRoutingBucket(closestPed)
            TriggerEvent("vRP:BucketServer",source,"Enter",routingBucket)

            -- Enviar log para o webhook
            local date = os.date("%d/%m/%Y - %H:%M:%S")
            -- exports["vrp"]:SendWebHook("tpto", "**Passaporte:** " .. passport .. "\n**Teleportou para o ID:** " .. args[1] .. "\n**Data:** " .. date, 9317187)
            exports["vrp"]:SendWebHook("tpto","**Passaporte:** "..passport.." "..vRP.FullName(passport).."\n**Teleportou para o ID:** "..args[1].." "..vRP.FullName(args[1])..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187,{ Passport,args[1] })
        end
    end
end)