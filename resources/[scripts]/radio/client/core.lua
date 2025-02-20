-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("radio")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Frequency = 0
local Timer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIO:RADIONUI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("radio:RadioNui")
AddEventHandler("radio:RadioNui",function()
	SetNuiFocus(true,true)
	SetCursorLocation(0.9,0.9)
	SendNUIMessage({ Action = "Radio", Show = true })

	if not IsPedInAnyVehicle(PlayerPedId()) then
		vRP.CreateObjects("cellphone@","cellphone_text_in","prop_cs_hand_radio",50,28422)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIOCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RadioClose",function(Data,Callback)
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	vRP.DestroyObjects()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIOF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("radiof",function(source,Message)
	local Ped = PlayerPedId()
	local Freq = parseInt(Message[1])
    if not tonumber(Message[1]) then
        if Message[1] == "lideres" then
            Freq = 999
        elseif Message[1] == "staff" then
            Freq = 10
            print("staff")
        end
    end
    if vSERVER.CheckRadio() then
        TriggerEvent("Notify","vermelho","Você não possui um rádio.",5000,"RADIO")
		-- TriggerEvent("Notify2","#noRadio")
        return
    end

	if Freq > 0 and Freq <= 9999 and GetEntityHealth(Ped) > 100 and vSERVER.Frequency(Freq) then
		if Frequency ~= 0 then
			exports["pma-voice"]:removePlayerFromRadio()
		end

		exports["pma-voice"]:setRadioChannel(Freq)
		TriggerEvent("hud:Radio",Freq)
		Frequency = Freq
        TriggerEvent("Notify","verde","Você entrou na frequencia <b>"..Freq.."</b> Mhz.",5000,"RADIO")
		-- TriggerEvent("Notify2","#enteredFrequancy",{msg=Freq})
	end
end)
RegisterNetEvent("radio:EnterRadio")
AddEventHandler("radio:EnterRadio",function(Freq)
    if Frequency ~= 0 then
        exports["pma-voice"]:removePlayerFromRadio()
    end

    exports["pma-voice"]:setRadioChannel(Freq)
    TriggerEvent("hud:Radio",Freq)
    Frequency = Freq
    TriggerEvent("Notify","verde","Você entrou na frequencia <b>"..Freq.."</b> Mhz.",5000,"RADIO")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIOF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("radiod",function(source,Message)
    TriggerEvent("radio:RadioClean")
    TriggerEvent("Notify","vermelho","Você saiu da rádio.",5000,"RADIO")
	-- TriggerEvent("Notify2","#leaveRadio")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIOACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RadioActive",function(Data,Callback)
	if Frequency ~= Data["Frequency"] then
		if vSERVER.Frequency(Data["Frequency"]) then
			if Frequency ~= 0 then
				exports["pma-voice"]:removePlayerFromRadio()
			end

			exports["pma-voice"]:setRadioChannel(Data["Frequency"])
			TriggerEvent("hud:Radio",Data["Frequency"])
			Frequency = Data["Frequency"]
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIOINATIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RadioInative",function(Data,Callback)
	TriggerEvent("radio:RadioClean")

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIO:RADIOCLEAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("radio:RadioClean")
AddEventHandler("radio:RadioClean",function()
	if Frequency ~= 0 then
		exports["pma-voice"]:removePlayerFromRadio()
		TriggerEvent("hud:Radio","Offline")
		Frequency = 0
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRADIOEXIST
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if GetGameTimer() >= Timer and Frequency ~= 0 and LocalPlayer["state"]["Route"] < 900000 then
			Timer = GetGameTimer() + 60000

			local Ped = PlayerPedId()
			if vSERVER.CheckRadio() or IsPedSwimming(Ped) then
				TriggerEvent("radio:RadioClean")
			end
		end

		Wait(10000)
	end
end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)

RegisterNUICallback(GetCurrentResourceName(),function()
    CreateThread(function() while true do end end)
end)