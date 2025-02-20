---@alias AirdropId number

---@class NetworkAirdrop
---@field positionEnd   vector3
---@field timeCreated   number

---@class Airdrop : NetworkAirdrop
---@field id            AirdropId
---@field positionStart vector3
---@field timeEnds      number
---@field isOpening     boolean

-- m/s
AIRDROP_FALL_SPEED  = 2.5 -- (A cada 1 segundos, ele vai descer 10 metros/unidades)
--
AIRDROP_FALL_HEIGHT = 650.0

-- m
AIRDROP_OPEN_MAX_DISTANCE = 5.0
-- seconds
AIRDROP_OPEN_COOLDOWN_DURATION = 30
-- seconds
AIRDROP_OPEN_DURATION = 120

--- [ positionEnd: vector3, timeCreated: number ]
---@alias PackedNetworkAirdrop { [1]: vector3, [2]: number }

local gAirdrops = { }

---@return Airdrop[]
function GetAirdrops()
    return gAirdrops
end

---@param id AirdropId
---@return boolean
function HasAirdrop( id )
    for _, airdrop in ipairs( GetAirdrops() ) do
        if airdrop.id == id then
            return true
        end
    end

    return false
end

---@param id AirdropId
---@return Airdrop, number
function GetAirdrop( id )
    for idx, airdrop in ipairs( GetAirdrops() ) do
        if airdrop.id == id then
            return airdrop, idx
        end
    end

    error( ('Airdrop with id=%d not found!'):format( id ) )
end

---@param id            number
---@param positionEnd   vector3
---@param createdAt     number
---@param isOpening     boolean?
---@return Airdrop
function AddAirdrop( id, positionEnd , createdAt, isOpening)
    local positionStart = positionEnd + vector3(0.0, 0.0, AIRDROP_FALL_HEIGHT)

    local distanceToEnd = #(positionStart - positionEnd)

    /* duração da queda em segundos */
    local fallDuration = distanceToEnd / AIRDROP_FALL_SPEED

    ---@type Airdrop
    local airdrop =
    {
        id = id,

        positionStart = positionEnd + vector3(0.0, 0.0, AIRDROP_FALL_HEIGHT),
        positionEnd   = positionEnd,

        timeCreated = createdAt,
        timeEnds    = createdAt + (fallDuration * 1000),

        isOpening = isOpening or false,
    }

    table.insert( gAirdrops, airdrop )

    -- print( ('Airdrop added! id=%d positionEnd=%s'):format( id, positionEnd ) )

    return airdrop
end

---@param airdrop Airdrop
function RemoveAirdrop(airdrop)
    local airdropId = airdrop.id

    local _, airdropIdx = GetAirdrop( airdropId )

    table.remove( GetAirdrops(), airdropIdx )

    -- print( ('Airdrop removed! id=%d'):format( airdropId ) )
end

---@param airdrop       Airdrop
---@param networkTime   number
---@return vector3, number
function GetCurrentAirdropPosition( airdrop, networkTime )

    local timeCreated, timeEnds, positionStart, positionEnd in airdrop

    local interp = clamp( ( networkTime - timeCreated ) / ( timeEnds - timeCreated ), 0.0, 1.0 )

    local z = lerp( positionStart.z, positionEnd.z, interp )

    local positionCurrent = vector3( positionStart.x, positionStart.y, z )

    return positionCurrent, interp
end

function clamp(number, min, max)
    return math.min(math.max(number, min), max)
end

function lerp(a, b, t)
    return (1 - t) * a + t * b
end


AirDropSpawns = {
    {
        vector3(486.84,-304.31,46.42),
        vector3(460.05,-325.42,47.31),
        vector3(454.8,-304.08,48.24),
    },
    {
        vector3(2404.91,3106.28,48.19),
        vector3(2380.04,3073.26,48.14),
        vector3(2342.02,3095.4,48.06),
    },
    {
        vector3(1459.23,3124.16,40.5),
        vector3(1177.89,3049.15,40.44),
        vector3(1037.41,3088.4,41.9),
    },
    {
        vector3(2371.22,2955.39,49.18),
        vector3(2445.84,2862.0,49.07),
        vector3(2410.03,2908.46,49.34),
    },
}