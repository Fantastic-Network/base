if GetCurrentResourceName() == "vrp" then return end

_SERVER = IsDuplicityVersion()
_CLIENT = not _SERVER

local modules = {}
function import(rsc, path)
	if path == nil then
		path = rsc
		rsc = "vrp"
	end

	local key = rsc..path
	local module = modules[key]
	if module then
		return module
	else
		local code = LoadResourceFile(rsc, path..".lua")
		if code then
			local f,err = load(code, rsc.."/"..path..".lua")
			if f then
				local ok, res = xpcall(f, debug.traceback)
				if ok then
					modules[key] = res
					return res
				else
					error("error loading module "..rsc.."/"..path..":"..res)
				end
			else
				error("error parsing module "..rsc.."/"..path..":"..debug.traceback(err))
			end
		else
			error("resource file "..rsc.."/"..path..".lua not found")
		end
	end
end

---@param t table
---@param o any
---@return boolean
function table.includes(t, o)
	for i, v in pairs(t) do
		if v == o then
			return true
		end
	end
	return false
end

function table.clone(original)
	local copy = {}
	for key, value in pairs(original) do
		if type(value) == "table" then
			copy[key] = table.clone(value) -- recursively clone nested tables
		else
			copy[key] = value -- copy non-table values
		end
	end
	return copy
end

function table.count(t)
	local count = 0
	for _ in pairs(t) do count = count + 1 end
	return count
end

-- Copying JS behavior (it"s way easier)
emit = TriggerEvent
emitNet = TriggerClientEvent or TriggerServerEvent
onNet = RegisterNetEvent
on = AddEventHandler
onCommand = RegisterCommand
onNuiCallback = RegisterNUICallback