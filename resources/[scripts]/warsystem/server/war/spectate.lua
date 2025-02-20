-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
PlayerSpectate = {}
AdminSpectate = {}
Spectate = {}
RegisterServerEvent("warsystem:NextSpectate")
AddEventHandler("warsystem:NextSpectate",function()
    local Source = source
    local Passport = vRP.Passport(Source)
    local Group = vRP.UserGroupByType(Passport,"Job")
    if AdminSpectate[Source] then
        Group = AdminSpectate[Source]
    end
    if Group and type(Group) ~= "number" then
        if InWarSystem then
            if InWarSystem["Groups"][Group] then
                --NextSpectate(Source,Group,true)
                return
            end
        end
    end
end)

RegisterServerEvent("warsystem:PreviousSpectate")
AddEventHandler("warsystem:PreviousSpectate",function()
    local Source = source
    local Passport = vRP.Passport(Source)
    local Group = vRP.UserGroupByType(Passport,"Job")
    if AdminSpectate[Source] then
        Group = AdminSpectate[Source]
    end
    if Group then
        if InWarSystem["Groups"][Group] then
            --NextSpectate(Source,Group,false)
            return
        end
    end
end)

function NextSpectate(Source,Group,Next)
    if not PlayerSpectate[Source] then
        PlayerSpectate[Source] = 1
    else
        if Next then
            PlayerSpectate[Source] = PlayerSpectate[Source] + 1
        else
            PlayerSpectate[Source] = PlayerSpectate[Source] - 1
        end
    end
    if PlayerSpectate[Source] > #InWarSystem["Groups"][Group] then
        PlayerSpectate[Source] = 1
    end
    local Spectated = InWarSystem["Groups"][Group][PlayerSpectate[Source]]
    Spectate[Source] = Spectated
    if Spectated then
        local Ped = GetPlayerPed(Spectated)
        local Bucket = GetPlayerRoutingBucket(Spectated)
        if Ped and InWarSystem then
            exports["vrp"]:ChangePlayerBucket(Source,Bucket)
            local Name = Entity(Ped)["state"]["Name"]
            local Kills = SourceKills[Spectated]
            TriggerClientEvent("warsystem:Spectate",Source,{ name = Name, kills = Kills, Info = InWarSystem["Info"], Source = Spectated })
        else
            ExitWarSystem(Source,"Finish")
        end
    end
end

function EndSpectate(Source,End)
    if PlayerSpectate[Source] then
        PlayerSpectate[Source] = nil
    end
    if AdminSpectate[Source] then
        AdminSpectate[Source] = nil
    end
    TriggerClientEvent("admin:resetSpectate",Source)
    
    if End then
        TriggerClientEvent("warsystem:EndSpectate",Source)
    end
end

RegisterCommand("spectatewar",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",4) then
            local Keyboard = vKEYBOARD.keySingle(source,"Grupo:")
            if Keyboard and Keyboard[1] then
                local Group = Keyboard[1]
                if InWarSystem["Groups"][Group] then
                    AdminSpectate[source] = Group
                    --NextSpectate(source,Group,true)
                end
            end
        end
    end
end)

RegisterCommand("exitspectate",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",4) then
            EndSpectate(Source,true)
        end
    end
end)