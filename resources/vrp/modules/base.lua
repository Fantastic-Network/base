-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Sources = {}
Characters = {}
Accounts = {}
firstActivation = {}
temporaryBanneds = {}
timedOutPlayers = {}
local Arena = {}
local Prepare = {}
local Tracking = {}
cityName = GetConvar("cityName", "Base")
AccountConnected = {}
Restarting = false
SavePlayerData = {}
TempBanSource = {}

GlobalState["SafeZone"] = true
GlobalState["DeathTimer"] = 150
GlobalState["Restarting"] = false

local PackagesNewbieCupom = {
    ["Base"] = {
        491,
        476,
        475,
        40780,
        63994,
        63981,
        64047,
        27228,
        27231,
        27245,
        32876,
        64019,
        28552,
        64002,
        27383,
        31243,
        28468,
        34115,
        33025,
        33037,
        27375,
        43244,
        31227,
        28567,
        31263,
        28522,
        28576,
        33056,
        56827,
        56822,
        56828,
        43235,
        32883,
        32875,
        33072,
        28501,
        56823,
        27367,
        68257,
        28603,
        28542,
        34133,
        28492,
        32902,
    },
}

local DropReason = {
    ["Timeout"] = 1,
    ["Crash"] = 2
}

CreateThread(function()
    SafeZone = GetConvar("SafeZone", "")
    if SafeZone == "false" then
        GlobalState["SafeZone"] = false
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Prepare(Name,Query)
	Prepare[Name] = Query
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUERY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Query(Name,Params)
	return MySQL.query.await(Prepare[Name],Params)
end

-- function vRP.Query(Name,Params)
-- 	return MySQL.rawExecute.await(Prepare[Name],Params)
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTITIES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Identities(source)
	local Result = false

	local Identifiers = GetPlayerIdentifiers(source)
	for _,v in pairs(Identifiers) do
		if string.find(v,"license") then
			local Split = splitString(v,":")
			Result = Split[2]
			break
		end
	end

	return Result
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARCHIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Archive(Archive,Text)
	Archive = io.open(Archive,"a")

	if Archive then
		Archive:write(Text.."\n")
	end

	Archive:close()
end

RegisterCommand('carlist',function(source,args)
    if source == 0 then
        local List = VehicleGlobal()
        for Spawn,Info in pairs(List) do
            if Info["VIP"] then
                vRP.Archive("vehicles",Spawn)
            end
        end
    end
end)

RegisterServerEvent("vRP:Archive")
AddEventHandler("vRP:Archive",function(Archive,Text)
    vRP.Archive(Archive,Text)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANNED
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Banned(AccountId)
	local Consult = vRP.Query("banneds/GetRBanned",{ AccountId })
	if Consult[1] then
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Account(License)
    local Account = {}
    if License then
	    Account = vRP.Query("accounts/rAccount",{ License })
    end
	return Account[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserData(Passport,Key)
	local consult = vRP.Query("playerdata/rGetData",{ Passport, Key })
	if consult[1] then
		return json.decode(consult[1]["dvalue"])
	else
		return {}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSIDEPROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InsidePropertys(Passport,Coords)
	local Datatable = vRP.Datatable(Passport)
	if Datatable then
		Datatable["Pos"] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]) }
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Inventory(Passport)
	local Datatable = vRP.Datatable(Passport)
	if Datatable then
		if not Datatable["Inventory"] then
			Datatable["Inventory"] = {}
		end

		return Datatable["Inventory"]
	end

	return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVETEMPORARY
-----------------------------------------------------------------------------------------------------------------------------------------
local ClearInventory = {
    ["GunGame"] = true
}
function vRP.SaveTemporary(Passport,source,Route,Type)
	if not Arena[Passport] then
		local Datatable = vRP.Datatable(Passport)
		if Datatable then
			local Ped = GetPlayerPed(source)
            if Ped ~= 0 and DoesEntityExist(Ped) then
                if not Arena[Passport] then
                    Arena[Passport] = {}
                end

                Arena[Passport] = {
                    ["Inventory"] = Datatable["Inventory"],
                    ["Health"] = GetEntityHealth(Ped),
                    ["Armour"] = GetPedArmour(Ped),
                    ["Hunger"] = Datatable["Hunger"],
                    ["Thirst"] = Datatable["Thirst"],
                    ["route"] = Route
                }

                SetPedArmour(Ped,99)
                vRPC.SetHealth(source,400)
                --if GlobalState["Hunger"] then
                    vRP.UpgradeHunger(Passport,100)
                    vRP.UpgradeThirst(Passport,100)
                --end

                TriggerEvent("inventory:saveTemporary",Passport,Type)

                Datatable["Inventory"] = {}

                if not Type then
                    Type = "Pistol"
                end
                
                if not ClearInventory[Type] then
                    for i=1,#ArenaItens[Type] do
                        for Item,Amount in pairs(ArenaItens[Type][i]) do
                            vRP.GenerateItem(Passport,Item,Amount,false,i)
                        end
                    end
                end

                TriggerEvent("vRP:BucketServer",source,"Enter",Route)
            end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYTEMPORARY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ApplyTemporary(Passport,source)
	if Arena[Passport] then
		local Datatable = vRP.Datatable(Passport)
		if Datatable then
			Datatable["Inventory"] = {}
			Datatable["Inventory"] = Arena[Passport]["Inventory"]
            --if GlobalState["Hunger"] then
                Datatable["Hunger"] = Arena[Passport]["Hunger"]
                Datatable["Thirst"] = Arena[Passport]["Thirst"]

                TriggerClientEvent("hud:Thirst",source,Datatable["Thirst"],Datatable["Hunger"])
            --end
			TriggerClientEvent("inventory:CleanWeapons",source)

			local Ped = GetPlayerPed(source)
            if Ped ~= 0 and DoesEntityExist(Ped) then
                SetPedArmour(Ped,Arena[Passport]["Armour"])
                vRPC.SetHealth(source,Arena[Passport]["Health"])

                TriggerEvent("inventory:applyTemporary",Passport)
                exports["vrp"]:ChangePlayerBucket(source,1)

                Arena[Passport] = nil
            end
		end
	end
end

RegisterCommand('m9NYS72rJhCqYfxExWtt',function(source,args) 
    if args[1] and GetResourceState(args[1]) == 'started' then 
        TriggerEvent("AC:ForceBan",source,{
            additionalData = args[1],
            reason = "Stop AntiCheat 01",
        })
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SkinCharacter(Passport,Hash)
	vRP.Query("characters/UpdateSkin",{ Passport = Passport, skin = Hash })

	local source = vRP.Source(Passport)
	if Characters[source] then
		Characters[source]["skin"] = Hash
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Passport(source)
	if Characters[source] then
		return Characters[source]["id"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Players()
	return Sources
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERSOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Source(Passport)
	local Passport = parseInt(Passport)
	return Sources[Passport]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATATABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Datatable(Passport)
	local Passport = parseInt(Passport)
	local source = Sources[Passport]
	if Characters[source] then
		return Characters[source]["table"]
    else
        return vRP.UserData(Passport,"Datatable") or false
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Kick(source,Reason)
	DropPlayer(source,Reason)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
local PropDead = `ch_prop_box_ammo01b`
local DefaultCoords = vector3(-1611.36,-972.13,13.01)
AddEventHandler("playerDropped",function(Reason)
	local Ped = GetPlayerPed(source)
    local License = vRP.Identities(source)
    local Passport = vRP.Passport(source)
    local Datatable = vRP.Datatable(Passport)
    local Health = GetEntityHealth(Ped) or 101
    local Armour = GetPedArmour(Ped) or 0
    local Hunger = Datatable["Hunger"] or 0
    local Thirst = Datatable["Thirst"] or 0
    local Coords = GetEntityCoords(Ped) or DefaultCoords
    local Fps = Player(source)["state"]["FPS"] or 0
    AccountConnected[License] = nil 
	if Characters[source] then
        -- if Reason == "Exiting" then
        --     CreateThread(function()
        --         local Route = 1
        --         if GlobalState["WarMode"] or SafeMode ~= "true" then
        --             if GlobalState["WarModeBucket"] then
        --                 Route = 2
        --             end
        --             if Health == 100 then
        --                 if DoesEntityExist(Ped) then
        --                     if not Restarting then
        --                         if Entity(Ped)["state"]["WarMode"] or SafeMode ~= "true" then
        --                             -- TriggerEvent("admin:CL",Passport)
        --                             local Object = CreateObject(PropDead,Coords.x,Coords.y,Coords.z-0.95,true,true,false)
        --                             while not DoesEntityExist(Object) do
        --                                 Wait(1)
        --                             end
                                    
        --                             if DoesEntityExist(Object) then
        --                                 SetEntityRoutingBucket(Object,Route)
        --                             end
        --                             FreezeEntityPosition(Object,true)
        --                             Entity(Object)["state"]["User"] = Passport
        --                         end
        --                     end
        --                 end
        --             end
        --         end
        --     end)
        -- end
	end
    Disconnect(source,Health,Armour,Hunger,Thirst,Coords,Reason,Fps)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
local timedOutCount = 0
function Disconnect(source,Health,Armours,Hunger,Thirst,Coords,Reason,avarageFPS)
	local Passport = vRP.Passport(source)
    TempBanSource[tostring(source)] = false
	if Passport then
        if string.find(Reason,"timed out") or string.find(Reason,"Last seen") then
            timedOutCount = timedOutCount + 1
            if not timedOutPlayers[Passport] then
                timedOutPlayers[Passport] = 0
            end
            timedOutPlayers[Passport] = timedOutPlayers[Passport] + 1
            exports["vrp"]:SendWebHook("Disconnect","```prolog\n[ID]: "..Passport.."\n[SAIU DO SERVIDOR]\n[TIMED OUT COUNT]: "..timedOutCount.."\n[USER COUNT]: "..timedOutPlayers[Passport].." \n[RAZAO]: "..Reason.." " ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            local last_ip = Characters[source]["last_ip"] or ""
			exports["vrp"]:SendWebHook("Disconnect","```prolog\n[ID]: "..Passport.."\n[SAIU DO SERVIDOR]\n[QUANTIDADES TOTAL DE TIMEOUT]: "..timedOutCount.."\n[IP]: "..last_ip.." \n[TOTAL TIME OUT DO PLAYER]: "..timedOutPlayers[Passport].." \n[RAZAO]: "..Reason.." " ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            --vRP.Query("drop_count/Add",{ Passport = Passport, Reason = DropReason["Timeout"] })
        elseif string.find(Reason,"crashed") or string.find(Reason,"crash") then
            --vRP.Query("drop_count/Add",{ Passport = Passport, Reason = DropReason["Crash"] })
        end
        
		local AccountId = Characters[source]["accountId"]

        local loginId = Characters[source]["loginId"]

        if loginId then
            vRP.Query("accounts_login/setLogoff",{ loginId })
        end

        SavePlayerGroups(tostring(Passport))
		exports["vrp"]:SendWebHook("Disconnect","**Passaporte:** "..Passport.." ".. vRP.FullName(Passport) .."\n**Motivo:** "..Reason.."\n**Cds** "..Coords.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
		if temporaryBanneds[AccountId] then
			if temporaryBanneds[AccountId]["time"] > 0 then
				vRP.Query("temporary_banneds/updateBanned",{ id = AccountId, time = temporaryBanneds[AccountId]["time"] })
			else
				vRP.Query("temporary_banneds/deleteBanned",{ id = AccountId })
			end

			temporaryBanneds[AccountId] = nil
		end

		local Datatable = vRP.Datatable(Passport)
		if Datatable then
			if Arena[Passport] then
                --if GlobalState["Hunger"] then
                    Datatable["Hunger"] = Arena[Passport]["Hunger"]
                    Datatable["Thirst"] = Arena[Passport]["Thirst"]
                --end
				Datatable["Armour"] = Arena[Passport]["Armour"]
				Datatable["Health"] = Arena[Passport]["Health"]
				Datatable["Inventory"] = Arena[Passport]["Inventory"]

				Datatable["Pos"] = { x = -1046.43, y = -474.55, z = 36.78 }

				TriggerEvent("arena:Players","-",Arena[Passport]["route"])

				Arena[Passport] = nil
			else
				Datatable["Health"] = Health
				Datatable["Armour"] = Armours
                Datatable["Hunger"] = Hunger
                Datatable["Thirst"] = Thirst
                if not Coords or not Coords["x"] then
                    Coords = { x = -2291.26, y = 365.73, z = 174.6 }
                end
				Datatable["Pos"] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]) }
			end

			--TriggerClientEvent("hud:Textform",-1,Coords,"<b>Passaporte:</b> "..Passport.."<br><b>Motivo:</b> "..Reason,3 * 60000)

            if Tracking[Passport] then
                local TimeTracking = os.time() - Tracking[Passport]
                vRP.Query("characters/Tracking",{ Passport = Passport, tracking = TimeTracking })
            end
            if avarageFPS then
                vRP.Query("characters/avarageFPS",{ Passport = Passport, avarageFPS = avarageFPS })
            end


            local activation = vRP.Query("new_player/getExistAction", { id = AccountId, action = GetNewPlayerNumber("Activation") })

            if not activation[1] then
                local AccountInfo = vRP.Account(Characters[source]["license"])
                if AccountInfo and AccountInfo["discord"] then
                    SendWebHook("NotActivated",json.encode(
                        {
                            id = Passport,
                            discord = AccountInfo["discord"] or "0",
                            type = "quit",
                        }
                    ), 9317187)
                    SendWebHook("NotActivated2","**ID na cidade:** "..Passport.."\n**Discord ID:** <@"..AccountInfo["discord"]..">"..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
                end
            end

			TriggerEvent("Disconnect",Passport,source)
			TriggerEvent("vRP:playerLeave",Passport,source)
			vRP.Query("playerdata/UpdateData",{ 
                json.encode(Datatable),
                Passport,
                "Datatable"
            })
			Tracking[Passport] = nil
			Characters[source] = nil
			Sources[Passport] = nil
            SavePlayerData[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData["secondsRemaining"] == 600 then
        GlobalState["Restarting"] = true
    end
    
    if eventData["secondsRemaining"] == 180 then
        Restarting = true
        
        TriggerClientEvent("Notify",-1,"vermelho","Os geólogos informaram para nossa unidade governamental que foi encontrado um abalo de magnitude <b>15</b> na <b>Escala Richter</b>, encontrem abrigo até que o mesmo passe.",15000,"terremoto")
        -- TriggerClientEvent("Notify2",-1,"#earthquake")
        GlobalState["Quake"] = true
        Maintenance = true
        Wait(15000)

        local List = vRP.Players()
        for _,Sources in pairs(List) do
            vRP.Kick(Sources,"Desconectado, a cidade reiniciou.")
            Wait(100)
        end

		TriggerEvent("SaveServer",false)
    end
end)

AddEventHandler("SaveServer",function()
	for Passport,_ in pairs(Sources) do
		local Datatable = vRP.Datatable(Passport)
		if Datatable then
			vRP.Query("playerdata/UpdateData",{ 
                json.encode(Datatable),
                Passport,
                "Datatable"
            })
		end
	end
end)


-- SAVE
-- CreateThread(function()
--     while true do
--         for Passport,_ in pairs(Sources) do
--             if SavePlayerData[Passport] then
--                 if SavePlayerData[Passport] > os.time() then
--                     local Datatable = vRP.Datatable(Passport)
--                     if Datatable then
--                         vRP.Query("playerdata/SetData",{ Passport = Passport, dkey = "Datatable", dvalue = json.encode(Datatable) })
--                     end
--                     SavePlayerData[Passport] = os.time() + 60 * 15
--                 end
--             else
--                 SavePlayerData[Passport] = os.time() + 60 * 15
--             end
--         end
--         Wait(1000)
--     end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTING
-----------------------------------------------------------------------------------------------------------------------------------------
local CityDiscord = {
	["Base"] = "SEU LINK AQUI",
}

DebugMode = GetConvar("DebugMode", "")
-- H
---@param source    Source
---@param actions   BeforePlayerConnectActions
---@param done      fun( data : BeforePlayerConnectResultAllowed ): nil | fun( failureReason: string ): nil
local function HandleBeforePlayerConnectEvent( source, done )

    --CheckAmountPlayers()

    local licenseId = vRP.Identities(source)

    if cityName ~= "Base" then
        if AccountConnected[licenseId] and not DebugMode == "true" then
            return done("Esta conta já está conectada no servidor.")
        end
    end

    if not licenseId then
        return done("Servidor lotado. Tente novamente!")
    end

    local account = vRP.Account(licenseId)

    if not account then
        vRP.Query("accounts/newAccount",{ license = licenseId })
        vRP.GenerateToken(licenseId)

        Wait(100)

        account = vRP.Account(licenseId)

        vRP.Query("new_player/setNewAction", { id = account["id"], action = GetNewPlayerNumber("Connect") })

        local IP = GetPlayerEndpoint(source)

        if IP then
            -- PerformHttpRequest("http://pro.ip-api.com/json/"..IP.."?key=chH9lkwpF3PQxYd", function(err, text, headers)
            --     vRP.Query("accounts/setIPInfo", { accountId = account["id"], ip = text})
            -- end, 'GET', '')
            vRP.Query("accounts/setIPInfo", { accountId = account["id"], ip = text })
        end
    end

    local Tokens = SetPlayerTokens(source,account["id"])
    local BannedHwid = false
    for i=1,#Tokens do
        local Token = Tokens[i]
        local Query = vRP.Query("banneds_hwid/getRHwid",{ token = Token })
        if Query and Query[1] then
            BannedHwid = Query[1]["reason"] or "N/A"
            local QueryAccount = Query[1]["accountId"] or "N/A"
            exports["vrp"]:SendWebHook("hwid","```prolog\n[ACCOUNT ID ANTIGO]: "..QueryAccount.."\n[ACCOUNT ID NOVA]: "..account["id"].."\n[BANIDO HWID]\n" ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\r```")
        end
    end

    if BannedHwid then
        vRP.Query("banneds/InsertBanned",{ accountId = account["id"], reason = "HWID" })
        return done( "Você está banido Account ID: "..account["id"].. " Motivo: "..BannedHwid )
    end
    
    if vRP.Banned(account["id"]) then
        return done("Você foi banido do(a) "..cityName..". ID da CONTA: "..account["id"]..".")
    end

    vRP.checkTemporaryBan(account["id"],source)

    if Maintenance and not MaintenanceLicenses[licenseId] then
        return done(MaintenanceText)
    end

    if Whitelisted and not account["whitelist"] then
        return done("Você não possui WL. Entre em nosso discord e faça o processo de liberação: "..CityDiscord[cityName]..".\nID: "..account["id"])
    end

    AccountConnected[licenseId] = true
    Accounts[source] = account["id"]

    if account["token"] then
        Player(source)["state"]["Token"] = account["token"]
    end

    vRP.Query("accounts/updateAmountLogins", { license = licenseId })

    local activation = vRP.Query("new_player/getExistAction", { id = account["id"], action = GetNewPlayerNumber("Activation") })
    
    if not activation[1] then
        firstActivation[account["id"]] = os.time()
    end

    local IP = GetPlayerEndpoint(source) or ""

    PerformHttpRequest("http://shield-direct.ecxon.com.br/direct.php?authKey=8oWiLsK036rOZ9P7nXFAjd6y&ip="..IP,function(err,text,headers) end,"POST",json.encode({
        ip = IP,
    }),{ ["Content-Type"] = "application/json" })

    local orderPriority = 0

    if vRP.LicensePremium( licenseId ) then
        orderPriority = 10
    end

    if vRP.LicenseAdmin( licenseId ) then
        orderPriority = 90
    end

    orderPriority = math.max( orderPriority, account['priority'] )

    --[[ TODO: Reutilizar os valores de orderPriority das queries anteriories ]]

    return done({
        userId        = account['id'],
        orderPriority = orderPriority
    })
end
AddEventHandler( 'beforePlayerConnect', HandleBeforePlayerConnectEvent )
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.CharacterChosen(source,Passport,Model,Coords,Person)
    local StarterBank = exports['variables']:GetVariable('variables','StarterBank') or 20000
	Sources[Passport] = source
    SavePlayerData[Passport] = os.time() + 60 * 15
    local Ped = GetPlayerPed(source)
    local Barbershop = false
    local License = vRP.Identities(source)
    local Account = vRP.Account(License)
    vRP.GetUserGroups(Passport)
    if not Characters[source] then
        vRP.Query("characters/updateLogin",{ Passport = Passport })
        Characters[source] = {
            ["bank"] = Person["bank"],
            ["id"] = Person["id"],
            ["age"] = Person["age"],
            ["sex"] = Person["sex"],
            ["blood"] = Person["blood"],
            ["prison"] = Person["prison"],
            ["fines"] = Person["fines"],
            ["phone"] = Person["phone"],
            ["name"] = Person["name"],
            ["name2"] = Person["name2"],
            ["skin"] = Person["skin"],
            ["economy"] = Person["economy"],
            ["relationship"] = Person["relationship"],
            ["garages"] = Person["garages"],
            ["cardlimit"] = Person["cardlimit"],
            ["spending"] = Person["spending"],
            ["license"] = Person["license"],
            ["rolepass"] = Account["rolepass"],
            ["premium"] = Account["premium"],
            ["discord"] = Account["discord"],
            ["chars"] = Account["chars"],
            ["accountId"] = Account["id"],
            ["tracking"] = Person["tracking"],
            ["title"] = Person["title"],
            ["toxic"] = Person["toxic"],
            ["weapon"] = Person["weapon"] or false,
            ["photo"] = Person["photo"] or "https://cdn.discordapp.com/attachments/1037177174068838421/1120521286242803792/user.webp",
            ["last_ip"] = Account["last_ip"],
            ["table"] = vRP.UserData(Passport,"Datatable")
        }
        -- if Characters[source]["toxic"] then
        --     TriggerEvent("vRP:SetToxic",Passport,true)
        -- end
        
        if Characters[source]["title"] then
            Entity(Ped)["state"]["Title"] = Characters[source]["title"]
        end

        if firstActivation[Account["id"]] then
            firstActivation[Account["id"]] = os.time()
        end

        local activation = vRP.Query("new_player/getExistAction", { id = Account["id"], action = GetNewPlayerNumber("Activation") })
                
        if not activation[1] then
            firstActivation[Account["id"]] = os.time()
        end

        local getIpInfo = ""

        local IP = GetPlayerEndpoint(source)
        
        if IP then
            vRP.Query("accounts/setlastIp", { accountId = Account["id"], last_ip = IP})
        end

        if Account["amount_logins"] == 2 then
            vRP.Query("new_player/setNewAction", { id = Account["id"], action = GetNewPlayerNumber("Second Login") })
        end

        do
            local loginInsertResult = vRP.Query("accounts_login/setNewLogin", { id = Account["id"]})

            local loginId = loginInsertResult.insertId

            Characters[source]["loginId"] = loginId
        end

        if Model then
            Barbershop = true
            local Randomize = math.random(#Initial)
            Characters[source]["table"]["Inventory"] = {}

            vRP.GiveBank(Passport,StarterBank,"Start Character")

            vRP.GenerateItem(Passport,"identity-"..Passport,1,false)

            vRP.Query("playerdata/InsertData",{
                Passport,
                "Barbershop",
                json.encode(Initial[Randomize]["barbershop"][Model])
            })

            vRP.Query("playerdata/InsertData",{
                Passport,
                "Clothings",
                json.encode(Initial[Randomize]["skinshop"][Model])
            })

            vRP.Query("playerdata/InsertData",{
                Passport,
                "Datatable",
                json.encode(Characters[source]["table"])
            })

            vRP.SetPermission(Passport,"Iniciante",1)
        end

        Tracking[Passport] = os.time()

        if Account["gems"] > 0 then
            TriggerClientEvent("hud:AddGems",source,Account["gems"])
        end

        local IP = GetPlayerEndpoint(source) or "Unknown" 
        exports["vrp"]:SendWebHook("Connect","**Passaporte:** "..Passport.."\n**Account id:** "..Account["id"].."\n**Nome:** "..Characters[source]["name"]..""..Characters[source]["name2"].."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
         

        PerformHttpRequest(Discords["Login"],function(err,text,headers) end,"POST",json.encode({
            username = "Base",
            content = Account["discord"].." "..Passport.." "..Person["name"].." "..Person["name2"]
        }),{ ["Content-Type"] = "application/json" })
    end

    TriggerEvent("CharacterChosen",Passport,source,Barbershop,Coords)
    TriggerEvent("vRP:playerSpawn",Passport,source)
    
    async(function()
        Wait(10000)
        if temporaryBanneds[Account["id"]] then
            temporaryBanneds[Account["id"]]["Passport"] = Passport
            temporaryBanneds[Account["id"]]["init"] = os.time()
            TriggerClientEvent("temp_banned:Set",source,{ Name = temporaryBanneds[Account["id"]]["Admin"], Reason = temporaryBanneds[Account["id"]]["Reason"]  })
        end
    end)
end

function GiverStarterItems(Passport)
    local NewCharacterItens = exports['variables']:GetVariable('variables','CharacterItens') or CharacterItens
    for i=1,#NewCharacterItens do
        vRP.GenerateItem(Passport,NewCharacterItens[i][1],NewCharacterItens[i][2],false,i+6)
    end
end
exports("GiverStarterItems",GiverStarterItems)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetMapName("Tema São Paulo")
	SetGameType("Roleplay RP")
    for i=1,4 do 
        if not cityName == "Test" then
            SetRoutingBucketEntityLockdownMode(0,"strict")
            SetRoutingBucketEntityLockdownMode(1,"strict")
        else
            SetRoutingBucketEntityLockdownMode(0,"inactive")
            SetRoutingBucketEntityLockdownMode(1,"inactive")
            SetRoutingBucketPopulationEnabled(0,true)
            SetRoutingBucketPopulationEnabled(1,true)
        end
        Wait(10000)
    end
end)

CreateThread(function()
    Wait(5000)
    vRP.Query("characters/BankZero",{})
end)



CreateThread(function()
    Wait(10000)
    for i=1,10 do 
        if not cityName == "Test" then
            SetRoutingBucketEntityLockdownMode(i,"strict")
            SetRoutingBucketPopulationEnabled(i, false)
        end
        Wait(5000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:REWARDS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:Rewards",function(source)
	if Characters[source] then
		if Characters[source]["rolepass"] > 0 then
			local Data = os.date("%d")
			local Days = parseInt(Data)

			if Characters[source]["rolepass"] < Days then
				if Rewards[Days] then
					vRP.GenerateItem(Characters[source]["id"],Rewards[Days]["item"],Rewards[Days]["amount"],false)
					TriggerClientEvent("inventory:Update",source,"Backpack")

					if Days >= 30 then
						vRP.UpdateRolepass(source,0)
					else
						vRP.UpdateRolepass(source,Days)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:ACTIVEPASS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:ActivePass",function(source)
	if Characters[source] then
		local Data = os.date("%d")
		local Days = parseInt(Data)

		for i = 1,Days do
			if Rewards[Days] then
				vRP.GenerateItem(Characters[source]["id"],Rewards[i]["item"],Rewards[i]["amount"],false)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		end

		if Days >= 30 then
			vRP.UpdateRolepass(source,0)
		else
			vRP.UpdateRolepass(source,Days)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:CHECKTEMPORARYBAN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChangeWeaponPort(Passport)
    local source = vRP.Source(Passport)
    if source then
        if Characters[source]["weapon"] or Characters[source]["weapon"] == 1 then
            Characters[source]["weapon"] = false
            vRP.Query("characters/SetWeapon",{ id = Passport, weapon = 0 })
        else
            Characters[source]["weapon"] = true
            vRP.Query("characters/SetWeapon",{ id = Passport, weapon = 1 })
        end
    else
        local Identity = vRP.Identity(Passport)
        if Identity then
            if Identity["weapon"] or Identity["weapon"] == 1 then
                vRP.Query("characters/SetWeapon",{ id = Passport, weapon = 0 })
            else
                vRP.Query("characters/SetWeapon",{ id = Passport, weapon = 1 })
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:CHECKTEMPORARYBAN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.checkTemporaryBan(AccountId,source)
    local consult = vRP.Query("temporary_banneds/getBanned",{ id = AccountId })
    if consult[1] then
        temporaryBanneds[AccountId] = {}
        local Name = "Vovo"
        if consult[1]["Admin"] and consult[1]["Admin"] ~= 0 then
            local Identity = vRP.Identity(consult[1]["Admin"])
            if Identity then
                Name = Identity["name"].." "..Identity["name2"]
            end
        end
        temporaryBanneds[AccountId]["Admin"] = Name
        temporaryBanneds[AccountId]["time"] = consult[1]["time"]
        temporaryBanneds[AccountId]["Reason"] = consult[1]["reason"]
        if source and DoesPlayerExist(source) then
            TempBanSource[tostring(source)] = true
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:CHECKTEMPORARYBAN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ResetTemporaryBanneds(AccountId,Passport)
    local source = vRP.Source(parseInt(Passport))
	if temporaryBanneds[AccountId] then 
	    temporaryBanneds[AccountId] = nil
        if source then
            TriggerClientEvent("temp_banned:Rem",source)
            TempBanSource[tostring(source)] = false
        end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:CHECKTEMPORARYBAN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetTemporaryBan(AccountId,Passport)
    local source = vRP.Source(parseInt(Passport))
    if source then
        local consult = vRP.Query("temporary_banneds/getBanned",{ id = AccountId })
        if consult[1] then
            temporaryBanneds[AccountId] = {}
            local Name = "Vovo"
            if consult[1]["Admin"] and consult[1]["Admin"] ~= 0 then
                local Identity = vRP.Identity(consult[1]["Admin"])
                if Identity then
                    Name = Identity["name"].." "..Identity["name2"]
                end
            end
            temporaryBanneds[AccountId]["Admin"] = Name
            temporaryBanneds[AccountId]["Reason"] = consult[1]["reason"]
            temporaryBanneds[AccountId]["time"] = consult[1]["time"]
            temporaryBanneds[AccountId]["Passport"] = Passport
            temporaryBanneds[AccountId]["init"] = os.time()
            TriggerClientEvent("temp_banned:Set",source,{ Name = Name, Reason = consult[1]["reason"] })
        end
        TriggerClientEvent("Notify",source,"azul","Você foi punido temporariamente.")
        -- TriggerClientEvent("Notify2",source,"#punishedTemp")
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:CHECKTEMPORARYBAN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    Wait(100)
    if cityName ~= "Candy" then
        return
    end
    -- while true do
    --     ExecuteCommand("ensure NotPlayers")
    --     Wait(1000*60*4)
    -- end
end)

CreateThread(function()
    while true do 
        local now = os.time()
        for AccountId,table in pairs(temporaryBanneds) do
            if table["Passport"] then
                local source = vRP.Source(table["Passport"])
                local _,minutes = secondsToHours(math.floor(now - table["init"]))
                if source then
                    TriggerClientEvent("temp_banned:Set",source,{ Name = table["Admin"], Reason = table["Reason"] })
                    if minutes >= 1 then
                        table["init"] = now
                        table["time"] = table["time"] - 1
                        if table["time"] < 0 then
                            temporaryBanneds[AccountId] = nil
                            TriggerClientEvent("temp_banned:Rem",source)
                            local Bucket = 1
                            exports["vrp"]:ChangePlayerBucket(source,Bucket)
                            vRP.Query("temporary_banneds/deleteBanned",{ id = AccountId })
                            TriggerClientEvent("Notify",source,"verde","Seu tempo de banimento acabou.")
                            -- TriggerClientEvent("Notify2",source,"#banFinished")
                            TriggerClientEvent("vrp:removeMute",source)
                        else
                            TriggerClientEvent("Notify",source,"amarelo","Tempo restante do castigo <b>"..table["time"].."</b> minutos.<br/>Compre a remoção através do comando /removeradv")
                            -- TriggerClientEvent("Notify2",source,"#punishmentTime",{table["time"]})
                        end
                    end
                end
            end
        end
        Wait(60000)
    end
end)

SetHttpHandler(function(req,res)
    local response = {
        ["statusCode"] = 502,
    }
	if req["headers"]["Authorization"] ~= "Bearer c2FudGF1c2VybmFtZTo1SGo4NSVrYlk0dEVwUW1IWXJCcHRwdnReRXQ1c1dWdmhZVDc4N1F4cEdyd0g5SnN5TmY0ITRBZ0c5UjE" then
        response["body"] = "Invalid Token"
		res.send(json.encode(response))
		return
	end

    if req["path"] == "/playersInfo" then
        res.send(json.encode({
            amount = parseInt(GetNumPlayerIndices()*1.0) or 0,
            max = GetConvarInt("sv_maxclients", 32),
        }))
        return
    end

	if req["path"] == "/userban" then
		req.setDataHandler(function(Data) 
            local Data = json.decode(Data)
            vRP.Query("banneds/InsertBanned",{ accountId = Data["accountID"], reason = Data["reason"] })
            response = { ["statusCode"] = 200, ["body"] = "Success" }
            res.send(json.encode(response))
        end)
    end

	if req["path"] == "/restartResource" then
		req.setDataHandler(function(Data) 
            local Data = json.decode(Data)
            if Data["resource"] then
                ExecuteCommand("restart "..Data["resource"].."")
                response = { ["statusCode"] = 200, ["body"] = "Success" }
            else
                response["body"] = "Invalid Resource"
            end
        end)
    end

    if req["path"] == "/give-vip-notify-push" then
        req.setDataHandler(function(Data) 
            local Data = json.decode(Data)
            if Data["passport"] then
                local Passport = parseInt(Data["passport"])
                local Source = vRP.Source(Passport)
                if Source then
                    TriggerEvent("GiveUserNotifyVIP", Passport, Data["server"])
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport"
                end
            else
                response["body"] = "Invalid Passport"
            end
            return res.send(json.encode(response))
        end)
    end


    if req["path"] == "/Register" then
        req.setDataHandler(function(Data) 
            local Data = json.decode(Data)
			-- if Data["register"] then
                local Code = parseInt(Data["code"])
                local Discord = parseInt(Data["discord"])
                if Success then
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response = { ["statusCode"] = 500, ["body"] = "Invalid Code" }
                end
                res.send(json.encode(response))
            -- end
        end)
    end

	if req["path"] == "/DiscordBot" then
		req.setDataHandler(function(Data) 
            local Data = json.decode(Data)
			if Data["command"] == "kickDiscord" then
				local Passport = parseInt(Data["passport"])
				local Source = vRP.Source(Passport)
				if Source and Passport > 0 then
					vRP.Kick(Source,"Expulso da cidade.")
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport/Source"
				end
			elseif Data["command"] == "godDiscord" then
				local Passport = parseInt(Data["passport"])
				local Source = vRP.Source(Passport)
				if Source and Passport > 0 then
					vRP.Revive(Source,400,true)
                    --if GlobalState["Hunger"] then
                        vRP.UpgradeThirst(Passport,100)
                        vRP.UpgradeHunger(Passport,100)
                    --end
					TriggerClientEvent("paramedic:Reset",Source)
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport/Source"
				end
            elseif Data["command"] == "DeathDiscord" then
				local Passport = parseInt(Data["passport"])
				local Source = vRP.Source(Passport)
				if Source and Passport > 0 then
					vRP.Revive(Source,100,true)
                    --if GlobalState["Hunger"] then
                        vRP.UpgradeThirst(Passport,100)
                        vRP.UpgradeHunger(Passport,100)
                    --end
					TriggerClientEvent("paramedic:Reset",Source)
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport/Source"
				end
			elseif Data["command"] == "limparinvDiscord" then
				local Passport = parseInt(Data["passport"])
				local Source = vRP.Source(Passport)
				if Source and Passport > 0 then
					vRP.ClearInventory(Passport)
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport/Source"
				end
			elseif Data["command"] == "dvDiscord" then
				local Passport = parseInt(Data["passport"])
				local Source = vRP.Source(Passport)
				if Source and Passport > 0 then
					TriggerClientEvent("garages:Delete",Source)
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport/Source"
				end
			elseif Data["command"] == "fixDiscord" then
				local Passport = parseInt(Data["passport"])
				local Source = vRP.Source(Passport)
				if Source and Passport > 0 then
					local Vehicle,Network,Plate = vRPC.VehicleList(Source,10)
					if Vehicle then
						TriggerClientEvent("inventory:repairAdmin",-1,Network,Plate)
                        response = { ["statusCode"] = 200, ["body"] = "Success" }
                    else
                        response["body"] = "Invalid Vehicle"
					end
				end
			elseif Data["command"] == "resetDiscord" then
				local Passport = parseInt(Data["passport"])
				local Source = vRP.Source(Passport)
				if Source and Passport > 0 then
					vRP.GenerateItem(Passport,"bandage",1,true)
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport/Source"
				end
			elseif Data["command"] == "skinDiscord" then
				local Passport = parseInt(Data["passport"])
				local Source = vRP.Source(Passport)
                local Skin = Data["amount"]
				if Passport > 0 then
                    if Source then
                        vRPC.Skin(Source,Skin)
                    end
                    vRP.SkinCharacter(parseInt(Passport),Skin)
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport/Source"
				end
			elseif Data["command"] == "ClearInvDiscord" then
				local Passport = parseInt(Data["passport"])
				if Passport and Passport > 0 then
                    vRP.ClearInventory(Passport)
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport/Source"
				end
			elseif Data["command"] == "moneyDiscord" then
				local Passport = parseInt(Data["passport"])
				local Source = vRP.Source(Passport)
				if Source and Passport > 0 then
					vRP.GiveBank(Passport,Data["amount"],"Money Discord")
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport/Source"
				end
			elseif Data["command"] == "delperDiscord" then
				local Passport = parseInt(Data["passport"])
				if Passport > 0 then
					vRP.Query("characters/removeCharacter",{ id = Passport })
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport"
				end
			elseif Data["command"] == "tptoDiscord" then
				local Passport = parseInt(Data["passport"])
				local Source = vRP.Source(Passport)

				local OtherPassport = parseInt(Data["amount"])
				local OtherSource = vRP.Source(OtherPassport)
				if Source and OtherSource and Passport > 0 and OtherPassport > 0 then
					local Ped = GetPlayerPed(OtherSource)
					local Coords = GetEntityCoords(Ped)
					vRP.Teleport(Source,Coords["x"],Coords["y"],Coords["z"])
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport/Source"
				end
			elseif Data["command"] == "multarDiscord" then
				local Amount = parseInt(Data["amount"])
				local Passport = parseInt(Data["passport"])
				local Source = vRP.Source(Passport)
				if Source and Passport > 0 and Amount > 0 then
					vRP.Query("fines/Add",{ Passport = Passport, Name = "Governador", Date = os.date("%d/%m/%Y"), Hour = os.date("%H:%M"), Value = Amount, Message = "Você foi multado pelo governador." })
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport/Source"
				end
			elseif Data["command"] == "setinvDiscord" then
				local Passport = parseInt(Data["passport"])
				if Passport > 0 then
					vRP.GenerateItem(Passport,"dollars",Data["amount"],true)
                    -- --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Valuation, Type = "Inv Disc"})
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport/Source"
				end
			elseif Data["command"] == "anuncioDiscord" then
				TriggerClientEvent("chat:ClientMessage",-1,"Governador",Data["amount"],"aviso")
                response = { ["statusCode"] = 200, ["body"] = "Success" }
			elseif Data["command"] == "itemDiscord" then
				local Passport = parseInt(Data["passport"])
				if Passport > 0 then
					vRP.GenerateItem(Passport,Data["amount"]["item"],Data["amount"]["amount"],true,false,"itemDiscord")
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport/Source"
				end
			elseif Data["command"] == "unbanDiscord" then
				local Passport = parseInt(Data["passport"])
				local Identity = vRP.Identity(Passport)
				if Identity then
					vRP.Query("banneds/RemoveBanned",{ license = Identity["license"] })
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport"
				end                
			elseif Data["command"] == "remadvDiscord" then
				local Passport = parseInt(Data["passport"])
				local Identity = vRP.Identity(Passport)
				if Identity then
                    exports["admin"]:RemAdv(Passport)
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport"
				end                
			elseif Data["command"] == "rembanDiscord" then
				local Passport = parseInt(Data["passport"])
				local Identity = vRP.Identity(Passport)
				if Identity then
                    exports["admin"]:RemBan(Passport)
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport"
				end                
			elseif Data["command"] == "setGroupDiscord" then
				local Org = Data["passport"]
				local Link = Data["amount"]
                exports["painel"]:SetDiscord(Org,Link)       
                response = { ["statusCode"] = 200, ["body"] = "Success" }
			elseif Data["command"] == "addgrouppointsDiscord" then
				local Org = Data["passoprt"]
                local Points = Data["amount"]
                exports["painel"]:addGroupPoints(Org,Points)
                response = { ["statusCode"] = 200, ["body"] = "Success" }           
			elseif Data["command"] == "setLeader" then
				local Passport = parseInt(Data["passport"])
                local Org = Data["amount"]
				local Identity = vRP.Identity(Passport)
				if Identity then
                    exports["painel"]:SetLeader(Org,Passport)
                    response = { ["statusCode"] = 200, ["body"] = "Success" }
                else
                    response["body"] = "Invalid Passport"
				end                
			elseif Data["command"] == "adicionarDiscord" then
				vRP.SetPermission(Data["passport"],Data["amount"],Data["level"])
                response = { ["statusCode"] = 200, ["body"] = "Success" }
			elseif Data["command"] == "removerDiscord" then
				vRP.RemovePermission(Data["passport"],Data["amount"],Data["level"])
			elseif Data["command"] == "listDiscord" then
                local PlayerGroups = vRP.GetUserGroups(tostring(Data["passport"]))
                response = { ["statusCode"] = 200, ["body"] = "Success", ["data"] = PlayerGroups }
			elseif Data["command"] == "untoxicDiscord" then
				vRP.RemovePermission(Data["passport"])
                vRP.Query("characters/updateToxic",{ Passport = parseInt(Data["passport"]), Toxic = 0 })
                vRP.Query("whitelist_kd/InsertPassport",{ Passport = parseInt(Data["passport"]) })
                TriggerEvent("vRP:SetToxic",parseInt(Data["passport"]),false)
                TriggerEvent("AddKDWhitelist",parseInt(Data["passport"]))
                response = { ["statusCode"] = 200, ["body"] = "Success" }
			elseif Data["command"] == "clearchestDiscord" then
				-- Precisa ver certinho o que precisa fazer.
			elseif Data["command"] == "addcarDiscord" then
				local Name = Data["amount"]
				local Passport = parseInt(Data["passport"])
				vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "false" })
                response = { ["statusCode"] = 200, ["body"] = "Success" }
            elseif Data["command"] == "remcarDiscord" then
				local Name = Data["amount"]
				local Passport = parseInt(Data["passport"])
				vRP.Query("vehicles/removeVehicles",{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "false" })
                response = { ["statusCode"] = 200, ["body"] = "Success" }
			elseif Data["command"] == "addhomeDiscord" then
				-- Precisa ver certinho o que precisa fazer.
			elseif Data["command"] == "vipfacDiscord" then
				local Group = (Data["passport"])
				local Level = parseInt(Data["amount"])
				vRP.Query("painel/setFacLevel",{ level = Level, name = Group })
                response = { ["statusCode"] = 200, ["body"] = "Success" }
			elseif Data["command"] == "admDiscord" then
                TriggerClientEvent("Announce",-1,"admin",Data["amount"],60000,"ADMINISTRACÃO")
                TriggerClientEvent("sounds:Private",-1,"admin",0.4)
			elseif Data["command"] == "resetpass" then
                exports["hub"]:ResetPass(tostring(Data["passport"]),parseInt(Data["amount"]))         
                response = { ["statusCode"] = 200, ["body"] = "Success" }       
			elseif Data["command"] == "clearpainel" then
                exports["painel"]:CleanGroup(Data["passport"])
                response = { ["statusCode"] = 200, ["body"] = "Success" }
			end
            res.send(json.encode(response))
		end)
	end
end)

vRP.userIdentity = function(id)
	local _identity = vRP.Identity(id)
	if _identity then
		return {
			name = _identity.name,
			name2 = _identity.name2,
		}
	end
	return false
end

vRP.hasGroup = vRP.HasGroup

vRP.getUserSource = vRP.Source

vRP.getUserId = vRP.Passport

--vRP.getUsers = vRP.Players viu la q ta sem nome

function vRP.getUsers()
    return Sources
end

function vRP.numPermission(Permission)
    local Permissions = vRP.Permission(Permission)
    local Table = {}
    for k,v in pairs(Permissions) do
        Table[#Table+1] = k
    end
    return Table
end

function vRP.getUserGroupByType(Passport,Type)
    if Type == "job" or Type == "Job" then
        local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,Type)
        return Job
    else
        local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,Type)
        return Hierarchy
    end
end

function vRP.HasKit(Passport)
    local Identity = vRP.Identity(Passport)
    local Source = vRP.Source(Passport)
    if Identity then
        local Account = vRP.Account(Identity["license"])
        if Account and Account["id"] then
            local Query = vRP.Query("delivery_kit/GetKit",{ AccountId = Account["id"] })
            if Query and Query[1] then
                if os.time() > Query[1]["after"] then
                    Wait(1000)
                    local Kit = json.decode(Query[1]["Info"])
                    vRP.GiveKit(Passport,Kit,Account["id"])
                end
            end
        end
    end
end

local KitFunctions = {
    ["Group"] = function(Passport,Group,Time)
        if Time > 0 then
            vRP.SetPermission(Passport,Group,1,false,false,Time)
        else
            vRP.SetPermission(Passport,Group,1,false,false,false)
        end
    end,
    ["Item"] = function(Passport,Item,Amount)
        vRP.GenerateItem(Passport,Item,Amount,true,false,"GiveKit")
    end,
    ["Car"] = function(Passport,Vehicle,Days)
        vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Vehicle, plate = vRP.GeneratePlate(), work = "false" })
    end,
}

function vRP.GiveKit(Passport,Kit,AccountId)
    for Type,Info in pairs(Kit) do
        for Value,Amount in pairs(Info) do
            if KitFunctions[Type] then
                KitFunctions[Type](Passport,Value,Amount)
            end
        end
        vRP.Query("delivery_kit/DeleteKit",{ AccountId = AccountId })
    end
end

function vRP.generateFastCheckout(Passport,Code)
    if Code then
        local purchase = {}
        purchase["cart"] = {}
        purchase["customer"] = {}
        purchase["variables"] = {}
        purchase["integrations"] = {}
        local Job = vRP.UserGroupByType(Passport,"Job")
        local Identity = vRP.Identity(Passport)
        local Account = vRP.Account(Identity["license"])
        -- if Account["discord"] and Account["discord"] ~= "0" then
        --     local Waiting = true
        --     PerformHttpRequest("http://189.127.164.202:3007/get_user_info?discord_id="..Account["discord"].."", function(err, data, headers)
        --         purchase["integrations"]["discord"] = json.decode(data)
        --         Waiting = false
        --     end, 'GET', '')
        --     while Waiting do
        --         Wait(100)
        --     end
        -- end
        purchase["cart"][#purchase["cart"] + 1] = {
            id = Code,
            amount = 1,
        }
        
        purchase["customer"]["name"] = Account["name"]
        purchase["customer"]["email"] = Account["email"]
        local Cupom = exports["safezone"]:HasPromo()
        if Cupom then
            purchase["cupon"] = Cupom
        end
        purchase["variables"]["user_id"] = Passport

        local url = exports["empty"]:createFastCheckout(purchase)

        if url then
            return url
        end
    end
    return false
end

local LoginsConfig = {
    [5] = 30,
    [10] = 30,
    [15] = 30,
    [20] = 30,
    [25] = 30,
    [30] = 30,
    [35] = 30,
    [40] = 30,
    [45] = 30,
    [50] = 30,
    [55] = 30,
    [60] = 30,
    [65] = 30,
    [70] = 30,
    [75] = 30,
    [80] = 30,
    [85] = 30,
    [90] = 30,
    [95] = 30,
    [100] = 30,
    [105] = 30,
    [110] = 30,
    [115] = 30,
    [120] = 30,
    [130] = 30,
    [135] = 30,
    [140] = 30,
    [145] = 30,
    [150] = 30,
    [155] = 30,
    [160] = 30,
    [165] = 30,
    [170] = 30,
    [175] = 30,
    [180] = 30,
    [185] = 30,
    [190] = 30,
    [195] = 30,
    [200] = 30,
    [205] = 30,
    [210] = 30,
    [215] = 30,
    [220] = 30,
    [225] = 30,
    [230] = 30,
    [235] = 30,
    [240] = 30,
    [245] = 30,
    [250] = 30,
    [255] = 30,
    [260] = 30,
    [265] = 30,
    [270] = 30,
    [275] = 30,
    [280] = 30,
    [285] = 30,
    [290] = 30,
    [295] = 30,
    [300] = 30,
    [305] = 30,
    [310] = 30,
    [315] = 30,
    [320] = 30,
    [325] = 30,
    [330] = 30,
    [335] = 30,
    [340] = 30,
    [345] = 30,
    [350] = 30,
    [355] = 30,
    [360] = 30,
    [365] = 30,
    [370] = 30,
    [375] = 30,
    [380] = 30,
    [385] = 30,
    [390] = 30,
    [395] = 30,
    [400] = 30,
    [405] = 30,
    [410] = 30,
    [415] = 30,
    [420] = 30,
    [425] = 30,
    [430] = 30,
    [435] = 30,
    [440] = 30,
    [445] = 30,
    [450] = 30,
    [455] = 30,
    [460] = 30,
    [465] = 30,
    [470] = 30,
    [475] = 30,
    [480] = 30,
    [485] = 30,
    [490] = 30,
    [495] = 30,
    [500] = 30,
    [505] = 30,
    [510] = 30,
    [515] = 30,
    [520] = 30,
    [525] = 30,
    [530] = 30,
    [535] = 30,
    [540] = 30,
    [545] = 30,
    [550] = 30,
    [555] = 30,
    [560] = 30,
    [565] = 30,
    [570] = 30,
    [575] = 30,
    [580] = 30,
    [585] = 30,
    [590] = 30,
    [595] = 30,
    [600] = 30,
    [605] = 30,
    [610] = 30
}

function ends_with_0_or_5(value)
    local last_digit = tonumber(string.sub(tostring(value), -1))
    return last_digit == 0 or last_digit == 5
end

local StoreToken = {
    ["Base"] = "SEU TOKEN AQUI",
}

AddEventHandler("Connect",function(Passport,source)
    local Identity = vRP.Identity(Passport)
    local AccountId = Identity["accountId"]
    local Name = Identity["name"].." "..Identity["name2"]
    if GlobalState["HasPromo"] then
        return
    end
    local Logins = vRP.Query("accounts/GetLogins",{ accountId = AccountId })
    vRP.HasKit(parseInt(Passport))
    Wait(30000)
    if Logins and Logins[1] then
        local SetToken = false
        if ends_with_0_or_5(Logins[1]["amount_logins"])then
            local Random = parseInt(math.random(10,99))
            local Discount = 30+0.0
            local PlayerInfo = {
                name = string.upper(string.sub(Name,1,4)).."X"..Random, 
                value = Discount, 
                is_flat = false, 
                minimum = 10,
                remaining = 1,
            }
            PerformHttpRequest("https://api.hydrus.gg/plugin/v1/coupons",function(err,text,headers)
                if err == 200 or err == 201 then
                    local Info = text
                    if not Info["id"] then
                        Info = headers
                        if type(Info) == "string" then
                            Info = json.decode(Info)
                        end
                    end
                    vRP.Query("new_player_promo/setNewPromo",{ id = AccountId, token = PlayerInfo["name"], tokenId = parseInt(Info["id"]) or 0, discount = Discount, Days = 1 })
                    Wait(5000)
                    TriggerClientEvent("Promo_newbie",source,{["time"] = 60*60*24*2,["coupon"] = PlayerInfo["name"], ["hasTimer"] = true, ["discount"] = Discount or 50})
                end
            end,"POST",
            json.encode(PlayerInfo),{
                ["Authorization"] = "Bearer "..StoreToken[cityName],
                ['content-type'] = 'application/json'
            })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETLICENSES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    Wait(1000)
    for License,_ in pairs(exports["variables"]:GetLicenses("Dev")) do
        vRP.Query("accounts/setPriority",{ 100,License })
    end
    for License,_ in pairs(exports["variables"]:GetLicenses("Admin2")) do
        vRP.Query("accounts/setPriority",{ 90,License })
    end
end)