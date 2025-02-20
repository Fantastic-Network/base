-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
AirDrops = {}
Entitys = {}
function CreateAirDrop(Source)
    local Ped = GetPlayerPed(Source)
    local Coords = GetEntityCoords(Ped)
    local Box = CreateObject(`p_secret_weapon_02`, Coords.x, Coords.y, Coords.z + MaxDistance, true, false, false)
    local Parachute = CreateObject(`p_parachute1_mp_dec`, Coords.x, Coords.y, Coords.z + MaxDistance , true, false, false)
    local High = Coords["z"] + MaxDistance
    local Ground =  Coords["z"] - 1.0
    table.insert(Entitys,{ Box = Box, Parachute = Parachute })
    Wait(250)
    if DoesEntityExist(Parachute) and DoesEntityExist(Box) then
        TriggerClientEvent("Notify",-1,"airdrop","Um Airdrop foi lançado e marcado em seu mapa!",15000,"Lancamento")
        -- TriggerClientEvent("Notify2",-1,"#airdrop")
        TriggerClientEvent("Airdrop:Particle", -1,"core","exp_grd_flare",Coords,Box)
        while High > Ground do
            High = High - 0.1
            SetEntityCoords(Parachute, Coords.x, Coords.y, High+4.0, false, false, false)
            SetEntityCoords(Box, Coords.x, Coords.y, High, false, false, false)
            if High - Ground <= 0.5 then
                    
                if Parachute then
                    if DoesEntityExist(Parachute) then
                        DeleteEntity(Parachute)
                    end
                end
                FreezeEntityPosition(Box,true)
                SetEntityCoords(Box, Coords["x"], Coords["y"], Ground)
                TriggerClientEvent("Airdrop:Ground", -1, Box)
                AirDrops[Box] = { Opening = false }
                Entity(Box)["state"]["Entity"] = Box
                TriggerClientEvent("Airdrop:Blip",-1,Box)
                return
            end
            Wait(1)
        end
    end
end

local CooldownSource = {}
RegisterServerEvent("Airdrop:Open")
AddEventHandler("Airdrop:Open", function(Entity)
    local Source = source
    if CooldownSource[Source] and os.time() < CooldownSource[Source] then
        TriggerClientEvent("Notify",Source,"negado","Aguarde "..CooldownSource[Source] - os.time().." segundos para abrir outro airdrop!",5000,"Aguarde")
        -- TriggerClientEvent("Notify2",Source,"#airdropOpen",{msg=CooldownSource[Source], - os.time()})
        return
    end
    CooldownSource[Source] = os.time() + 30
    if AirDrops[Entity] and not AirDrops[Entity]["Opening"] then
        local Passport = vRP.Passport(Source)
        local Ped = GetPlayerPed(Source)
        AirDrops[Entity]["Opening"] = Source
        TriggerClientEvent("Notify",-1,"airdrop","O Airdrop está sendo aberto!",5000,"Abrindo")
        -- TriggerClientEvent("Notify2",-1,"#airdropOpening")
        local Seconds = 60
        TriggerClientEvent("Progress",Source,"Abrindo",Seconds*1000)
        TriggerClientEvent("Airdrop:Opening",Source,Entity)
        TriggerClientEvent("Notify:Text",Source,"F6 para cancelar")
        vRPC.playAnim(Source,false,{"amb@medic@standing@tendtodead@idle_a","idle_a"},true)
        Player(Source)["state"]["Buttons"] = true
        Player(Source)["state"]["Cancel"] = true
        FreezeEntityPosition(Ped,true)
        CreateThread(function()
            while true do
                Seconds = Seconds - 0.5

                if not AirDrops[Entity] then
                    break
                end
                
                if AirDrops[Entity] and AirDrops[Entity]["Opening"] ~= Source or not DoesEntityExist(Entity) then
                    break
                end

                if GetEntityHealth(Ped) == 100 and AirDrops[Entity]["Opening"] == Source then
                    AirDrops[Entity]["Opening"] = false
                    TriggerClientEvent("Airdrop:Finish",Source)
                    TriggerClientEvent("Progress",Source,"Cancelando",0)
                    Player(Source)["state"]["Buttons"] = false
                    Player(Source)["state"]["Cancel"] = false
                    FreezeEntityPosition(Ped,false)
                    break
                end
                
                if Seconds <= 0 then
                    if AirDrops[Entity] and AirDrops[Entity]["Opening"] == Source and DoesEntityExist(Entity) then
                        TriggerClientEvent("Airdrop:Remove",-1,Entity)
                        TriggerClientEvent("Notify",-1,"airdrop","O Airdrop foi aberto!",5000,"Aberto")
                        -- TriggerClientEvent("Notify2",-1,"#airdropOpened")
                        DeleteEntity(Entity)
                        vRPC.stopAnim(Source)
                        AirDrops[Entity] = nil
                        TriggerClientEvent("Airdrop:Finish",Source)
                        Player(Source)["state"]["Buttons"] = false
                        Player(Source)["state"]["Cancel"] = false
                        FreezeEntityPosition(Ped,false)
                        TriggerClientEvent("Notify:Text",Source,"")
                        for i=1,#Items do
                            vRP.GenerateItem(Passport,Items[i]["Item"],Items[i]["Amount"],true)
                        end
                    end
                end
                Wait(500)
            end
        end)
    end
end)

RegisterServerEvent("Airdrop:Cancel")
AddEventHandler("Airdrop:Cancel", function(Entity)
    local Source = source
    if AirDrops[Entity]["Opening"] == Source then
        AirDrops[Entity]["Opening"] = false
        vRPC.stopAnim(Source)
        Player(Source)["state"]["Buttons"] = false
        Player(Source)["state"]["Cancel"] = false
        TriggerClientEvent("Progress",Source,"Cancelando",0)
        local Ped = GetPlayerPed(Source)
        FreezeEntityPosition(Ped,false)
    end
end)

AddEventHandler("Airdrop:Drop",function(Source)
    CreateAirDrop(Source)
    Player(Source)["state"]["Buttons"] = false
    Player(Source)["state"]["Cancel"] = false
end)

function AirDropClean()
    for i=1,#Entitys do
        for _,Entity in pairs(Entitys[i]) do
            if AirDrops[Entity] then
                AirDrops[Entity] = nil
            end
            if DoesEntityExist(Entity) then
                DeleteEntity(Entity)
            end
        end
    end
    TriggerClientEvent("Airdrop:Clean",-1)
end

RegisterCommand("CleanAirDrop",function(source)
    local Source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Admin", 4) then
        Wait(100)
        AirDropClean()
    end
end)