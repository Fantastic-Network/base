-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
UserPremium = {}
BlockGroups = {
    ["Desempregado"] = true,
    ["Iniciante"] = true
}
GroupsId = {}
UserGroups = {}
SaveGroups = {}
cityName = GetConvar("cityName", "Base")
SafeMode = GetConvar("SafeMode", "")

TimerAdmin = {
    [1] = 1,
    [2] = 1,
    [3] = 10,
    [4] = 30,
}


CreateThread(function()
    for Group,Info in spairs(Groups) do
        vRP.Query("groups/AddGroups",{ Group = Group })
    end
    local Query = vRP.Query("groups/GetGroups",{})
    for i=1,#Query do
        local Info = Query[i]
        if Groups[Info["group"]] then
            Groups[Info["group"]]["Id"] = Info["id"]
            GroupsId[Info["id"]] = Info["group"]
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HIERARCHY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Hierarchy(Permission)
    if Groups[Permission] and Groups[Permission]["Hierarchy"]then
        return Groups[Permission]["Hierarchy"] or {}
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetUserGroups(Passport)
    local Passport = tostring(Passport)
    if UserGroups[Passport] then
        return UserGroups[Passport]
    else
        local Query = vRP.Query("user_groups/GetUserGroups",{ passport = Passport })
        UserGroups[Passport] = {}
        if Query and Query[1] then
            for i=1,#Query do
                local Info = Query[i]
                local Group = GroupsId[Info["groupId"]]
                if UserGroups[Passport] and Group then
                    UserGroups[Passport][Group] = Info["permission"]
                    if Query[i]["expires"] and Query[i]["expires"] ~= nil then
                        if os.time() > parseInt(Query[i]["expires"]) then
                            vRP.RemovePermission(Passport,Group)
                        end
                    end
                end
            end
        end
    end
    return UserGroups[Passport] or {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HIERARCHY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GroupVIP(ThisShouldBeNil, Group)
    local Consult = vRP.Query("painel/getallVip",{ name = Group })
    if Group ~= "Desempregado" and Group ~= "Iniciante" then
        if Consult[1] and parseInt(Consult[1]["level"]) == 1 then
            return true
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.NumPermission(Permission)
	local Amount = 0
	local Tables = {}

	if Groups[Permission] and Groups[Permission]["Parent"] then
		for Perm,_ in pairs(Groups[Permission]["Parent"]) do
			if Groups[Perm] and Groups[Perm]["Service"] then
				for Passport,Source in pairs(Groups[Perm]["Service"]) do
					if Source and Characters[Source] and not Tables[Passport] then
						Tables[Passport] = Source
						Amount = Amount + 1
					end
				end
			end
		end
	end

	return Tables,Amount
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetNewbieInfo()
	local Tables = {}
    local lastLogin = os.date('%d/%m/%Y')
    local Iniciante = vRP.NumPermission("Iniciante")
	for Passport,Source in pairs(Iniciante) do
        Passport = parseInt(Passport)
        local Identity = vRP.Identity(Passport)
        if Identity and Identity["name"] and Identity["name2"] then
            Tables[#Tables+1] = { name = Identity["name"], role = 1, id = Passport, phone = Identity["phone"] }
        end
	end

    local Desempregado = vRP.NumPermission("Desempregado")
	for Passport,Source in pairs(Desempregado) do
        Passport = parseInt(Passport)
        local Identity = vRP.Identity(Passport)
        if Identity and Identity["name"] and Identity["name2"] then
            Tables[#Tables+1] = { name = Identity["name"], role = 2, id = Passport, phone = Identity["phone"] }
        end
	end

	return Tables
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWBIEINFO
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetNewbies()
	local Tables = {}
    local Iniciante = vRP.NumPermission("Iniciante")
    local Desempregado = vRP.NumPermission("Desempregado")
    table.insert(Tables,Iniciante)
    table.insert(Tables,Desempregado)
	return Tables
end

function vRP.GetOnlyNewbies()
    local Table = {}
    local Iniciante = vRP.NumPermission("Iniciante")
    for Passport,Source in pairs(Iniciante) do
        Table[#Table+1] = Passport
    end
	return Table
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UserGroupByType
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserGroupByType(Passport,Type)
    if Passport and Type then
        if Type == "job" then
            Type = "Job"
        end

        local Results = false
        local Rank = false
        local Group = false
        local Hyerarchy = "Novato"
		local Passport = tostring(Passport)
        if not UserGroups[Passport] then
            vRP.GetUserGroups(Passport)
        end
        if UserGroups[Passport] then
            for Permission,Level in pairs(UserGroups[Passport]) do
                if Groups[Permission]["Type"] and Groups[Permission]["Type"] == Type then
                    Results = Permission
                    Rank = Level
                    Group = Permission..""..Level
                    if Groups[Permission]["Hierarchy"] and Groups[Permission]["Hierarchy"][Level] then
                        Hyerarchy = Groups[Permission]["Hierarchy"][Level]
                    end
                    
                    break
                end
            end
        end
        return Results,Rank,Group,Hyerarchy
    end
end

function RemPlayerNewbie(Passport)
    if UserGroups[Passport] and UserGroups[Passport]["Iniciante"] then
        for Group,_ in pairs(UserGroups[Passport]) do
            if Permission ~= "Iniciante" and Groups[Group]["Type"] == "Job" then
                vRP.RemovePermission(Passport,"Iniciante")
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICETOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ServiceToggle(Source,Passport,Permission,Silenced)
	local Split = splitString(Permission,"-")
	local Passport = tostring(Passport)
	local Permission = Split[1]

	if Groups[Permission]["Service"] and Groups[Permission]["Service"][Passport] then
		vRP.ServiceLeave(Source,Passport,Permission,Silenced)
	else
		if vRP.HasPermission(Passport,Permission) then
			vRP.ServiceEnter(Source,Passport,Permission,Silenced)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICEENTER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ServiceEnter(Source,Passport,Permission,Silenced)
	local Passport = tostring(Passport)
    local source = vRP.Source(Passport)
    if source then
        if ClientState[Permission] then
            if Permission == "Policia" or Permission == "Mechanic" or Permission == "Paramedic" or Permission == "Admin" then
                Player(source)["state"][Permission] = true
            end
        end

        --if GroupBlips[Permission] then
			--exports["player"]:EnterMarkers(Source,Permission)
        --end

        if Groups[Permission]["Salary"] then
            TriggerEvent("Salary:Add",Passport,Permission)
        end

        Groups[Permission]["Service"][Passport] = Source

        if not Silenced then
            TriggerClientEvent("Notify",Source,"verde","Entrou em serviço.",5000)
            -- TriggerClientEvent("Notify2",Source,"#cameService")
            exports["vrp"]:SendWebHook("bater-ponto","**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .. "\n**Entrou de serviço:** "..Permission.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICELEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ServiceLeave(Source,Passport,Permission,Silenced)
	local Passport = tostring(Passport)

	if ClientState[Permission] then
		Player(Source)["state"][Permission] = false
	end

	if GroupBlips[Permission] then
		--exports["player"]:ExitMarkers(Source)
		TriggerClientEvent("radio:RadioClean",Source)
	end

	if Groups[Permission] and Groups[Permission]["Salary"] then
		TriggerEvent("Salary:Remove",Passport,Permission)
	end

	if Groups[Permission]["Service"] and Groups[Permission]["Service"][Passport] then
		Groups[Permission]["Service"][Passport] = nil
	end

	if Permission == "Policia" then
		vRP.ClearInventory(Passport)
	end

	if not Silenced then
		TriggerClientEvent("Notify",Source,"verde","Saiu de serviço.",5000)
        -- TriggerClientEvent("Notify2",Source,"#leaveService")
		exports["vrp"]:SendWebHook("bater-ponto","**Passaporte:** "..Passport.."\n**Saiu de serviço:** "..Permission.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Groups()
	return Groups
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATAGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DataGroups(Permission)
	return vRP.GetSrvData("Permissions:"..Permission)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function AddPlayerIcr(Passport,Permission)
    vRP.RemovePermission(parseInt(Passport),"Iniciante")
    vRP.Query("icr/addICR",{ date = os.date("%Y-%m-%d") })
    local source = vRP.Source(Passport)
    if source then
        Player(source)["state"]["Job"] = Permission
        Player(source)["state"]["Newbie"] = false
        local Ped = GetPlayerPed(source)
        if Ped and Ped ~= 0 then
            Entity(Ped)["state"]["Newbie"] = false
        end
    end
end
exports("AddPlayerIcr",AddPlayerIcr)

function vRP.SetPermission(Passport,Permission,Level,Mode,Recruiter,Days,ignoreVIP)
	if Groups[Permission] and Passport then
        vRP.GetUserGroups(Passport)
        local source = vRP.Source(Passport)
        local Job = vRP.UserGroupByType(parseInt(Passport),"Job")
        local HasGroup = false

        if Groups[Permission]["Type"] == "VIP" and not ignoreVIP then
            local Days = 30
            if Permission == "Black" then
                Days = 60
            end
            SetNewVip(Passport,Permission,Days)
        end

		local Hierarchy = 5
		local Passport = tostring(Passport)

		if Groups[Permission]["Hierarchy"] then
			Hierarchy = #Groups[Permission]["Hierarchy"]
		end

		if ClientState[Permission] then
            if source and Permission then
			    Player(source)["state"][Permission] = true
            end
		end

        if Groups[Permission]["Type"] == "Job" and vRP.HasGroup(Passport,"Iniciante") and Permission ~= "Iniciante" then
            AddPlayerIcr(Passport,Permission)
        end

        if Groups[Permission]["Type"] == "Job" then
            if UserGroups[Passport] and not UserGroups[Passport][Permission] then
                vRP.RemoveAllJobs(Passport)
            end
        end

        if UserGroups[Passport] and not UserGroups[Passport][Permission] then
            UserGroups[Passport][Permission] = 5
        else
            HasGroup = true
        end
        local OldLevel = UserGroups[Passport][Permission]
		if Mode and UserGroups[Passport][Permission] then
			if Mode == "Demote" then
                if UserGroups[Passport][Permission] then
                    UserGroups[Passport][Permission] = UserGroups[Passport][Permission] + 1

                    if UserGroups[Passport][Permission] > Hierarchy then
                        UserGroups[Passport][Permission] = Hierarchy
                    end
                end
			else
				UserGroups[Passport][Permission] = UserGroups[Passport][Permission] - 1

				if UserGroups[Passport][Permission] < 1 then
					UserGroups[Passport][Permission] = 1
				end
			end
		else
            if Level then
                Level = parseInt(Level)
                if Level > Hierarchy then
                    Level = Hierarchy
                end
            end
            if UserGroups[Passport] then
                UserGroups[Passport][Permission] = Level or Hierarchy
            end
		end

        --if Groups[Permission]["Achievement"] then
            -- local PlayerAchievement = vRP.GetPlayerAchievements(Passport,true) or {}
            -- local Achievement = Groups[Permission]["Achievement"]
            -- if PlayerAchievement and not PlayerAchievement[Achievement] or not PlayerAchievement[Achievement]["completed"] then
            --     vRP.UpdateAchievement(Passport,Achievement,1)
            -- end
        --end

        if not BlockGroups[Permission] then
            TriggerEvent("painel:addUserGroup",parseInt(Passport),Recruiter or 1,Permission)
        end

        if source then
            local Ped = GetPlayerPed(source)
            
            if Permission == "Iniciante" then
                Player(source)["state"]["Iniciante"] = true
                Entity(Ped)["state"]["Iniciante"] = true
            end

            if Groups[Permission]["Type"] == "Job" then
                if Ped and Ped ~= 0 then
                    Player(source)["state"]["Job"] = Permission
                    Entity(Ped)["state"]["Job"] = Permission
                end
                Player(source)["state"]["Iniciante"] = false
            end
        end

        local GroupId = Groups[Permission]["Id"]
        local NewLevel = Level or 5
        if UserGroups[Passport] and UserGroups[Passport][Permission] then
            NewLevel = UserGroups[Passport][Permission]
        end
        if not HasGroup then
            InsertSaveGroups(parseInt(Passport),GroupId,NewLevel,Days or false,"Add")
        else
            if UserGroups[Passport][Permission] ~= OldLevel then
                InsertSaveGroups(parseInt(Passport),GroupId,NewLevel,Days,"Update")
            end
        end

        if source then
            Groups[Permission]["Service"][Passport] = source
            vRP.ServiceEnter(source,parseInt(Passport),Permission,true)
            NewVipFunctions(Passport,source)
            local Number = vRP.HasPermission(Passport,"Admin")
            if Number and Number < 4 then
                if TimerAdmin[Number] then
                    if source and DoesPlayerExist(source) then
                        Player(source)["state"]["AdminDeathTimer"] = TimerAdmin[Number]
                    end
                end
            end
            if Permission == "Putaria" then
                Player(source)["state"]["Putaria"] = true
            end
        end

		if source and Groups[Permission]["Service"] then
			Groups[Permission]["Service"][Passport] = source
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemovePermission(Passport,Permission,Level)
	if Groups[Permission] then
		local Passport = tostring(Passport)

        if Groups[Permission]["Type"] == "Job" then
            exports["painel"]:RemoveUserPainel(parseInt(Passport),Permission)
        end

        if Permission == "Policia" and not vRP.HasGroup(Passport, "Admin") then
            vRP.PoliceClean(Passport)
        end

		if Groups[Permission]["Service"] and Groups[Permission]["Service"][Passport] then
			Groups[Permission]["Service"][Passport] = nil
		end
        local Source = vRP.Source(parseInt(Passport))
        if Source and Permission == "Iniciante" then
            Player(Source)["state"]["Newbie"] = false
            local Ped = GetPlayerPed(Source)
            if Ped and Ped ~= 0 then
                Entity(Ped)["state"]["Newbie"] = false
            end
        end
		if UserGroups[Passport] and UserGroups[Passport][Permission] then
			UserGroups[Passport][Permission] = nil
		end
        local source = vRP.Source(parseInt(Passport))
        if source then
            if Permission == "Putaria" then
                Player(source)["state"]["Putaria"] = false
            end
        end
        local GroupId = Groups[Permission]["Id"]
        InsertSaveGroups(tostring(Passport),GroupId,false,false,"Remove")
	end
end

function vRP.ClearPermission(Permission)
    for Passport,Group in pairs(UserGroups) do
        if Group[Permission] then
            UserGroups[Passport][Permission] = nil
        end
    end
    vRP.Query("user_groups/ClearGroup",{ groupId = Groups[Permission]["Id"] })
end

function vRP.RemoveAllJobs(Passport)
    local Passport = tostring(Passport)
    if UserGroups[Passport] then
        for Permission,Level in pairs(UserGroups[Passport]) do
            if Groups[Permission]["Type"] == "Job" then
                vRP.RemovePermission(Passport,Permission)
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.HasPermission(Passport,Permission,Level)
    if Permission == "player.spec" then
        local Source = vRP.Source(parseInt(Passport))
        if Source and Player(Source)["state"]["Spectate"] then
            return true
        else
            return false
        end
    end
	local Passport = tostring(Passport)
    if not UserGroups[Passport] then
        vRP.GetUserGroups(Passport)
    end
    if UserGroups[Passport] then
        if UserGroups[Passport][Permission] and (not Level or parseInt(UserGroups[Passport][Permission]) <= parseInt(Level)) then
            return UserGroups[Passport][Permission] 
        end
    end
	return false
end
vRP.hasPermission = vRP.HasPermission
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.HasGroup(Passport,Permission,Level)
	local Results = false
	if Groups[Permission] then
		local Passport = tostring(Passport)
        if not UserGroups[Passport] then
            vRP.GetUserGroups(Passport)
        end
        if UserGroups[Passport] then
            if Level then
                if UserGroups[Passport][Permission] and UserGroups[Passport][Permission] <= Level then
                    Results = true
                end
            else
                if UserGroups[Passport][Permission] then
                    Results = true
                end
            end
            if not Results then
                for Perm,_ in pairs(Groups[Permission]["Parent"]) do
                    if UserGroups[Passport][Perm] and (not Level or UserGroups[Passport][Perm] <= Level) then
                        Results = true
                        break
                    end
                end
            end
        end
	end
	return Results
end
vRP.hasGroup = vRP.HasGroup
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETVIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetVips()
    return GetVips()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETVIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetBlacks(Passport)
    local Results = false
    for i=1,#Groups["Blacks"]["Hierarchy"] do
        if vRP.HasPermission(Passport,"Blacks",i) then
            if not Results then
                Results = {}
            end
            table.insert(Results,i)
        end
    end
    return Results
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETVIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetLancamento(Passport)
    local Results = false
    for i=1,#Groups["Blacks"]["Hierarchy"] do
        if vRP.HasPermission(Passport,"Lancamento",i) then
            if not Results then
                Results = {}
            end
            table.insert(Results,i)
        end
    end
    return Results
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetGroup(Passport,Permission)
	local Results = false
    if Permission == "VIP" then
        local HasPrem,Premium = vRP.GetPremium(Passport)
        local Blacks = vRP.GetBlacks(Passport)
        local Lancamento = vRP.GetLancamento(Passport)
        if HasPrem or Blacks then
            Results = {}
            Results["Premium"] = Premium
            Results["Blacks"] = Blacks
            Results["Lancamento"] = Lancamento
        end 
        return Results
    end
	if Groups[Permission] then
		local Passport = tostring(Passport)
		for Perm,_ in pairs(Groups[Permission]["Parent"]) do
			if UserGroups[Passport][Permission] then
				Results = UserGroups[Passport][Permission] 
				break
			end
		end
	end

	return Results
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckJob(Passport)
    local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
    if not Job and vRP.HasGroup(Passport,"BolsaFamilia") then
        vRP.SetPermission(parseInt(Passport),"Iniciante",1)
    end
end
AddEventHandler("Connect",function(Passport,source,First)
	local Passport = tostring(Passport)
    local Ped = GetPlayerPed(source)
    local Query = vRP.Query("user_groups/GetUserGroups",{ passport = Passport })
    local UserGroups = vRP.GetUserGroups(Passport)
    for Permission,_ in pairs(UserGroups) do
        Groups[Permission]["Service"][Passport] = source
        vRP.ServiceEnter(source,Passport,Permission,true)
        Wait(500)
        if Groups[Permission]["Salary"] then
            TriggerEvent("Salary:Add",Passport,Permission)
        end
        if Permission == "Putaria" then
            Player(source)["state"]["Putaria"] = true
        end
    end
    RemPlayerNewbie(Passport)
    -- if Ped and Ped ~= 0 then
    --     if Job and not Staff then
    --         Player(source)["state"]["Blip"] = GetGroupBlip(Job)
    --     end
    --     if Staff then
    --         Player(source)["state"]["Blip"] = Rank
    --     end
    -- end
    local Number = vRP.HasPermission(Passport,"Admin")
    if Number and Number < 4 then
        if TimerAdmin[Number] then
            if source and TimerAdmin[Number] then
                Player(source)["state"]["AdminDeathTimer"] = TimerAdmin[Number]
            end
        end
    end
    if not Player(source)["state"]["AdminDeathTimer"] and vRP.HasGroup(Passport, "Influencer") then
        Player(source)["state"]["AdminDeathTimer"] = 15
    end
    CheckJob(Passport)
end)

if cityName == "Base" then
    DeathTimerGroups["Policia"] = 90
end

vRP.Prepare("characters/getCustomSpawn","SELECT customSpawn FROM characters WHERE id = @Passport ")

-- local Coords = GetEntityCoords(GetPlayerPed(Source))
-- local FormatCoords = tD(Coords.x)..","..tD(Coords.y)..","..tD(Coords.z)
AddEventHandler("Connect",function(Passport,source,First)
    local Table = {}
    local Ped = GetPlayerPed(source)
    local NewVips = vRP.HasVip(Passport)
    local DeathTimer = GlobalState["DeathTimer"]
    if NewVips then
        local Result = GetVIPRank(NewVips)
        if Result then
            Entity(Ped)["state"]["VipEmote"] = Result
        end
        for Group,_ in pairs(NewVips) do
            if DeathTimerGroups[Group] and DeathTimerGroups[Group] < (GlobalState["Deathtimer"] or 150) then
                DeathTimer = DeathTimerGroups[Group]
            end
            TriggerEvent("Salary:Add",Passport,Group)
        end
        local Query = vRP.Query("characters/getCustomSpawn",{ Passport = Passport })
        if Query and Query[1] and Query[1]["customSpawn"] then
            local Coords = Query[1]["customSpawn"]
            local FormatedCoords = toVector3(Coords)
            if FormatedCoords then
                Player(source)["state"]["CustomSpawn"] = FormatedCoords
            end
        end
        Player(source)["state"]["VIPDeathTimer"] = DeathTimer
    end
    if vRP.HasGroup(Passport, "Admin") then
        TriggerClientEvent("radio:EnterRadio",source,10)
    end
end)

function SetNewVip(Passport,Group,Days)
    if not Days then Days = 30 end
    vRP.Query("premium_time/SetNewVIP",{ Passport = Passport, Group = Group, Days = Days})
end

function NewVipFunctions(Passport,source)
    local Table = {}
    local Ped = GetPlayerPed(source)
    local NewVips = vRP.HasVip(Passport)
    local DeathTimer = GlobalState["DeathTimer"]
    if NewVips then
        local Result = GetVIPRank(NewVips)
        if Result then
            Entity(Ped)["state"]["VipEmote"] = Result
        end
        for Group,_ in pairs(NewVips) do
            if DeathTimerGroups[Group] and DeathTimerGroups[Group] < DeathTimer then
                DeathTimer = DeathTimerGroups[Group]
            end
            TriggerEvent("Salary:Add",Passport,Group)
        end
        local Query = vRP.Query("characters/getCustomSpawn",{ Passport = Passport })
        if Query and Query[1] and Query[1]["customSpawn"] then
            local Coords = Query[1]["customSpawn"]
            local FormatedCoords = toVector3(Coords)
            if FormatedCoords then
                Player(source)["state"]["CustomSpawn"] = FormatedCoords
            end
        end
        Player(source)["state"]["VIPDeathTimer"] = DeathTimer
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	local Passport = tostring(Passport)
    if not UserGroups[Passport] then
        return
    end
    for Group,Permission in pairs(UserGroups[Passport]) do
		if Groups[Group]["Service"][Passport] then
			-- if GroupBlips[Group] then
			-- 	exports["player"]:ExitMarkers(source)
			-- end

			Groups[Group]["Service"][Passport] = false
		end

		if Groups[Group]["Salary"] then
			TriggerEvent("Salary:Remove",Passport,Permission)
		end
    end
    UserGroups[Passport] = nil
end)

function vRP.GetAllTypeOnline(Type,Rank,Newbie)
    local Results = {}
    local players = GetPlayers()
    for i=1,#players do
        local source = players[i]
        local Passport = vRP.Passport(parseInt(source))
        if Passport then
            local Group,Level = vRP.UserGroupByType(Passport,Type)
            if Group and Level <= Rank then
                if Newbie then
                    if Group ~= "Desempregado" and Group ~= "Iniciante" then
                        Results[#Results+1] = source
                    end
                else
                    Results[#Results+1] = source
                end
            end
        end
    end
    return Results
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserPremium(Passport)
    return UserPremium[Passport] or {}
end

function vRP.GetPremium(Passport)
    -- local HasPremium = false
    -- local Permission = "Premium"
    -- if not Passport then
    --     return HasPremium
    -- end
    -- if not UserPremium[Passport] then
    --     local Query = vRP.Query("premium/getPremium",{ passport = Passport })
    --     if Query[1] then
    --         UserPremium[Passport] = {}
    --         local Table = {}
    --         local Removed = {}
    --         for i=1,#Query do
    --             if os.time() > Query[i]["expires"] then
    --                 vRP.Query("premium/deletePremium",{ passport = Passport, premium = Query[i]["premium"] })
    --                 Removed[#Removed+1] = Query[i]["premium"]
    --             else
    --                 Table[#Table+1] = Query[i]["premium"]
    --                 HasPremium = true
    --             end
    --         end
    --         table.sort(Table,function(a,b) return a < b end)
    --         if #Removed > 0 then
    --             for i=1,#Removed do
    --                 if Consult[tostring(Passport)] == Removed[i] then
    --                     Consult[tostring(Passport)] = nil
    --                 end
    --             end
    --             if #Table > 0 then
    --                 Consult[tostring(Passport)] = Table[1]
    --             end
    --             vRP.SetSrvData("Permissions:"..Permission,Consult)
    --         end
    --         if Table[1] then
    --             Consult[tostring(Passport)] = Table[1]
    --             vRP.SetSrvData("Permissions:"..Permission,Consult)
    --         end
    --         UserPremium[Passport] = Table
    --     end
    -- else
    --     HasPremium = true
    -- end
    -- return HasPremium,UserPremium[Passport]
end

function vRP.HasPremiumLevel(Passport,Level)
    local HasLevel = false
    if not UserPremium[Passport] then
        local HasPremium = vRP.GetPremium(Passport)
        if not HasPremium then
            return HasLevel
        end
    end
    if UserPremium[Passport] then
        for i=1,#UserPremium[Passport] do
            if UserPremium[Passport][i] == Level then
                HasLevel = true
                break
            end
        end
    end
    return HasLevel
end

function vRP.HasVip(Passport)
    local HasVip = false
    for Permission,_ in pairs(Groups) do
        if Groups[Permission]["Type"] and Groups[Permission]["Type"] == "VIP" then
            if vRP.HasGroup(Passport, Permission) then
                if not HasVip then
                    HasVip = {}
                    HasVip[Permission] = true
                else
                    HasVip[Permission] = true
                end
            end
        end
    end
    return HasVip
end

function vRP.SetPremiumSalary(Passport,Level)
    if not Level then
        Level = 5
    end
    local Permission = "Premium"
    local Consult = vRP.GetSrvData("Permissions:"..Permission)

    local HasPremium,Table = vRP.GetPremium(Passport)
    if HasPremium then
        if not vRP.HasPremiumLevel(Passport,Level) then
            vRP.Query("premium/setPremium",{ passport = Passport, premium = Level, Days = 30 })
            if Table and Table[1] and Table[1] < Level then
                UserPremium[Passport][#UserPremium[Passport]+1] = Level
                Level = Table[1] or 5
            else
                UserPremium[Passport][#UserPremium[Passport]+1] = Level
            end
        else
            vRP.Query("premium/updatePremium",{ passport = Passport, premium = Level, Days = 30 })
            if Table[1] < Level then
                Level = Table[1] or 5
            end
        end
    else
        vRP.Query("premium/setPremium",{ passport = Passport, premium = Level, Days = 30 })
        UserPremium[Passport] = {}
        UserPremium[Passport][#UserPremium[Passport]+1] = Level
    end
    local Cache = UserPremium[Passport]
    table.sort(Cache,function(a,b) return b > a end)
    Consult[tostring(Passport)] = parseInt(Level)

    vRP.SetSrvData("Permissions:"..Permission,Consult)
end

CreateThread(function()
    Wait(500)
    while true do
        local Query = vRP.Query("user_groups/GetAllGroupPerm",{ groupId = Groups["Admin"]["Id"], permission = 2 })
        for i=1,#Query do
            local Passport = Query[i]["passport"]
            local Identity = vRP.Identity(parseInt(Passport))
            if Identity and Identity["license"] then
                local License = Identity["license"]
                if not exports["variables"]:GetLicenses("Admin2")[License] then
                    vRP.RemovePermission(parseInt(Passport),"Admin")
                end
            end
        end
        Wait(60000*3)
    end
end)

CreateThread(function()
    Wait(500)
    while true do
        local Query = vRP.Query("user_groups/GetAllGroupPerm",{ groupId = Groups["Admin"]["Id"], permission = 1 })
        for i=1,#Query do
            local Passport = Query[i]["passport"]
            local Identity = vRP.Identity(parseInt(Passport))
            if Identity and Identity["license"] then
                local License = Identity["license"]
                if not exports["variables"]:GetLicenses("Dev")[License] then
                    vRP.RemovePermission(parseInt(Passport),"Admin")
                end
            end
        end
        Wait(60000*3)
    end
end)

vRP.Prepare("characters/GetByLicense","SELECT id FROM characters WHERE license = @license")

RegisterCommand("setadmins",function(source,Message)
    if source == 0 then
        for License,_ in pairs(exports["variables"]:GetLicenses("Dev")) do
            local Result = vRP.Query("characters/GetByLicense",{ license = License })
            if Result[1] then
                vRP.SetPermission(parseInt(Result[1]["id"]),"Admin",1)
                vRP.SetPermission(parseInt(Result[1]["id"]),"Abuser",1)
                print( "Admin setado para "..License,parseInt(Result[1]["id"]) )
            end
        end
        for License,_ in pairs(exports["variables"]:GetLicenses("Admin2")) do
            local Result = vRP.Query("characters/GetByLicense",{ license = License })
            if Result[1] then
                vRP.SetPermission(parseInt(Result[1]["id"]),"Admin",2)
                print( "Admin setado para "..License,parseInt(Result[1]["id"]) )
            end
        end
    end
end)

RegisterCommand("setqa",function(source,Message)
    if source == 0 then
        for License,_ in pairs(exports["variables"]:GetLicenses("QA")) do
            local result = vRP.Query("characters/GetByLicense",{ license = License })
            if result[1] then
                vRP.SetPermission(parseInt(result[1]["id"]),"QA",1)
                print( "Admin setado para "..License,parseInt(result[1]["id"]) )
            end
        end
    end
end)


CreateThread(function()
    local Query = vRP.Query("icr/getDate",{ date = os.date("%Y-%m-%d") })
    if not Query[1] then
        vRP.Query("icr/newDate",{})
    end
    while true do
        if os.date("%H:%M") == "00:00" then
            local Query = vRP.Query("icr/getDate",{ date = os.date("%Y-%m-%d") })
            if not Query[1] then
                vRP.Query("icr/newDate",{})
            end
        end
        Wait(10000)
    end
end)

vRP.Prepare("entitydata/getperm","SELECT * FROM entitydata WHERE dkey LIKE '%Permissions:%'")
-- CreateThread(function()
--     Wait(2500)
--     local Query = vRP.Query("entitydata/getperm",{})
--     for i=1,#Query do
--         local Info = Query[i]
--         local Dkey = Info["dkey"]
--         local Dvalue = json.decode(Info["dvalue"])
--         local Permission = string.gsub(Dkey, "Permissions:", "")
--         for Passport,Level in pairs(Dvalue) do
--             local GroupId = Groups[Permission]["Id"]
--             vRP.Query("user_groups/AddGroup2",{ Passport = Passport, groupId = GroupId, Permission = Level })
--         end
--     end
--     print("Finish set permissions")
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CACHE GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
SaveGroupsFunctions = {
    ["Add"] = function(Passport,GroupId,Level,Days)
        if Days then
            vRP.Query("user_groups/AddGroupDays",{ Passport,GroupId,Level,Days })
        else
            vRP.Query("user_groups/AddGroup",{ Passport,GroupId,Level })
        end
    end,
    ["Update"] = function(Passport,GroupId,Level,Days)
        if Days then
            vRP.Query("user_groups/UpdateGroupDays",{ Level,Days,Passport,GroupId })
        else
            vRP.Query("user_groups/UpdateGroup",{ Level,Passport,GroupId })
        end
    end,
    ["Remove"] = function(Passport,GroupId)
        vRP.Query("user_groups/RemGroup",{ Passport,GroupId })
    end,
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSERT SAVE GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function InsertSaveGroups(Passport,Group,Level,Days,Type)
    local GroupId = tostring(Group)
    local Passport = tostring(Passport)
    if not SaveGroups[Passport] then
        SaveGroups[Passport] = {}
    end
    if Type == "Add" then
        if not SaveGroups[Passport][GroupId] then
            SaveGroups[Passport][GroupId] = { "Add",Level,Days }
        elseif SaveGroups[Passport][GroupId][1] == "Remove" then
            SaveGroups[Passport][GroupId] = { "Add",Level,Days }
        end
    elseif Type == "Update" then
        if not SaveGroups[Passport][GroupId] then
            SaveGroups[Passport][GroupId] = { "Update",Level,Days }
        elseif SaveGroups[Passport][GroupId][1] == "Add" then
            SaveGroups[Passport][GroupId] = { "Add",Level,Days }
        end
    elseif Type == "Remove" then
        if not SaveGroups[Passport][GroupId] then
            SaveGroups[Passport][GroupId] = { "Remove" }
        else
            SaveGroups[Passport][GroupId] = nil
        end
    end
    SaveGroups[Passport]["Timer"] = os.time() + 60*30
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
function SavePlayerGroups(Passport)
    if SaveGroups[Passport] then
        local Table = SaveGroups[Passport]
        for GroupId,Info in pairs(Table) do
            if GroupId ~= "Timer" then
                local Type = Info[1]
                local Level = Info[2]
                local Days = Info[3]
                SaveGroupsFunctions[Type](Passport,GroupId,Level,Days)
            end
        end
        SaveGroups[Passport] = nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CACHE GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        pcall(function()
            for Passport,Info in pairs(SaveGroups) do
                if Info["Timer"] < os.time() then
                    xpcall(function()
                        SavePlayerGroups(tostring(Passport))
                    end,function(err)
                        print(err)
                    end)
                    Wait(5)
                end
            end
        end)
        Wait(60000*5)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CACHE GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("savegroups",function(source,Message)
    if source == 0 then
        for Passport,Info in pairs(SaveGroups) do
            SavePlayerGroups(tostring(Passport))
            Wait(10)
        end
    end
end)