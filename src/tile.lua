Tile = {}

function Tile:new(x, y)
    -- Add member variables here.
    selfObj = {}
    selfObj.xPos, selfObj.yPos = x, y

    -- Make this into a class.
    self.__index = self
    return setmetatable(selfObj, self)
end

-- Tile pos it top left corner.
function Tile:draw(xMod, yMod)
    love.graphics.setColor(0.75, 0.5, 0.25, 1)
    love.graphics.rectangle("fill", self.xPos + xMod, self.yPos + yMod, 16*4, 16*4)
end

function Tile:update()

end

return Tile
