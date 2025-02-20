-----------------------------------------------------------------------------------------------------------------------------------------
-- CACHE
-----------------------------------------------------------------------------------------------------------------------------------------
local ArenaCache = { 
    ["1x1"] = {
        { ["Players"] = {}, ["Bucket"] = parseInt(900060), ["Max"] = 2 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900061), ["Max"] = 2 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900062), ["Max"] = 2 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900063), ["Max"] = 2 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900064), ["Max"] = 2 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900065), ["Max"] = 2 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900066), ["Max"] = 2 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900067), ["Max"] = 2 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900068), ["Max"] = 2 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900069), ["Max"] = 2 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900070), ["Max"] = 2 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900071), ["Max"] = 2 },   
    },
    ["3x3"] = {
        { ["Players"] = {}, ["Bucket"] = parseInt(900060*3), ["Max"] = 6 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900061*3), ["Max"] = 6 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900062*3), ["Max"] = 6 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900063*3), ["Max"] = 6 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900064*3), ["Max"] = 6 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900065*3), ["Max"] = 6 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900066*3), ["Max"] = 6 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900067*3), ["Max"] = 6 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900068*3), ["Max"] = 6 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900069*3), ["Max"] = 6 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900070*3), ["Max"] = 6 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900071*3), ["Max"] = 6 },   
    },
    ["6x6"] = {
        { ["Players"] = {}, ["Bucket"] = parseInt(900060*6), ["Max"] = 12 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900061*6), ["Max"] = 12 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900062*6), ["Max"] = 12 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900063*6), ["Max"] = 12 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900064*6), ["Max"] = 12 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900065*6), ["Max"] = 12 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900066*6), ["Max"] = 12 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900067*6), ["Max"] = 12 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900068*6), ["Max"] = 12 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900069*6), ["Max"] = 12 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900070*6), ["Max"] = 12 },
        { ["Players"] = {}, ["Bucket"] = parseInt(900071*6), ["Max"] = 12 },     
    },
}

local ArenaTypes = {
    ["1x1"] = 1,
    ["3x3"] = 2,
    ["6x6"] = 3
}
local PlayerStreak = {}
local KiilsPoints = 2
local PlayerCache = {}
SafeMode = GetConvar("SafeMode", "")
local StartCoords = {
    vector3(-1604.71,-1025.39,13.06),
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("arena_ranking/getUser","SELECT id FROM arena_ranking WHERE Passport = @Passport AND Arena = @Arena")
vRP.Prepare("arena_ranking/insertUser","INSERT INTO arena_ranking(passport,arena) VALUES(@Passport,@Arena)")
vRP.Prepare("arena_ranking/upateUser","UPDATE arena_ranking SET points = points + @Points WHERE passport = @Passport AND arena = @Arena")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.GetArena(Arena,Number)
    if ArenaCache[Arena][Number] then
        local Formated = {}
        if not Formated[1] then
            Formated[1] = {players = #ArenaCache[Arena][Number]["Players"], maxPlayers = ArenaCache[Arena][Number]["Max"]}
            Formated[2] = {players = #ArenaCache[Arena][Number]["Players"], maxPlayers = ArenaCache[Arena][Number]["Max"]}
        end
        return Formated
    end
end

function Creative.EnterArena(Arena,Number,Team)
    local Source = source
    local Passport = vRP.Passport(Source)
    local Query = vRP.Query("arena_ranking/getUser",{ Passport = Passport, Arena = ArenaTypes[Arena] })
    Player(Source)["state"]["PVP"] = true
    local Ped = GetPlayerPed(Source)
    if Ped and DoesEntityExist(Ped) then
        local Coords = GetEntityCoords(Ped)
        local Distance = #(Coords - StartCoords[1])
        if Distance > 5.0 then
            return
        end
    end
    if not Query[1] then
        PlayerCache[Passport] = {}
        PlayerCache[Passport][ArenaTypes[Arena]] = true
        vRP.Query("arena_ranking/insertUser",{ Passport = Passport, Arena = ArenaTypes[Arena] })
    else
        if not PlayerCache[Passport] then
            PlayerCache[Passport] = {}
            PlayerCache[Passport][ArenaTypes[Arena]] = true
        else
            PlayerCache[Passport][ArenaTypes[Arena]] = true
        end
    end
    if ArenaCache[Arena][Number] and #ArenaCache[Arena][Number]["Players"] <= ArenaCache[Arena][Number]["Max"] then
        local Identity = vRP.Identity(Passport)
        ArenaCache[Arena][Number]["Players"][#ArenaCache[Arena][Number]["Players"]+1] = { Source = Source, Passport = Passport, Kills = 0 }
        local Route = ArenaCache[Arena][Number]["Bucket"]
        vRP.SaveTemporary(Passport,Source,Route)
        Player(Source)["state"]["Arena"] = { ["Name"] = Identity["name"], ["Arena"] = Arena, ["Number"] = Number, ["Team"] = 0 }
        local SelectedTeam = parseInt(Team)
        local State = Player(Source)["state"]["Arena"]
        if SelectedTeam == 1 or SelectedTeam == 2 then
            exports["inventory"]:putWeaponHands(Source,"WEAPON_PISTOL_MK2",250,{},false)
            if State["Team"] == 0 then
                State["Team"] = SelectedTeam
                Player(Source)["state"]["Arena"] = State
            end
        end
    else
        TriggerClientEvent("Notify",Source,"vermelho","Arena cheia.",5000,"Arena")
        -- TriggerClientEvent("Notify2",Source,"#arenaCheia")
    end
    PlayerStreak[Source] = 0
    Player(Source)["state"]["GreenMode"] = false
    Entity(Ped)["state"]:set("WarMode",true,true)
end

function Creative.ExitArena(Arena,Number)
    local Source = source
    local Passport = vRP.Passport(Source)
    local Found = false
    local Ped = GetPlayerPed(Source)
    if ArenaCache[Arena][Number] then
        for i = 1,#ArenaCache[Arena][Number]["Players"] do
            if ArenaCache[Arena][Number]["Players"][i]["Passport"] == Passport then
                if ArenaCache[Arena][Number]["Players"][i]["Kills"] then
                    vRP.Query("arena_ranking/upateUser",{ Passport = Passport, Arena = ArenaTypes[Arena], Points = ArenaCache[Arena][Number]["Players"][i]["Kills"]*KiilsPoints })
                end
                table.remove(ArenaCache[Arena][Number]["Players"],i) 
                if Ped ~= 0 and DoesEntityExist(Ped) then
                    SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),0)
                    RemoveWeaponFromPed(Ped,GetSelectedPedWeapon(Ped))
                end
                vRP.ApplyTemporary(Passport,Source)
                Found = true
                Player(Source)["state"]["Arena"] = false
                Player(Source)["state"]["PVP"] = false
                if SafeMode == "true" then
                    Player(Source)["state"]["GreenMode"] = true
                    Entity(Ped)["state"]:set("WarMode",false,true)
                end
                break
            end
        end
        
        if not Found then
            for Arena,Number in pairs(State) do
                if Arena and Number then
                    for i = 1,#ArenaCache[Arena][Number]["Players"] do
                        if ArenaCache[Arena][Number]["Players"][i]["Passport"] == Passport then
                            vRP.Query("arena_ranking/upateUser",{ Passport = Passport, Arena = ArenaTypes[Arena], Points = ArenaCache[Arena][Number]["Players"][i]["Kills"]*KiilsPoints })
                            table.remove(ArenaCache[Arena][Number]["Players"],i) 
                            if Ped ~= 0 and DoesEntityExist(Ped) then
                                SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),0)
                                RemoveWeaponFromPed(Ped,GetSelectedPedWeapon(Ped))
                            end
                            vRP.ApplyTemporary(Passport,Source)
                            Player(Source)["state"]["Arena"] = false
                            if SafeMode == "true" then
                                Player(Source)["state"]["GreenMode"] = true
                                Entity(Ped)["state"]:set("WarMode",false,true)
                            end
                            Found = true
                            break
                        end
                    end
                end
            end
        end
        
    end
    return Found
end

local KillStreak = {
    [10] = function(Source,Streak)
        local Passport = vRP.Passport(Source)
        local identity = vRP.Identity(Passport)
        if identity then
            TriggerClientEvent("chat:ClientMessage",-1,"Jogador",Passport.." "..identity["name"].." "..identity["name2"].." Está com um kill streak de "..Streak..".","arena")	
        end
    end,
    [15] = function(Source,Streak)
        local Passport = vRP.Passport(Source)
        local identity = vRP.Identity(Passport)
        if identity then
            TriggerClientEvent("chat:ClientMessage",-1,"Jogador",Passport.." "..identity["name"].." "..identity["name2"].." Está com um kill streak de "..Streak..".","arena")	
        end
    end,
    [20] = function(Source,Streak)
        local Passport = vRP.Passport(Source)
        local identity = vRP.Identity(Passport)
        if identity then
            TriggerClientEvent("chat:ClientMessage",-1,"Jogador",Passport.." "..identity["name"].." "..identity["name2"].." Está com um kill streak de "..Streak..".","arena")	
        end
    end,
    [30] = function(Source,Streak)
        local Passport = vRP.Passport(Source)
        local identity = vRP.Identity(Passport)
        if identity then
            TriggerClientEvent("chat:ClientMessage",-1,"Jogador",Passport.." "..identity["name"].." "..identity["name2"].." Está com um kill streak de "..Streak..", Será que alguem consegue parar essa maquina ?","arena")	
        end
    end,
    [40] = function(Source,Streak)
        local Passport = vRP.Passport(Source)
        local identity = vRP.Identity(Passport)
        if identity then
            TriggerClientEvent("chat:ClientMessage",-1,"Jogador",Passport.." "..identity["name"].." "..identity["name2"].." Está com um kill streak de "..Streak..", Será que alguem consegue parar essa maquina ?","arena")	
        end
    end,
}

RegisterServerEvent("arena:SetKillFeed")
AddEventHandler("arena:SetKillFeed",function(Victim,Killer,Weapon)
    local KillerState = Player(Killer)["state"]["Arena"]
    if KillerState then
        local KillerArena = KillerState["Arena"]
        local KillerNumber = KillerState["Number"]
        local KillerName = KillerState["Name"]
        local VictimState = Player(Victim)["state"]["Arena"]
        local VictimName = VictimState["Name"]
        for i=1,#ArenaCache[KillerArena][KillerNumber]["Players"] do
            local Player = ArenaCache[KillerArena][KillerNumber]["Players"][i]["Source"]
            async(function()
                --TriggerClientEvent("arena:KillFeed",Player,VictimName,KillerName,Weapon)
                if ArenaCache[KillerArena][KillerNumber]["Players"][i]["Source"] == Killer then
                    if ArenaCache[KillerArena][KillerNumber]["Players"][i]["Kills"] then
                        ArenaCache[KillerArena][KillerNumber]["Players"][i]["Kills"] = ArenaCache[KillerArena][KillerNumber]["Players"][i]["Kills"] + 1
                    end
                end
            end)
        end
        PlayerStreak[Killer] = PlayerStreak[Killer] + 1
        PlayerStreak[Victim] = 0
        async(function()
            if KillStreak[PlayerStreak[Killer]] then
                KillStreak[PlayerStreak[Killer]](Killer,PlayerStreak[Killer])
            end
            TriggerClientEvent("arena:KillFeed",Killer,VictimName,KillerName,Weapon)
            TriggerClientEvent("arena:KillFeed",Victim,VictimName,KillerName,Weapon)
            Player(Victim)["state"]["Buttons"] = false
        end)
    end
end)

RegisterServerEvent("arena:Death")
AddEventHandler("arena:Death",function()
    local Source = source
    if Player(Source)["state"]["Arena"] then
        exports["inventory"]:putWeaponHands(Source,"WEAPON_PISTOL_MK2",250,{},false)
    end
end)

function Creative.enterTeam()
    local Source = source
    local Passport = vRP.Passport(Source)
    local State = Player(Source)["state"]["Arena"]
    local Ped = GetPlayerPed(Source)
    if PlayerCache[Passport] and State["Team"] == 0 then
        ::retry::
        local Keyboard = vKEYBOARD.keySingle(source,"TIME 1 ou 2:")
        if Keyboard and Keyboard[1] then
            local SelectedTeam = parseInt(Keyboard[1])
            if SelectedTeam == 1 or SelectedTeam == 2 then
                exports["inventory"]:putWeaponHands(Source,"WEAPON_PISTOL_MK2",250,{},false)
                if State["Team"] == 0 then
                    State["Team"] = SelectedTeam
                    Player(Source)["state"]["Arena"] = State
                else
                    TriggerClientEvent("Notify",Source,"vermelho","Você já escolheu um time."..GetPlayerRoutingBucket(Source),5000,"Arena")
                    -- TriggerClientEvent("Notify2",Source,"#escolheuTime",{msg=GetPlayerRoutingBucket(Source)})
                end
            else
                TriggerClientEvent("Notify",Source,"vermelho","Time inválido.",5000,"Arena")
                -- TriggerClientEvent("Notify2",Source,"#timeInvalido")
                goto retry
            end
        end
    end
end

function Creative.GetArenaInfo()
    return ArenaCache or {}
end