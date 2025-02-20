-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Previous = nil
local Treatment = false
local TreatmentTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Beds = {
	-- Hospital Saint
    { ["Coords"] = vec3(1124.74,-1554.48,34.96), ["Heading"] = 0.0 },
    { ["Coords"] = vec3(1121.26,-1554.65,34.96), ["Heading"] = 0.0 },
    { ["Coords"] = vec3(1117.69,-1554.75,34.96), ["Heading"] = 0.0 },
    { ["Coords"] = vec3(1117.84,-1563.13,34.96), ["Heading"] = 170.08 },
    { ["Coords"] = vec3(1121.4,-1563.03,34.96), ["Heading"] = 187.09 },
	{ ["Coords"] = vec3(1124.82,-1563.06,34.96), ["Heading"] = 187.09 },

	-- Medical Center Norte
	{ ["Coords"] = vec3(-252.15,6323.11,32.35), ["Heading"] = 133.23 },
	{ ["Coords"] = vec3(-250.5,6321.87,32.35), ["Heading"] = 133.23 },
	{ ["Coords"] = vec3(-246.98,6317.95,32.33), ["Heading"] = 133.23 },
	{ ["Coords"] = vec3(-245.27,6316.22,32.35), ["Heading"] = 133.23 },
	{ ["Coords"] = vec3(-251.03,6310.51,32.35), ["Heading"] = 317.49 },
	{ ["Coords"] = vec3(-252.63,6312.12,32.35), ["Heading"] = 317.49 },
	{ ["Coords"] = vec3(-254.39,6313.88,32.35), ["Heading"] = 317.49 },
	{ ["Coords"] = vec3(-256.1,6315.58,32.35), ["Heading"] = 317.49 },
	{ ["Coords"] = vec3(-258.03,6317.12,32.35), ["Heading"] = 317.49 },
	-- Boolingbroke
	{ ["Coords"] = vec3(1761.87,2591.56,45.66), ["Heading"] = 272.13 },
	{ ["Coords"] = vec3(1761.87,2594.64,45.66), ["Heading"] = 272.13 },
	{ ["Coords"] = vec3(1761.87,2597.73,45.66), ["Heading"] = 272.13 },
	{ ["Coords"] = vec3(1771.98,2597.95,45.66), ["Heading"] = 87.88 },
	{ ["Coords"] = vec3(1771.98,2594.88,45.66), ["Heading"] = 87.88 },
	{ ["Coords"] = vec3(1771.98,2591.79,45.66), ["Heading"] = 87.88 },	
	-- Clandestine
	{ ["Coords"] = vec3(-471.87,6287.56,13.63), ["Heading"] = 53.86 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number,v in pairs(Beds) do
		AddBoxZone("Beds:"..Number,v["Coords"],1.0,1.0,{
			name = "Beds:"..Number,
			heading = v["Heading"],
			minZ = v["Coords"]["z"] - 0.01,
			maxZ = v["Coords"]["z"] + 0.55
		},{
			shop = Number,
			Distance = 1.75,
			options = {
				{
					event = "target:PutBed",
					label = "Deitar",
					tunnel = "client"
				},{
					event = "target:Treatment",
					label = "Tratamento",
					tunnel = "client"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:PUTBED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:PutBed")
AddEventHandler("target:PutBed",function(Number)
	if not Previous then
		local Ped = PlayerPedId()
		Previous = GetEntityCoords(Ped)
		SetEntityCoords(Ped,Beds[Number]["Coords"]["x"],Beds[Number]["Coords"]["y"],Beds[Number]["Coords"]["z"],false,false,false,false)
		vRP.playAnim(false,{"amb@world_human_sunbathe@female@back@idle_a","idle_a"},true)
		SetEntityHeading(Ped,Beds[Number]["Heading"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:UPBED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:UpBed")
AddEventHandler("target:UpBed",function()
	if Previous then
		local Ped = PlayerPedId()
		SetEntityCoords(Ped,Previous["x"],Previous["y"],Previous["z"],false,false,false,false)
		Previous = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:TREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Treatment")
AddEventHandler("target:Treatment",function(Number)
	if not Previous then
		if vSERVER.CheckIn() then
			local Ped = PlayerPedId()
			Previous = GetEntityCoords(Ped)
			SetEntityCoords(Ped,Beds[Number]["Coords"]["x"],Beds[Number]["Coords"]["y"],Beds[Number]["Coords"]["z"],false,false,false,false)
			vRP.playAnim(false,{"amb@world_human_sunbathe@female@back@idle_a","idle_a"},true)
			SetEntityHeading(Ped,Beds[Number]["Heading"])

			TriggerEvent("inventory:preventWeapon",true)
			LocalPlayer["state"]["Commands"] = true
			LocalPlayer["state"]["Cancel"] = true
			TriggerEvent("paramedic:Reset")

			if GetEntityHealth(Ped) <= 100 then
				exports["survival"]:Revive(101)
			end

			Treatment = true
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:StartTreatment")
AddEventHandler("target:StartTreatment",function()
	if not Treatment then
		LocalPlayer["state"]["Commands"] = true
		LocalPlayer["state"]["Cancel"] = true
		Treatment = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBEDS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if Previous and not IsEntityPlayingAnim(Ped,"amb@world_human_sunbathe@female@back@idle_a","idle_a",3) then
			SetEntityCoords(Ped,Previous["x"],Previous["y"],Previous["z"] - 1,false,false,false,false)
			Previous = nil
		end

		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Treatment then
			if GetGameTimer() >= TreatmentTimer then
				local Ped = PlayerPedId()
				local Health = GetEntityHealth(Ped)
				TreatmentTimer = GetGameTimer() + 1000

				if Health < 400 then
					SetEntityHealth(Ped,Health + 4)
				else
					Treatment = false
					LocalPlayer["state"]["Cancel"] = false
					LocalPlayer["state"]["Commands"] = false
					TriggerEvent("Notify","amarelo","Tratamento concluido.",5000)
					-- TriggerEvent("Notify2","#completedTreatment")
				end
			end
		end

		Wait(1000)
	end
end)