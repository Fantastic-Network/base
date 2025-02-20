local TaskbarClient = {}
Tunnel.bindInterface("inventory/taskbar",TaskbarClient)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Status = ""
local Progress = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASKBAR:FAIL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("taskFailure",function(Data,Callback)
	if Progress == false then
		return
	end
	SetNuiFocus(false,false)
	Status = "failure"
	Progress = false

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASKBAR:SUCESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("taskSuccess",function(Data,Callback)
	if Progress == false then
		return
	end
	SetNuiFocus(false,false)
	Status = "success"
	Progress = false

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASKBAR:TASKBAR
-----------------------------------------------------------------------------------------------------------------------------------------
function taskBar(Timer)
	if Progress then return end

	Progress = true
	SetNuiFocus(true,false)
	SendNUIMessage({ page = "taskbar", action = "open", time = Timer })

	while Progress do
		Wait(0)
	end

	if Status == "success" then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASK
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Task",function(Amount,Speed)
	local Return = true

	for Number = 1,Amount do
		if not taskBar(Speed) then
			Return = false
			break
		end
	end

	return Return
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASK
-----------------------------------------------------------------------------------------------------------------------------------------
function TaskbarClient.Task(Amount,Speed)
	local Return = true

	for Number = 1,Amount do
		if not taskBar(Speed) then
			Return = false
			break
		end
	end

	return Return
end