
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("spawn",Creative)
cityName = GetConvar("cityName", "Base")
SafeMode = GetConvar("SafeMode", "")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Selected = {}
local UsersCharacters = {}
local Connected = {}

local CityRequests = {
    ["Base"] = "SEU LINK AQUI", 
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Characters()
	local source = source
	local License = vRP.Identities(source)
	local Consult = vRP.Query("characters/Characters",{ license = License })
    local Account = vRP.Account(License)
    if Account and Account["chars"] then
        local AmountCharacters = Account["chars"]
        local CharactersCount = vRP.Query("characters/countPersons",{ license = License })
        local Characters = {}
        local Slots = {}
        local isFirstLogin = true
        local CustomSpawn = nil
        for i=1,#Consult do
            local hours,minutes = secondsMinutesHours(Consult[i]["tracking"])
            local CharIndex = #Characters+1
            local Passport = Consult[i]["id"]
            Characters[CharIndex] = {
                ["id"] = Passport,
                ["Skin"] = Consult[i]["skin"],
                ["name"] = Consult[i]["name"].." "..Consult[i]["name2"],
                ["horas"] = hours,
                ["minutos"] = minutes,
                ["Blood"] = Sanguine(Consult[i]["blood"]),
                ["Clothes"] = vRP.UserData(Passport,"Clothings"),
                ["Barber"] = vRP.UserData(Passport,"Barbershop"),
                ["Tattoos"] = vRP.UserData(Passport,"Tattooshop")
            }
            Slots[#Slots+1] = { slot = false }
            if vRP.getFirstLogin(Passport) then
                isFirstLogin = false
            end
            if isFirstLogin then
                Characters[CharIndex]["job"] = vRP.UserGroupByType(Passport,"Job")
            end
            local Query = vRP.Query("characters/getCustomSpawn",{ Passport = Passport })
            if Query and Query[1] and Query[1]["customSpawn"] then
                local Coords = Query[1]["customSpawn"]
                local FormatedCoords = toVector3(Coords)
                if FormatedCoords then
                    Player(source)["state"]["CustomSpawn"] = FormatedCoords
                    CustomSpawn = FormatedCoords
                end
            end
        end
        if #Characters > 0 then
            TriggerClientEvent("sounds:Private",source,"spawn",0.2)
        end
        for i = 1,3 do
            if not Slots[i] then
                if parseInt(AmountCharacters) > parseInt(CharactersCount[1]["qtd"]) then
                    Slots[i] = { slot = true }
                else
                    Slots[i] = { slot = false }
                end
            end
        end
        exports["vrp"]:ChangePlayerBucket(source,source)
        UsersCharacters[source] = Consult
        return Characters, Slots, isFirstLogin, CustomSpawn
    end
    return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
local CountBug = 0
local Logins = 0
local Ped0 = 0 
function Creative.ChoseCharacter(Number,Coords)
	local source = source
	local License = vRP.Identities(source)
    local Code = "Sucess"
    Number = Number or 1
    if not UsersCharacters[source] then
        DropPlayer(source,"Personagem irregular.")
        return
    end
    local Passport = parseInt(UsersCharacters[source][Number]["id"])
	local Consult = vRP.Query("characters/UserLicense",{ id = Passport, license = License })
    local Count = 0
    Logins = Logins + 1
    
    Wait(100)

    if GetPlayerPed(source) == 0 then
        TriggerClientEvent("Notify",source,"vermelho","Seu personagem está com problemas, para ter uma experiência completa por favor relogue.",5000,"Bugado")
        -- TriggerClientEvent("Notify2",source,"#relogWarning")
    end
    if Consult[1] then
        local Bucket = GetPlayerRoutingBucket(source)
        exports["vrp"]:ChangePlayerBucket(source,Bucket)
        if not UsersCharacters[source] then
            DropPlayer(source,"Personagem irregular.")
            return
        end
        if not UsersCharacters[source][Number] or not UsersCharacters[source][1] then
            DropPlayer(source,"Personagem irregular.")
            return
        end
        vRP.CharacterChosen(source,Passport,false,Coords,UsersCharacters[source][Number] or UsersCharacters[source][1])
    else
        DropPlayer(source,"Conectando em personagem irregular.")
    end
    UsersCharacters[source] = nil
    return Code
end

function ValidPlayer(Source)
    local Players = GetPlayers()
    local Valid = false
    for i=1,#Players do
        if parseInt(Players[i]) == Source then
            Valid = true
        end
    end
    return Valid
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
-- function Creative.TestingAccounts()
--     local source = source
--     local License = vRP.Identities(source)
--     local Account = vRP.Account(License)
--     if Account["id"] then
--         vRP.Query("new_player/setNewAction", { id = Account["id"], action = GetNewPlayerNumber("Spawn2") })
--     end
-- end
vRP.Prepare("temporary_groups/inserTemporaryGroup","INSERT INTO temporary_groups(`passport`,`group`,`date`) VALUES(@Passport,@Group,DATE_ADD(CURRENT_TIMESTAMP(),INTERVAL + @Days DAY))")
vRP.Prepare("characters/lastCharacters","SELECT * FROM characters WHERE license = @license ORDER BY id DESC LIMIT 1")
function Creative.NewCharacter(Name,Name2,Sex,Age,Coords)
	local source = source
	if not Selected[source] then
		Selected[source] = true

		local License = vRP.Identities(source)
		local Account = vRP.Account(License)
        if Account then
            local AmountCharacters = Account["chars"]
            local Characters = vRP.Query("characters/countPersons",{ license = License })
            if vRP.LicensePremium(License) then
                AmountCharacters = AmountCharacters + 2
            end

            if parseInt(AmountCharacters) <= parseInt(Characters[1]["qtd"]) then
                TriggerClientEvent("Notify",source,"amarelo","Limite de personagem atingido.",3000)
                -- TriggerClientEvent("Notify2",source,"#maxCharacter")
                Selected[source] = nil
                return
            end

            local Sexo = { "M",0 }
            if Sex == "mp_f_freemode_01" then
                Sexo = { "F",1 }
            end

            vRP.Query("characters/newCharacter",{ license = License, name = Name, age = Age, name2 = Name2, sex = Sexo[1], skin = Sex, phone = vRP.GeneratePhone(), blood = math.random(4) })
            Wait(500)
            local Consult = vRP.Query("characters/lastCharacters",{ license = License })
            if Consult[1] then
                local Passport = parseInt(Consult[1]["id"])
                local Ped = GetPlayerPed(source)
                exports["vrp"]:ChangePlayerBucket(source,parseInt(source))
                vRP.CharacterChosen(source,Consult[1]["id"],Sexo[2],Coords,Consult[1])
                vRP.SetPermission(Passport,"Iniciante",1)
                vRP.SetPermission(Passport,"BolsaFamilia",5,false,false,7)
                if cityName ~= "Candy" and SafeMode == "true" then
                    Player(source)["state"]["Newbie"] = true
                    Entity(Ped)["state"]["Newbie"] = true
                end
                PerformHttpRequest(CityRequests[cityName],function(err,text,headers)
                end,"POST",
                json.encode({
                    { discord = Account["discord"],
                        name = Name.." "..Name2,
                        passport = Passport 
                    }
                }),{ ["Content-Type"] = "application/json" })
                Player(source)["state"]["Creating"] = true
                Wait(500)
                exports["vrp"]:ChangePlayerBucket(source,parseInt(source))
                TriggerClientEvent("barbershop:Open",source,"open",true)
                CreateThread(function()
                    Wait(10000)
                    local Ped = GetPlayerPed(source)
                    vRP.SetPermission(Passport,"Iniciante",1)
                    Player(source)["state"]["Iniciante"] = true
                    Player(source)["state"]["FirstLogin"] = true
                    if Ped ~= 0 then
                        Entity(Ped)["state"]["Iniciante"] = true
                    end 
                end)
            end
        else
            Selected[source] = nil
        end
	end
end



-----------------------------------------------------------------------------------------------------------------------------------------
-- SIDE FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function secondsMinutesHours(seconds)
    local seconds = tonumber(seconds)

    if seconds <= 0 then
        hours,mins = 0,0
    else
        hours = string.format("%02.f", math.floor(seconds/3600));
        mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
        return tonumber(hours),tonumber(mins)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
-- local Logins = 0
-- local LoggedSource = {}

-- RegisterServerEvent("testPed")
-- AddEventHandler("testPed",function()
--     -- local source = source
--     -- local Count = 0
--     -- Wait(100)
--     -- TriggerClientEvent("spawn:SetModel",source)
--     -- Wait(100)
--     -- local Ped = GetPlayerPed(source)
--     -- while Ped == 0 do
--     --     Ped = GetPlayerPed(source)
--     --     Count = Count + 1
--     --     if Count > 75 then
--     --         local Valid = ValidPlayer(source)
--     --         if not Valid then
--     --             break
--     --         end
--     --         if Valid then
--     --             print("Limit Exceeded ",tostring(source),tostring(Ped))
--     --             CountBug = CountBug + 1
--     --             TriggerClientEvent("Notify",source,"vermelho","Seu personagem está bugado, para ter acesso a todas as funcionalidades do servidor por favor relogue.",45000,"Bug")
--     --         end
--     --         break
--     --     end
--     --     Wait(500)
--     -- end
--     -- if not LoggedSource[source] then
--     --     LoggedSource[source] = true
--     --     print("Logins: "..Logins.." CountBug: "..CountBug)
--     -- end
-- end)

AddEventHandler("playerDropped",function(Reason)
    if UsersCharacters[source] then
        UsersCharacters[source] = nil
    end
end)