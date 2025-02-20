-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VEHICLEEJECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("hud:VehicleEject")
AddEventHandler("hud:VehicleEject",function(Velocity)
	local source = source
	local Ped = GetPlayerPed(source)
    if Ped ~= 0 and DoesEntityExist(Ped) then
        local Coords = GetEntityCoords(Ped)

        SetEntityCoords(Ped,Coords["x"],Coords["y"],Coords["z"] - 0.5,true,true,true)
        SetEntityVelocity(Ped,Velocity)

        Wait(1)

        SetPedToRagdoll(Ped,5000,5000,0,0,0,0)
    end
end)

RegisterServerEvent("hud:roads")
AddEventHandler("hud:roads",function(RoadsTxt,CrossTx)
    vRP.Archive("Roads.txt",RoadsTxt)
end)