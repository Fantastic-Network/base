---@type boolean
DOORSYSTEM_DEBUG = false

local IS_CLIENT = GetGameName() ~= 'fxserver'

--[[
---@type Door[]
local gDoors = { }
--]]

local gNumDoors = 0

---@type table<DoorId, Door>
local gDoorsById = setmetatable({ }, { __mode = 'v' --[[ weak values ]] })

--[[
---@type table<DoorId, boolean>
local gLockedDoors = { }

---@type table<DoorId, boolean>
local gUnlockedDoors = { }
--]]

---@param doorId DoorId
---@return Door
function GetDoorById(doorId)
	local door = gDoorsById[doorId]

	assert(door, ('Door not found with doorId=%s'):format(doorId) )

	return door
end

function GetNumDoors()
	return gNumDoors
end

---@param door Door
---@param lockState DoorLockState
function SetDoorLockState(door, lockState)
	door.lockState = lockState

	OnSetDoorLockState(door, lockState)

	-- gLockedDoors[doorId]   = lockState 	   and true or nil

	-- gUnlockedDoors[doorId] = not lockState and true or nil
end

---@param doorId 			DoorId
---@param archetype DoorArchetype
local function RegisterDoor(doorId, archetype)

	local modelHashKey 	   = archetype.Hash
	local position 		   = archetype.Coords
	local interactionDist  = archetype.Distance
	local defaultLockState = archetype.Lock
	local authorizedGroup  = archetype.Perm

    gNumDoors = gNumDoors + 1

	local index = gNumDoors

	local doorHash = doorId -- GetHashKey( ('CUS_DOOR_%d'):format(doorId) )

	--[[ TODO: Mover para o client! ]]
if IS_CLIENT then
	-- assert( not IsDoorRegisteredWithSystem(doorHash), ('Duplicate door with doorId=%s and doorHash=%d. You can safely ignore this error if the script is being restarted'):format(doorId, doorHash) )

	-- if IsDoorRegisteredWithSystem(doorHash) then
	-- 	RemoveDoorFromSystem(doorHash)
	-- end

	AddDoorToSystem(doorHash, modelHashKey, position.x, position.y, position.z, false --[[ useOldOverrides ]], false --[[ network ]], false --[[ permanent ]])
end

	---@type Door
	local door =
	{
		id = doorId,

		index = index,

		hash = doorHash,

		position = position,

		lockState = true,

		interactionDist = interactionDist or 1.5,

		authorizedGroup = authorizedGroup,
	}

	-- gDoors[index] = door

	gDoorsById[doorId] = door

	--[[ TODO: Mover para outra função separada (AddWorldGridCellDoor) ]]
	do
		local cellX, cellY = GetWorldGridCellXYFromPosition(position)

		local worldGridCell = GetWorldGridCell(cellX, cellY)

		table.insert(worldGridCell.doors, door)

		-- if #worldGridCell.doors <= 10 then
		if cellX == 38 and cellY == 42 then
			print( ('new door cellX=%d cellY=%d numDoors=%d'):format(cellX, cellY, #worldGridCell.doors) )
		end
	end

	--[[ Inicializar o estado inicial da porta ]]
	SetDoorLockState(door,  defaultLockState )
end

local function RegisterAllConfigDoors()
	local DoorsConfig = exports["variables"]:GetDoors()

	assert(DoorsConfig)

	for id, entry in pairs(DoorsConfig) do
		xpcall(
			function ()
				RegisterDoor(id, entry)
			end,
			function(err)
				print( ('An error occurred while registering a Door, doorId=%d. %s'):format(id, err) )
			end
		)
	end

	DoorsConfig = nil
end

CreateThread(function()
    RegisterAllConfigDoors()
end)