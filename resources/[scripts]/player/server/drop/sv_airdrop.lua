
local AirdropRPC = { }

Tunnel.bindInterface('airdrop', AirdropRPC)

---@class ServerAirdrop : Airdrop
---@field isOpen        boolean
---@field clientsCooldownUntil table<ClientId, number>
---@field clientOpening ClientId?

---@type AirdropId
local gNextAirdropId = 0

---@param id AirdropId
---@return ServerAirdrop
function GetServerAirdrop( id )
    local airdrop = GetAirdrop( id )

    return airdrop --[[ @as ServerAirdrop ]]
end

---@param position vector3
local function CreateServerAirdrop( position )
    gNextAirdropId += 1

    local id = gNextAirdropId

    local airdrop = AddAirdrop( id, position, GetGameTimer() ) --[[ @as ServerAirdrop ]]

    airdrop.isOpen    = false

    airdrop.clientsCooldownUntil = { }

    UpdateAirdropGlobalState( airdrop )

    UpdateAirdropsGlobalState()

    TriggerClientEvent( "Notify", -1, "airdrop", "Um Airdrop foi lançado e marcado em seu mapa!", 15000, "Lancamento" )
    TriggerClientEvent("rewardsAnimation",-1,"airdrop")
    -- TriggerClientEvent("Notify2",-1,"#airdrop")
end

---@param airdrop Airdrop
local function DeleteServerAirdrop( airdrop )
    RemoveAirdrop( airdrop )

    ClearAirdropGlobalState( airdrop.id )

    UpdateAirdropsGlobalState()
end

---@param airdrop ServerAirdrop
function SetServerAirdropAsOpening( airdrop, isOpening )
    airdrop.isOpening = isOpening

    UpdateAirdropIsOpeningGlobalState( airdrop )
end

---@param airdrop ServerAirdrop
---@return boolean
local function CanOpenServerAirdropFromPosition( airdrop, position )
    local airdropCurrentPos = GetCurrentAirdropPosition( airdrop, GetGameTimer() )

    if #(airdropCurrentPos - position ) > AIRDROP_OPEN_MAX_DISTANCE then
        return false
    end

    return true
end

---@param source ClientId
---@param airdrop ServerAirdrop
---@return boolean
local function CanOpenServerAirdrop( source, airdrop )
    local Bucket = GetPlayerRoutingBucket(source)
    if airdrop.isOpening then
        return false
    end

    if airdrop.isOpen then
        return false
    end

    if Bucket ~= 1 then
        return
    end

    if airdrop.clientsCooldownUntil[source] then
        local remainingCooldown = airdrop.clientsCooldownUntil[source] - GetGameTimer()

        if remainingCooldown > 0 then

            TriggerClientEvent("Notify", source, "negado", ("Aguarde %.0f segundos para abrir esse airdrop!"):format( remainingCooldown / 1000 ), 5000, "Aguarde")
            -- TriggerClientEvent("Notify2",source,"#thisAirdrop",{msg=format( remainingCooldown / 1000 )})

            return false
        end

        airdrop.clientsCooldownUntil[source] = nil
    end

    if not CanOpenServerAirdropFromPosition( airdrop, GetEntityCoords( GetPlayerPed(source) ) ) then
        return false
    end

    return true
end

---@param airdrop ServerAirdrop
local function StopOpeningServerAirdrop( airdrop )
    local clientOpening in airdrop

    assert(clientOpening)

    SetServerAirdropAsOpening( airdrop, false )

    airdrop.isOpen    = false

    airdrop.clientOpening = nil

    Player(clientOpening)["state"]["Buttons"] = false
    Player(clientOpening)["state"]["Cancel"]  = false

    TriggerClientEvent('Airdrop:StoppedOpening', clientOpening)
end

---@param airdrop ServerAirdrop
local function SuccededOpeningServerAirdrop( airdrop )
    local clientOpening in airdrop

    assert(clientOpening)

    TriggerClientEvent("Notify",-1, "airdrop", "O Airdrop foi aberto!", 5000, "Aberto")
    -- TriggerClientEvent("Notify2",-1,"#airdropOpened")

    local passport = vRP.Passport( clientOpening )

    for _, item in ipairs( Items ) do
        vRP.GenerateItem( passport, item["Item"], item["Amount"], true )
    end

    StopOpeningServerAirdrop( airdrop )

    DeleteServerAirdrop( airdrop )
end

---@param airdrop ServerAirdrop
---@param reason string?
local function FailedOpeningServerAirdrop( airdrop, reason )
    local clientOpening in airdrop

    assert(clientOpening)

    airdrop.clientsCooldownUntil[clientOpening] = GetGameTimer() + (AIRDROP_OPEN_COOLDOWN_DURATION * 1000)

    TriggerClientEvent("Progress", clientOpening, "Cancelando",0)

    -- print( 'Failed opening airdrop, reason:', reason )

    StopOpeningServerAirdrop( airdrop )
end

---@param airdrop ServerAirdrop
---@param opensAt number
---@return true | nil
local function TickOpenAirdrop( airdrop, opensAt )
    Wait(500)

    if not HasAirdrop( airdrop.id ) then
        return FailedOpeningServerAirdrop( airdrop, 'Airdrop is no longer valid!' )
    end

    --[[ Cancelado por motivos externos? provavelmente o player cancelou manualmente ]]
    if not airdrop.isOpening then
        return
    end

    local clientOpening in airdrop

    assert(clientOpening)
    
    local clientOpeningPedId = GetPlayerPed(clientOpening)

    if GetEntityHealth(clientOpeningPedId) <= 100 then
        return FailedOpeningServerAirdrop( airdrop, 'player is dead' )
    end

    if not CanOpenServerAirdropFromPosition( airdrop, GetEntityCoords( clientOpeningPedId ) ) then
        return FailedOpeningServerAirdrop( airdrop, 'too far' )
    end

    if GetGameTimer() >= opensAt then
        return SuccededOpeningServerAirdrop( airdrop )
    end

    return true
end

---@param source ClientId
---@param airdropId AirdropId
local function OpenServerAirdrop( source, airdropId )
    local airdrop = GetServerAirdrop( airdropId )

    if not CanOpenServerAirdrop( source, airdrop ) then
        return false
    end

    SetServerAirdropAsOpening( airdrop, true )

    airdrop.clientOpening = source

    TriggerClientEvent("Notify", -1, "airdrop", "O Airdrop está sendo aberto!", 5000, "Abrindo")
    -- TriggerClientEvent("Notify2",-1,"#airdropOpening")

    Player(source)["state"]["Buttons"] = true
    Player(source)["state"]["Cancel"]  = true

    local opensAt = GetGameTimer() + (AIRDROP_OPEN_DURATION * 1000)

    CreateThread(function ()
        while TickOpenAirdrop( airdrop, opensAt ) do
        end
    end)

    return true
end

---@param airdropId AirdropId
function AirdropRPC.OpenServerAirdrop( airdropId )
    return OpenServerAirdrop( source, airdropId )
end

RegisterNetEvent('Airdrop:StopOpening', function( airdropId )
    local source = source

    local airdrop = GetServerAirdrop( airdropId )

    if airdrop.clientOpening ~= source then
        return
    end

    FailedOpeningServerAirdrop( airdrop, 'canceled by player' )
end)


RegisterCommand("airdrop",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
            CreateServerAirdrop( GetEntityCoords( GetPlayerPed(source) ) - vector3(0.0, 0.0, 0.99) )
        end
    end
end)
cityName = GetConvar("cityName", "Base")

CreateThread(function()
    if GlobalState["RemoveAirDrop"] then
        return
    end
    while true do
        Wait(1000 * 60 * 30) -- Wait for 30 minutes
        local currentTime = os.date("*t")
        
        if currentTime.hour >= 18 and currentTime.hour < 24 then
            local Random = math.random(1, #AirDropSpawns)
            for i = 1, #AirDropSpawns do
                if i == Random then
                    for j=1,#AirDropSpawns[i] do
                        CreateServerAirdrop(AirDropSpawns[i][j] - vector3(0.0, 0.0, 0.99))
                    end
                end
            end
        end
        
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    for _, airdrop in ipairs( GetAirdrops() ) do
        DeleteServerAirdrop(airdrop)
    end
end)