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
Tunnel.bindInterface("skinshop",Creative)
vSERVER = Tunnel.getInterface("skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Init = "hat"
local Camera = nil
local Animation = false
local Command = false
cityName = GetConvar("cityName", "Base")
local Bucket = 1
local Newbie = false
local CachedCoords
local Cooldown = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATASET
-----------------------------------------------------------------------------------------------------------------------------------------
local Dataset = {
	["pants"] = { item = 0, texture = 0 },
	["arms"] = { item = 0, texture = 0 },
	["tshirt"] = { item = 1, texture = 0 },
	["torso"] = { item = 0, texture = 0 },
	["vest"] = { item = 0, texture = 0 },
	["shoes"] = { item = 0, texture = 0 },
	["mask"] = { item = 0, texture = 0 },
	["backpack"] = { item = 0, texture = 0 },
	["hat"] = { item = -1, texture = 0 },
	["glass"] = { item = 0, texture = 0 },
	["ear"] = { item = -1, texture = 0 },
	["watch"] = { item = -1, texture = 0 },
	["bracelet"] = { item = -1, texture = 0 },
	["accessory"] = { item = 0, texture = 0 },
	["decals"] = { item = 0, texture = 0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Skinshop",function()
	if LocalPlayer["state"]["Route"] < 900000 and GetGameTimer() >= Cooldown then
		Cooldown = GetGameTimer() + 10000

		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)
			local Skinshops = exports["variables"]:GetSkinShops()
			for k,v in pairs(Skinshops) do
				local Distance = #(Coords - vec3(v[1],v[2],v[3]))
				if Distance <= 2 and not exports["hud"]:Wanted() and not exports["hud"]:Reposed() then
					if not LocalPlayer["state"]["Plaster"] then
						OpenSkinshop()
					end

					break
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:Apply")
AddEventHandler("skinshop:Apply",function(Table, forceEmptyUpdate --[[ Outros scripts dependem que esse evento salve as roupas novamente, mas no login a gente não tem essa necessidade! ]])
	for Index,v in pairs(Dataset) do
		if not Table[Index] then
			Table[Index] = v
		end
	end
    LocalPlayer["state"]["Skinshop"] = Table
	Dataset = Table

	vSERVER.Update(forceEmptyUpdate and { } or Dataset)

	exports["skinshop"]:Apply()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:Open")
AddEventHandler("skinshop:Open",function(Boolean,Variable)
	TriggerEvent("dynamic:closeSystem")
    if Variable then
        Newbie = true
        OpenSkinshop()
        FreezeEntityPosition(PlayerPedId(),true)
        vSERVER.Open()
        return
    end
	if not exports["hud"]:Wanted() and not exports["hud"]:Reposed() then
        if Boolean then
            Command = true
        end
        OpenSkinshop()
        FreezeEntityPosition(PlayerPedId(),true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAXVALUES
-----------------------------------------------------------------------------------------------------------------------------------------
function MaxValues()
	local MaxValues = {}
	local Ped = PlayerPedId()
    local isMale = GetEntityModel(Ped) == GetHashKey("mp_m_freemode_01")
	for Index, dump in pairs(SharedClothingData) do
        local v = {}
        v["min"] = dump["min"]
        v["max"] = dump["max"]
        v["id"] = dump["id"]
        v["mode"] = dump["mode"]
        v["vips"] = dump["vips"]
        v["diamonds"] = dump["diamonds"]
        v["prices"] = dump["prices"]
        v["reset"] = dump["reset"]

		if v["mode"] == "variation" then
			v["item"] = GetNumberOfPedDrawableVariations(Ped,v["id"])
			v["texture"] = GetNumberOfPedTextureVariations(Ped,v["id"],GetPedDrawableVariation(Ped,v["id"])) - 1
		elseif v["mode"] == "prop" then
			v["item"] = GetNumberOfPedPropDrawableVariations(Ped,v["id"])
			v["texture"] = GetNumberOfPedPropTextureVariations(Ped,v["id"],GetPedPropIndex(Ped,v["id"])) - 1
		end

        if isMale then
            v["diamonds"] = v["diamonds"]["mp_m_freemode_01"]
            v["vips"] = v["vips"]["mp_m_freemode_01"]
            v["prices"] = v["prices"]["mp_m_freemode_01"]
        else
            v["diamonds"] = v["diamonds"]["mp_f_freemode_01"]
            v["vips"] = v["vips"]["mp_f_freemode_01"]
            v["prices"] = v["prices"]["mp_f_freemode_01"]
        end

        if isMale then
            v["reset"] = v["reset"]["mp_m_freemode_01"]
        else
            v["reset"] = v["reset"]["mp_f_freemode_01"]
        end

		if v["texture"] < 0 then
			v["texture"] = 0
		end
        MaxValues[Index] = v
	end

	return MaxValues
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENSKINSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function OpenSkinshop()
    FreezeEntityPosition(PlayerPedId(),true)
	LocalPlayer["state"]["Skinshop"] = Dataset
    Bucket = LocalPlayer["state"]["Route"]
    if not Command then
        vSERVER.Open()
    end
    SendNUIMessage({ action = "setVisible", data = "" })

	vRP.playAnim(true,{"mp_sleep","bind_pose_180"},true)
    CachedCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.25,1.0,0.0)

	SetNuiFocus(true,true)
	CameraActive()
    TriggerEvent("hud:Active",false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAMERAACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
local function UpdateCameraBasedOnInit()
	local Ped = PlayerPedId()
    if not CachedCoords then
        CachedCoords = GetOffsetFromEntityInWorldCoords(Ped,0.25,1.0,0.0)
    end

	if Init == "hat" then
		SetCamCoord(Camera,CachedCoords["x"],CachedCoords["y"],CachedCoords["z"] + 0.45)
    elseif Init == "mask" then
        SetCamCoord(Camera,CachedCoords["x"],CachedCoords["y"],CachedCoords["z"] + 0.45)
	elseif Init == "shirt" then
		SetCamCoord(Camera,CachedCoords["x"],CachedCoords["y"],CachedCoords["z"] + 0.25)
	elseif Init == "pants" then
		SetCamCoord(Camera,CachedCoords["x"],CachedCoords["y"],CachedCoords["z"] - 0.45)
	elseif Init == "watch" then
		SetCamCoord(Camera,CachedCoords["x"],CachedCoords["y"],CachedCoords["z"] + 0.05)
    elseif Init == "bracelet" then
        SetCamCoord(Camera,CachedCoords["x"],CachedCoords["y"],CachedCoords["z"] + 0.05)
    elseif Init == "arms" then
        SetCamCoord(Camera,CachedCoords["x"],CachedCoords["y"],CachedCoords["z"] + 0.15)
    elseif Init == "vest" then
        SetCamCoord(Camera,CachedCoords["x"],CachedCoords["y"],CachedCoords["z"] + 0.15)
    elseif Init == "shoes" then
        SetCamCoord(Camera,CachedCoords["x"],CachedCoords["y"],CachedCoords["z"] - 0.75)
    else
        SetCamCoord(Camera,CachedCoords["x"],CachedCoords["y"],CachedCoords["z"] + 0.25)
	end
end

function CameraActive(Number,NPC)
	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	local Ped = PlayerPedId()

	if Number then
		SetEntityCoords(Ped,Skinshops[Number][1],Skinshops[Number][2],Skinshops[Number][3] - 1)
		SetEntityHeading(Ped,Skinshops[Number][4])
	end

    if NPC then
        SetEntityCoords(Ped,NPC["x"],NPC["y"],NPC["z"] - 1)
        SetEntityHeading(Ped,NPC["w"])
    end

	local Heading = GetEntityHeading(Ped)
	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
    UpdateCameraBasedOnInit()

	RenderScriptCams(true,true,100,true,true)
	SetCamRot(Camera,0.0,0.0,Heading + 180)
	SetEntityHeading(Ped,Heading)
	SetCamActive(Camera,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Apply",function(Data,Ped)
	if not Ped then
		Ped = PlayerPedId()
	end

	if not Data then
		Data = Dataset
	end

	for Index,v in pairs(Dataset) do
		if not Data[Index] then
			Data[Index] = {
				["item"] = v["item"],
				["texture"] = v["texture"]
			}
		end
	end

	SetPedComponentVariation(Ped,4,Data["pants"]["item"],Data["pants"]["texture"],1)
	SetPedComponentVariation(Ped,3,Data["arms"]["item"],Data["arms"]["texture"],1)
	SetPedComponentVariation(Ped,5,Data["backpack"]["item"],Data["backpack"]["texture"],1)
	SetPedComponentVariation(Ped,8,Data["tshirt"]["item"],Data["tshirt"]["texture"],1)
	SetPedComponentVariation(Ped,9,Data["vest"]["item"],Data["vest"]["texture"],1)
	SetPedComponentVariation(Ped,11,Data["torso"]["item"],Data["torso"]["texture"],1)
	SetPedComponentVariation(Ped,6,Data["shoes"]["item"],Data["shoes"]["texture"],1)
	SetPedComponentVariation(Ped,1,Data["mask"]["item"],Data["mask"]["texture"],1)
	SetPedComponentVariation(Ped,10,Data["decals"]["item"],Data["decals"]["texture"],1)
	SetPedComponentVariation(Ped,7,Data["accessory"]["item"],Data["accessory"]["texture"],1)

	if Data["hat"]["item"] ~= -1 and Data["hat"]["item"] ~= 0 then
		SetPedPropIndex(Ped,0,Data["hat"]["item"],Data["hat"]["texture"],1)
	else
		ClearPedProp(Ped,0)
	end

	if Data["glass"]["item"] ~= -1 and Data["glass"]["item"] ~= 0 then
		SetPedPropIndex(Ped,1,Data["glass"]["item"],Data["glass"]["texture"],1)
	else
		ClearPedProp(Ped,1)
	end

	if Data["ear"]["item"] ~= -1 and Data["ear"]["item"] ~= 0 then
		SetPedPropIndex(Ped,2,Data["ear"]["item"],Data["ear"]["texture"],1)
	else
		ClearPedProp(Ped,2)
	end

	if Data["watch"]["item"] ~= -1 and Data["watch"]["item"] ~= 0 then
		SetPedPropIndex(Ped,6,Data["watch"]["item"],Data["watch"]["texture"],1)
	else
		ClearPedProp(Ped,6)
	end

	if Data["bracelet"]["item"] ~= -1 and Data["bracelet"]["item"] ~= 0 then
		SetPedPropIndex(Ped,7,Data["bracelet"]["item"],Data["bracelet"]["texture"],1)
	else
		ClearPedProp(Ped,7)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESKINSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("getDataOfCategory", function(tag, Callback)
    local Ped = PlayerPedId()
    local isMale = GetEntityModel(Ped) == GetHashKey("mp_m_freemode_01")
    local currentsOfTag = Dataset[tag]
    local maxsOfTag = MaxValues()[tag]
    Callback({
        current = currentsOfTag,
        max = maxsOfTag,
        isVip = false,
        isMale = isMale
    })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateDataOfCategory",function(Data,Callback)
	local _Dataset = Dataset
    
    _Dataset[Data["category"]]["item"] = Data["item"]
    _Dataset[Data["category"]]["texture"] = Data["texture"]
	exports["skinshop"]:Apply()

	Callback(MaxValues())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterNUICallback("buyDataOfCategory",function(Data,Callback)
--    local isMale = GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01")
--    local success = vSERVER.tryBuyCloth(Data["category"], Data["item"], isMale)
--    if success then
--        local newData = LocalPlayer["state"]["Skinshop"]
--        newData[Data["category"]]["item"] = Data["item"]
--        newData[Data["category"]]["texture"] = Data["texture"]
--        vSERVER.Update(newData)
--    end
--	Callback("Ok")
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateCamera",function(Data,Callback)
	Init = Data
    UpdateCameraBasedOnInit()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("getIsFirstLogin",function(Data,Callback)
	Callback(LocalPlayer["state"]["FirstLogin"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("save",function(Data,Callback)
	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end
    if not Command then
        vSERVER.Cancel()
    end
    Command = false
	vSERVER.Update(Dataset)
	vRP.DestroyObjects()
    if Newbie then
        vSERVER.Cancel()
        Newbie = false
    end
	SetNuiFocus(false,false)
    TriggerEvent("hud:Active", true)
    Callback("Ok")
    FreezeEntityPosition(PlayerPedId(),false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("hideFrame",function(Data,Callback)
    if LocalPlayer["state"]["FirstLogin"] then
        return
    end
	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	exports["skinshop"]:Apply(LocalPlayer["state"]["Skinshop"])
    if not Command then
        vSERVER.Cancel()
    end
    Command = false
	Dataset = LocalPlayer["state"]["Skinshop"]
	LocalPlayer["state"]["Skinshop"] = {}
	SetNuiFocus(false,false)
    FreezeEntityPosition(PlayerPedId(),false)
    SendNUIMessage({ action = "setVisible", data = false })
    TriggerEvent("hud:Active",true)
	vRP.DestroyObjects()
    if Newbie then
        if LocalPlayer["state"]["DefaultSpawn"] then
            TriggerEvent("talknpc:NpcVovo2")
		else
            TriggerEvent("talknpc:NpcVovo")
		end
        Newbie = false
    end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Rotate",function(Data,Callback)
	local Ped = PlayerPedId()

	if Data == "Left" then
		SetEntityHeading(Ped,GetEntityHeading(Ped) - 5)
	elseif Data == "Right" then
		SetEntityHeading(Ped,GetEntityHeading(Ped) + 5)
	elseif Data == "Top" then
		local Coords = GetCamCoord(Camera)
		SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"] + 0.05)
	elseif Data == "Bottom" then
		local Coords = GetCamCoord(Camera)
		SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"] - 0.05)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMASK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setMask")
AddEventHandler("skinshop:setMask",function()
	if not Animation and not LocalPlayer["state"]["Buttons"] then
		Animation = true
		vRP.playAnim(true,{"missfbi4","takeoff_mask"},true)

		Wait(1000)

		local Ped = PlayerPedId()
		if GetPedDrawableVariation(Ped,1) == Dataset["mask"]["item"] then
			SetPedComponentVariation(Ped,1,0,0,1)
		else
			SetPedComponentVariation(Ped,1,Dataset["mask"]["item"],Dataset["mask"]["texture"],1)
		end

		Animation = false
		vRP.DestroyObjects()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setHat")
AddEventHandler("skinshop:setHat",function()
	if not Animation and not LocalPlayer["state"]["Buttons"] then
		Animation = true
		vRP.playAnim(true,{"mp_masks@standard_car@ds@","put_on_mask"},true)

		Wait(1000)

		local Ped = PlayerPedId()
		if GetPedPropIndex(Ped,0) == Dataset["hat"]["item"] then
			ClearPedProp(Ped,0)
		else
			SetPedPropIndex(Ped,0,Dataset["hat"]["item"],Dataset["hat"]["texture"],1)
		end

		Animation = false
		vRP.DestroyObjects()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETGLASSES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setGlasses")
AddEventHandler("skinshop:setGlasses",function()
	if not Animation and not LocalPlayer["state"]["Buttons"] then
		Animation = true
		vRP.playAnim(true,{"clothingspecs","take_off"},true)

		Wait(1000)

		local Ped = PlayerPedId()
		if GetPedPropIndex(Ped,1) == Dataset["glass"]["item"] then
			ClearPedProp(Ped,1)
		else
			SetPedPropIndex(Ped,1,Dataset["glass"]["item"],Dataset["glass"]["texture"],1)
		end

		Animation = false
		vRP.DestroyObjects()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.checkShoes()
	local Number = 34
	local Ped = PlayerPedId()
	if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
		Number = 35
	end

	if Dataset["shoes"]["item"] ~= Number then
		Dataset["shoes"]["item"] = Number
		Dataset["shoes"]["texture"] = 0
		SetPedComponentVariation(Ped,6,Dataset["shoes"]["item"],Dataset["shoes"]["texture"],1)

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Customization()
	return Dataset
end

RegisterNetEvent("skinshop:Open:NPC")
AddEventHandler("skinshop:Open:NPC",function(coords)
    TriggerEvent("talknpc:closeTalk")
    OpenSkinshop(false,coords)
end)

RegisterNetEvent('register:Open')
AddEventHandler('register:Open',function()
    SendNUIMessage({ action = "setVisible", data = false })
    SetNuiFocus(false,false)
    FreezeEntityPosition(PlayerPedId(),false)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setmascara')
AddEventHandler('setmascara',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if modelo == nil then
			vRP.playAnim(true,{"missfbi4","takeoff_mask"},false)
			Wait(1100)
			vRP._stopAnim(true)
			SetPedComponentVariation(ped,1,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP.playAnim(true,{"misscommon@van_put_on_masks","put_on_mask_ps"},false)
			Wait(1500)
			vRP._stopAnim(true)
			SetPedComponentVariation(ped,1,parseInt(modelo),parseInt(cor),2)
		end
        local DataSet = LocalPlayer["state"]["Skinshop"]
        DataSet["mask"]["item"] = parseInt(modelo)
        DataSet["mask"]["texture"] = parseInt(cor)
        LocalPlayer["state"]["Skinshop"] = DataSet
        vSERVER.Update(DataSet)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBLUSA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setblusa')
AddEventHandler('setblusa',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101  then
		if not modelo then
			vRP.playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP.playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP.playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,parseInt(modelo),parseInt(cor),2)
		end
        local DataSet = LocalPlayer["state"]["Skinshop"]
        DataSet["shirt"]["item"] = parseInt(modelo)
        DataSet["shirt"]["texture"] = parseInt(cor)
        LocalPlayer["state"]["Skinshop"] = DataSet
        vSERVER.Update(DataSet)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCOLETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setcolete')
AddEventHandler('setcolete',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101  then
		if not modelo then
			vRP.playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,9,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP.playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,9,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP.playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,9,parseInt(modelo),parseInt(cor),2)
		end
        local DataSet = LocalPlayer["state"]["Skinshop"]
        DataSet["vest"]["item"] = parseInt(modelo)
        DataSet["vest"]["texture"] = parseInt(cor)
        LocalPlayer["state"]["Skinshop"] = DataSet
        vSERVER.Update(DataSet)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETJAQUETA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setjaqueta')
AddEventHandler('setjaqueta',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101  then
		if not modelo then
			vRP.playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,11,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP.playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,11,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP.playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,11,parseInt(modelo),parseInt(cor),2)
		end
        local DataSet = LocalPlayer["state"]["Skinshop"]
        DataSet["torso"]["item"] = parseInt(modelo)
        DataSet["torso"]["texture"] = parseInt(cor)
        LocalPlayer["state"]["Skinshop"] = DataSet
        vSERVER.Update(DataSet)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMAOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setmaos')
AddEventHandler('setmaos',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if not modelo then
			vRP.playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP.playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP.playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,parseInt(modelo),parseInt(cor),2)
        end
        local DataSet = LocalPlayer["state"]["Skinshop"]
        DataSet["arms"]["item"] = parseInt(modelo)
        DataSet["arms"]["texture"] = parseInt(cor)
        LocalPlayer["state"]["Skinshop"] = DataSet
        vSERVER.Update(DataSet)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCALCA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setcalca')
AddEventHandler('setcalca',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101  then
		if not modelo then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				vRP.playAnim(true,{"clothingtrousers","try_trousers_neutral_c"},false)
				Wait(2500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,4,18,0,2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				vRP.playAnim(true,{"clothingtrousers","try_trousers_neutral_c"},false)
				Wait(2500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,4,15,0,2)
			end
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP.playAnim(true,{"clothingtrousers","try_trousers_neutral_c"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,4,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP.playAnim(true,{"clothingtrousers","try_trousers_neutral_c"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,4,parseInt(modelo),parseInt(cor),2)
		end
        local DataSet = LocalPlayer["state"]["Skinshop"]
        DataSet["pants"]["item"] = parseInt(modelo)
        DataSet["pants"]["texture"] = parseInt(cor)
        LocalPlayer["state"]["Skinshop"] = DataSet
        vSERVER.Update(DataSet)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETACESSORIOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setacessorios')
AddEventHandler('setacessorios',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if not modelo then
			SetPedComponentVariation(ped,7,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,7,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,7,parseInt(modelo),parseInt(cor),2)
		end
        local DataSet = LocalPlayer["state"]["Skinshop"]
        DataSet["accessory"]["item"] = parseInt(modelo)
        DataSet["accessory"]["texture"] = parseInt(cor)
        LocalPlayer["state"]["Skinshop"] = DataSet
        vSERVER.Update(DataSet)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSAPATOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setsapatos')
AddEventHandler('setsapatos',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped) then
		if not modelo then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				vRP.playAnim(false,{"clothingshoes","try_shoes_positive_d"},false)
				Wait(2200)
				SetPedComponentVariation(ped,6,34,0,2)
				Wait(500)
				ClearPedTasks(ped)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				vRP.playAnim(false,{"clothingshoes","try_shoes_positive_d"},false)
				Wait(2200)
				SetPedComponentVariation(ped,6,35,0,2)
				Wait(500)
				ClearPedTasks(ped)
			end
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP.playAnim(false,{"clothingshoes","try_shoes_positive_d"},false)
			Wait(2200)
			SetPedComponentVariation(ped,6,parseInt(modelo),parseInt(cor),2)
			Wait(500)
			ClearPedTasks(ped)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP.playAnim(false,{"clothingshoes","try_shoes_positive_d"},false)
			Wait(2200)
			SetPedComponentVariation(ped,6,parseInt(modelo),parseInt(cor),2)
			Wait(500)
			ClearPedTasks(ped)
		end
        local DataSet = LocalPlayer["state"]["Skinshop"]
        DataSet["shoes"]["item"] = parseInt(modelo)
        DataSet["shoes"]["texture"] = parseInt(cor)
        LocalPlayer["state"]["Skinshop"] = DataSet
        vSERVER.Update(DataSet)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setchapeu')
AddEventHandler('setchapeu',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if not modelo then
			vRP.playAnim(true,{"veh@common@fp_helmet@","take_off_helmet_stand"},false)
			Wait(700)
			ClearPedProp(ped,0)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") and parseInt(modelo) ~= 39 then
			vRP.playAnim(true,{"veh@common@fp_helmet@","put_on_helmet"},false)
			Wait(1700)
			SetPedPropIndex(ped,0,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") and parseInt(modelo) ~= 38 then
			vRP.playAnim(true,{"veh@common@fp_helmet@","put_on_helmet"},false)
			Wait(1700)
			SetPedPropIndex(ped,0,parseInt(modelo),parseInt(cor),2)
		end
        local DataSet = LocalPlayer["state"]["Skinshop"]
        DataSet["hat"]["item"] = parseInt(modelo)
        DataSet["hat"]["texture"] = parseInt(cor)
        LocalPlayer["state"]["Skinshop"] = DataSet
        vSERVER.Update(DataSet)
	end 
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETOCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setoculos')
AddEventHandler('setoculos',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if not modelo then
			vRP.playAnim(true,{"mini@ears_defenders","takeoff_earsdefenders_idle"},false)
			Wait(500)
			ClearPedTasks(ped)
			ClearPedProp(ped,1)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP.playAnim(true,{"misscommon@van_put_on_masks","put_on_mask_ps"},false)
			Wait(800)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,1,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP.playAnim(true,{"misscommon@van_put_on_masks","put_on_mask_ps"},false)
			Wait(800)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,1,parseInt(modelo),parseInt(cor),2)
		end
        local DataSet = LocalPlayer["state"]["Skinshop"]
        DataSet["glass"]["item"] = parseInt(modelo)
        DataSet["glass"]["texture"] = parseInt(cor)
        LocalPlayer["state"]["Skinshop"] = DataSet
        vSERVER.Update(DataSet)
	end
end)