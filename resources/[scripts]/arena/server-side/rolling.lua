vRP.Prepare("aimlabs_ranking/insertRanking","INSERT INTO aimlabs_ranking(Passport,type,points,time) VALUES(@Passport,@type,@points,@time)")
vRP.Prepare("aimlabs_ranking/getRanking","SELECT id FROM aimlabs_ranking WHERE Passport = @Passport and type = @type")
vRP.Prepare("aimlabs_ranking/updateRanking","UPDATE aimlabs_ranking SET points = @points, time = @time WHERE Passport = @Passport and type = @type")
local Bucket = 900000
function Creative.StartAimNPC()
    local Source = source
    local Ped = GetPlayerPed(Source)
    local Passport = vRP.Passport(Source)
    vRP.SaveTemporary(Passport,Source,parseInt(Bucket+(Passport*20)),"AimNPC")
    if Ped ~= 0 and DoesEntityExist(Ped) then
        SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),0)
        RemoveWeaponFromPed(Ped,GetSelectedPedWeapon(Ped))
    end
    exports["inventory"]:putWeaponHands(Source,"WEAPON_PISTOL_MK2",250,{},false)
    Player(Source)["state"]["Rolling"] = true
    Player(Source)["state"]["PVP"] = true
end

function Creative.exitAimNPC(Score)
    local Source = source
    local Passport = vRP.Passport(Source)
    Player(Source)["state"]["Rolling"] = false
    Player(Source)["state"]["PVP"] = false
    vRP.ApplyTemporary(Passport,Source)
    local Ped = GetPlayerPed(Source)
    if Ped ~= 0 and DoesEntityExist(Ped) then
        SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),0)
        RemoveWeaponFromPed(Ped,GetSelectedPedWeapon(Ped))
    end
    if Score["timer"] <= 0 and Score["points"] then
        local Query = vRP.Query("aimlabs_ranking/getRanking", { Passport = Passport, type = 1} )
        if not Query[1] then
            vRP.Query("aimlabs_ranking/insertRanking",{ Passport = Passport, type = 1, points = Score["points"], time = Score["timer"] })
        else
            if Query[1]["points"] and Query[1]["points"] < Score["points"] then
                vRP.Query("aimlabs_ranking/updateRanking",{ Passport = Passport, type = 1, points = Score["points"], time = Score["timer"] })
            end
        end
    end
    TriggerClientEvent("rolling:Close",Source)
end 