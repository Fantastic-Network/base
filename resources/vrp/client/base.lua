-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
tvRP = {}
Proxy.addInterface("vRP",tvRP)
Tunnel.bindInterface("vRP",tvRP)
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.giveWeapons(wp_table)
end
function tvRP.getWeapons(wp_table)
	return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESTPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ClosestPeds(Radius)
	local Players = {}
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)

	for _,source in pairs(GetPlayers()) do
		local Player = GetPlayerFromServerId(source)
		if Player ~= PlayerId() and NetworkIsPlayerConnected(Player) then
			local OtherPed = GetPlayerPed(Player)
			local OtherCoords = GetEntityCoords(OtherPed)
			local Distance = #(Coords - OtherCoords)

			if Distance <= Radius then
				Players[Player] = { Distance,source }
			end
		end
	end

	return Players
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESTPED
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ClosestPed(Radius)
	local Selected = false
	local Min = Radius + 0.0001
	local Players = tvRP.ClosestPeds(Radius)

	for _,v in pairs(Players) do
		if v[1] <= Min then
			Selected = v[2]
			Min = v[1]
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayers()
	local Players = {}

	for _,v in ipairs(GetActivePlayers()) do
		Players[#Players + 1] = GetPlayerServerId(v)
	end

	return Players
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Players()
	return GetPlayers()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PlaySound(Dict,Name)
	PlaySoundFrontend(-1,Dict,Name,false)
end





-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blipmin = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayersAdmin()
	local Selected = {}
	local GamePool = GetGamePool("CPed")

	for _,Entity in pairs(GamePool) do
		local Index = NetworkGetPlayerIndexFromPed(Entity)

		if Index and IsPedAPlayer(Entity) and NetworkIsPlayerConnected(Index) then
			Selected[Entity] = GetPlayerServerId(Index)
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
local Markers = {}
local Colors = {
	["Novato"] = 43,
    ["Jogador"] = 50,
}

function CleanMarkers()
	for Index,v in pairs(Markers) do
		if DoesBlipExist(v) then
			RemoveBlip(v)
		end
	end

	Markers = {}
end

function GetPlayers2()
	local Selected = {}
    local Peds = GetGamePool("CPed")
    for i=1,#Peds do
        local SelectedPed = Peds[i]
        if IsPedAPlayer(SelectedPed) then
            local Mode = "Jogador"
            if Entity(SelectedPed)["state"]["Newbie"] then
                Mode = "Novato"
            end
			Selected[SelectedPed] = Mode
        end
    end
	return Selected
end

function tvRP.BlipAdmin()
	Blipmin = not Blipmin
    CleanMarkers()
	while Blipmin do
        CleanMarkers()
        for Ped,Mode in pairs(GetPlayers2()) do
            if not Markers[Ped] then
                Markers[Ped] = AddBlipForEntity(Ped)
                SetBlipSprite(Markers[Ped],1)
                SetBlipDisplay(Markers[Ped],4)
                SetBlipAsShortRange(Markers[Ped],true)
                SetBlipColour(Markers[Ped],Colors[Mode])
                SetBlipScale(Markers[Ped],0.7)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("! "..Mode)
                EndTextCommandSetBlipName(Markers[Ped])
            end
        end
        Wait(1000)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(Coords,Text,Newbie)
	local onScreen,x,y = World3dToScreen2d(Coords["x"],Coords["y"],Coords["z"] + 1.10)

	if onScreen then
		SetTextFont(4)
		SetTextCentre(true)
		SetTextProportional(1)
		SetTextScale(0.35,0.35)

		SetTextEntry("STRING")
		AddTextComponentString(Text)
		EndTextCommandDisplayText(x,y)

		local Width = string.len(Text) / 160 * 0.275

		if Newbie then
			SetTextColour(0,0,0,150)
			DrawRect(x,y + 0.0125,Width,0.03,255,255,255,175)
		else
			SetTextColour(255,255,255,150)
			DrawRect(x,y + 0.0125,Width,0.03,15,15,15,175)
		end
	end
end