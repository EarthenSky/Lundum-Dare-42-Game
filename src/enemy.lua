Enemy = {}

local _speed = 100  -- 1/3 player speed

-- Randomizes start position.
function initPosition()
    side = love.math.random(0, 3)

    if side == 0 then
        return -64, util.round(love.math.random(0, SCREEN_SIZE.x*3)/4)*4
    elseif side == 1 then
        return SCREEN_SIZE.x*3+64, util.round(love.math.random(0, SCREEN_SIZE.x*3)/4)*4
    elseif side == 2 then
        return util.round(love.math.random(0, SCREEN_SIZE.y*3)/4)*4, -64
    elseif side == 3 then
        return util.round(love.math.random(0, SCREEN_SIZE.y*3)/4)*4, SCREEN_SIZE.y*3+64
    end
end

function Enemy:new()
    -- Add member variables here.
    selfObj = {}
    selfObj.xPos, selfObj.yPos = initPosition()
    selfObj.isDead = false
    selfObj.isFast = false

    -- Make this into a class.
    self.__index = self
    return setmetatable(selfObj, self)
end

-- Enemy is moved from its center.
function Enemy:draw(xMod, yMod)
    if selfObj.isFast == true then
        love.graphics.setColor(0, 0.75, 0, 1)
    else
        love.graphics.setColor(0.5, 0.25, 0.75, 1)
    end

    love.graphics.draw(enemyImg, util.round(self.xPos/4)*4 + xMod, util.round(self.yPos/4)*4 + yMod, 0, 1, 1, enemyImg:getWidth()/2, enemyImg:getHeight()/2)
end

function Enemy:update(dt)
    xDis = self.xPos + scene.getExactX() - SCREEN_SIZE.x/2
    yDis = self.yPos + scene.getExactY() - SCREEN_SIZE.y/2

    -- Case: enemy turns into a tile.
    ----if math.pow((math.pow(xDis, 2) + math.pow(yDis, 2)),0.5) <= SCREEN_SIZE.X then

    ----else  -- Case: ai moves towards player.
        c = math.pow((math.pow(xDis, 2)+math.pow(yDis, 2)),0.5)
        scale = _speed/c

        self.xPos = self.xPos - xDis*scale*dt
        self.yPos = self.yPos - yDis*scale*dt
    ----end

    -- Check for collision with lazer.
    for k, lazer in ipairs(player.lazerList) do
        lx = scene.getExactX() + util.round(lazer.xPos/4)*4 - SCREEN_SIZE.x/2
        ly = scene.getExactY() + util.round(lazer.yPos/4)*4 - SCREEN_SIZE.x/2

        -- Lazer and enemy distance.
        if math.pow((math.pow(math.abs(lx-xDis), 2)+math.pow(math.abs(ly-yDis), 2)),0.5) < 6*4 then
            self.isDead = true
        end
    end
end

return Enemy
