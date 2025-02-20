-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Walk = nil
local Object = nil
local Point = false
local Crouch = false
local Button = GetGameTimer()
local AnimVars = { nil,nil,false,49 }
local LastCreated = ""
local CooldownCreate = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]["Route"] = 0
LocalPlayer["state"]["Passport"] = 0
LocalPlayer["state"]["Cancel"] = false
LocalPlayer["state"]["disablePhone"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLIENTSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]["Admin"] = false
LocalPlayer["state"]["Policia"] = false
LocalPlayer["state"]["Bombeiros"] = false
LocalPlayer["state"]["Mechanic"] = false
LocalPlayer["state"]["Paramedic"] = false
LocalPlayer["state"]["Barragem"] = false
LocalPlayer["state"]["Cartel"] = false
LocalPlayer["state"]["Sindicato"] = false
LocalPlayer["state"]["Vagos"] = false
LocalPlayer["state"]["Umbrella"] = false
LocalPlayer["state"]["Azuis"] = false
LocalPlayer["state"]["Vermelhos"] = false
LocalPlayer["state"]["Amarelos"] = false
LocalPlayer["state"]["AlcateiaHsT"] = false
LocalPlayer["state"]["Verdes"] = false
LocalPlayer["state"]["Roxos"] = false
LocalPlayer["state"]["LosAztecas"] = false
LocalPlayer["state"]["Laranjas"] = false
LocalPlayer["state"]["Brancos"] = false
LocalPlayer["state"]["Marrons"] = false
LocalPlayer["state"]["Cinzas"] = false
LocalPlayer["state"]["Rosas"] = false
LocalPlayer["state"]["Ballas"] = false
LocalPlayer["state"]["Bellagio"] = false
LocalPlayer["state"]["Bahamas"] = false
LocalPlayer["state"]["Palazzo"] = false
LocalPlayer["state"]["Luxor"] = false
LocalPlayer["state"]["Groove"] = false
LocalPlayer["state"]["TopGear"] = false
LocalPlayer["state"]["Redline"] = false
LocalPlayer["state"]["Bennys"] = false
LocalPlayer["state"]["DriftKing"] = false
LocalPlayer["state"]["Forza"] = false
LocalPlayer["state"]["Overdrive"] = false
LocalPlayer["state"]["Crips"] = false
LocalPlayer["state"]["Tropadu7"] = false
LocalPlayer["state"]["Outlaws"] = false
LocalPlayer["state"]["SonsofAnarchy"] = false
LocalPlayer["state"]["Sinaloa"] = false
LocalPlayer["state"]["HellsAngels"] = false
LocalPlayer["state"]["Triade"] = false
LocalPlayer["state"]["Yakuza"] = false
LocalPlayer["state"]["Warlocks"] = false
LocalPlayer["state"]["Bloods"] = false
LocalPlayer["state"]["Mercenarios"] = false
LocalPlayer["state"]["Bopegg"] = false
LocalPlayer["state"]["LaMafia"] = false
LocalPlayer["state"]["Gringa"] = false
LocalPlayer["state"]["Franca"] = false
LocalPlayer["state"]["Italia"] = false
LocalPlayer["state"]["Russia"] = false
LocalPlayer["state"]["Israel"] = false
LocalPlayer["state"]["Playboy"] = false
LocalPlayer["state"]["Mexico"] = false
LocalPlayer["state"]["China"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- WALKERS
-----------------------------------------------------------------------------------------------------------------------------------------
local Walkers = {
	"move_m@alien","anim_group_move_ballistic","move_f@arrogant@a","move_m@brave","move_m@casual@a","move_m@casual@b","move_m@casual@c",
	"move_m@casual@d","move_m@casual@e","move_m@casual@f","move_f@chichi","move_m@confident","move_m@business@a","move_m@business@b",
	"move_m@business@c","move_m@drunk@a","move_m@drunk@slightlydrunk","move_m@buzzed","move_m@drunk@verydrunk","move_f@femme@",
	"move_characters@franklin@fire","move_characters@michael@fire","move_m@fire","move_f@flee@a","move_p_m_one","move_m@gangster@generic",
	"move_m@gangster@ng","move_m@gangster@var_e","move_m@gangster@var_f","move_m@gangster@var_i","anim@move_m@grooving@","move_f@heels@c",
	"move_m@hipster@a","move_m@hobo@a","move_f@hurry@a","move_p_m_zero_janitor","move_p_m_zero_slow","move_m@jog@","anim_group_move_lemar_alley",
	"move_heist_lester","move_f@maneater","move_m@money","move_m@posh@","move_f@posh@","move_m@quick","female_fast_runner","move_m@sad@a",
	"move_m@sassy","move_f@sassy","move_f@scared","move_f@sexy@a","move_m@shadyped@a","move_characters@jimmy@slow@","move_m@swagger",
	"move_m@tough_guy@","move_f@tough_guy@","move_p_m_two","move_m@bag","move_m@injured"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANDAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("andar",function(source,Message)
	local Ped = PlayerPedId()

	if Message[1] then
		local Mode = parseInt(Message[1])

		if Walkers[Mode] and LoadMovement(Walkers[Mode]) then
			SetPedMovementClipset(Ped,Walkers[Mode],0.25)
			Walk = Walkers[Mode]
		end
	else
		ResetPedMovementClipset(Ped,0.25)
		Walk = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Cancel"] and LocalPlayer["state"]["Active"] then
			TimeDistance = 1
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,38,true)
			DisableControlAction(1,47,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,137,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if (LocalPlayer["state"]["disablePhone"] or AnimVars[3]) and LocalPlayer["state"]["Active"] then
			TimeDistance = 1
			DisableControlAction(1,18,true)
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,68,true)
			DisableControlAction(1,70,true)
			DisableControlAction(1,91,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,143,true)
			DisableControlAction(1,257,true)
			DisablePlayerFiring(Ped,true)

			if AnimVars[3] then
				if not IsEntityPlayingAnim(Ped,AnimVars[1],AnimVars[2],3) then
					TaskPlayAnim(Ped,AnimVars[1],AnimVars[2],8.0,8.0,-1,AnimVars[4],0,0,0,0)
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.CreateObjects(Dict,Anim,Prop,Flag,Hands,Height,Pos1,Pos2,Pos3,Pos4,Pos5)
	local Ped = PlayerPedId()

	if LastCreated == Prop then
        if CooldownCreate > GetGameTimer() then
            return
        end
    end
    CooldownCreate = GetGameTimer() + 10000
    LastCreated = Prop

	if DoesEntityExist(Object) then
		TriggerServerEvent("DeleteObject",ObjToNet(Object))
		Object = nil
	end

	if Anim ~= "" then
		if LoadAnim(Dict) then
			TaskPlayAnim(Ped,Dict,Anim,8.0,8.0,-1,Flag,1,0,0,0)
		end

		AnimVars[4] = Flag
		AnimVars[3] = true
		AnimVars[1] = Dict
		AnimVars[2] = Anim
	end

	if not IsPedInAnyVehicle(Ped) then
		local Coords = GetEntityCoords(Ped)
		local Progression,Network = vRPS.CreateObject(Prop,Coords["x"],Coords["y"],Coords["z"])
		if Progression then
			Object = LoadNetwork(Network)
			if Object then
				if Height then
					AttachEntityToEntity(Object,Ped,GetPedBoneIndex(Ped,Hands),Height,Pos1,Pos2,Pos3,Pos4,Pos5,true,true,false,true,1,true)
				else
					AttachEntityToEntity(Object,Ped,GetPedBoneIndex(Ped,Hands),0.0,0.0,0.0,0.0,0.0,0.0,true,true,false,true,2,true)
				end
			else
				Object = nil
			end

			SetModelAsNoLongerNeeded(Prop)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESTROYOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.DestroyObjects(Mode)
	local Ped = PlayerPedId()

	if IsPedUsingScenario(Ped,"PROP_HUMAN_SEAT_CHAIR_UPRIGHT") then
		TriggerEvent("target:UpChair")
	elseif IsEntityPlayingAnim(Ped,"amb@world_human_sunbathe@female@back@idle_a","idle_a",3) or LocalPlayer["state"]["Bed"] then
		TriggerEvent("target:UpBed")
	end

	if Mode == "one" then
		tvRP.stopAnim(true)
	elseif Mode == "two" then
		tvRP.stopAnim(false)
	else
		tvRP.stopAnim(true)
		tvRP.stopAnim(false)
	end

	AnimVars[3] = false

	if DoesEntityExist(Object) then
		TriggerServerEvent("DeleteObject",ObjToNet(Object))
		Object = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPOINT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 100
		if Point and LocalPlayer["state"]["Active"] then
			TimeDistance = 1
			local Ped = PlayerPedId()
			local Cam = GetGameplayCamRelativePitch()

			if Cam < -70.0 then
				Cam = -70.0
			elseif Cam > 42.0 then
				Cam = 42.0
			end

			Cam = (Cam + 70.0) / 112.0

			local camHeading = GetGameplayCamRelativeHeading()
			local cosCamHeading = Cos(camHeading)
			local sinCamHeading = Sin(camHeading)
			if camHeading < -180.0 then
				camHeading = -180.0
			elseif camHeading > 180.0 then
				camHeading = 180.0
			end

			camHeading = (camHeading + 180.0) / 360.0

			local blocked = 0
			local Coords = GetOffsetFromEntityInWorldCoords(Ped,(cosCamHeading * - 0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)),(sinCamHeading * - 0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)),0.6)
			local Ray = Cast_3dRayPointToPoint(Coords["x"],Coords["y"],Coords["z"] - 0.2,Coords["x"],Coords["y"],Coords["z"] + 0.2,0.4,95,Ped,7);
			_,blocked = GetRaycastResult(Ray)

			SetTaskMoveNetworkSignalFloat(Ped,"Pitch",Cam)
			SetTaskMoveNetworkSignalFloat(Ped,"Heading",camHeading * -1.0 + 1.0)
			SetTaskMoveNetworkSignalBool(Ped,"isBlocked",blocked)
			SetTaskMoveNetworkSignalBool(Ped,"isFirstPerson",GetCamViewModeForContext(GetCamActiveViewModeContext()) == 4)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Cancel",function()
	local Ped = PlayerPedId()
    TriggerEvent("actions:Cancel")
    if LocalPlayer["state"]["Carregar"] then
        return
    end
	if GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Handcuff"] and not IsPedInAnyVehicle(Ped) and not LocalPlayer["state"]["disablePhone"] and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and LocalPlayer["state"]["Active"] then
		Button = GetGameTimer() + 1000
		TriggerEvent("inventory:Cancel")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDSUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("HandsUp",function()
	local Ped = PlayerPedId()
	if GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPedInAnyVehicle(Ped) and not LocalPlayer["state"]["disablePhone"] and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and LocalPlayer["state"]["Active"] and not IsPedReloading(Ped) then
		Button = GetGameTimer() + 1000

		if IsEntityPlayingAnim(Ped,"random@mugging3","handsup_standing_base",3) then
			StopAnimTask(Ped,"random@mugging3","handsup_standing_base",8.0)
			tvRP.AnimActive()
		else
			tvRP.playAnim(true,{"random@mugging3","handsup_standing_base"},true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POINT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Point",function()
	local Ped = PlayerPedId()
	if GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPedInAnyVehicle(Ped) and not LocalPlayer["state"]["disablePhone"] and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and LocalPlayer["state"]["Active"] and not IsPedReloading(Ped) then
		Button = GetGameTimer() + 1000

		if not Point then
			Point = true
			tvRP.AnimActive()
			SetPedConfigFlag(Ped,36,true)

			if LoadAnim("anim@mp_point") then
				TaskMoveNetwork(Ped,"task_mp_pointing",0.5,0,"anim@mp_point",24)
			end
		else
			RequestTaskMoveNetworkStateTransition(Ped,"Stop")
			if not IsPedInjured(Ped) then
				ClearPedSecondaryTask(Ped)
			end

			SetPedConfigFlag(Ped,36,false)
			ClearPedSecondaryTask(Ped)
			Point = false
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Engine",function()
	local Ped = PlayerPedId()
	if GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["disablePhone"] and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and LocalPlayer["state"]["Active"] and not IsPedReloading(Ped) then
		Button = GetGameTimer() + 1000

		local Vehicle = GetVehiclePedIsUsing(Ped)
		if GetPedInVehicleSeat(Vehicle,-1) == Ped then
			local Running = GetIsVehicleEngineRunning(Vehicle)
			SetVehicleEngineOn(Vehicle,not Running,true,true)

			if Running then
				SetVehicleUndriveable(Vehicle,true)
			else
				SetVehicleUndriveable(Vehicle,false)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BINDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Binds",function(source,Message)
	local Ped = PlayerPedId()
	if GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["disablePhone"] and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and LocalPlayer["state"]["Active"] and not IsPedReloading(Ped) then
		Button = GetGameTimer() + 1000

		if parseInt(Message[1]) >= 1 and parseInt(Message[1]) <= 5 then
			TriggerEvent("inventory:Slot",Message[1],1)
		elseif Message[1] == "6" then
			if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped,6) and not IsPedSwimming(Ped) then
				if IsEntityPlayingAnim(Ped,"anim@heists@heist_corona@single_team","single_team_loop_boss",3) then
					StopAnimTask(Ped,"anim@heists@heist_corona@single_team","single_team_loop_boss",8.0)
					tvRP.AnimActive()
				else
					tvRP.playAnim(true,{"anim@heists@heist_corona@single_team","single_team_loop_boss"},true)
				end
			end
		elseif Message[1] == "7" then
			if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped,6) and not IsPedSwimming(Ped) then
				if IsEntityPlayingAnim(Ped,"mini@strip_club@idles@bouncer@base","base",3) then
					StopAnimTask(Ped,"mini@strip_club@idles@bouncer@base","base",8.0)
					tvRP.AnimActive()
				else
					tvRP.playAnim(true,{"mini@strip_club@idles@bouncer@base","base"},true)
				end
			end
		elseif Message[1] == "8" then
			if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped,6) and not IsPedSwimming(Ped) then
				if IsEntityPlayingAnim(Ped,"anim@mp_player_intupperfinger","idle_a_fp",3) then
					StopAnimTask(Ped,"anim@mp_player_intupperfinger","idle_a_fp",8.0)
					tvRP.AnimActive()
				else
					tvRP.playAnim(true,{"anim@mp_player_intupperfinger","idle_a_fp"},true)
				end
			end
		elseif Message[1] == "9" then
			if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped,6) and not IsPedSwimming(Ped) then
				if IsEntityPlayingAnim(Ped,"random@arrests@busted","idle_a",3) then
					StopAnimTask(Ped,"random@arrests@busted","idle_a",8.0)
					tvRP.AnimActive()
				else
					tvRP.playAnim(true,{"random@arrests@busted","idle_a"},true)
				end
			end
		elseif Message[1] == "left" then
			if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped,6) and not IsPedSwimming(Ped) then
				tvRP.playAnim(true,{"anim@mp_player_intupperthumbs_up","enter"},false)
			end
		elseif Message[1] == "right" then
			if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped,6) and not IsPedSwimming(Ped) then
				tvRP.playAnim(true,{"anim@mp_player_intcelebrationmale@face_palm","face_palm"},false)
			end
		elseif Message[1] == "up" then
			if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped,6) and not IsPedSwimming(Ped) then
				tvRP.playAnim(true,{"anim@mp_player_intcelebrationmale@salute","salute"},false)
			end
		elseif Message[1] == "down" then
			if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped,6) and not IsPedSwimming(Ped) then
				tvRP.playAnim(true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Lock",function()
	local Ped = PlayerPedId()
	if GetGameTimer() >= Button and not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["disablePhone"] and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Cancel"] and LocalPlayer["state"]["Active"] and not IsPedReloading(Ped) then
		Button = GetGameTimer() + 1000

		local Vehicle,Network,Plate = tvRP.VehicleList(5)
		if Vehicle then
			TriggerServerEvent("garages:Lock",Network,Plate)
		end
	end
end)