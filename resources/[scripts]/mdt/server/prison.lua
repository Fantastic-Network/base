inPrison = {}

AddEventHandler("Connect",function(Passport,Source)
    local Query = vRP.Query("mdt_arrest/GetArrested",{ player = Passport })
    if Query[1] then
        SetPlayerInPrison(Passport,Query[1]["time"])
    end
end)

AddEventHandler("Disconnect",function(Passport,Source)
    if inPrison[Passport] then
        vRP.Query("mdt_arrest/GetArrested",{ player = Passport, time = inPrison[Passport]["Time"] })
    end
    inPrison[Passport] = nil
end)

CreateThread(function()
    local Query = vRP.Query("mdt_arrest/GetArresteds",{})
    for i=1,#Query do
        local Passport = Query[i]["passport"]
        local Time = Query[i]["time"]
        local Source = vRP.Source(Passport)
        if Source then
            SetPlayerInPrison(Passport,Time)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REDUCE TIME
-----------------------------------------------------
function Server.ReduceTime()
    local Source = source
    local Passport = vRP.Passport(Source)
    if inPrison[Passport] and Passport then
        if inPrison[Passport]["JobTimer"] <= os.time() then
            inPrison[Passport]["JobTimer"] = os.time() + 60
            vRPC.playAnim(Source,false,{"amb@prop_human_bum_bin@base","base"},true)
            TriggerClientEvent("Progress",Source,"Arrumando",10000)
            Player(Source)["state"]["Buttons"] = true
            Player(Source)["state"]["Cancel"] = true
            local timeProgress = 10

            repeat
                Wait(1000)
                timeProgress = timeProgress - 1
            until timeProgress <= 0
        
            Player(Source)["state"]["Buttons"] = false
            Player(Source)["state"]["Cancel"] = false
            vRPC.DestroyObjects(Source)
            if inPrison[Passport] then
                inPrison[Passport]["Time"] = inPrison[Passport]["Time"] - 1 
                if inPrison[Passport]["Time"] <= 0 then
                    inPrison[Passport] = nil
                    TriggerClientEvent("skinshop:Apply",Source,vRP.UserData(Passport,"Clothings"))
                    TriggerClientEvent("tattooshop:Apply",Source,vRP.UserData(Passport,"Tattooshop"))
                    TriggerClientEvent("barbershop:Apply",Source,vRP.UserData(Passport,"Barbershop"))

                    Player(Source)["state"]["InPrison"] = false
                    vRP.Query("mdt_arrest/RemoveArrested",{ passport = Passport })
                    return
                end
                vRP.Query("mdt_arrest/UpdateArrested",{ passport = Passport, time = inPrison[Passport]["Time"]})
                TriggerClientEvent("Notify",Source,"vermelho","Você tem <b>"..inPrison[Passport]["Time"].." minutos</b> de prisão.",5000,"Prisão")
                -- TriggerClientEvent("Notify2",Source,"#prisonTime",{msg=inPrison[Passport]["Time"]})
                return true
            end
        else
            TriggerClientEvent("Notify",Source,"vermelho","Você precisa esperar <b>"..parseInt(inPrison[Passport]["JobTimer"]-os.time()).." segundos</b> para poder trabalhar novamente.")
            -- TriggerClientEvent("Notify2",Source,"#waitToWorkAgain",{msg=parseInt(inPrison[Passport]["JobTimer"]-os.time())})
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE PRISON
-----------------------------------------------------
AddEventHandler("mdt:RemovePrison",function(Passport)
    local Source = vRP.Source(Passport)
    if inPrison[Passport] then
        inPrison[Passport] = nil
        vRP.Query("mdt_arrest/RemoveArrested",{ passport = Passport })
        if Source then
            inPrison[Passport] = nil
            Player(Source)["state"]["InPrison"] = false
            TriggerClientEvent("skinshop:Apply",Source,vRP.UserData(Passport,"Clothings"))
            TriggerClientEvent("tattooshop:Apply",Source,vRP.UserData(Passport,"Tattooshop"))
            TriggerClientEvent("barbershop:Apply",Source,vRP.UserData(Passport,"Barbershop"))
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADREDUCE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do 
        for Passport,Info in pairs(inPrison) do
            if Info["Timer"] <= os.time() then
                local Source = Info["Source"]
                inPrison[Passport]["Time"] = inPrison[Passport]["Time"] - 1
                if inPrison[Passport]["Time"] <= 0 then
                    inPrison[Passport] = nil
                    vRP.Query("mdt_arrest/RemoveArrested",{ passport = Passport })
                    Player(Source)["state"]["InPrison"] = false
                    TriggerClientEvent("skinshop:Apply",Source,vRP.UserData(Passport,"Clothings"))
                    TriggerClientEvent("tattooshop:Apply",Source,vRP.UserData(Passport,"Tattooshop"))
                    TriggerClientEvent("barbershop:Apply",source,vRP.UserData(Passport,"Barbershop"))
                    return
                else
                    Player(Source)["state"]["InPrison"] = true
                    if not Player(Source)["state"]["InPrison"] then
                        inPrison[Passport]["Time"] = inPrison[Passport]["Time"] + 50
                    end
                    inPrison[Passport]["Timer"] = os.time() + 5
                    vRP.Query("mdt_arrest/UpdateArrested",{ passport = Passport, time = inPrison[Passport]["Time"]})
                    TriggerClientEvent("Notify",Source,"vermelho","Você tem <b>"..Info["Time"].." minutos</b> de prisão.",5000,"Prisão")
                    -- TriggerClientEvent("Notify2",Source,"#prisonTime",{msg=Info["Time"]})
                end
                --if GlobalState["Hunger"] then
                    vRP.UpgradeThirst(Passport,100)
                    vRP.UpgradeHunger(Passport,100)
                --end
            end
        end
        Wait(5000)
    end
end)