-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("hud",Creative)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Hours = 12
Minutes = 0
Weather = "EXTRASUNNY"
Minutes = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
local Work = 0
local Hours = 12
local Minutes = 0
local LastUpdate = os.time()
CreateThread(function()
    Wait(1000)
    TriggerClientEvent("hud:SyncTime",-1,Hours,Minutes,Weather)
	while true do
        local New = Minutes + 1.4
        Minutes = New
		Minutes = math.floor(Minutes + 0.5)

		if Minutes >= 60 then
			Hours = Hours + 1
			Minutes = 0
            Minutes = 0

			if Hours >= 24 then
				Hours = 0
			end
		end
        if os.time() >= LastUpdate + 60*3 then
            LastUpdate = os.time()
            TriggerClientEvent("hud:SyncTime",-1,Hours,Minutes,Weather)
        end
		Wait(5000)
	end
end)
GlobalState["RobberyTime"] = {}
vRP.Prepare("server_info/GetRobberyTime","SELECT * FROM server_info")
vRP.Prepare("server_info/SetRobberyTime","INSERT INTO server_info(robbery_north_start,robbery_north_end,robbery_south_start,robbery_south_end) VALUES(@NorthStart,@NorthEnd,@SouthStart,@SouthEnd)")
vRP.Prepare("server_info/UpdateRobberyTime","UPDATE server_info SET robbery_north_start = @NorthStart, robbery_north_end = @NorthEnd, robbery_south_start = @SouthStart, robbery_south_end = @SouthEnd")

CreateThread(function()
     local Query = vRP.Query("server_info/GetRobberyTime")
     local Table = {}
     if Query and Query[1] then
        if Query[1].robbery_north_start and Query[1].robbery_north_start ~= 0 then
            Table["North"] = {Start = Query[1].robbery_north_start, End = Query[1].robbery_north_end}
        end

        if Query[1].robbery_south_start and Query[1].robbery_south_start ~= 0 then
            Table["South"] = {Start = Query[1].robbery_south_start, End = Query[1].robbery_south_end}
        end
        GlobalState["RobberyTime"] = Table
     end
    --  Table["North"] = {Start = 1, End = 23}
    --  Table["South"] = {Start = 24, End = 25}
     GlobalState["RobberyTime"] = Table
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HORARIO ASSAULTO
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('horaroubo',function(source,args,rawCommand)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keyFourth(source,"Hora inicio roubo sul:","Hora fim roubo sul:","Hora inicio roubo norte:","Hora fim roubo norte:")
            TriggerClientEvent("Notify",source,"sucesso","Horario de roubo definido com sucesso.",8000)
            -- TriggerClientEvent("Notify2",source,"#theftTime")
            if Keyboard and Keyboard[4] then
                local SouthStart = parseInt(Keyboard[1])
                local SouthEnd = parseInt(Keyboard[2])
                local NorthStart = parseInt(Keyboard[3])
                local NorthEnd = parseInt(Keyboard[4])
                local Table = {}
                if NorthStart and NorthEnd and SouthStart and SouthEnd then
                    if not GlobalState["RobberyTime"]["North"] then
                        vRP.Query("server_info/SetRobberyTime",{NorthStart = NorthStart, NorthEnd = NorthEnd, SouthStart = SouthStart, SouthEnd = SouthEnd})
                    else
                        vRP.Query("server_info/UpdateRobberyTime",{NorthStart = NorthStart, NorthEnd = NorthEnd, SouthStart = SouthStart, SouthEnd = SouthEnd})
                    end
                    Table["North"] = {Start = NorthStart, End = NorthEnd}
                    Table["South"] = {Start = SouthStart, End = SouthEnd}
                    GlobalState["RobberyTime"] = Table
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("timeset",function(source,Message)
	local Passport = vRP.Passport(source)
    Wait(100)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
			Hours = parseInt(Message[1])
            Minutes = parseInt(Message[2])
			if Message[3] then
				Weather = Message[3]
			end
            TriggerClientEvent("hud:SyncTime",-1,Hours,Minutes,Weather)
		end
	end
end)

RegisterCommand("timeset2",function(source,Message)
    if source == 0 then
        Hours = parseInt(Message[1])
        Minutes = parseInt(Message[2])

        if Message[3] then
            Weather = Message[3]
        end
    end
    TriggerClientEvent("hud:SyncTime",-1,Hours,Minutes,Weather)
end)

RegisterCommand("testhud",function(source,Message)
    if source == 0 then
        TriggerClientEvent("hud:Active",-1,true)
    end
end)


AddEventHandler("Connect",function(Passport,source)
    TriggerClientEvent("hud:SyncTime",source,Hours,Minutes,Weather)
end)

local SourceName = {}

function Creative.GetPlayerInfo(Source)
    local Passport = vRP.Passport(Source)
    local sSource = tostring(Source)
    if SourceName[sSource] then
        return SourceName[sSource]
    end
    if Passport then
        local Identity = vRP.Identity(Passport)
        if Identity and Identity["name"] then
            local PlayerInfo = Passport.." | "..Identity["name"]
            SourceName[sSource] = PlayerInfo
            return PlayerInfo
        end
    end
    return ""
end


AddEventHandler("Connect",function(Passport,source)
    local sSource = tostring(Source)
    if Passport then
        local Identity = vRP.Identity(Passport)
        if Identity and Identity["name"] then
            local PlayerInfo = Passport.." | "..Identity["name"]
            SourceName[sSource] = PlayerInfo
        end
    end
end)

AddEventHandler("Disconnect",function(Passport,source)
    local sSource = tostring(source)
    if SourceName[sSource] then
        SourceName[sSource] = nil
    end
end)

-- local LogDiscord = {
--     ["SUSPECTV3"] = "https://discord.com/api/webhooks/11155965280229535944/ctjrZtUQaPLqHeqlfw3SROGLBv_eS-PQG9M8cYCXxFHIuWFGa_ORAjSmdDwSiGbptBDb"
-- }
-- CreateThread(function()
--     Wait(1000)
--     exports["vrp"]:UpdateWebHook("SUSPECTV3","https://discord.com/api/webhooks/11155965280229535944/ctjrZtUQaPLqHeqlfw3SROGLBv_eS-PQG9M8cYCXxFHIuWFGa_ORAjSmdDwSiGbptBDb")
-- end)

-- cityName = GetConvar("cityName", "Base")

-- RegisterNetEvent("SAHUDUHNW", function(wp)
--     local source = source
--     local Passport = vRP.Passport(source)
--     --TriggerEvent("AC:Suspect",{user_id = Passport or source, reason = "[SUSPEITO/V3]"})
--     exports["vrp"]:SendWebHook("SUSPECTV3", "**CIDADE:** "..cityName.." \n**PASSPORT:** " .. Passport .. "\n**SOURCE:** " .. source .. "\n[SUSPEITO/V3] " .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187,{Passport})
-- end)