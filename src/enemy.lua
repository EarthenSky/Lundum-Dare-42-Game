Enemy = {}

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
    selfObj.speed = 50  -- ~1/6 player speed
    selfObj.tileCounter = 0

    -- Make this into a class.
    self.__index = self
    return setmetatable(selfObj, self)
end

-- Enemy is moved from its center.
function Enemy:draw(xMod, yMod)
    if self.isFast == true then
        love.graphics.setColor(0*255, 0.75*255, 0*255, 1*255)
    else
        love.graphics.setColor(0.5*255, 0.25*255, 0.75*255, 1*255)
    end

    love.graphics.draw(enemyImg, util.round(self.xPos/4)*4 + xMod, util.round(self.yPos/4)*4 + yMod, 0, 1, 1, enemyImg:getWidth()/2, enemyImg:getHeight()/2)
end

function Enemy:update(dt)
    xDis = self.xPos + scene.getExactX() - SCREEN_SIZE.x/2
    yDis = self.yPos + scene.getExactY() - SCREEN_SIZE.y/2

    -- Case: enemy turns into a tile.
    if math.pow(math.pow(math.abs(xDis), 2)+math.pow(math.abs(yDis), 2), 0.5) >= SCREEN_SIZE.x*1.5 and tileManager.isTile(self.xPos, self.yPos) == false and self.tileCounter ~= -1 then
        self.tileCounter = self.tileCounter + dt
        if self.tileCounter > 2 then
            self.tileCounter = -1

            tileManager.createTile(self.xPos, self.yPos)

            self.speed = self.speed*2.5
            self.isFast = true
        end
    else  -- Case: ai moves towards player.
        c = math.pow((math.pow(xDis, 2)+math.pow(yDis, 2)),0.5)
        scale = self.speed/c

        self.xPos = self.xPos - xDis*scale*dt
        self.yPos = self.yPos - yDis*scale*dt
    end

    -- Check for collision with lazer.
    for k, lazer in ipairs(player.lazerList) do
        lx = scene.getExactX() + util.round(lazer.xPos/4)*4 - SCREEN_SIZE.x/2
        ly = scene.getExactY() + util.round(lazer.yPos/4)*4 - SCREEN_SIZE.x/2

        -- Lazer and enemy distance.
        if math.pow((math.pow(math.abs(lx-xDis), 2)+math.pow(math.abs(ly-yDis), 2)),0.5) < 5*4 then
            self.isDead = true
        end
    end

    -- Check for collision with player.
    --px = scene.getExactX() - SCREEN_SIZE.x/2
    --py = scene.getExactY() - SCREEN_SIZE.y/2

    -- Lazer and enemy distance.
    if math.pow((math.pow(xDis, 2) + math.pow(yDis, 2)),0.5) < 3*4+6*4 then
        self.isDead = true
        loseLife()
    end
end

return Enemy
