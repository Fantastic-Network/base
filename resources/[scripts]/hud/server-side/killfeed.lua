vRP.Prepare("characters/UpdateKills","UPDATE characters SET Kills = Kills + 1 WHERE id = @id")
vRP.Prepare("characters/UpdateDeaths","UPDATE characters SET Deaths = Deaths + 1 WHERE id = @id")
vRP.Prepare("characters/GetKD","SELECT Kills,Deaths FROM characters WHERE id = @id")
local Cooldown = {}
local KillsDeath = {}
local Warning = 5
local WhiteList = {}

function CheckPlayerKD(Passport)
    if KillsDeath[Passport] and KillsDeath[Passport]["Kills"] > 0 then
        local KD = 0
        local Kills = 0
        local Deaths = 0
        if KillsDeath[Passport]["Deaths"] == 0 then
            KD = KillsDeath[Passport]["Kills"]
            Kills = KD
        else
            KD = math.floor(KillsDeath[Passport]["Kills"] / KillsDeath[Passport]["Deaths"])
            Kills = KillsDeath[Passport]["Kills"]
            Deaths = KillsDeath[Passport]["Deaths"]
        end
        if Kills >= 10 and KD >= 5 then
            Passport = tostring(Passport)
            if not WhiteList[Passport] then
                local Identity = vRP.Identity(Passport)
                local Discord = "Invalido"
                if Identity then
                    local Account = vRP.Account(Identity["license"])
                    if Account and Account["discord"] then
                        Discord = Account["discord"] or "Invalido"
                    end
                end
                exports["vrp"]:SendWebHook("warningKD","**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Discord:** <@"..Discord..">\n**Kills/Deaths: "..Kills.."/"..Deaths.."**\n**K/D:** "..KD.." " .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"))
                vRP.Query("characters/updateToxic",{ Passport = Passport, Toxic = 1 })
                TriggerEvent("vRP:SetToxic",parseInt(Passport),true)
            end
        end
    end
end

local weapons = {
    [-1075685676] = "WEAPON_PISTOL_MK2",
    [126349499] = "WEAPON_SNOWBALL",
    [-270015777] = "WEAPON_ASSAULTSMG",
    [615608432] = "WEAPON_MOLOTOV",
    [2024373456] = "WEAPON_SMG_MK2",
    [-1810795771] = "WEAPON_POOLCUE",
    [-1813897027] = "WEAPON_GRENADE",
    [-598887786] = "WEAPON_MARKSMANPISTOL",
    [-1654528753] = "WEAPON_BULLPUPSHOTGUN",
    [-72657034] = "GADGET_PARACHUTE",
    [-102323637] = "WEAPON_BOTTLE",
    [2144741730] = "WEAPON_COMBATMG",
    [-1121678507] = "WEAPON_MINISMG",
    [-1652067232] = "WEAPON_SWEEPERSHOTGUN",
    [961495388] = "WEAPON_ASSAULTRIFLE_MK2",
    [-86904375] = "WEAPON_CARBINERIFLE_MK2",
    [-1786099057] = "WEAPON_BAT",
    [177293209] = "WEAPON_HEAVYSNIPER_MK2",
    [600439132] = "WEAPON_BALL",
    [1432025498] = "WEAPON_PUMPSHOTGUN_MK2",
    [-1951375401] = "WEAPON_FLASHLIGHT",
    [171789620] = "WEAPON_COMBATPDW",
    [1593441988] = "WEAPON_COMBATPISTOL",
    [-2009644972] = "WEAPON_SNSPISTOL_MK2",
    [2138347493] = "WEAPON_FIREWORK",
    [1649403952] = "WEAPON_COMPACTRIFLE",
    [-619010992] = "WEAPON_MACHINEPISTOL",
    [-952879014] = "WEAPON_MARKSMANRIFLE",
    [317205821] = "WEAPON_AUTOSHOTGUN",
    [-1420407917] = "WEAPON_PROXMINE",
    [-1045183535] = "WEAPON_REVOLVER",
    [94989220] = "WEAPON_COMBATSHOTGUN",
    [-1658906650] = "WEAPON_MILITARYRIFLE",
    [1198256469] = "WEAPON_RAYCARBINE",
    [2132975508] = "WEAPON_BULLPUPRIFLE",
    [1627465347] = "WEAPON_GUSENBERG",
    [984333226] = "WEAPON_HEAVYSHOTGUN",
    [1233104067] = "WEAPON_FLARE",
    [-1716189206] = "WEAPON_KNIFE",
    [940833800] = "WEAPON_STONE_HATCHET",
    [1305664598] = "WEAPON_GRENADELAUNCHER_SMOKE",
    [727643628] = "WEAPON_CERAMICPISTOL",
    [-1074790547] = "WEAPON_ASSAULTRIFLE",
    [-1169823560] = "WEAPON_PIPEBOMB",
    [324215364] = "WEAPON_MICROSMG",
    [-1834847097] = "WEAPON_DAGGER",
    [-1466123874] = "WEAPON_MUSKET",
    [-1238556825] = "WEAPON_RAYMINIGUN",
    [-1063057011] = "WEAPON_SPECIALCARBINE",
    [1470379660] = "WEAPON_GADGETPISTOL",
    [584646201] = "WEAPON_APPISTOL",
    [-494615257] = "WEAPON_ASSAULTSHOTGUN",
    [-771403250] = "WEAPON_HEAVYPISTOL",
    [1672152130] = "WEAPON_HOMINGLAUNCHER",
    [338557568] = "WEAPON_PIPEWRENCH",
    [1785463520] = "WEAPON_MARKSMANRIFLE_MK2",
    [-1355376991] = "WEAPON_RAYPISTOL",
    [101631238] = "WEAPON_FIREEXTINGUISHER",
    [1119849093] = "WEAPON_MINIGUN",
    [883325847] = "WEAPON_PETROLCAN",
    [-102973651] = "WEAPON_HATCHET",
    [-275439685] = "WEAPON_DBSHOTGUN",
    [-1746263880] = "WEAPON_DOUBLEACTION",
    [-879347409] = "WEAPON_REVOLVER_MK2",
    [125959754] = "WEAPON_COMPACTLAUNCHER",
    [911657153] = "WEAPON_STUNGUN",
    [-2066285827] = "WEAPON_BULLPUPRIFLE_MK2",
    [-538741184] = "WEAPON_SWITCHBLADE",
    [100416529] = "WEAPON_SNIPERRIFLE",
    [-656458692] = "WEAPON_KNUCKLE",
    [-1768145561] = "WEAPON_SPECIALCARBINE_MK2",
    [1737195953] = "WEAPON_NIGHTSTICK",
    [2017895192] = "WEAPON_SAWNOFFSHOTGUN",
    [-2067956739] = "WEAPON_CROWBAR",
    [-1312131151] = "WEAPON_RPG",
    [-1568386805] = "WEAPON_GRENADELAUNCHER",
    [205991906] = "WEAPON_HEAVYSNIPER",
    [1834241177] = "WEAPON_RAILGUN",
    [-1716589765] = "WEAPON_PISTOL50",
    [736523883] = "WEAPON_SMG",
    [1317494643] = "WEAPON_HAMMER",
    [453432689] = "WEAPON_PISTOL",
    [1141786504] = "WEAPON_GOLFCLUB",
    [-1076751822] = "WEAPON_SNSPISTOL",
    [-2084633992] = "WEAPON_CARBINERIFLE",
    [487013001] = "WEAPON_PUMPSHOTGUN",
    [-1168940174] = "WEAPON_HAZARDCAN",
    [-38085395] = "WEAPON_DIGISCANNER",
    [-1853920116] = "WEAPON_NAVYREVOLVER",
    [-37975472] = "WEAPON_SMOKEGRENADE",
    [-1600701090] = "WEAPON_BZGAS",
    [-1357824103] = "WEAPON_ADVANCEDRIFLE",
    [-581044007] = "WEAPON_MACHETE",
    [741814745] = "WEAPON_STICKYBOMB",
    [-608341376] = "WEAPON_COMBATMG_MK2",
    [137902532] = "WEAPON_VINTAGEPISTOL",
    [-1660422300] = "WEAPON_MG",
    [1198879012] = "WEAPON_FLAREGUN"
}

RegisterServerEvent("hud:KillFeed")
AddEventHandler("hud:KillFeed",function(Victim,Weapon)
    local Source = source
    local Passport = vRP.Passport(Source)
    local vPassport = vRP.Passport(Victim)
    if not Passport then
        DropPlayer(Source,"Jogador sem identificação.")
    end
    if Cooldown[Source] and Cooldown[Source] > os.time() then
        return
    end
    local VictimName = vRP.FullName(vPassport)
    local KillerName = vRP.FullName(Passport)
    Cooldown[Source] = os.time() + 1
    -- if weapons[tonumber(Weapon)] then
    --     local WeaponName = weapons[tonumber(Weapon)]
    --     local Consult = vRP.InventoryItemAmount(Passport,WeaponName)
    --     if not Consult or Consult == nil or Consult[1] <= 0 then
    --         print("Weapon: " .. WeaponName .. " not found in inventory."..Passport.." | "..Source..".")
    --     end
    -- end
    if vPassport then
        local Bucket = GetPlayerRoutingBucket(Source)
        if Bucket == 12 then
            TriggerClientEvent("arena:KillFeed",-1,VictimName,KillerName,Weapon)
        end
        vRP.Query("characters/UpdateDeaths",{ id = vPassport })
        vRP.Query("characters/UpdateKills",{ id = Passport })
        if KillsDeath[Passport] then
            KillsDeath[Passport].Kills = KillsDeath[Passport].Kills + 1
        else
            local Query = vRP.Query("characters/GetKD",{ id = Passport })
            KillsDeath[Passport] = { Kills = Query[1].Kills or 0 ,Deaths = Query[1].Deaths or 0 }
        end
        if KillsDeath[vPassport] then
            KillsDeath[vPassport].Deaths = KillsDeath[vPassport].Deaths + 1
        else
            local Query = vRP.Query("characters/GetKD",{ id = vPassport })
            KillsDeath[vPassport] = { Kills = Query[1].Kills or 0 ,Deaths = Query[1].Deaths or 0 }
        end
        CheckPlayerKD(Passport)
        CheckPlayerKD(vPassport)
    end
end)

AddEventHandler("Connect",function(Passport,source,First)
    if Passport then
        local Query = vRP.Query("characters/GetKD",{ id = Passport })
        KillsDeath[Passport] = { Kills = Query[1].Kills or 0 ,Deaths = Query[1].Deaths or 0 }
        local IsWhitelisted = vRP.Query("whitelist_kd/isWhitelisted",{ Passport = Passport })
        if IsWhitelisted and IsWhitelisted[1] then
            WhiteList[tostring(Passport)] = true
        end
    end
end)

AddEventHandler("Disconnect",function(Passport)
    KillsDeath[Passport] = nil 
end)

AddEventHandler("AddKDWhitelist",function(Passport)
    WhiteList[tostring(Passport)] = true
end)

function NotifyAdmins(title,msg)
    local Admin = vRP.NumPermission("Admin")
    for Passports,Sources in pairs(Admin) do
        TriggerClientEvent("Notify",Sources,"vermelho",msg,15000,title)
    end
end

-- RegisterServerEvent("hud:UpdateHealthInformation")
-- AddEventHandler("hud:UpdateHealthInformation",function(Attacker,Weapon)
--     local Source = source
--     local vPassport = vRP.Passport(Source)
--     local Passport = vRP.Passport(Attacker)
--     local KillerSource = Attacker
--     if not Passport then
--         DropPlayer(Source,"Jogador sem identificação.")
--     end
--     if weapons[tonumber(Weapon)] then
--         local WeaponName = weapons[tonumber(Weapon)]
--         local Consult = vRP.InventoryItemAmount(Passport,WeaponName)
--         if not Consult or Consult == nil or Consult[1] <= 0 then
--             print("Weapon: " .. WeaponName .. " not found in inventory."..Passport.." | "..Source..".")
--             TriggerEvent("AC:Suspect",{user_id = Passport or KillerSource, reason = "[SUSPEITO/V4]"})
--             exports["vrp"]:SendWebHook("SUSPECTV3", "**CIDADE:** "..cityName.." \n**PASSPORT:** " .. Passport .. "\n **SOURCE:**"..KillerSource.." \n[SUSPEITO/V4] " .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187,{Passport})
--             NotifyAdmins("[SUSPEITO/V4]","PASSPORT: "..Passport.."<br>SOURCE: "..KillerSource)
--         end
--     end
-- end)