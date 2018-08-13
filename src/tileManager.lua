local TileManager = {}  -- This is a Module

TILE_SIZE = 24*4

TileManager.tileList = {}

function TileManager.draw()
    for k, tile in pairs(TileManager.tileList) do
        tile:draw( scene.getExactX(), scene.getExactY() )
    end
end

function TileManager.update()

end

-- x, y are real positions. (enemy position values)
function TileManager.createTile(x, y)
    local xIndex = math.floor(x / TILE_SIZE)
    local yIndex = math.floor(y / TILE_SIZE)

    table.insert(TileManager.tileList, tile:new(xIndex, yIndex))
end

-- x, y are real positions. (enemy position values)
function TileManager.removeTile(x, y)
    local xIndex = math.floor(x / TILE_SIZE)
    local yIndex = math.floor(y / TILE_SIZE)

    local remKey = -1

    for k, tile in pairs(TileManager.tileList) do
        if tile.xIndex == xIndex and tile.yIndex == yIndex then
            remKey = k  --Find matching tile key.
            break
        end
    end

    -- Remove tile.
    if remKey ~= -1 then
        table.remove(TileManager.tileList, remKey)
    end
end

-- x, y are real positions. (enemy position values)
function TileManager.isTile(x, y)
    local xIndex = math.floor(x / TILE_SIZE)
    local yIndex = math.floor(y / TILE_SIZE)

    if x >= SCREEN_SIZE.x*3 or x <= 0 or y >= SCREEN_SIZE.y*3 or y <= 0 then
        return true  -- Case: outside of tile range.
    end

    for k, tile in pairs(TileManager.tileList) do
        if tile.xIndex == xIndex and tile.yIndex == yIndex then
            return true
        end
    end

    return false  -- Case: no tiles are x,y.
end

return TileManager
