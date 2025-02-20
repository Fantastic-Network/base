local Tools = module("lib/Tools")

local Proxy = {}

local function proxy_resolve(itable,key)

    ProfilerEnterScope( ('proxy_resolve:%s:%s'):format( itable, key ) )

	local mtable = getmetatable(itable)
	local iname = mtable.name
	local ids = mtable.ids
	local callbacks = mtable.callbacks
	local identifier = mtable.identifier

	local fname = key
	local no_wait = false
	if string.sub(key,1,1) == "_" then
		fname = string.sub(key,2)
		no_wait = true
	end

	local fcall = function(...)
		local rid, r
		local profile

		if no_wait then
			rid = -1
		else
			r = async()
			rid = ids:gen()
			callbacks[rid] = r
		end

		local Message = {...}

		TriggerEvent(iname..":proxy",fname, Message, identifier, rid)
    
		if not no_wait then
			return r:wait()
		end
	end

	itable[key] = fcall

    ProfilerExitScope()

	return fcall
end

local eventStats = {}
function Proxy.addInterface(name,itable)
	AddEventHandler(name..":proxy",function(member,Message,identifier,rid)
		local f = itable[member]
		local rets = {}
		if type(f) == "function" then
			rets = {f(table.unpack(Message,1,table.maxn(Message)))}
		end
		if rid >= 0 then
			TriggerEvent(name..":"..identifier..":proxy_res",rid,rets)
		end
        local eventName = name

        if not identifier then
            identifier = GetCurrentResourceName()
        end
        if not eventStats[identifier] then
            eventStats[identifier] = {}
        end
        if not eventStats[identifier][member] then
            eventStats[identifier][member] = {
                calls = 0,
                member = member,
                identifier = identifier
            }
        end
        eventStats[identifier][member].calls = eventStats[identifier][member].calls + 1
	end)
end


function Proxy.getInterface(name,identifier)
	if not identifier then
		identifier = GetCurrentResourceName()
	end

	local callbacks = {}
	local ids = Tools.newIDGenerator()
	local r = setmetatable({},{ __index = proxy_resolve, name = name, ids = ids, callbacks = callbacks, identifier = identifier })

	AddEventHandler(name..":"..identifier..":proxy_res",function(rid,rets)
		local callback = callbacks[rid]
		if callback then
			-- ids:free(rid)
			callbacks[rid] = nil
			callback(table.unpack(rets,1,table.maxn(rets)))
		end
	end)

	return r
end

-- Citizen.CreateThread(function()
--     if PlayerPedId then
--         return
--     end
--     while true do
--         Citizen.Wait(60000) -- Wait for 1 minute
--         local Count = 0
--         for resource, functions in pairs(eventStats) do
--             for _, stats in pairs(functions) do
--                 Count = Count + 1
--             end
--         end
--         if Count > 0 then
--             for resource, info in pairs(eventStats) do
--                 for functions, stats in pairs(info) do
--                     print("PROXY:"..resource.." | Function: "..functions.." Count: "..stats.calls)
--                 end
--             end
--         end
--         eventStats = {}
--     end
-- end)

return Proxy