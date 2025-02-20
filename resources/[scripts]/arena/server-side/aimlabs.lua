local Bucket = 900000
local StartCoords = {
    vector3(-1615.71,-1038.06,13.14)
}
function Creative.StartAimLabs()
    local Source = source
    local Passport = vRP.Passport(Source)
    local Ped = GetPlayerPed(Source)
    if Ped and DoesEntityExist(Ped) then
        local Coords = GetEntityCoords(Ped)
        local Distance = #(Coords - StartCoords[1])
        if Distance > 5.0 then
            return
        end
    end
    vRP.SaveTemporary(Passport,Source,Bucket+(Passport*20),"AimLabs")
    Player(Source)["state"]["AimLabs"] = true
    Player(Source)["state"]["PVP"] = true
    exports["inventory"]:putWeaponHands(Source,"WEAPON_PISTOL_MK2",250,{},false)
end

function Creative.ExitAimLabs(Score)
    local Source = source
    local Passport = vRP.Passport(Source)
    local Ped = GetPlayerPed(Source)
    if Ped ~= 0 and DoesEntityExist(Ped) then
        SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),0)
        RemoveWeaponFromPed(Ped,GetSelectedPedWeapon(Ped))
    end
    vRP.ApplyTemporary(Passport,Source)
    Player(Source)["state"]["AimLabs"] = false
    Player(Source)["state"]["PVP"] = false
    if Score["timer"] <= 0 then
        local Query = vRP.Query("aimlabs_ranking/getRanking", { Passport = Passport, type = 2} )
        if not Query[1] then
            vRP.Query("aimlabs_ranking/insertRanking",{ Passport = Passport, type = 2, points = Score["points"], time = Score["timer"] })
        else
            if Query[1]["points"] and Score["points"] then
                if Query[1]["points"] < Score["points"] then
                    vRP.Query("aimlabs_ranking/updateRanking",{ Passport = Passport, type = 2, points = Score["points"], time = Score["timer"] })
                end
            end
        end
    end
end