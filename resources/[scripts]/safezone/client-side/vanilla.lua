local VanillaProps = nil
local InsideVanilla = false
local VanillaPoly = PolyZone:Create({
    vector2(60.98, -1289.02),
    vector2(101.89, -1346.97),
    vector2(171.97, -1292.05),
    vector2(131.06, -1242.42)
   }, {
    name="Vanilla"
})

local VanillaPoly2 = PolyZone:Create({
    vector2(79.92, -1282.95),
    vector2(108.71, -1338.26),
    vector2(150.00, -1370.45),
    vector2(175.38, -1345.08),
    vector2(200.38, -1289.02),
    vector2(162.50, -1273.11),
    vector2(120.45, -1273.48)
   }, {
    name="Vanilla"
})

local VanillaConfig = {
    ["Prop"] = "v_res_d_paddedwall",
    ["Coords"] = {
        vector4(128.6397, -1298.424, 29.3,30.018259048462),
        vector4(95.33549, -1284.823, 29.27496,207.43284606934),	
        vector4(117.456352, -1304.985718, 29.550035,28.364276885986),	
    }
}

function SpawnVanillaProps()
    local Prop = VanillaConfig["Prop"]
    print("Spawnando")
    VanillaProps = {}
    for i=1,#VanillaConfig["Coords"] do
        local Coords = VanillaConfig["Coords"][i]
        local Object = CreateObjectNoOffset(GetHashKey(Prop),Coords.x,Coords.y,Coords.z,false,false,false)
        SetEntityHeading(Object,Coords.w)
        SetEntityVisible(Object,true)
        FreezeEntityPosition(Object,true)
        SetEntityInvincible(Object,true)
        SetEntityCollision(Object,true,true)
        table.insert(VanillaProps,Object)
    end
end

CreateThread(function()
    while true do
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        if LocalPlayer["state"]["Putaria"] then
            return
        end
        if VanillaPoly2:isPointInside(Coords) then
            if not InsideVanilla then
                InsideVanilla = true
                --if LocalPlayer["state"]["Route"] ~= 15 then
                    --TriggerServerEvent("Safe:VanillaBucket",false)
                    Wait(1000)
                    SpawnVanillaProps()
                --end
            end
        else
            if InsideVanilla then
                InsideVanilla = false
                if VanillaProps ~= nil then
                    for i=1,#VanillaProps do
                        DeleteEntity(VanillaProps[i])
                    end
                end
                VanillaProps = nil
                -- if LocalPlayer["state"]["Route"] == 15 then
                --     TriggerServerEvent("Safe:VanillaBucket",true)
                -- end
            end
        end
        Wait(1500)
    end
end)