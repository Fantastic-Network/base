-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Damaged = {}
local Bleeding = 0
local BloodTick = 0
local Injuried = GetGameTimer()
local BloodTimers = GetGameTimer()
local DrugsTreatment = false
local TreatmentTimer = GetGameTimer()
local DefaultHealth = 400
local ArmourTimer = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(name,Message)
	if LocalPlayer["state"]["Route"] < 900000 then
		if name == "CEventNetworkEntityDamage" then
			if PlayerPedId() == Message[1] and LocalPlayer["state"]["Active"] then
				if (Message[7] == 126349499 or Message[7] == 1064738331 or Message[7] == 85055149) and GetEntityHealth(Message[1]) > 100 then
    				SetPedCanRagdoll(PlayerPedId(), true)
					SetPedToRagdoll(Message[1],2500,2500,0,0,0,0)
				else
					if GetGameTimer() >= Injuried then
						if not IsPedInAnyVehicle(Message[1]) and GetEntityHealth(Message[1]) > 100 then
							Injuried = GetGameTimer() + 1000

							local Hit,Mark = GetPedLastDamageBone(Message[1])
							if Hit and not Damaged[Mark] and Mark ~= 0 then
								-- TriggerServerEvent("evidence:dropEvidence","yellow")
								Bleeding = Bleeding + 1
								Damaged[Mark] = true
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOODTICK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if GetGameTimer() >= BloodTimers and LocalPlayer["state"]["Route"] < 900000 and GetEntityHealth(Ped) > 100 then
			BloodTimers = GetGameTimer() + 10000
			BloodTick = BloodTick + 1

			if BloodTick >= 3 and Bleeding >= 3 then
				BloodTick = 0
				-- local Nocaute = Bleeding * 1000

				-- if not IsPedInAnyVehicle(Ped) then
				-- 	SetPedToRagdoll(Ped,Nocaute,Nocaute,0,0,0,0)
				-- 	TriggerEvent("inventory:Cancel")
				-- end

				-- DoScreenFadeOut(1000)
				-- Wait(Nocaute)
				-- DoScreenFadeIn(1000)
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:RESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:Reset")
AddEventHandler("paramedic:Reset",function()
	Damaged = {}
	Bleeding = 0
	BloodTick = 0
	Injuried = GetGameTimer()
	BloodTimers = GetGameTimer()
	ClearPedBloodDamage(PlayerPedId())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Bleeding()
	return Bleeding
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Bandage()
	local Humanes = ""
	for Number,_ in pairs(Damaged) do
		TriggerEvent("Notify","amarelo","Passou ataduras no(a) <b>"..Bone(Number).."</b>.",3000)
		-- TriggerEvent("Notify2","#usaBandage",{msg=Bone(Number)})
		TriggerEvent("sounds:Private","bandage",0.5)
		Bleeding = Bleeding - 1
		Humanes = Bone(Number)
		Damaged[Number] = nil
		BloodTick = 0
		break
	end

	if Bleeding <= 0 then
		ClearPedBloodDamage(PlayerPedId())
	end

	return Humanes
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:INJURIES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:Injuries")
AddEventHandler("paramedic:Injuries",function()
	local Wounds = 0
	local Injuries = ""
	local Damages = false

	for Number,_ in pairs(Damaged) do
		if not Damages then
			Injuries = Injuries.."<b>Danos Superficiais:</b><br>"
			Damages = true
		end

		Wounds = Wounds + 1
		Injuries = Injuries.."<b>"..Wounds.."</b>: "..Bone(Number).."<br>"
	end

	if Injuries == "" then
		TriggerEvent("Notify","amarelo","Nenhum ferimento encontrado.",5000)
		-- TriggerEvent("Notify2","#semFerimento")
	else
		TriggerEvent("Notify","amarelo",Injuries,10000)
		-- TriggerEvent("Notify2","#injuries",{msg=Injuries})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Diagnostic()
	return Damaged,Bleeding
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARMS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Arms",function()
	if Damaged[18905] or Damaged[18905] or Damaged[60309] or Damaged[36029] or Damaged[57005] or Damaged[28422] or Damaged[6286] then
		return true
	end

	return false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEGS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Legs",function()
	if Damaged[14201] or Damaged[65245] or Damaged[57717] or Damaged[52301] or Damaged[35502] or Damaged[24806] then
		return true
	end

	return false
end)


RegisterNetEvent("damage:Apply")
AddEventHandler("damage:Apply",function()
    local Ped = PlayerPedId()
    SetEntityHealth(Ped,100)
    SetPedArmour(Ped,0)
end)

RegisterNetEvent("paramedic:Drugs")
AddEventHandler("paramedic:Drugs",function()
    TriggerEvent("Notify","drogas","Acho que essa droga não estava pura...",5000,"DROGAS")
	-- TriggerEvent("Notify2","#drogaNPura")
    local Ped = PlayerPedId()
    Damaged = {}
	Bleeding = 0
	BloodTick = 0
	Injuried = GetGameTimer()
	BloodTimers = GetGameTimer()
    DefaultHealth = GetEntityHealth(Ped)
    ClearPedBloodDamage(PlayerPedId())
    Wait(100)
    DrugsTreatment = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DrugsTreatment
-----------------------------------------------------------------------------------------------------------------------------------------
function DrugsTimer()
    local Ped = PlayerPedId()
    local Pid = PlayerId()
    local Random = math.random(1,5)
    Wait(60000*Random)
    ArmourTimer = false
end

CreateThread(function()
	while true do
		if DrugsTreatment then
            local Ped = PlayerPedId()
            local Health = GetEntityHealth(Ped)
            local Armour = GetPedArmour(Ped)
            local DoneHealth = false
            if Health == 400 then
                DoneHealth = true
            end

            if GetEntityHealth(Ped) <= 100 then
                break
            end

            if Armour == 200 or Bleeding > 0 then
                ArmourTimer = 60*2
                DrugsTimer()
                DrugsTreatment = false
            end

            if Health < 400 and not DoneHealth then
                while Health < 400 do
                    local Amount = 5
                    SetEntityHealth(Ped,Health + Amount)
                    Health = Health + Amount
                    TriggerEvent("hud:updateLife")
                    if Bleeding > 0 then
                        break
                    end
                    Wait(250)
                end
            end

            if DoneHealth then
                while Armour < 200 do
                    local Amount = 5
                    SetPedArmour(Ped,Armour + Amount)
                    Armour = Armour + Amount
                    TriggerEvent("hud:updateLife")
                    Wait(250)
                    if Bleeding > 0 then
                        break
                    end
                end
            end
		end
        Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOPE
-----------------------------------------------------------------------------------------------------------------------------------------
-- local Hope = GetGameTimer()
-- local Warning = GetGameTimer()
-- CreateThread(function()
-- 	while true do
-- 		local TimeDistance = 999
-- 		local Ped = PlayerPedId()
-- 		if not IsPedInAnyVehicle(Ped) then
-- 			if exports["player"]:Legs() then
-- 				TimeDistance = 1
-- 				DisableControlAction(1,22,true)

-- 				if IsDisabledControlJustPressed(1,22) and GetGameTimer() >= Warning then
-- 					TriggerEvent("Notify","amarelo","Perna machucada.",3000)
-- 					Warning = GetGameTimer() + 5000
-- 				end
-- 			elseif GetGameTimer() <= Hope then
-- 				TimeDistance = 1
-- 				DisableControlAction(1,22,true)
-- 			else
-- 				if IsPedJumping(Ped) then
-- 					Hope = GetGameTimer() + 5000
-- 				end
-- 			end
-- 		end

-- 		Wait(TimeDistance)
-- 	end
-- end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)