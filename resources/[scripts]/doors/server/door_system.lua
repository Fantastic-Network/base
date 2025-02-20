
---@param door Door
---@param source unknown
local function SendDoor(door, source)
    ---@type DoorState
    local state = door.lockState

    TriggerClientEvent('doorState', source, door.id, state)

if DOORSYSTEM_DEBUG then
    print( ('Sent door=%d to source=%s, state=%s'):format(door.id, source, state) )
end

end

---@param doors Door[]
---@param source unknown
local function SendDoors(doors, source)
    ---@type table<DoorId, DoorState>
    local data = { }

    for _, door in ipairs(doors) do
        data[door.id] = door.lockState
    end

    TriggerClientEvent('doorsState', source, data)

if DOORSYSTEM_DEBUG then
    print( ('Sent multiple door to source=%s, data=%s'):format(source, json.encode(data)) )
end

end

---@param door Door
---@param lockState DoorLockState
function OnSetDoorLockState(door, lockState)

if DOORSYSTEM_DEBUG then
    print( ('OnSetDoorLockState door=%d lockState=%s'):format(door.id, lockState) )
end

    local cell = GetServerWorldGridCellFromPosition(door.position)

    --[[ Vamos salvar o momento em que a gente fez o ultimo update de qualquer porta dessa celula! ]]
    cell.lastUpdtDoorsState = GetGameTimer()

    for _, source in ipairs(cell.players) do
        xpcall(
            function ()
                local cellState = GetPlayerWorldGridCellState(source, cell.x, cell.y)

                SendDoor(door, source)
        
                --[[ Salvar o ultimo momento em que o jogador recebeu um update das portas nessa celula ]]
                cellState.lastRecvDoorsState = GetGameTimer()
            end,
            function(err)
                print( ('^1Ocorreu um error ao enviar as informaçoes da porta com id=%d e lockState=%s.\n\t%s^7'):format(door.id, lockState, err) )
            end
        )
    end
end

---@param cellX number
---@param cellY number
---@param source unknown
local function OnSentWorldGridCell(cellX, cellY, source)
if DOORSYSTEM_DEBUG then
    print( ('OnSentWorldGridCell cellX=%d cellY=%d source=%s'):format(cellX, cellY, source) )
end

    local cell = GetServerWorldGridCell(cellX, cellY)

    --[[ Não existe nenhuma porta nessa celula, skip! ]]
    if #cell.doors <= 0 then

if DOORSYSTEM_DEBUG then
        print( ('OnSentWorldGridCell cellX=%d cellY=%d source=%s -> no doors at cell, skipping!'):format(cellX, cellY, source) )
end

        return
    end

    local state = GetPlayerWorldGridCellState(source, cellX, cellY)

    local lastRecvDoorsState in state

    --[[ O jogaodres já tem todos os ultimos updates, não precisamos mandar de novo! ]]
    if lastRecvDoorsState and (lastRecvDoorsState >= cell.lastUpdtDoorsState) then

if DOORSYSTEM_DEBUG then
        print( ('OnSentWorldGridCell cellX=%d cellY=%d source=%s -> player has latest updates, skipping!'):format(cellX, cellY, source) )
end

        return
    end

    SendDoors(cell.doors, source)
    
    --[[ Salvar o ultimo momento em que o jogador recebeu um update das portas nessa celula ]]
    state.lastRecvDoorsState = GetGameTimer()
end

AddEventHandler('sentWorldGridCell', OnSentWorldGridCell)

---@param source unknown
---@param door Door
local function CanClientToggleDoorLockState(source, door)
    local passport = vRP.Passport(source)
	
    if door.authorizedGroup and not vRP.HasGroup(passport, door.authorizedGroup) then
        return false
    end

    return true
end

---@param doorId DoorId
function OnClientToggleDoorLockState(doorId)
    local source = source

    local door = GetDoorById(doorId)

    if not CanClientToggleDoorLockState(source, door) then
        return
    end

    --[[ TODO: Adicionar verificação de distancia entre o jogador e a porta! ]]

    SetDoorLockState(door, not door.lockState)
end

RegisterNetEvent('toggleDoorLockState', OnClientToggleDoorLockState)