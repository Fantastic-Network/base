---@class ServerWorldGridCell : WorldGridCell
---@field lastUpdtDoorsState number
---@field players number[]

---@class PlayerWorldGridCellState
---@field x                     number
---@field y                     number
---@field isCurrent             boolean
---@field lastRecvDoorsState    number?

---@type table<unknown, PlayerWorldGridCellState[]>
local gPlayersWorldGridCellStates = { }

---@param cell ServerWorldGridCell
local function InitializeServerWorldGridCell(cell)
    --[[ TODO: Inicializar esses estados em outro local, provavelmente na criação da celula ]]
    do
        if not cell.lastUpdtDoorsState then
            cell.lastUpdtDoorsState = GetGameTimer()
        end

        if not cell.players then
            cell.players = { }
        end
    end
end

---@param cellX number
---@param cellY number
---@return ServerWorldGridCell
function GetServerWorldGridCell(cellX, cellY)
    local cell = GetWorldGridCell(cellX, cellY) --[[ @as ServerWorldGridCell ]]

    --[[ TODO: Inicializar esses estados em outro local, provavelmente na criação da celula ]]
    InitializeServerWorldGridCell(cell)

    return cell
end

---@param position vector3
---@return ServerWorldGridCell
function GetServerWorldGridCellFromPosition(position)
    local cell = GetWorldGridCellFromPosition(position)  --[[ @as ServerWorldGridCell ]]

    --[[ TODO: Inicializar esses estados em outro local, provavelmente na criação da celula ]]
    InitializeServerWorldGridCell(cell)

    return cell
end

---@param cell ServerWorldGridCell
---@param source unknown
function SendServerWorldGridCell(cell, source)
    --[[ NOTHING FOR NOW! ]]

    --[[ Outros scripts que queiram saber quando uma celular se tornou relevante para um jogador ]]
    TriggerEvent('sentWorldGridCell', cell.x, cell.y, source)
end

--[[
---@param source unknown
function GetPlayerWorldGridCellCoords(source)
    local encoded = gPlayersWorldGridCellStates[source]

    assert(encoded, ('No grid state found for client'):format(source) )

    local cellX, cellY = DecodeWorldGridCellXY(encoded)

    return cellX, cellY
end
--]]

function GetPlayerWorldGridCellState(source, cellX, cellY)
    local states = gPlayersWorldGridCellStates[source]

    for _, entry in ipairs(states) do
        if entry.x == cellX and entry.y == cellY then
            return entry
        end
    end

    error( ('source=%s cellX=%d cellY=%d state not found. states dump = \n%s'):format(source, cellX, cellY, json.encode(states, { indent = true })) )
end

local function OnClientEnteredWorldGridCell()
    local source = source

    --[[ As worldgrid só funcionam na dimensão 1 (global) ]]
    -- if GetPlayerRoutingBucket(source) ~= 1 then
    --     return
    -- end

if WORLDGRID_DEBUG then
    print( ('ClientEnteredWorldGridCell source=%s'):format(source) )
end

    local playerPed = GetPlayerPed(source)

    if not DoesEntityExist(playerPed) then
        return
    end

    -- assert( DoesEntityExist(playerPed), ('Entity=%s of Player=%s does not exist'):format(playerPed, source) )

    local playerPos = GetEntityCoords(playerPed)
    
    local wishCellX, wishCellY = GetWorldGridCellXYFromPosition(playerPos)
    local wishCell = GetServerWorldGridCell(wishCellX, wishCellY)

    -- local currCellX, currCellY = GetPlayerWorldGridCellCoords(source)

    -- if (wishCellX == currCellX) and (wishCellY == currCellY ) then
    --     return --[[ Não mudou nada ]]
    -- end

    --[[ Distancia minima e máxima das celulas para que elas sejam relevantes para o jogador! ]]
    local minCellX = math.floor(math.max((playerPos.x - 199.0) + WORLD_GRID_CELL_SIZE, 0.0) / WORLD_GRID_COLS)
	local maxCellX = math.floor(math.max((playerPos.x + 199.0) + WORLD_GRID_CELL_SIZE, 0.0) / WORLD_GRID_COLS)
	local minCellY = math.floor(math.max((playerPos.y - 199.0) + WORLD_GRID_CELL_SIZE, 0.0) / WORLD_GRID_ROWS)
	local maxCellY = math.floor(math.max((playerPos.y + 199.0) + WORLD_GRID_CELL_SIZE, 0.0) / WORLD_GRID_ROWS)

if WORLDGRID_DEBUG then
    print( ('ClientEnteredWorldGridCell source=%s cellX(min=%d max=%d) cellY(min=%d max=%d)'):format(source, minCellX, maxCellX, minCellY, maxCellY) )
end

    --[[ Celulas que são relevantes para gente, celula atual e próximas! ]]
    local states = gPlayersWorldGridCellStates[source]

    if not states then
        --[[ O player não tinha nenhuma grid relevante, vamos adicionar popular com o id dele! ]]

        states = { }

        gPlayersWorldGridCellStates[source] = states
    end

    if states then

        for entryIdx, entry in ipairs( states ) do

            local cell = GetServerWorldGridCell(entry.x, entry.y)

            --[[ Saber se essa celula é a celula atual do jogador ]]
            --[[ TOOD: Melhorar essa lógica ]]
            for idx, player in ipairs(cell.players) do
                if player == source then

                    table.remove(cell.players, idx)

                    break
                end
            end

            --[[ Não é mais o estado atual, já que a gente vai adicionar um novo! ]]
            entry.isCurrent = false

            --[[ Essa celula esta proxima e é relevante para a gente? ]]
            if (entry.x < minCellX or entry.x > maxCellX or
                entry.y < minCellY or entry.y > maxCellY)
            then
                --[[ Essa celula nao é mais relevante para a gente ]]

                --[[ O estado dessa celula não é mais relevante para esse jogador! ]]
                table.remove(states, entryIdx)

if WORLDGRID_DEBUG then
                print( ('ClientEnteredWorldGridCell source=%s -> removed from cell x=%d y=%d'):format(source, entry.x, entry.y) )
end
            else
                --[[ Essa celula continua relevante! ]]

                --[[ Essa celula é a mesma em que o jogador está tentando entrar? ]]
                if entry.x == wishCellX and entry.y == wishCellY then

                    --[[ Essa celula é duplicada, vamos remover-lá para adiciona-lá novamente! ]]
                    table.remove(states, entryIdx)
                end
            end
        end
    end

    ---@type PlayerWorldGridCellState
    local wishState =
    {
        x = wishCellX,
        y = wishCellY,

        isCurrent = true,

        --[[ Ainda não recebendos os estados das portas dessa grid, vamos deixar como nullo! ]]
        lastRecvDoorsState = nil,
    }

    --[[ Agora o estado dessa celular é relevante para essa jogador ]]
    table.insert(states, wishState)

if WORLDGRID_DEBUG then
        print( ('ClientEnteredWorldGridCell source=%s -> added to wish cell x=%d y=%d'):format(source, wishCellX, wishCellY) )
end

    --[[ A celula precisa saber quais clients são relevantes para ela ]]
    table.insert(wishCell.players, source)

    --[[ A gente manda um update mesmo que seja duplicado ]]
    SendServerWorldGridCell(wishCell, source)

    --[[
        assert(  (wishCellX == cellX) and (wishCellY == cellY ) )
    --]]

if WORLDGRID_DEBUG then
    -- print( ('ClientEnteredWorldGridCell source=%s -> states dump = %s'):format(source, json.encode(states, { indent = true }) ) )

    for _, entry in ipairs( states ) do

        print( ('ClientEnteredWorldGridCell source=%s -> state x=%d y=%d entry dump = %s'):format(source, entry.x, entry.y, json.encode(entry, { indent = true }) ) )

        local cell = GetServerWorldGridCell(entry.x, entry.y)

        print( ('ClientEnteredWorldGridCell source=%s -> state x=%d y=%d dump = %s'):format(source, entry.x, entry.y, json.encode(cell, { indent = true }) ) )
    end
end

end

RegisterNetEvent('enteredWorldGridCell', OnClientEnteredWorldGridCell)

--[[ TODO: player dropped! remove states ]]
AddEventHandler('playerDropped', function()
    local source = source

    local states = gPlayersWorldGridCellStates[source]

    if not states then
        return
    end

    for _, entry in ipairs( states ) do
    
        local cell = GetServerWorldGridCell(entry.x, entry.y)
        
        for idx, player in ipairs(cell.players) do
            if player == source then

                table.remove(cell.players, idx)

                break
            end
        end
    end

    gPlayersWorldGridCellStates[source] = nil
end)