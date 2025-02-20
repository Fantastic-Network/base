vRP.Prepare("player_titles/GetPlayerTitles","SELECT * FROM player_titles WHERE passport = @Passport")
vRP.Prepare("player_titles/AddPlayerTitle","INSERT INTO player_titles(passport,title) VALUES(@Passport,@Title)")

local PlayerTitles = {}

-- AddEventHandler("Connect",function(Passport,Source)
--     local Query = vRP.Query("player_titles/GetPlayerTitles",{Passport = Passport})
--     if Query and Query[1] then
--         for i=1,#Query do
--             local Title = Query[i]["title"]
--             PlayerTitles[Passport] = {}
--             PlayerTitles[Passport][title] = true
--         end 
--     end
-- end)

-- AddEventHandler("Disconnect",function(Passport,Source)
--     PlayerTitles[Passport] = nil
-- end)

function AddTitle(Passport,Title)
    if not PlayerTitles[Passport] then
        PlayerTitles[Passport] = {}
    end
    if PlayerTitles[Passport][Title] then
        return
    end
    PlayerTitles[Passport][Title] = true
    vRP.Query("player_titles/AddPlayerTitle",{Passport = Passport,Title = Title})
end