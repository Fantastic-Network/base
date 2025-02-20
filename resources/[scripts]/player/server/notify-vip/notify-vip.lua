local Rewards = {
    ["Base"] = {
        { "dollars", 2 }
    }
}

AddEventHandler("GiveUserNotifyVIP",function(Passport)
    local userRedeemed = vRP.UserData(Passport, "NotifyVIP")
    if userRedeemed == 1 then
        return
    end
    
    vRP.Query("playerdata/SetData",{ Passport = Passport, dkey = "NotifyVIP", dvalue = 1 })
    local server = GetConvar("cityName", "Base")
    for k,item in pairs(Rewards[server]) do
        local name = item[1]
        local amount = item[2]
        vRP.GenerateItem(Passport,name,amount,false)
    end
end)