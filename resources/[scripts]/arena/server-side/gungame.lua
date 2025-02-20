-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local GunGame = {}
local GunGameMax = 5
local GunGameUpdate = 2
GunGames = {}
vRP.Prepare("gungame_ranking/getRanking","SELECT * FROM gungame_ranking WHERE passport = @Passport")
vRP.Prepare("gungame_ranking/insertRanking","INSERT INTO gungame_ranking(passport,wins) VALUES(@Passport,1)")
vRP.Prepare("gungame_ranking/updateRanking","UPDATE gungame_ranking SET wins = wins + 1 WHERE passport = @Passport")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTER GUNGAME
-----------------------------------------------------------------------------------------------------------------------------------------
local StartCoords = {
    vector3(-1589.28,-974.26,13.08),
}
function Creative.EnterGunGame()
    local Source = source
    local Passport = vRP.Passport(Source)
    local hasGunGame = false
    local State = {}
    local Ped = GetPlayerPed(Source)
    if Ped and DoesEntityExist(Ped) then
        local Coords = GetEntityCoords(Ped)
        local Distance = #(Coords - StartCoords[1])
        if Distance > 5.0 then
            return
        end
    end
    local Identity = vRP.Identity(Passport)
    local Full = false
    for i=1,#GunGames do
        if not GunGames[i]["Started"] and #GunGames[i]["Players"] < GunGameMax then
            hasGunGame = true
            State = GunGames
            State[i]["Players"][#State[i]["Players"]+1] = { Source = Source, Ped = Ped, Name = Identity["name"] }
            if #State[i]["Players"] == GunGameMax then
                Full = true
            else
                TriggerClientEvent("gungame:BeforeStart",Source)
            end
            TriggerClientEvent("Notify",Source,"verde","Você entrou no GunGame Aguarde mais "..math.floor(GunGameMax-#GunGames[i]["Players"])..".",5000,"GunGame")
            -- TriggerClientEvent("Notify2",Source,"#entrounoGun",{msg=math.floor(GunGameMax-#GunGames[i]["Players"])})
            
            GunGames = State
            if Full then
                local Route = i*400
                Wait(1000)
                for j=1,#State[i]["Players"] do
                    async(function()
                        local PlayerPed = State[i]["Players"][j]["Ped"]
                        local PlayerSource = State[i]["Players"][j]["Source"]
                        local PlayerPassport = vRP.Passport(PlayerSource)
                        Player(Source)["state"]["PVP"] = true
                        vRP.SaveTemporary(PlayerPassport,PlayerSource,Route,"GunGame")
                        
                        local Identity = vRP.Identity(PlayerPassport)
                        if Identity and vRP.Source(PlayerPassport) then
                            Player(PlayerSource)["state"]["GunGame"] = { Game = i, Weapon = 1, Started = false, Kills = 0, Name = Identity["name"] }
                        end
                        
                        local Random = math.random(1,#GunGameCoords)
                        if PlayerPed ~= 0 and DoesEntityExist(PlayerPed) then
                            SetPedAmmo(PlayerPed,GetSelectedPedWeapon(PlayerPed),0)
                            RemoveWeaponFromPed(PlayerPed,GetSelectedPedWeapon(PlayerPed))
                            SetEntityCoords(PlayerPed, GunGameCoords[Random])
                        end
                        exports["inventory"]:putWeaponHands(PlayerSource,GunGameConfigWeapons[1]["name"],250,{},false)
                        TriggerClientEvent("gungame:startGunGame",PlayerSource,i,GunGames)
                    end)
                end
                State[i]["Started"] = true
                State[i]["Running"] = true
                GunGames = State
            end
        end
    end
    
    if not hasGunGame then
        State = GunGames
        local nextGunGame = #GunGame + 1
        local Route = nextGunGame*400
        State[#State+1] = {  Started = false, Players = { { Source = Source, Ped = Ped, Name = Identity["name"] } }}
        GunGames = State
        TriggerClientEvent("Notify",Source,"verde","Você entrou no GunGame Aguarde mais 7 jogadores.",5000,"GunGame")
        -- TriggerClientEvent("Notify2",Source,"#esperaPlayerGun")
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXIT GUNGAME
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ExitGungame()
    local source = source
    local Passport = vRP.Passport(source)
    local State = GunGames
    if Player(source)["state"]["GunGame"] then
        local PlayerState = parseInt(Player(source)["state"]["GunGame"]["Game"])
        local Ped = GetPlayerPed(source)
        for i=1,#State[parseInt(PlayerState)]["Players"] do
            if State[PlayerState]["Players"][i]["Source"] == source then
                if Ped ~= 0 and DoesEntityExist(Ped) then
                    SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),0)
                    RemoveWeaponFromPed(Ped,GetSelectedPedWeapon(Ped))
                end
                vRP.ApplyTemporary(Passport,source)
                table.remove(State[PlayerState]["Players"],i)
                GunGames = State
                TriggerClientEvent("Notify",source,"vermelho","Você saiu do GunGame.",5000,"GunGame")
                -- TriggerClientEvent("Notify2",source,"#saiuGun")
                    Player(source)["state"]["GunGame"] = false
                    Player(source)["state"]["PVP"] = false
                    break
                end
            end
            
            if #State[parseInt(PlayerState)]["Players"] <= 0 then
                FinishGunGame(PlayerState)
            end
        end
    end
    -----------------------------------------------------------------------------------------------------------------------------------------
    -- KILLFEED
    -----------------------------------------------------------------------------------------------------------------------------------------
    RegisterServerEvent("gungame:Death")
    AddEventHandler("gungame:Death",function()
        local Source = source
        if Player(Source)["state"]["GunGame"] then
            exports["inventory"]:putWeaponHands(Source,GunGameConfigWeapons[Player(Source)["state"]["GunGame"]["Weapon"]]["name"],250,{},false)
        end
    end)
    
    RegisterServerEvent("gungame:SetKillFeed")
    AddEventHandler("gungame:SetKillFeed",function(Victim,Killer,Weapon)
        local KillerState = Player(Killer)["state"]["GunGame"]
        local KillerName = KillerState["Name"]
        local VictimState = Player(Victim)["state"]["GunGame"]
        local VictimName = VictimState["Name"]
        KillerState["Kills"] = KillerState["Kills"] + 1
        VictimState["Kills"] = 0
        
        -- for i=1,#GunGames[KillerState["Game"]]["Players"] do
        --     local Player = GunGames[KillerState["Game"]]["Players"][i]["Source"]
        --     async(function()
        --         TriggerClientEvent("gungame:KillFeed",Player,VictimName,KillerName,Weapon,GunGames)
        --     end)
        -- end
        async(function()
            TriggerClientEvent("gungame:KillFeed",Killer,VictimName,KillerName,Weapon)
            TriggerClientEvent("gungame:KillFeed",Victim,VictimName,KillerName,Weapon)
            Player(Victim)["state"]["Buttons"] = false
        end)
        if KillerState["Kills"] == 2 then
            KillerState["Kills"] = 0
            KillerState["Weapon"] = KillerState["Weapon"] + 1
            
            if KillerState["Weapon"] > #GunGameConfigWeapons then
                local Passport = vRP.Passport(Killer)
                local Query = vRP.Query("gungame_ranking/getRanking",{ Passport = Passport})
                if Query[1] then
                    vRP.Query("gungame_ranking/updateRanking",{ Passport = Passport })
                else
                    vRP.Query("gungame_ranking/insertRanking",{ Passport = Passport })
                end
                FinishGunGame(KillerState["Game"],KillerState["Name"])
                return
            end
            
            exports["inventory"]:putWeaponHands(Killer,GunGameConfigWeapons[KillerState["Weapon"]]["name"],250,{},false)
        end
        Player(Killer)["state"]["GunGame"] = KillerState
        Player(Victim)["state"]["GunGame"] = VictimState
        Player(Victim)["state"]["Buttons"] = false
    end)
    -----------------------------------------------------------------------------------------------------------------------------------------
    -- ENDGUNGAME
    -----------------------------------------------------------------------------------------------------------------------------------------
    function FinishGunGame(GunGame,Name)
        local State = GunGames
        for i=1,#State[GunGame]["Players"] do
            local Ped = State[GunGame]["Players"][i]["Ped"]
            local Source = State[GunGame]["Players"][i]["Source"]
            local Passport = vRP.Passport(Source)
            if Name then
                TriggerClientEvent("Notify",Source,"azul",Name.." Ganhou a corrida armada.",5000,"GunGame")
                -- TriggerClientEvent("Notify2",Source,"#ganhouCorridaArmada",{msg=Name})
            end
            if Ped ~= 0 and DoesEntityExist(Ped) then
                SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),0)
                RemoveWeaponFromPed(Ped,GetSelectedPedWeapon(Ped))
            end
            vRP.ApplyTemporary(Passport,Source)
            TriggerClientEvent("gungame:EndGunGame",Source)
            Player(Source)["state"]["GunGame"] = false
            TriggerClientEvent("Notify",Source,"vermelho","Você saiu da corrida armada.",5000,"GunGame")
            -- TriggerClientEvent("Notify2",Source,"#saiuCorridaArmada")
        end
        table.remove(State,GunGame)
        GunGames = State
    end