-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
SERVER = IsDuplicityVersion()
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCATEGORY
-----------------------------------------------------------------------------------------------------------------------------------------
function ClassCategory(Number)
	local Category = "B"

	if Number >= 100 and Number <= 200 then
		Category = "B+"
	elseif Number >= 201 and Number <= 350 then
		Category = "A"
	elseif Number >= 351 and Number <= 500 then
		Category = "A+"
	elseif Number >= 501 and Number <= 1000 then
		Category = "S"
	elseif Number >= 1001 then
		Category = "S+"
	end

	return Category
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SANGUINE
-----------------------------------------------------------------------------------------------------------------------------------------
function Sanguine(Number)
	local Types = {
		[1] = "A+",
		[2] = "B+",
		[3] = "A-",
		[4] = "B-"
	}

	return Types[Number]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLE.MAXN
-----------------------------------------------------------------------------------------------------------------------------------------
function table.maxn(t)
	local max = 0

	for k,v in pairs(t) do
		local n = tonumber(k)
		if n and n > max then
			max = n
		end
	end

	return max
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODULE
-----------------------------------------------------------------------------------------------------------------------------------------
local modules = {}
function module(Resource,patchs)
	if not patchs then
		patchs = Resource
		Resource = "vrp"
	end

	local key = Resource..patchs
	local checkModule = modules[key]
	if checkModule then
		return checkModule
	else
		local code = LoadResourceFile(Resource,patchs..".lua")
		if code then
			local floats = load(code,Resource.."/"..patchs..".lua")
			if floats then
				local resAccept,resUlts = xpcall(floats,debug.traceback)
				if resAccept then
					modules[key] = resUlts
					return resUlts
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAIT
-----------------------------------------------------------------------------------------------------------------------------------------
local function wait(self)
	local rets = Citizen.Await(self.p)
	if not rets then
		if self.r then
			rets = self.r
		end
	end

	return table.unpack(rets,1,table.maxn(rets))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARETURN
-----------------------------------------------------------------------------------------------------------------------------------------
local function areturn(self,...)
	self.r = {...}
	self.p:resolve(self.r)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ASYNC
-----------------------------------------------------------------------------------------------------------------------------------------
function async(func)
	if func then
		Citizen.CreateThreadNow(func)
	else
		return setmetatable({ wait = wait, p = promise.new() },{ __call = areturn })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARSEINT
-----------------------------------------------------------------------------------------------------------------------------------------
function parseInt(Value)
	local Result = 0
	local Number = tonumber(Value)

	if Number ~= nil then
		if Number > 0 then
			Result = math.floor(Number)
		end
	end

	return Result
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SANITIZESTRING
-----------------------------------------------------------------------------------------------------------------------------------------
local sanitize_tmp = {}
function sanitizeString(str,strchars,allow_policy)
	local r = ""
	local chars = sanitize_tmp[strchars]
	if not chars then
		chars = {}
		local size = string.len(strchars)
		for i = 1,size do
			local char = string.sub(strchars,i,i)
			chars[char] = true
		end

		sanitize_tmp[strchars] = chars
	end

	size = string.len(str)
	for i = 1,size do
		local char = string.sub(str,i,i)
		if (allow_policy and chars[char]) or (not allow_policy and not chars[char]) then
			r = r..char
		end
	end

	return r
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLITSTRING
-----------------------------------------------------------------------------------------------------------------------------------------
function splitString(Full,Symbol)
	local Table = {}

	if not Symbol then
		Symbol = "-"
	end

    if not Full then
        return Table
    end

	for Full in string.gmatch(Full,"([^"..Symbol.."]+)") do
		Table[#Table + 1] = Full
	end

	return Table
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLITONE
-----------------------------------------------------------------------------------------------------------------------------------------
function SplitOne(Name)
	return splitString(Name,"-")[1]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MATHLEGTH
-----------------------------------------------------------------------------------------------------------------------------------------
function mathLength(Number)
	return math.ceil(Number * 100) / 100
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARSEFORMAT
-----------------------------------------------------------------------------------------------------------------------------------------
function parseFormat(Number)
	local Left,Number,Right = string.match(parseInt(Number),"^([^%d]*%d)(%d*)(.-)$")
	return Left..(Number:reverse():gsub("(%d%d%d)","%1."):reverse())..Right
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPLETETIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
function CompleteTimers(Seconds)
	local Days = math.floor(Seconds / 86400)
	Seconds = Seconds - Days * 86400
	local Hours = math.floor(Seconds / 3600)
	Seconds = Seconds - Hours * 3600
	local Minutes = math.floor(Seconds / 60)
	Seconds = Seconds - Minutes * 60

	if Days > 0 then
		return string.format("<b>%d Dias</b>, <b>%d Horas</b>, <b>%d Minutos</b>",Days,Hours,Minutes)
	elseif Hours > 0 then
		return string.format("<b>%d Horas</b>, <b>%d Minutos</b> e <b>%d Segundos</b>",Hours,Minutes,Seconds)
	elseif Minutes > 0 then
		return string.format("<b>%d Minutos</b> e <b>%d Segundos</b>",Minutes,Seconds)
	elseif Seconds > 0 then
		return string.format("<b>%d Segundos</b>",Seconds)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MINIMALTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
function MinimalTimers(Seconds)
	local Days = math.floor(Seconds / 86400)
	Seconds = Seconds - Days * 86400
	local Hours = math.floor(Seconds / 3600)
	Seconds = Seconds - Hours * 3600
	local Minutes = math.floor(Seconds / 60)
	Seconds = Seconds - Minutes * 60

	if Days > 0 then
		return string.format("%d Dias, %d Horas",Days,Hours)
	elseif Hours > 0 then
		return string.format("%d Horas, %d Minutos",Hours,Minutes)
	elseif Minutes > 0 then
		return string.format("%d Minutos",Minutes)
	elseif Seconds > 0 then
		return string.format("%d Segundos",Seconds)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BONES
-----------------------------------------------------------------------------------------------------------------------------------------
local Bones = {
	[11816] = "Pelvis",
	[58271] = "Coxa Esquerda",
	[63931] = "Panturrilha Esquerda",
	[14201] = "Pe Esquerdo",
	[2108] = "Dedo do Pe Esquerdo",
	[65245] = "Pe Esquerdo",
	[57717] = "Pe Esquerdo",
	[46078] = "Joelho Esquerdo",
	[51826] = "Coxa Direita",
	[36864] = "Panturrilha Direita",
	[52301] = "Pe Direito",
	[20781] = "Dedo do Pe Direito",
	[35502] = "Pe Direito",
	[24806] = "Pe Direito",
	[16335] = "Joelho Direito",
	[23639] = "Coxa Direita",
	[6442] = "Coxa Direita",
	[57597] = "Espinha Cervical",
	[23553] = "Espinha Toraxica",
	[24816] = "Espinha Lombar",
	[24817] = "Espinha Sacral",
	[24818] = "Espinha Cocciana",
	[64729] = "Escapula Esquerda",
	[45509] = "Braco Esquerdo",
	[61163] = "Antebraco Esquerdo",
	[18905] = "Mao Esquerda",
	[26610] = "Dedo Esquerdo",
	[4089] = "Dedo Esquerdo",
	[4090] = "Dedo Esquerdo",
	[26611] = "Dedo Esquerdo",
	[4169] = "Dedo Esquerdo",
	[4170] = "Dedo Esquerdo",
	[26612] = "Dedo Esquerdo",
	[4185] = "Dedo Esquerdo",
	[4186] = "Dedo Esquerdo",
	[26613] = "Dedo Esquerdo",
	[4137] = "Dedo Esquerdo",
	[4138] = "Dedo Esquerdo",
	[26614] = "Dedo Esquerdo",
	[4153] = "Dedo Esquerdo",
	[4154] = "Dedo Esquerdo",
	[60309] = "Mao Esquerda",
	[36029] = "Mao Esquerda",
	[61007] = "Antebraco Esquerdo",
	[5232] = "Antebraco Esquerdo",
	[22711] = "Cotovelo Esquerdo",
	[10706] = "Escapula Direita",
	[40269] = "Braco Direito",
	[28252] = "Antebraco Direito",
	[57005] = "Mao Direita",
	[58866] = "Dedo Direito",
	[64016] = "Dedo Direito",
	[64017] = "Dedo Direito",
	[58867] = "Dedo Direito",
	[64096] = "Dedo Direito",
	[64097] = "Dedo Direito",
	[58868] = "Dedo Direito",
	[64112] = "Dedo Direito",
	[64113] = "Dedo Direito",
	[58869] = "Dedo Direito",
	[64064] = "Dedo Direito",
	[64065] = "Dedo Direito",
	[58870] = "Dedo Direito",
	[64080] = "Dedo Direito",
	[64081] = "Dedo Direito",
	[28422] = "Mao Direita",
	[6286] = "Mao Direita",
	[43810] = "Antebraço Direito",
	[37119] = "Antebraço Direito",
	[2992] = "Cotovelo Direito",
	[39317] = "Pescoco",
	[31086] = "Cabeca",
	[12844] = "Cabeca",
	[65068] = "Rosto"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BONE
-----------------------------------------------------------------------------------------------------------------------------------------
function Bone(Number)
	return Bones[Number] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local BlockItem = {
	["nigirizushi"] = true,
	["sushi"] = true,
	["cupcake"] = true,
	["milkshake"] = true,
	["cappuccino"] = true,
	["applelove"] = true,
	["cheese"] = true,
	["burgershot1"] = true,
	["burgershot2"] = true,
	["burgershot3"] = true,
	["burgershot4"] = true,
	["pizzathis1"] = true,
	["pizzathis2"] = true,
	["pizzathis3"] = true,
	["pizzathis4"] = true,
	["uwucoffee1"] = true,
	["uwucoffee2"] = true,
	["uwucoffee3"] = true,
	["uwucoffee4"] = true,
	["beanmachine1"] = true,
	["beanmachine2"] = true,
	["beanmachine3"] = true,
	["beanmachine4"] = true,
	["octopus"] = true,
	["shrimp"] = true,
	["carp"] = true,
	["codfish"] = true,
	["catfish"] = true,
	["goldenfish"] = true,
	["horsefish"] = true,
	["tilapia"] = true,
	["pacu"] = true,
	["pirarucu"] = true,
	["tambaqui"] = true,
	["milkbottle"] = true,
	["guarananatural"] = true,
	["water"] = true,
	["coffee"] = true,
	["coffeemilk"] = true,
	["cola"] = true,
	["tacos"] = true,
	["fries"] = true,
	["soda"] = true,
	["apple"] = true,
	["orange"] = true,
	["strawberry"] = true,
	["coffee2"] = true,
	["grape"] = true,
	["tange"] = true,
	["banana"] = true,
	["guarana"] = true,
	["acerola"] = true,
	["passion"] = true,
	["tomato"] = true,
	["mushroom"] = true,
	["sugar"] = true,
	["cookies"] = true,
	["orangejuice"] = true,
	["tangejuice"] = true,
	["grapejuice"] = true,
	["strawberryjuice"] = true,
	["bananajuice"] = true,
	["acerolajuice"] = true,
	["passionjuice"] = true,
	["bread"] = true,
	["ketchup"] = true,
	["cannedsoup"] = true,
	["canofbeans"] = true,
	["fishfillet"] = true,
	["marshmallow"] = true,
	["cookedfishfillet"] = true,
	["hamburger"] = true,
	["hamburger2"] = true,
	["onionrings"] = true,
	["chickenfries"] = true,
	["pizzamozzarella"] = true,
	["pizzamushroom"] = true,
	["pizzabanana"] = true,
	["pizzachocolate"] = true,
	["calzone"] = true,
	["hotdog"] = true,
	["donut"] = true,
	["chocolate"] = true,
	["sandwich"] = true,
	["absolut"] = true,
	["chandon"] = true,
	["dewars"] = true,
	["hennessy"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function BlockChest(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if BlockItem[Item] then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSIDEPOLYGON
-----------------------------------------------------------------------------------------------------------------------------------------
function insidePolygon(polygon, point)
    local inside = false
    local j = #polygon
    for i = 1, #polygon do
        if (polygon[i].y < point.y and polygon[j].y >= point.y or polygon[j].y < point.y and polygon[i].y >= point.y) then
            if (polygon[i].x + ( point.y - polygon[i].y ) / (polygon[j].y - polygon[i].y) * (polygon[j].x - polygon[i].x) < point.x) then
                inside = not inside
            end
        end
        j = i
    end
    return inside 
end

function getPolygonCenter(poly)
    local sumX = 0
    local sumY = 0
    local count = #poly
    
    for i = 1, count do
      sumX = sumX + poly[i][1]
      sumY = sumY + poly[i][2]
    end
    
    return vector2(sumX/count,sumY/count)
end
-----------------------------------------------------------------------------------------------------------------------------------------
--  FLOAT
-----------------------------------------------------------------------------------------------------------------------------------------
function f(n)
	n = n + 0.00000
	return n
end
-----------------------------------------------------------------------------------------------------------------------------------------
--  SECONDTOMINUTES
-----------------------------------------------------------------------------------------------------------------------------------------
function SecondsToMinutes(seconds)
    local minutes = math.floor(seconds / 60)
    local seconds = seconds % 60
    return string.format("%02d:%02d", minutes, seconds)
end
-----------------------------------------------------------------------------------------------------------------------------------------
--  NEWPLAYERCONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
local NewPlayerConfig = {
    "Connect",
    "Spawn",
    "Second Login",
    "Activation",
    "Pier",
    "Quit",
    "First Reward BattlePass",
    "Finish BattlePass",
    "VIP Store",
    "Spawn2",
}

function NewPlayer()
    return NewPlayerConfig
end

function GetNewPlayerNumber(Name)
    local Select = false
    for i=1, #NewPlayerConfig do
        if NewPlayerConfig[i] == Name then
            Select = i
        end
    end
    return Select
end


function spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function secondsToHours(seconds)
    local hours = math.floor(seconds/3600)
    local minutes = math.floor((seconds - (hours*3600))/60)
    local seconds = seconds - (hours*3600) - (minutes*60)
    return hours, minutes, seconds
end

function getDayHours(seconds)
    local days = math.floor(seconds/86400)
    seconds = seconds - days * 86400
    local hours = math.floor(seconds/3600)

    if days > 0 then
        return string.format("<b>%d Dias</b> e <b>%d Horas</b>",days,hours)
    else
        return string.format("<b>%d Horas</b>",hours)
    end
end

function GetDate(Unix)
    local Date = exports["vrp"]:getDate(Unix)
    if Date.day < 10 then
        Date.day = "0"..Date.day
    end
    if Date.month < 10 then
        Date.month = "0"..Date.month
    end
    if Date.hour < 10 then
        Date.hour = "0"..Date.hour
    end
    if Date.min < 10 then
        Date.min = "0"..Date.min
    end
    if Date.sec < 10 then
        Date.sec = "0"..Date.sec
    end
   return Date
end

function toVector3(String, Separator)
    local Separator = Separator or ','

    local axes = {}

    for axis in String:gmatch('[^'..Separator..']+') do
        axes[#axes + 1] = axis
    end
    return vector3(tonumber(axes[1]), tonumber(axes[2]), tonumber(axes[3]))
end

function toVector4(String, Separator)
    local Separator = Separator or ','

    local axes = {}

    for axis in String:gmatch('[^'..Separator..']+') do
        axes[#axes + 1] = axis
    end
    return vector4(tonumber(axes[1]), tonumber(axes[2]), tonumber(axes[3]), tonumber(axes[4]))
end
-----------------------------------------------------------------------------------------------------------------------------------------
--  LERP
-----------------------------------------------------------------------------------------------------------------------------------------
function Lerp(a, b, t)
    return a + (b - a) * t
end
-----------------------------------------------------------------------------------------------------------------------------------------
--  CLAMP
-----------------------------------------------------------------------------------------------------------------------------------------
function Clamp(x, min, max)
    return math.max(math.min(x, max), min)
end
-----------------------------------------------------------------------------------------------------------------------------------------
--  tD
-----------------------------------------------------------------------------------------------------------------------------------------
function tD(n)
	n = math.ceil(n * 100) / 100
	return n
end
-----------------------------------------------------------------------------------------------------------------------------------------
--  LEADING ZERO
-----------------------------------------------------------------------------------------------------------------------------------------
function addLeadingZero(num)
    if num < 10 then
        return "0"..num
    else
        return num
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--  DICTIONARY WITH HIGHER VALUE
-----------------------------------------------------------------------------------------------------------------------------------------
function dictionaryWithHigherValue(dict)
    
    local highest = 0
    local highestKey = nil
    
    for k,v in pairs(dict) do
        if v > highest then
            highest = v
            highestKey = k
        end
    end
    
    return highestKey
end
-----------------------------------------------------------------------------------------------------------------------------------------
--  BUCKET PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetBucketsPlayers()
    local Buckets = {}
    for _,Source in ipairs(GetPlayers()) do
        local Bucket = GetPlayerRoutingBucket(Source)
        if Bucket then
            if not Buckets[Bucket] then
                Buckets[Bucket] = {}
            end
            table.insert(Buckets[Bucket],Source)
        end
	end
    return Buckets
end
-----------------------------------------------------------------------------------------------------------------------------------------
--  PRINT
-----------------------------------------------------------------------------------------------------------------------------------------
function nPrint(Text,Source)
    if not IsDuplicityVersion() then
        TriggerEvent("Notify", "vermelho", Text)
    else
        if Source then
            TriggerClientEvent("Notify",Source,"vermelho", Text)
        else
            TriggerClientEvent("Notify",-1,"vermelho", Text)
        end
    end
end


--[=[
--[[ Shared ]]

local gLocalization =
{
	['#unknown.title'] = "👑 SEJA LIDER",
	['#unknown.message'] = "2 Facs estão disponível na cidade, você pode assumi-las [Olhe o Discord]"
}

--[[ SERVER ]]

function vRP.addNotification(to, message, ...)
	vRP.send( to, 'notifications:add', message, ... )
end

if false then
	vRP.addNotification( To.Single( source ), "#unknown.title", '#unknown.message', { amount = 1, character_name = 'deadshot' } )
	vRP.addNotification( To.Everyone()	   , "#unknown.title", '#unknown.message', { amount = 1, character_name = 'deadshot' }, { duration = 500 })

	vRP.addNotificationError( To.Everyone()	   , "#unknown.title", '#unknown.message', { amount = 1, character_name = 'deadshot' } )
end
--]=]

---@alias ClientId string | number

---@class To
---@private clients ClientId[]

To = { }

---@param clients ClientId[]
---@return To
function To.Multiple( clients )

	local to = setmetatable(
	{
		clients = clients,
	},
	{
		__ipairs = function(self)

			-- Iterator function
			local function stateless_iter(tbl, i)
				-- Implement your own index, value selection logic
				i = i + 1
				local v = tbl[i]
				if v ~= nil then
					return i, v
				end
			end

			-- return iterator function, table, and starting point
			return stateless_iter, self.clients, 0
		end
	})

	return to
end

---@param client ClientId
---@return To
function To.Single( client )
	return To.Multiple( { client } )
end

---@return To
function To.Everyone()
	return To.Multiple( GetPlayers() )
end

---@param to 		To
---@param eventName string
---@vararg ...
function Send( to, eventName, ... )
	local payload = msgpack.pack_args( ... )
	local len = payload:len()

	for _, client in ipairs( to ) do
		TriggerClientEventInternal( eventName, tostring(client), payload, len )
	end
end

