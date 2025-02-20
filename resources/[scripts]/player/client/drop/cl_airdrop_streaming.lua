local AIRDROP_STREAMING_DISTANCE = 200.0

local AIRDROP_STREAMING_MODEL = `p_secret_weapon_02`
local AIRDROP_STREAMING_MODEL_PARACHUTE = `p_parachute1_mp_dec`

local AIRDROP_STREAMING_PTFX_DICT = 'core'
local AIRDROP_STREAMING_PTFX_NAME = 'exp_grd_flare'

local AIRDROP_STREAMING_PARACHUTE_OFFSET = vector3(0.0, 0.0, 4.0)

---[[ Habilia o uso do paraquedas com fisica, porém nao funciona em network! porque o paraquedas é sincronizado para todo os jogadores ]]
local AIRDROP_STREAMING_USE_PHYSICS_PARACHUTE = false

if AIRDROP_STREAMING_USE_PHYSICS_PARACHUTE then
    AIRDROP_STREAMING_MODEL_PARACHUTE = `ruiner2`

    AIRDROP_STREAMING_PARACHUTE_OFFSET = vector3(0.0, 0.5, 1.0)
end

---@class AirdropStreamedInState
---@field airdropId         AirdropId
---@field loaded            boolean
---@field loadedParachute   boolean
---@field entityId          number?
---@field entityIdParachute number?
---@field entityIdParachuteDummy number?
---@field particleFxId      number?

---@type table<AirdropId, AirdropStreamedInState>
local gAirdropsStreamedInState = { }

---@param entityId number
---@return AirdropStreamedInState
function GetAirdropStreamedInStateFromEntity( entityId )
    for _, state in each( gAirdropsStreamedInState ) do
        if state.entityId == entityId then
            return state
        end
    end

    error( ('AirdropStreamedInState with entityId=%d not found!'):format(entityId) )
end

---@param airdrop Airdrop
---@return AirdropStreamedInState | nil
function GetAirdropStreamedInState(airdrop)
    return gAirdropsStreamedInState[airdrop.id]
end

---@param airdrop Airdrop
---@return boolean
function CanAirdropBeStreamedIn(airdrop, focusPos)

    if #(airdrop.positionEnd.xy - focusPos.xy) > AIRDROP_STREAMING_DISTANCE then
        return false
    end

    return true
end

---@return boolean
function StartAirdropStreamIn(airdrop)

    local state = GetAirdropStreamedInState(airdrop)

    --[[ Ainda está carregando os modelos do airdrop! ]]
    if state then
        return true
    end

    gAirdropsStreamedInState[airdrop.id] =
    {
        airdropId = airdrop.id,

        loaded = false,

        loadedParachute = false,

        entityId = nil,

        entityIdParachute = nil,

        entityIdParachuteDummy = nil,

        particleFxId = nil,
    }

    -- print( ('Airdrop with id=%d has started streaming in in!'):format( airdrop.id ) )

    return true
end

---@return boolean
function StopAirdropStreamIn(airdrop)

    local state = GetAirdropStreamedInState(airdrop)

    if not state then
        return true
    end

    if state.loaded then
        DeleteEntity(state.entityId)

        if state.entityIdParachute then
            DeleteEntity(state.entityIdParachute)
        end

        if state.entityIdParachuteDummy then
            DeleteEntity(state.entityIdParachuteDummy)
        end

        if state.particleFxId then
            StopParticleFxLooped(state.particleFxId, false)
        end
    end

    gAirdropsStreamedInState[airdrop.id] = nil

    -- print( ('Airdrop with id=%d has stopped streaming in!'):format( airdrop.id ) )

    return true
end

---@param airdrop       Airdrop
---@param networkTime   number
---@return number | nil
function UpdateStreamedInAirdrop( airdrop, networkTime )
    local state = GetAirdropStreamedInState( airdrop )

    assert(state)

    local positionCurrent, interp = GetCurrentAirdropPosition( airdrop, networkTime )

    local hasReachedEnd = interp >= 1.0

    if not state.loaded then

        RequestModel(AIRDROP_STREAMING_MODEL)
        RequestModel(AIRDROP_STREAMING_MODEL_PARACHUTE)

        RequestNamedPtfxAsset(AIRDROP_STREAMING_PTFX_DICT)

        if not HasModelLoaded(AIRDROP_STREAMING_MODEL) then
            return
        end
        
        if not HasModelLoaded(AIRDROP_STREAMING_MODEL_PARACHUTE) then
            return
        end

        if not HasNamedPtfxAssetLoaded(AIRDROP_STREAMING_PTFX_DICT) then
            return
        end

        local entityId          = CreateObject(AIRDROP_STREAMING_MODEL          , positionCurrent.x, positionCurrent.y, positionCurrent.z, false, true, false)

if AIRDROP_STREAMING_USE_PHYSICS_PARACHUTE then
        SetEntityVisible(entityId              , false, false)
end

        state.entityId               = entityId

        if not hasReachedEnd then
            local entityIdParachute
            local entityIdParachuteDummy

            
if AIRDROP_STREAMING_USE_PHYSICS_PARACHUTE then
            entityIdParachute =
                -- CreatePed(0, GetEntityModel(PlayerPedId()), positionCurrent.x, positionCurrent.y, positionCurrent.z + 5.0, 0.0, false, true)
                CreateVehicle(AIRDROP_STREAMING_MODEL_PARACHUTE, positionCurrent.x, positionCurrent.y, positionCurrent.z + 4.0 --[[ Tem que ser criado mais alto se nao o paraquedas nao abre! ]], 0.0, false, true)
else
            entityIdParachute = CreateObject(AIRDROP_STREAMING_MODEL_PARACHUTE, positionCurrent.x, positionCurrent.y, positionCurrent.z, false, true, false)
end

if AIRDROP_STREAMING_USE_PHYSICS_PARACHUTE then
            entityIdParachuteDummy = CreatePed(0, GetEntityModel(PlayerPedId()), positionCurrent.x, positionCurrent.y, positionCurrent.z, 0.0, false, true)
end

            UseParticleFxAsset(AIRDROP_STREAMING_PTFX_DICT)
            local particleFxId =  StartParticleFxLoopedAtCoord(AIRDROP_STREAMING_PTFX_NAME, airdrop.positionEnd.x, airdrop.positionEnd.y, airdrop.positionEnd.z, 0.0, 0.0, 0.0, 2.3, false, false, false, false)

if AIRDROP_STREAMING_USE_PHYSICS_PARACHUTE then
            SetPedIntoVehicle(entityIdParachuteDummy, entityIdParachute, -1)

            SetEntityVisible(entityIdParachute     , false, false)
            SetEntityVisible(entityIdParachuteDummy, false, false)

            SetEntityCompletelyDisableCollision(entityIdParachute     , false, false)
            SetEntityCompletelyDisableCollision(entityIdParachuteDummy, false, false)

            SetEntityInvincible(entityIdParachute     , true)
            SetEntityInvincible(entityIdParachuteDummy, true)
end
            state.entityIdParachute      = entityIdParachute
            state.entityIdParachuteDummy = entityIdParachuteDummy

            state.particleFxId = particleFxId
        end

        SetModelAsNoLongerNeeded(AIRDROP_STREAMING_MODEL)
        SetModelAsNoLongerNeeded(AIRDROP_STREAMING_MODEL_PARACHUTE)

        RemoveNamedPtfxAsset(AIRDROP_STREAMING_PTFX_DICT)

        state.loaded = true
    end

    if not state.loadedParachute then

        local entityId, entityIdParachute in state

        if entityIdParachute then

            assert(entityId)
            assert(entityIdParachute)

if AIRDROP_STREAMING_USE_PHYSICS_PARACHUTE then

            SetVehicleParachuteActive(entityIdParachute, true)

            if not IsVehicleParachuteActive(entityIdParachute) then
                return
            end

            --[[
            local parachuteState = GetPedParachuteState(entityIdParachute)

            ForcePedToOpenParachute(entityIdParachute)

            if parachuteState < 0 then
                TaskParachute(entityIdParachute, false)
            end

            if parachuteState ~= 2 then
                return
            end
            --]]

            SetEntityVisible(entityId, true, false)
end

            AttachEntityToEntity(entityIdParachute, entityId, 0, AIRDROP_STREAMING_PARACHUTE_OFFSET.x, AIRDROP_STREAMING_PARACHUTE_OFFSET.y, AIRDROP_STREAMING_PARACHUTE_OFFSET.z, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        end

        state.loadedParachute = true
    end

    --[[ O airdrop encostou no chao, vamos deletar as entidades! ]]
    if hasReachedEnd then

        if state.entityIdParachute then
            state.entityIdParachute = DeleteEntity(state.entityIdParachute)
        end

        if state.entityIdParachuteDummy then
            state.entityIdParachuteDummy = DeleteEntity(state.entityIdParachuteDummy)
        end

        --[[
        if state.particleFxId then
            state.particleFxId = StopParticleFxLooped(state.particleFxId, false)
        end
        --]]
    end

    SetEntityCoords(state.entityId, positionCurrent.x, positionCurrent.y, positionCurrent.z, false, false, false, false)

    return state.entityId
end