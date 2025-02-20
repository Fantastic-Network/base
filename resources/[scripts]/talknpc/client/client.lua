local pedList = {}
local cam = nil

-- CREATE NPCs
CreateThread(function()
	local pedInfo = {}
	local camCoords = nil
	local camRotation = nil
    for i=1,#TalkToNPC do
		RequestModel(GetHashKey(TalkToNPC[i].npc))
		while not HasModelLoaded(GetHashKey(TalkToNPC[i].npc)) do
			Wait(1)
		end

		RequestAnimDict("mini@strip_club@idles@bouncer@base")
		while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
			Wait(1)
		end

		ped =  CreatePed(4, TalkToNPC[i].npc, TalkToNPC[i].coordinates[1], TalkToNPC[i].coordinates[2], TalkToNPC[i].coordinates[3]-1, TalkToNPC[i].heading, false, true)
        if TalkToNPC[i].customNpc then
            ApplyFacials(ped,json.decode(TalkToNPC[i]["customNpc"]["character"]))
            ApplyClothes(ped,json.decode(TalkToNPC[i]["customNpc"]["clothing"]))
        end
		SetEntityHeading(ped, TalkToNPC[i].heading)
		FreezeEntityPosition(ped, true)
		LocalPlayer["state"]["Invincible"] = true
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)

		if AutoCamPosition then
			local px, py, pz = table.unpack(GetEntityCoords(ped, true))
			local x, y, z = px + GetEntityForwardX(ped) * 1.2, py + GetEntityForwardY(ped) * 1.2, pz + 0.52

			camCoords = vector3(x, y, z)
		end

		if AutoCamRotation then
			local rx = GetEntityRotation(ped, 2)

			camRotation = rx + vector3(0.0, 0.0, 181)
		end

		pedInfo = {
			name = TalkToNPC[i].name,
			model = TalkToNPC[i].npc,
			pedCoords = TalkToNPC[i].coordinates,
			entity = ped,
			camCoords = camCoords,
			camRotation = camRotation,
		}
        SetModelAsNoLongerNeeded(GetHashKey(TalkToNPC[i].npc))
		table.insert(pedList, pedInfo)
	end
end)

CreateThread(function()
    for i=1,#TalkToNPC do
        exports["interactions"]:removeInteraction("talkNpcs"..i)
        exports["interactions"]:registerInteraction("talkNpcs"..i, "E", "Pressione para", "Interagir com o funcionario", TalkToNPC[i].coordinates, TalkToNPC[i].interactionRange+1.0, function()
            if not exports["hud"]:Wanted() then
                LocalPlayer["state"]["Invisible"] = true
                SetEntityVisible(PlayerPedId(),false,false)
                TriggerEvent("hud:Actived", false)
                StartCam(TalkToNPC[i].coordinates, TalkToNPC[i].camOffset, TalkToNPC[i].camRotation, TalkToNPC[i].npc, TalkToNPC[i].name, TalkToNPC[i])
                if TalkToNPC[i].initAudio then
                    TriggerEvent("sounds:Private",TalkToNPC[i]["initAudio"]["audio"],TalkToNPC[i]["initAudio"]["volume"])
                end
                Wait(500)
                SendNUIMessage({
                    action = 'setVisible',
                    data = {
                        path = "/"
                    }
                })
                Wait(100)
                SendNUIMessage({
                    action = 'openDialog',
                    data = {
                        header = TalkToNPC[i].header,
                        name = TalkToNPC[i].name,
                        dialog = TalkToNPC[i].dialog,
                        options = TalkToNPC[i].options,
                        video = TalkToNPC[i].video,
                        duration = TalkToNPC[i].duration,
                        play = TalkToNPC[i].play,
                    }
                })
                SetNuiFocus(true, true)
            else
                TriggerEvent("sounds:Private","procurado",1.0)
            end
        end)
    end
end)

-- ACTIONS
RegisterNetEvent('register:Open')
AddEventHandler('register:Open',function()
    SendNUIMessage({
        action = 'closeDialog',
    })
    SetNuiFocus(false, false)
    EndCam()
    SetEntityVisible(PlayerPedId(),true,false)
	LocalPlayer["state"]["Invisible"] = false
    TriggerEvent("sounds:Private","voltesempre",0.5)
end)

RegisterNetEvent('talknpc:closeTalk')
AddEventHandler('talknpc:closeTalk',function()
    SendNUIMessage({
        action = 'closeDialog',
    })
    SetNuiFocus(false, false)
    EndCam()
    SetEntityVisible(PlayerPedId(),true,false)
	LocalPlayer["state"]["Invisible"] = false
    TriggerEvent("sounds:Private","voltesempre",0.5)
end)
RegisterNetEvent('talknpc:closeTalkWSound')
AddEventHandler('talknpc:closeTalkWSound',function()
    SendNUIMessage({
        action = 'closeDialog',
    })
    SetNuiFocus(false, false)
    EndCam()
    SetEntityVisible(PlayerPedId(),true,false)
	LocalPlayer["state"]["Invisible"] = false
end)

RegisterNUICallback('action', function(data, cb)
	if data.action == 'close' then
		SetNuiFocus(false, false)
		EndCam()
		SetEntityVisible(PlayerPedId(),true,false)
		LocalPlayer["state"]["Invisible"] = false
		TriggerEvent("sounds:Private","voltesempre",0.5)
	elseif data.action == 'option' then
		--SetNuiFocus(false, false)
		if data.options[2] then
			TriggerEvent(data.options[2], data.options[3] or false,data.options[4])
		end
		EndCam()
		SetEntityVisible(PlayerPedId(),true,false)
		LocalPlayer["state"]["Invisible"] = false
		if data.options[3] == "SERVER" then
            TriggerServerEvent(data.options[2])
        end
		-- if data.options[3] == 'c' then 
		-- 	TriggerEvent(data.options[2])
		-- elseif data.options[3] ~= nil then
		-- 	TriggerServerEvent(data.options[2])
		-- end

	end
	TriggerEvent("hudActived", true)

	cb("Ok")
end)

-- CAMERA

function StartCam(coords, offset, rotation, model, name, key)
	ClearFocus()
    local ped
	if AutoCamRotation then
		for k,v in pairs(pedList) do
			if v.pedCoords == coords then
				if v.name == name and v.model == model then
					rotation = v.camRotation
                    ped = v.entity
				end
			end
		end
	end

	if AutoCamPosition then
		for k,v in pairs(pedList) do
			if v.pedCoords == coords then
				if v.name == name and v.model == model then
					coords = v.camCoords
				end
			end
		end
	else
		coords = coords + offset
	end

	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords, rotation, GetGameplayCamFov())

	SetCamActive(cam, true)
	RenderScriptCams(true, true, CameraAnimationTime, true, false)
    if key["anim"] then
        PlayFacialAnim(ped, 'mic_chatter', 'mp_facial')
        SetTimeout(key["anim"]["duration"],function()
            PlayFacialAnim(ped, 'mood_normal_1', 'facials@gen_male@variations@normal')
        end)
    end
end

function EndCam()
	ClearFocus()

	RenderScriptCams(false, true, CameraAnimationTime, true, false)
	DestroyCam(cam, false)

	cam = nil
end

RegisterNetEvent("talknpc:hospital")
AddEventHandler("talknpc:hospital",	function()
	TriggerEvent("sounds:Private","hospital",0.5)
end)

RegisterNetEvent("talknpc:close")
AddEventHandler("talknpc:close",function()
    SendNUIMessage({
        action = 'closeDialog',
    })
end)

RegisterNetEvent("talknpc:hospital2")
AddEventHandler("talknpc:hospital2",	function()
	TriggerEvent("sounds:Private","hospital2",0.5)
end)

RegisterNetEvent("talknpc:juridico")
AddEventHandler("talknpc:juridico",	function()
	TriggerEvent("sounds:Private","juridico",0.5)
end)

RegisterNetEvent("talknpc:juridico2")
AddEventHandler("talknpc:juridico2",	function()
	TriggerEvent("sounds:Private","juridico2",0.5)
end)

RegisterNetEvent("talknpc:juridico3")
AddEventHandler("talknpc:juridico3",	function()
	TriggerEvent("sounds:Private","juridico3",0.5)
end)

RegisterNetEvent("talknpc:closeNuiF")
AddEventHandler("talknpc:closeNuiF",	function()
	TriggerEvent("sounds:Private","feminina",0.5)
end)

AddEventHandler('talknpc:playAudio',function(Name)
    TriggerEvent("sounds:Private",Name,0.5)
end)

RegisterNetEvent('talknpc:NpcVovo')
AddEventHandler('talknpc:NpcVovo',function()
	local ConfigVovo = {
		npc = 'mp_m_freemode_01',
		customNpc = {
			["character"] = '[0,8,0.5,0,3,0,-1,4,-1,73,0,0,0,0,0,0,0,0,30,0.99,0,1,0.88,0,-1,0,0,-1,0.84,0.72,0.46,0,0,0.3,-0.3,0,-0.58,-0.72,-0.52,0.21,0.37,0.79,0.6,0.71,0.43,-0.7,0,0,0,0]',
			["clothing"] = '{"bracelet":{"item":-1,"texture":0},"watch":{"item":-1,"texture":0},"decals":{"item":0,"texture":0},"arms":{"item":4,"texture":0},"vest":{"item":0,"texture":0},"accessory":{"item":0,"texture":0},"pants":{"item":197,"texture":5},"tshirt":{"item":32,"texture":0},"mask":{"item":87,"texture":0},"shoes":{"item":57,"texture":11},"glass":{"item":0,"texture":0},"ear":{"item":-1,"texture":0},"torso":{"item":32,"texture":0},"backpack":{"item":0,"texture":0},"hat":{"item":-1,"texture":0}}', 
		},
		header = '',
		name = 'Vovô',
		uiText = "",
		dialog = '',
		coordinates = vector3(-2290.98,369.17,174.6),
		heading = 170.08,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
        initAudio = { audio = 'vovo', volume = 0.5 },
        anim = {
            duration = 12000
        },
		options = {
			{'Aceitar missão!'},	-- NUI para compra real
		},
		video = {
		    {'http://www.youtube.com/embed/clYHvnL_Acc?autoplay=1'},
		    {''},
		    {''},
		    {''},
		},
		duration = {
        	{'32000'},
        	{''},
        	{''},
        	{''},
    },
		play = 'true',
	}

	LocalPlayer["state"]["Invisible"] = true
	SetEntityVisible(PlayerPedId(),false,false)
	TriggerEvent("hud:Actived", false)
	StartCam(ConfigVovo.coordinates, ConfigVovo.camOffset, ConfigVovo.camRotation, ConfigVovo.npc, ConfigVovo.name, ConfigVovo)
	if ConfigVovo.initAudio then
		TriggerEvent("sounds:Private",ConfigVovo["initAudio"]["audio"],ConfigVovo["initAudio"]["volume"])
	end
	Wait(500)
	SendNUIMessage({
        action = 'setVisible',
        data = {
            path = "/"
        }
    })
    Wait(100)

	SendNUIMessage({
		action = 'openDialog',
		data = {
			header = ConfigVovo.header,
			name = ConfigVovo.name,
			dialog = ConfigVovo.dialog,
			options = ConfigVovo.options,
			video = ConfigVovo.video,
			duration = ConfigVovo.duration,
			play = ConfigVovo.play,
		}
	})
	SetNuiFocus(true, true)
    FreezeEntityPosition(PlayerPedId(),false)
end)

RegisterNetEvent('talknpc:NpcVovo2')
AddEventHandler('talknpc:NpcVovo2',function()
	local ConfigVovo = {
		npc = 'mp_m_freemode_01',
		customNpc = {
			["character"] = '[0,8,0.5,0,3,0,-1,4,-1,73,0,0,0,0,0,0,0,0,30,0.99,0,1,0.88,0,-1,0,0,-1,0.84,0.72,0.46,0,0,0.3,-0.3,0,-0.58,-0.72,-0.52,0.21,0.37,0.79,0.6,0.71,0.43,-0.7,0,0,0,0]',
			["clothing"] = '{"bracelet":{"item":-1,"texture":0},"watch":{"item":-1,"texture":0},"decals":{"item":0,"texture":0},"arms":{"item":4,"texture":0},"vest":{"item":0,"texture":0},"accessory":{"item":0,"texture":0},"pants":{"item":197,"texture":5},"tshirt":{"item":32,"texture":0},"mask":{"item":87,"texture":0},"shoes":{"item":57,"texture":11},"glass":{"item":0,"texture":0},"ear":{"item":-1,"texture":0},"torso":{"item":32,"texture":0},"backpack":{"item":0,"texture":0},"hat":{"item":-1,"texture":0}}', 
		},
		header = '',
		name = 'Vovô',
		uiText = "",
		dialog = '',
		coordinates = vector3(-2290.98,369.17,174.6),
		heading = 170.08,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
        initAudio = { audio = 'vovo', volume = 0.5 },
        anim = {
            duration = 12000
        },
		options = {
			{'Aceitar missão!'},	-- NUI para compra real
		},
		video = {
		    {'http://www.youtube.com/embed/clYHvnL_Acc?autoplay=1'},
		    {''},
		    {''},
		    {''},
		},
		duration = {
        	{'32000'},
        	{''},
        	{''},
        	{''},
    },
		play = 'true',
	}

	LocalPlayer["state"]["Invisible"] = true
	SetEntityVisible(PlayerPedId(),false,false)
	TriggerEvent("hud:Actived", false)
	StartCam(ConfigVovo.coordinates, ConfigVovo.camOffset, ConfigVovo.camRotation, ConfigVovo.npc, ConfigVovo.name, ConfigVovo)
	if ConfigVovo.initAudio then
		TriggerEvent("sounds:Private",ConfigVovo["initAudio"]["audio"],ConfigVovo["initAudio"]["volume"])
	end

	Wait(500)
	
	SendNUIMessage({
        action = 'setVisible',
        data = {
            path = "/"
        }
    })
    Wait(100)
	SendNUIMessage({
		action = 'openDialog',
		data = {
			header = ConfigVovo.header,
			name = ConfigVovo.name,
			dialog = ConfigVovo.dialog,
			options = ConfigVovo.options,
			video = ConfigVovo.video,
			duration = ConfigVovo.duration,
			play = ConfigVovo.play,
		}
	})
	SetNuiFocus(true, true)
    SetNewWaypoint(-1647.74 + 0.0001,-1102.27 + 0.0001)
    FreezeEntityPosition(PlayerPedId(),false)
end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "")
    Callback(string.lower(cityName))
end)