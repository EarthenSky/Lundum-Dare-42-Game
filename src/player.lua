local Player = {}  -- This is a Module

Player.lazerList = {}

local _SPEED = 300

local _direction = 0  -- (0, 1, 2, 3) -> (up, down, left, right)
local _next_direction = 0  -- (0, 1, 2, 3) -> (up, down, left, right)
local _rotation = 0

function Player.draw()
    -- Draw the lazers under player
    for k, lazer in pairs(Player.lazerList) do
        lazer:draw(0, 0)
    end

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(playerImg, SCREEN_SIZE.x/2, SCREEN_SIZE.y/2, _rotation, 1, 1, playerImg:getWidth()/2, playerImg:getHeight()/2)
end

local tempSpeed = _SPEED
local directionChange = false
function changeDirection(dir)
    tempSpeed = _SPEED
    directionChange = true

    -- Set the slowdown function.
    if _direction == 0 then
        slowDown = function(dt) scene.yPos = scene.yPos + tempSpeed*dt end
    elseif _direction == 1 then
        slowDown = function(dt) scene.yPos = scene.yPos - tempSpeed*dt end
    elseif _direction == 2 then
        slowDown = function(dt) scene.xPos = scene.xPos + tempSpeed*dt end
    elseif _direction == 3 then
        slowDown = function(dt) scene.xPos = scene.xPos - tempSpeed*dt end
    end

    _next_direction = dir
end

-- Control bool switches.
local is_w_down = false
local is_a_down = false
local is_s_down = false
local is_d_down = false
local is_space_down = false

function movePlayer(dt)
    if love.keyboard.isDown("w") and is_w_down == false then
        if _direction ~= 0 then
            changeDirection(0)
            is_w_down = true
        end
    elseif love.keyboard.isDown("s") and is_s_down == false then
        if _direction ~= 1 then
            changeDirection(1)
            is_s_down = true
        end
    elseif love.keyboard.isDown("a") and is_a_down == false then
        if _direction ~= 2 then
            changeDirection(2)
            is_a_down = true
        end
    elseif love.keyboard.isDown("d") and is_d_down == false then
        if _direction ~= 3 then
            changeDirection(3)
            is_d_down = true
        end
    elseif not love.keyboard.isDown("w") and is_w_down == true then
        is_w_down = false
    elseif not love.keyboard.isDown("s") and is_s_down == true then
        is_s_down = false
    elseif not love.keyboard.isDown("a") and is_a_down == true then
        is_a_down = false
    elseif not love.keyboard.isDown("d") and is_d_down == true then
        is_d_down = false
    end

    if _direction == 0 then
        scene.yPos = scene.yPos + _SPEED*dt
    elseif _direction == 1 then
        scene.yPos = scene.yPos - _SPEED*dt
    elseif _direction == 2 then
        scene.xPos = scene.xPos + _SPEED*dt
    elseif _direction == 3 then
        scene.xPos = scene.xPos - _SPEED*dt
    end
end

function checkCollision(dt)
    -- Check wall collision.
    if scene.getExactX() < -SCREEN_SIZE.x*2.5+playerImg:getWidth()/2 or scene.getExactX() > SCREEN_SIZE.x*0.5-playerImg:getWidth()/2 or
    scene.getExactY() < -SCREEN_SIZE.y*2.5+playerImg:getHeight()/2 or scene.getExactY() > SCREEN_SIZE.y*0.5-playerImg:getHeight()/2 then
        loseLife() -- Case: hit wall.
    end

    -- Check Enemy Collision.
end

local shootCounter = 0
function Player.update(dt)
    -- Case: player is not changing it's direction.
    if directionChange == false then
        if not love.keyboard.isDown("e") then
            movePlayer(dt)
        end
    else
        if tempSpeed > 0 then
            tempSpeed = tempSpeed - 20
            slowDown(dt)
        else
            if _next_direction == 0 then
                _rotation = 0
                _direction = 0
            elseif _next_direction == 1 then
                _rotation = math.pi
                _direction = 1
            elseif _next_direction == 2 then
                _rotation = math.pi*1.5
                _direction = 2
            elseif _next_direction == 3 then
                _rotation = math.pi*0.5
                _direction = 3
            end

            directionChange = false
        end
    end

    --print (scene.getExactX(), scene.getExactY())

    checkCollision(dt) -- Check collision after moving.

    local garbageList = {}

    -- Move the lazers and check for garbage items.
    for k, lazer in ipairs(Player.lazerList) do
        lazer:update(dt)

        if lazer.isDead == true then
            table.insert(garbageList, k)
            print("found dead", lazer.lazer_num, k)
        end
    end
    -- TODO: why does the second lazer get cleaned but not removed?
    -- Clean up garbage.
    for k, item in ipairs(garbageList) do
        print ("clean", item)
        table.remove( Player.lazerList, item )
    end

    -- Press space to shoot, cooldown 0.5 second.
    if love.keyboard.isDown("space") and is_space_down == false then
        table.insert(Player.lazerList, lazer:new(-scene.getExactX() + SCREEN_SIZE.x/2, -scene.getExactY() + SCREEN_SIZE.y/2, _direction, 0))  -- left lazer
        table.insert(Player.lazerList, lazer:new(-scene.getExactX() + SCREEN_SIZE.x/2, -scene.getExactY() + SCREEN_SIZE.y/2, _direction, 1))  -- right lazer
        is_space_down = true
    elseif is_space_down == true then
        shootCounter = shootCounter + dt
        if shootCounter > 0.5 then
            is_space_down = false
            shootCounter = 0
        end
    end
end

function Player.reset()
    _direction = 0
    _rotation = 0
end

return Player
