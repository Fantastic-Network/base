-----------------------------------------------------------------------------------------------------------------------------------------
-- FORMAT VEHICLE LIST
-----------------------------------------------------------------------------------------------------------------------------------------
function FormatList(Table)
    for Type,Info in pairs(Table) do
        for i=1,#Info["List"] do
            local Cache = {}
            local Spawn = Info["List"][i]
            local Name = VehicleName(Spawn)
            Cache = {
                name = Name,
                spawn = Spawn,
            }
            Info["List"][i] = Cache
        end
    end
    return Table
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SET VEHICLE TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
function SetVehicleTuning(Vehicle)
    SetVehicleModKit(Vehicle,0)
    SetVehicleMod(Vehicle,11,GetNumVehicleMods(Vehicle,11) - 1,false)
    SetVehicleMod(Vehicle,12,GetNumVehicleMods(Vehicle,12) - 1,false)
    SetVehicleMod(Vehicle,13,GetNumVehicleMods(Vehicle,13) - 1,false)
    SetVehicleMod(Vehicle,15,GetNumVehicleMods(Vehicle,15) - 1,false)
    ToggleVehicleMod(Vehicle,18,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- START TESTDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function TestDrive(data)
    TriggerEvent("Notify:Text","")
    SetNuiFocus(false,false)
    SendNUIMessage({
        action = "setVisible",
        data = false
    })
    if not IsScreenFadedOut() then 
        DoScreenFadeOut(2500)
    end
    while not IsScreenFadedOut() do 
        Wait(5) 
    end
    TriggerEvent("hud:Active",false)
    local NetWork = vSERVER.StartTestDrive(data["spawn"])
    local Ped = PlayerPedId()
    local Vehicle = NetToVeh(NetWork)
    SetVehicleEngineOn(Vehicle,true,true,true)
    Wait(500)
    SetPedIntoVehicle(Ped,Vehicle,-1)
    SetVehicleTuning(Vehicle)
    SetVehicleDirtLevel(Vehicle, 0)
    FreezeEntityPosition(Vehicle,true)
    Wait(1000)
    DoScreenFadeIn(5000)
    local Count = 0.001
    while not IsScreenFadedIn() do
        Count = Count + 0.003
        if Count > 1 then
            Count = 1.0
        end
        SetVehicleCurrentRpm(Vehicle,Count)
        Wait(1) 
    end
    SetVehicleForwardSpeed(Vehicle,0.0)
    SetVehicleCurrentRpm(Vehicle,0.0)
    TriggerEvent("hud:Active",true)
    TriggerEvent("Notify:Text","Saia do carro para finalizar o test drive! [F]")
    if Vehicle then
        FreezeEntityPosition(Vehicle,false)
        local InsideVehicle = true
        while InsideVehicle do
            if not IsPedInAnyVehicle(Ped) then
                break
            end
            Wait(1)
        end
        DoScreenFadeOut(2500)
        while not IsScreenFadedOut() do 
            Wait(5) 
        end
        TriggerEvent("Notify:Text","")
        TriggerEvent("hud:Active",false)
        vSERVER.FinishTestDrive()
        Wait(1500)
        DoScreenFadeIn(2500)
        while not IsScreenFadedIn() do 
            Wait(5) 
        end
        TriggerEvent("hud:Active",true)
        SetNuiFocus(true,true)
        SendNUIMessage({
            action = "setVisible",
            data = "redeem"
        })
    end
end