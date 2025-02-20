-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("barbershop",Creative)
vSERVER = Tunnel.getInterface("barbershop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Barber = {}
local Camera = nil
local FirstLogin = false
local Cooldown = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]["Barbershop"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Barbershop",function()
	if LocalPlayer["state"]["Route"] < 900000 and GetGameTimer() >= Cooldown then
		Cooldown = GetGameTimer() + 10000

		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)
			local Barbershops = exports["variables"]:GetBarberShops()
			for _,v in pairs(Barbershops) do
				local Distance = #(Coords - vec3(v[1],v[2],v[3]))
				if Distance <= 2.5 and not exports["hud"]:Wanted() then
					OpenBarbershop("barber")

					break
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Finish",function(Data,Callback)
	exports["barbershop"]:Apply(Data)
	SetNuiFocus(false,false)
    FreezeEntityPosition(PlayerPedId(),false)
	vSERVER.Update(Data,FirstLogin)
	vRP.DestroyObjects()
	if FirstLogin then
		FirstLogin = false
		FreezeEntityPosition(PlayerPedId(),false)
	end
	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end
    LocalPlayer["state"]["Character"] = Data
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Cancel",function(Data,Callback)
	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end
    vSERVER.Cancel()
	exports["barbershop"]:Apply(LocalPlayer["state"]["Barbershop"])
	LocalPlayer["state"]["Barbershop"] = {}
	SetNuiFocus(false,false)
    FreezeEntityPosition(PlayerPedId(),false)
	vRP.DestroyObjects()
    FreezeEntityPosition(PlayerPedId(),false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
local Presets = {
    ["mp_f_freemode_01"] = json.decode("[0,0,1,26,10,0,-1,-1,-1,74,0,19,64,0.99,0,5,0.99,55,12,0.99,0,0,0,0,1,0.13,0,-0.17,-0.06,0.58,0.49,-0.1,0,-0.1,-0.3,-0.43,0.18,-0.2,-0.19,0.14,0,-1,-1,0,-0.25,-0.6,1,0,0,0]"),
}
RegisterNUICallback("Update",function(Data,Callback)
	local Ped = PlayerPedId()
	if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") and Data[47] == 0 then
		vSERVER.ChangeSkin("mp_m_freemode_01")
		exports["skinshop"]:Apply()
	elseif GetEntityModel(Ped) == GetHashKey("mp_m_freemode_01") and Data[47] == 1 then
		vSERVER.ChangeSkin("mp_f_freemode_01")
		exports["skinshop"]:Apply()
        if FirstLogin then
            if Presets["mp_f_freemode_01"] then
                exports["barbershop"]:Apply(Presets["mp_f_freemode_01"])
            end
        end
	end

	for Index,v in pairs(Data) do
		Barber[Index] = v
	end

	exports["barbershop"]:Apply()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Rotate",function(Data,Callback)
	local Ped = PlayerPedId()
	local Heading = GetEntityHeading(Ped)
	if Data == "Left" then
		SetEntityHeading(Ped,Heading + 10)
	else
		SetEntityHeading(Ped,Heading - 10)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:Apply")
AddEventHandler("barbershop:Apply",function(Table)
	if Table then
		exports["barbershop"]:Apply(Table)
	else
		exports["barbershop"]:Apply()
	end
    LocalPlayer["state"]["Character"] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Apply",function(Table,Ped)
	if not Ped then
		Ped = PlayerPedId()
	end

	if Table then
		Barber = Table
	end

	for Number = 1,50 do
		if not Barber[Number] then
			Barber[Number] = 0
		end
	end

	local Fathers = exports["variables"]:GetParents("Fathers")
	local Mothers = exports["variables"]:GetParents("Mothers")

	SetPedHeadBlendData(Ped,Fathers[Barber[1] + 1],Mothers[Barber[2] + 1],0,Barber[5],0,0,Barber[3] + 0.0,0,0,false)

	SetPedEyeColor(Ped,Barber[4])

	SetPedComponentVariation(Ped,2,Barber[10],0,0)
	SetPedHairColor(Ped,Barber[11],Barber[12])

	SetPedHeadOverlay(Ped,0,Barber[7],0.99)
	SetPedHeadOverlayColor(Ped,0,0,0,0)

	SetPedHeadOverlay(Ped,1,Barber[22],Barber[23])
	SetPedHeadOverlayColor(Ped,1,1,Barber[24],Barber[24])

	SetPedHeadOverlay(Ped,2,Barber[19],Barber[20])
	SetPedHeadOverlayColor(Ped,2,1,Barber[21],Barber[21])

	SetPedHeadOverlay(Ped,3,Barber[9],0.99)
	SetPedHeadOverlayColor(Ped,3,0,0,0)

	SetPedHeadOverlay(Ped,4,Barber[13],Barber[14])
	SetPedHeadOverlayColor(Ped,4,1,Barber[15],Barber[15])

	SetPedHeadOverlay(Ped,5,Barber[25],Barber[26])
	SetPedHeadOverlayColor(Ped,5,1,Barber[27],Barber[27])

	SetPedHeadOverlay(Ped,6,Barber[6],0.99)
	SetPedHeadOverlayColor(Ped,6,0,0,0)

	SetPedHeadOverlay(Ped,8,Barber[16],Barber[17])
	SetPedHeadOverlayColor(Ped,8,1,Barber[18],Barber[18])

	SetPedHeadOverlay(Ped,9,Barber[8],0.99)
	SetPedHeadOverlayColor(Ped,9,0,0,0)

    SetPedHeadOverlay(Ped,10, Barber[48], Barber[49])
    SetPedHeadOverlayColor(Ped, 10, 1, Barber[50], Barber[51])

	SetPedFaceFeature(Ped,0,Barber[28])
	SetPedFaceFeature(Ped,1,Barber[29])
	SetPedFaceFeature(Ped,2,Barber[30])
	SetPedFaceFeature(Ped,3,Barber[31])
	SetPedFaceFeature(Ped,4,Barber[32])
	SetPedFaceFeature(Ped,5,Barber[33])
	SetPedFaceFeature(Ped,6,Barber[44])
	SetPedFaceFeature(Ped,7,Barber[34])
	SetPedFaceFeature(Ped,8,Barber[36])
	SetPedFaceFeature(Ped,9,Barber[35])
	SetPedFaceFeature(Ped,10,Barber[45])
	SetPedFaceFeature(Ped,12,Barber[42])
	SetPedFaceFeature(Ped,13,Barber[46])
	SetPedFaceFeature(Ped,14,Barber[37])
	SetPedFaceFeature(Ped,15,Barber[38])
	SetPedFaceFeature(Ped,16,Barber[40])
	SetPedFaceFeature(Ped,17,Barber[39])
	SetPedFaceFeature(Ped,18,Barber[41])
	SetPedFaceFeature(Ped,19,Barber[43])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENBARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function OpenBarbershop(Mode)
    local Ped = PlayerPedId()
	for Number = 1,47 do
		if not Barber[Number] then
			Barber[Number] = 0
		end
	end
    if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
        Barber[47] = 1
	elseif GetEntityModel(Ped) == GetHashKey("mp_m_freemode_01") then
        Barber[47] = 0
    else
        Barber[47] = 3
	end
	LocalPlayer["state"]["Barbershop"] = Barber
    if not FirstLogin then
        vSERVER.Open()
    else
        vSERVER.Open()
        SetEntityHeading(Ped,138.9)
    end
	vRP.playAnim(true,{"mp_sleep","bind_pose_180"},true)

	local Heading = GetEntityHeading(Ped)
	local Coords = GetOffsetFromEntityInWorldCoords(Ped,0.0,0.5,0)
    local ConfigCreating = false
    if LocalPlayer["state"]["Creating"] then
        ConfigCreating = exports["variables"]:GetSelectionSpawn()
        TriggerEvent("notify:TutorialStatus",false)
    end

    if ConfigCreating then
        SetEntityCoords(Ped,ConfigCreating["Peds"]["x"],ConfigCreating["Peds"]["y"],ConfigCreating["Peds"]["z"])
        Coords = GetOffsetFromEntityInWorldCoords(Ped,0.0,0.5,0)
        Heading = ConfigCreating["Peds"]["w"]
        Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
        SetCamCoord(Camera,Coords["x"],Coords["y"] - 0.1,Coords["z"] + 0.6)
        RenderScriptCams(true,true,100,true,true)
        SetCamRot(Camera,0.0,0.0,Heading + 180)
        SetEntityHeading(Ped,Heading)
        SetCamActive(Camera,true)
        DoScreenFadeIn(2500)
        while not IsScreenFadedIn() do 
            Wait(5) 
        end
    else
        Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
        SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"] + 0.6)
        RenderScriptCams(true,true,100,true,true)
        SetCamRot(Camera,0.0,0.0,Heading + 180)
        SetEntityHeading(Ped,Heading)
        SetCamActive(Camera,true)
    end

	SendNUIMessage({ action = Mode, data = { Barber,GetNumberOfPedDrawableVariations(Ped,2) - 1 } })
	SetNuiFocus(true,true)

    CreateThread(function()
        local Ped = PlayerPedId()
        while DoesCamExist(Camera) do
            FreezeEntityPosition(Ped,true)
            SetEntityVisible(Ped,true)
            Wait(1)
        end
        FreezeEntityPosition(Ped,false)
        SetEntityVisible(Ped,true)
    end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:Open")
AddEventHandler("barbershop:Open",function(Mode,Bool)
	OpenBarbershop(Mode)
    FirstLogin = Bool
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP:OPEN:NPC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:Open:NPC")
AddEventHandler("barbershop:Open:NPC",function(Mode)
	TriggerEvent("talknpc:closeTalk")
	OpenBarbershop(Mode)
end)

-- RegisterNUICallback("getCityName",function(Data,Callback)
--     cityName = GetConvar("cityName", "Base")
--     Callback(string.lower(cityName))
-- end)

-- CreateThread(function()
--     Wait(500)
--     OpenBarbershop("open")
-- end)


-- CreateThread(function()
--     LocalPlayer["state"]["Creating"] = true
--     Wait(1000)
--     OpenBarbershop("open")
-- end)