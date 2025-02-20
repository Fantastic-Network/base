local blackListGroups = {
    ["Abuser"] = 1,
    ["Base"] = 1,
    ["Black"] = 1,
    ["Ouro"] = 1,
    ["Prata"] = 1,
    ["Iniciante"] = 1,
    ["ClienteEspecial"] = 1,
    ["ClienteBlack"] = 1,
    ["VipSorteio"] = 1,
    ["Bronze"] = 1
}
local AdminSet = {
    [1] = 1,
    [2] = 1,
    [3] = 3,
    [4] = 3,
    [5] = 3,
}

local Block = {
	["premium01"] = true,
    ["premium02"] = true,
    ["premium03"] = true,
    ["premium04"] = true,
    ["premium05"] = true,
    ["vipsorteio"] = true,
	["gemstone"] = true,
    ["premiumplate"] = true,
    ["phonechange"] = true,
    ["newchars"] = true,
    ["creditcard"] = true,
    ["vehkey"] = true,
    ["propertys"] = true,
	["money1"] = true,
	["money2"] = true,
	["money3"] = true,
	["money4"] = true,
	["money5"] = true,
	["packbasic"] = true,
	["packelite"] = true,
	["packpremium"] = true,
    ["kitfogueteiro"] = true,
    ["kitcriminal"] = true,
    ["kitmafioso"] = true,
    ["kitdosraul"] = true,
    ["kitboqueta"] = true,
    ["dollars"] = true,
    ["dinheirosujo"] = true,
    ["WEAPON_GRENADELAUNCHER"] = true,
    ["WEAPON_HOMINGLAUNCHER"] = true,
    ["WEAPON_RAILGUN"] = true,
    ["WEAPON_RPG"] = true,
    ["WEAPON_RPG_AMMO"] = true,
    ["WEAPON_RAYPISTOL"] = true,
    ["WEAPON_RAYCARBINE"] = true,
    ["WEAPON_RAYMINIGUN"] = true,
    ["rolepass"] = true
}
local Zaralho = {
    ["WEAPON_GRENADELAUNCHER"] = true,
    ["WEAPON_HOMINGLAUNCHER"] = true,
    ["WEAPON_RAILGUN"] = true,
    ["WEAPON_RPG"] = true,
    ["WEAPON_RPG_AMMO"] = true,
    ["WEAPON_RAYPISTOL"] = true,
    ["WEAPON_RAYCARBINE"] = true,
    ["WEAPON_RAYMINIGUN"] = true,
}


local KeyFunctions = {
    ["RemGroup"] = function(Passport,Player)
        if vRP.HasGroup(Passport,"Admin",3) then
            local source = vRP.Source(Passport)
            local Keyboard = vKEYBOARD.keySingle(source,"Grupo:")
            if Keyboard and Keyboard[1] then
                vRP.RemovePermission(Player,Keyboard[1],1)
                TriggerClientEvent("Notify2",source,"#ungroup",{msg=Keyboard[1],msg2=Player})
                exports["vrp"]:SendWebHook("group","**Passaporte:** "..Passport.." "..vRP.FullName(Passport).."\n**Removeu:** "..Player.." "..vRP.FullName(Player).."\n**Group:** "..Keyboard[1].." 1"..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187,{Passport,Player})
            end
        end
    end,
    ["AddGroup"] = function(Passport,Player)
        if not vRP.HasGroup(Passport, "Admin", 3) then
            return
        end
        local source = vRP.Source(Passport)
        local args = vKEYBOARD.keyDouble(source,"Grupo:","Nivel:")
        if args and args[2] then
            local Group = args[1]
            local nPassport = parseInt(Player)
            local permissionLevel = parseInt(args[2])
            local Number = vRP.HasPermission(Passport,"Admin")

            if blackListGroups[Group] and Number > blackListGroups[Group] then
                TriggerClientEvent("Notify2",source,"#group")
                return
            end
            if Group == "Admin" then
                if AdminSet[permissionLevel] and Number > AdminSet[permissionLevel] then
                    TriggerClientEvent("Notify2",source,"#group")
                    return
                end
            end
            vRP.SetPermission(Player, Group, permissionLevel)
            TriggerClientEvent("Notify2",source,"#groupPass",{msg=Group,msg2=nPassport})
            exports["vrp"]:SendWebHook("group", "**Passaporte:** " ..Passport.. " " ..vRP.FullName(Passport).. "\n**Setou:** " ..nPassport .. " " .. vRP.FullName(nPassport) .. "\n**Group:** " ..Group.. " " ..permissionLevel.. "" ..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187,{Passport})
        end
    end,
    ["ListGroups"] = function(Passport,Player)
        if not vRP.HasGroup(Passport, "Admin", 5) then
            return
        end
        local source = vRP.Source(Passport)
        local PlayerGroups = vRP.GetUserGroups(tostring(Player))
        local Messages = ""
        for Permission,Level in pairs(PlayerGroups) do 
            Messages = Messages.."Permissão: "..Permission.." - Level: "..Level.."<br>"
        end
        if Messages ~= "" then
            TriggerClientEvent("Notify2",source,"#ugroups",{ Msg = Messages })
        end
    end,
    ["God"] = function(Passport,Player)
        if not vRP.HasGroup(Passport, "Admin", 5) then
            return
        end
        local source = vRP.Source(Passport)
        local nSource = vRP.Source(Player)
        local Name1 = vRP.FullName(Passport) or "Desconhecido"
        local Name2 = vRP.FullName(Player) or "Desconhecido"
        vRP.Revive(nSource,400)
        exports["vrp"]:SendWebHook("god", "**Passaporte:** " .. Passport .. " " ..Name1.. "\n**Deu god no passaporte:** " .. Player .. " " ..Name2.."\n**Local:** Desconhecido\n" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187,{Passport,Player})
        local Ped = GetPlayerPed(nSource)
        if IsEntityVisible(Ped) then
            TriggerClientEvent("admin:Piscar",nSource)
        end
    end,
    ["Armor"] = function(Passport,Player)
        if not vRP.HasGroup(Passport, "Admin", 5) then
            return
        end
        local nSource = vRP.Source(Player)
        local Ped = GetPlayerPed(nSource)
        SetPedArmour(Ped,99)
    end,
    ["Skin"] = function(Passport,Player)
        if not vRP.HasGroup(Passport, "Admin", 3) then
            return
        end
        local source = vRP.Source(Passport)
        local Keyboard = vKEYBOARD.keySingle(source,"Skin:")
        local nSource = vRP.Source(Player)
        if Keyboard and Keyboard[1] then
            vRPC.Skin(nSource,Keyboard[1])
            vRP.SkinCharacter(parseInt(Player),Keyboard[1])
            exports["vrp"]:SendWebHook("skin","**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .. "\n**Setou skin:** "..Keyboard[1].."\n**Passaporte:** "..Player.." " .. vRP.FullName(Player) .. ""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
        end
    end,
    ["GiveItem"] = function(Passport,Player)
        if not vRP.HasGroup(Passport, "Admin", 3) then
            return
        end
        local source = vRP.Source(Passport)
        local Keyboard = vKEYBOARD.keyDouble(source,"Item:","Quantidade:")
        local nSource = vRP.Source(Player)
        if Keyboard and Keyboard[1] then
			local Number = vRP.HasPermission(Passport,"Admin")
			if Block[Keyboard[1]] and Number ~= 1 then
				return
			end

			if Zaralho[Keyboard[1]] and Number ~= 1 then
				return
			end
            vRP.GenerateItem(Player,Keyboard[1],parseInt(Keyboard[2]),true,false,"ItemCMD",Passport)
            exports["vrp"]:SendWebHook("item", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n** Setou item no Passaport:** "..Player.. " " .. vRP.FullName(Player) .. "\n** Item:** "..Keyboard[1].. "\n**Quantidade:** "..Keyboard[2].. "" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187,{Passport,Player})
        end
    end,
    ["GetDiscord"] = function(Passport,Player)
        if not vRP.HasGroup(Passport, "Admin", 3) then
            return
        end
        local source = vRP.Source(Passport)
        local nPassport = parseInt(Player)
        local License = vRP.License(nPassport)
        local Account = vRP.Account(License)
        if Account and Account["discord"] then
            TriggerClientEvent("Notify",source,"verde","Discord: "..Account["discord"],60000*1,"Discord")
            TriggerClientEvent("copyToClipboard",source,Account["discord"])
        end
    end,
}

function Server.ManagePlayer(Player,Data)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",5) then
            if KeyFunctions[Data] then
                KeyFunctions[Data](Passport,Player)
            end
        end
    end
end

local AdminList = {
    ["Admin"] = {
        {
            "Pika",100
        },
        {
            "Resp. Geral",100
        },
        {
            "Admin",100
        },
        {
            "Moderador",100
        },
        {
            "Suporte",100
        },
    },
    ["Aliado"] = {
        {
            "Aliado",90
        }
    },
    ["Influenciador"] = {
        {
            "Influenciador",80
        }
    },
    ["InfluenciadorVerificado"] = {
        {
            "Inf Verificado",70
        }
    },
}


local function isEmoji(char)
    local bytes = {string.byte(char, 1, -1)}
    if #bytes == 4 then
        -- This is a simple check for common emoji range. There are many more emoji ranges,
        -- but this should catch a majority of them.
        return (bytes[1] == 240 and bytes[2] >= 159)
    end
    return false
end

-- Function to remove emojis from a string
local function removeEmojis(str)
    local result = {}
    for uchar in string.gmatch(str, "([%z\1-\127\194-\244][\128-\191]*)") do
        if not isEmoji(uchar) then
            table.insert(result, uchar)
        end
    end
    return table.concat(result)
end


function CheckAdmin(source)
    local Passport = vRP.Passport(source)
    local Selected = false
    local Priority = 0
    if Passport then
        for Group,Data in pairs(AdminList) do
            local Number = vRP.HasPermission(Passport,Group)
            if Number and Number ~= nil and Data[Number] and Data[Number][2] > Priority then
                Selected = Data[Number][1]
                Priority = Data[Number][2]
            end
        end
    end
    return Selected
end

function GeneratePlayerInfo(source)
    local Passport = vRP.Passport(source)
    if Passport then
        local Identity = vRP.Identity(Passport)
        local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
        local License = vRP.Identities(source)
        local Account = vRP.Account(License)
        local cleanedName = removeEmojis(Identity.name)
        local cleanedName2 = removeEmojis(Identity.name2)
        local Job = Job or "Desempregado"
        Rank = Rank or "1"
        local formatedJob = Job.." ("..Rank..")"
        PlayerName = cleanedName .. ' ' .. cleanedName2
        if #PlayerName > 25 then
            PlayerName = PlayerName:sub(1, 25)
        end
        PlayerInfo[tostring(source)] = {
            ["identity"] = {
                id = Passport,
                name = PlayerName,
                purchased = 0
            },
            ["job"] = formatedJob,
            ["staff"] = CheckAdmin(source),
        }
        return PlayerInfo[tostring(source)]
    end
end


function UpdatePlayerInfo(source)
    for Source,_ in pairs(AdminWall) do
        Client._UpdateSource(Source,source,PlayerInfo[tostring(source)])
    end
end