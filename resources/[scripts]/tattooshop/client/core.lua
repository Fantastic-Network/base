-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("tattooshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Camera = nil
local Tattoos = {}
cityName = GetConvar("cityName", "Base")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------
-- TATTOOSHOP:APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tattooshop:Apply")
AddEventHandler("tattooshop:Apply",function(Table)
    Tattoos = Table
    local Ped = PlayerPedId()
    LocalPlayer["state"]["Tattoos"] = Table
    for Index,Tattoo in ipairs(Tattoos) do
        local Dic,Name = GetTattooTypeDictionaryAndName(eTattooType[Tattoo])
        AddPedDecorationFromHashes(Ped,Dic,Name)
    end
end)
exports("Apply",function(Table,Ped)
    Tattoos = Table
    if not Ped then
        Ped = PlayerPedId()
    end
    LocalPlayer["state"]["Tattoos"] = Table
    for Index,Tattoo in ipairs(Tattoos) do
        local Dic,Name = GetTattooTypeDictionaryAndName(eTattooType[Tattoo])
        AddPedDecorationFromHashes(Ped,Dic,Name)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENTATTOOSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function ConvertNewTattoos()
    local NewTattoos = {}
    for Index,Tattoo in ipairs(Tattoos) do
        local Dic,Name = GetTattooTypeDictionaryAndName(eTattooType[Tattoo])
        NewTattoos[Name] = Dic 
    end
    return NewTattoos
end
function OpenTattooshop()
	CameraActive()
	SetNuiFocus(true,true)

	local Ped = PlayerPedId()
	if GetEntityModel(Ped) == GetHashKey("mp_m_freemode_01") then
		Active = Dataset["Masculino"]

		SetPedComponentVariation(Ped,1,-1,0,1)
		SetPedComponentVariation(Ped,3,15,0,1)
		SetPedComponentVariation(Ped,4,61,0,1)
		SetPedComponentVariation(Ped,5,-1,0,1)
		SetPedComponentVariation(Ped,6,34,0,1)
		SetPedComponentVariation(Ped,7,-1,0,1)
		SetPedComponentVariation(Ped,8,15,0,1)
		SetPedComponentVariation(Ped,9,-1,0,1)
		SetPedComponentVariation(Ped,10,-1,0,1)
		SetPedComponentVariation(Ped,11,15,0,1)
	elseif GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
		Active = Dataset["Feminino"]

		SetPedComponentVariation(Ped,1,-1,0,1)
		SetPedComponentVariation(Ped,3,15,0,1)
		SetPedComponentVariation(Ped,4,17,0,1)
		SetPedComponentVariation(Ped,5,-1,0,1)
		SetPedComponentVariation(Ped,6,35,0,1)
		SetPedComponentVariation(Ped,7,-1,0,1)
		SetPedComponentVariation(Ped,8,7,0,1)
		SetPedComponentVariation(Ped,9,-1,0,1)
		SetPedComponentVariation(Ped,10,-1,0,1)
		SetPedComponentVariation(Ped,11,18,0,1)
	end

	ClearAllPedProps(Ped)

    vSERVER.Open()
	vRP.playAnim(true,{"mp_sleep","bind_pose_180"},true)
	SendNUIMessage({ open = true, shop = Active, tattoo = ConvertNewTattoos() })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAMERAACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function CameraActive()
	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	local Ped = PlayerPedId()
	local Heading = GetEntityHeading(Ped)
	local Coords = GetOffsetFromEntityInWorldCoords(Ped,0.30,1.60,-0.10)

	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
	SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"])
	RenderScriptCams(true,true,100,true,true)
	SetCamRot(Camera,0.0,0.0,Heading + 180)
	SetEntityHeading(Ped,Heading - 10)
	SetCamActive(Camera,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

    vSERVER.Cancel()
	exports["skinshop"]:Apply()
	SetNuiFocus(false,false)
	vRP.DestroyObjects()

	Callback("Ok")
end)

RegisterNUICallback("Save",function(Data,Callback)
	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

    vSERVER.Cancel()
    exports["skinshop"]:Apply()
    SetNuiFocus(false,false)
    vSERVER.Update(json.encode(Tattoos))
    TriggerEvent("vrp:removeObjects")

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Tables = {}

	for Number = 1,#Locations do
		Tables[#Tables + 1] = { Locations[Number]["x"],Locations[Number]["y"],Locations[Number]["z"],2.0,"E","Loja de Tatuagem","Pressione para abrir" }
	end

	TriggerEvent("hoverfy:Insert",Tables)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADLOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				local Coords = GetEntityCoords(Ped)

				for Number = 1,#Locations do
					if #(Coords - Locations[Number]) <= 2.0 then
						TimeDistance = 1

						if IsControlJustPressed(1,38) and not exports["hud"]:Wanted() then
							OpenTattooshop()
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGE
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckTatto(Tattoo)
    local Has = false
    for i=1,#Tattoos do
        if Tattoos[i] == Tattoo then
            Has = i
        end
    end
    return Has
end

RegisterNUICallback("Change",function(Data,Callback)
	local Ped = PlayerPedId()
	local Types = Data["type"]
	local Number = Data["id"] + 1

	if Active[Types] and Active[Types]["tattoo"] and Active[Types]["tattoo"][Number] then
		local Name = Active[Types]["tattoo"][Number]["name"]
        local Part = Active[Types]["tattoo"][Number]["part"]
        local Formated = FormatTattoo(Name,Part)
        local Tattoo = eTattooType[Formated]
        local Has = CheckTatto(Tattoo)
    
        if Has then
            table.remove(Tattoos,Has)
        else
            table.insert(Tattoos, eTattooType[Formated])
        end
        
		ClearPedDecorations(Ped)
        for Index,Tattoo in ipairs(Tattoos) do
            local Dic,Name = GetTattooTypeDictionaryAndName(eTattooType[Tattoo])
            AddPedDecorationFromHashes(Ped,Dic,Name)
        end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Clean",function(Data,Callback)
	ClearPedDecorations(PlayerPedId())
	Tattoos = {}

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Rotate",function(Data,Callback)
	local Ped = PlayerPedId()

	if Data == "Left" then
		SetEntityHeading(Ped,GetEntityHeading(Ped) + 5)
	elseif Data == "Right" then
		SetEntityHeading(Ped,GetEntityHeading(Ped) - 5)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDSUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("HandsUp",function(Data,Callback)
	local Ped = PlayerPedId()
	if IsEntityPlayingAnim(Ped,"random@mugging3","handsup_standing_base",3) then
		StopAnimTask(Ped,"random@mugging3","handsup_standing_base",8.0)
		vRP.AnimActive()
	else
		vRP.playAnim(true,{"random@mugging3","handsup_standing_base"},true)
	end

	Callback("Ok")
end)

RegisterNetEvent("tattooshop:Open:NPC")
AddEventHandler("tattooshop:Open:NPC",function(coords)
	TriggerEvent("talknpc:closeTalk")
	OpenTattooshop()
end)

RegisterNetEvent('register:Open')
AddEventHandler('register:Open', function()
	SendNUIMessage({ open = false })
end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)