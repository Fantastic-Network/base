-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Flags = 0
local Dict = nil
local Name = nil
local Active = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.playAnim(Upper,Sequency,Loop,FlagC)
	local Ped = PlayerPedId()

	if Sequency["task"] then
		tvRP.stopAnim(true)

		if Sequency["task"] == "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" then
			local Coords = GetEntityCoords(Ped)
			local Heading = GetEntityHeading(Ped)
			TaskStartScenarioAtPosition(Ped,Sequency["task"],Coords["x"],Coords["y"],Coords["z"] - 1,Heading,0,0,false)
		else
			TaskStartScenarioInPlace(Ped,Sequency["task"],0,false)
		end
	else
		local Consecutive = 0
		tvRP.stopAnim(Upper)

		if Upper then
			Consecutive = Consecutive + 48
		end

		if Loop then
			Consecutive = Consecutive + 1
		end

		if LoadAnim(Sequency[1]) then
			Dict = Sequency[1]
			Name = Sequency[2]
			Flags = Consecutive

			if Consecutive == 49 then
				Active = true
			end

            if FlagC then
                Active = true
            end

			TaskPlayAnim(Ped,Sequency[1],Sequency[2],8.0,8.0,-1,Consecutive,0,0,0,0)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADANIM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if Active then
			TimeDistance = 1

			local Ped = PlayerPedId()
			if not IsEntityPlayingAnim(Ped,Dict,Name,3) then
				TaskPlayAnim(Ped,Dict,Name,8.0,8.0,-1,Flags,0,0,0,0)
			end

			DisableControlAction(1,18,true)
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,263,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,143,true)
			DisablePlayerFiring(Ped,true)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.stopAnim(Upper)
	Active = false
	local Ped = PlayerPedId()

	if Upper then
		ClearPedSecondaryTask(Ped)
	else
		ClearPedTasks(Ped)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.AnimActive()
	Active = false
end