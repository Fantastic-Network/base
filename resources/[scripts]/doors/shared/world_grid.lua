---@type boolean
WORLDGRID_DEBUG = false

WORLD_GRID_ROWS = 256
WORLD_GRID_COLS = 256

WORLD_GRID_CELL_SIZE = 8192

--- TODO: Create table with table.create(WORLD_GRID_CELLS)
---@type WorldGridCell[][]
---@diagnostic disable-next-line: lowercase-global
gWorldGrid = { }

---@param cellX number
---@param cellY number
---@return WorldGridCell
function GetWorldGridCell(cellX, cellY)
	local x = gWorldGrid[cellX]

	assert(x, ('X = %d not found'):format(cellX) )

	local xy = gWorldGrid[cellX][cellY]

	assert(xy, ('X = %d and Y = %d not found'):format(cellX, cellY) )

	return xy
end

---@param position vector3
---@return number, number
function GetWorldGridCellXYFromPosition(position)
	local cellX = math.floor( (position.x + WORLD_GRID_CELL_SIZE) / WORLD_GRID_COLS )
	local cellY = math.floor( (position.y + WORLD_GRID_CELL_SIZE) / WORLD_GRID_ROWS )

	return cellX, cellY
end

---@param position vector3
---@return WorldGridCell
function GetWorldGridCellFromPosition(position)
	local cellX, cellY = GetWorldGridCellXYFromPosition(position)

	return GetWorldGridCell(cellX, cellY)
end

---@param x number
---@param y number
---@return number
function EncodeWorldGridCellXY(x, y)
	return (x << 8) | y
end

---@param encoded number
---@return number, number
function DecodeWorldGridCellXY(encoded)
	local x = encoded >> 8
	local y = encoded & 0xFF

	return x, y
end

function InitWorldGrid()

	for x = 1, WORLD_GRID_COLS do

		gWorldGrid[x] = { }

		for y = 1, WORLD_GRID_ROWS do

			gWorldGrid[x][y] =
			{
				x = x,
				y = y,

				doors = { },
			}
		end
	end
end

CreateThread(function()
    InitWorldGrid()
end)