Lazer = {}

local speed = 300*3  -- 3x player. (2x fast enemy)

function Lazer:new(x, y, dir, lazer_num)
    -- Add member variables here.
    selfObj = {}
    selfObj.xPos, selfObj.yPos = x, y
    selfObj.dir = dir
    selfObj.lazer_num = lazer_num

    if dir == 0 then
        selfObj.size = function() return 4, 8 end --w,h
        if lazer_num == 0 then
            selfObj.xPos = selfObj.xPos - 5*4
        elseif lazer_num == 1 then
            selfObj.xPos = selfObj.xPos + 4*4
        end
    elseif dir == 1 then
        selfObj.size = function() return 4, 8 end --w,h
        if lazer_num == 0 then
            selfObj.xPos = selfObj.xPos - 5*4
        elseif lazer_num == 1 then
            selfObj.xPos = selfObj.xPos + 4*4
        end
    elseif dir == 2 then
        selfObj.size = function() return 8, 4 end --w,h
        if lazer_num == 0 then
            selfObj.yPos = selfObj.yPos - 5*4
        elseif lazer_num == 1 then
            selfObj.yPos = selfObj.yPos + 4*4
        end
    elseif dir == 3 then
        selfObj.size = function() return 8, 4 end --w,h
        if lazer_num == 0 then
            selfObj.yPos = selfObj.yPos - 5*4
        elseif lazer_num == 1 then
            selfObj.yPos = selfObj.yPos + 4*4
        end
    end

    selfObj.isDead = false
    print("enemmy", lazer_num)
    -- Make this into a class.
    self.__index = self
    return setmetatable(selfObj, self)
end

-- Lazer is moved from top left
function Lazer:draw(xMod, yMod)
    love.graphics.setColor(1, 0.25, 0, 1)
    love.graphics.rectangle("fill", scene.getExactX() + util.round(self.xPos/4)*4, scene.getExactY() + util.round(self.yPos/4)*4, self.size())
end

-- Move lazer.
function Lazer:update(dt)
    if self.dir == 0 then
        self.yPos = self.yPos - speed * dt
    elseif self.dir == 1 then
        self.yPos = self.yPos + speed * dt
    elseif self.dir == 2 then
        self.xPos = self.xPos - speed * dt
    elseif self.dir == 3 then
        self.xPos = self.xPos + speed * dt
    end

    -- Check wall collision.
    local x = util.round(self.xPos/4)*4
    local y = util.round(self.yPos/4)*4
    if x < 0 or x > SCREEN_SIZE.x*3 or y < 0 or y > SCREEN_SIZE.y*3 then
        self.isDead = true
        print("ded", self.lazer_num)
    end
    --print( "thing", util.round(self.xPos/4)*4, util.round(self.yPos/4)*4 )
end

return Lazer
