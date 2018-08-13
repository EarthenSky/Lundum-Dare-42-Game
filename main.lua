-- Bugs:
-- Enemies touching the player when they respawn, each kill the player.  Nearby enemies are still killed.


-- Global and Constant variables go here.
SCREEN_SIZE = {x=640, y=640}

function love.load()
    -- Set up the window.
    love.window.setTitle("This is a Game")
    love.window.setMode(SCREEN_SIZE.x, SCREEN_SIZE.y, {resizable=false, vsync=true})
    love.graphics.setBackgroundColor(0.75*255, 0.5*255, 0.25*255, 1*255)

    -- Load images here.
    playerImg = love.graphics.newImage("resc/img/PlayerShip.png")
    spaceImg = love.graphics.newImage("resc/img/Background.png")
    enemyImg = love.graphics.newImage("resc/img/Enemy.png")

    -- Modules and classes are loaded here.
    util = require("util")

    lazer = require("src/lazer")
    enemy = require("src/enemy")
    tile = require("src/tile")

    player = require("src/player")
    scene = require("src/scene")
    ui = require("src/ui")
    waveManager = require("src/waveManager")
    tileManager = require("src/tileManager")

    -- Any initialization code goes here.
    gPauseGame = true  -- Game starts with player not moving.

    -- Init modules

end

function love.draw()
    scene.draw()

    if gPauseGame == false then
        player.draw()  -- Player is drawn over enemies and scene.
    end

    ui.draw()  -- Ui is on top
end

function love.update(dt)
    if gPauseGame == false then
        scene.update(dt)
        waveManager.update(dt)
        player.update(dt)
    elseif gEndGame == false then
        gPauseCounter = gPauseCounter + dt
        if gPauseCounter > 0.75 then  -- Wait 0.75 seconds until moving player.
            gPauseGame = false
            gPauseCounter = 0

            player.reset()

            scene.xPos = -SCREEN_SIZE.x
            scene.yPos = -SCREEN_SIZE.y

            ui.lives = ui.lives - 1

            local garbageList = {}

            -- Kill enemies around the player when re-alive.
            for i, enemy in ipairs(scene.enemyList) do
                local xDis = enemy.xPos + scene.getExactX() - SCREEN_SIZE.x/2
                local yDis = enemy.yPos + scene.getExactY() - SCREEN_SIZE.y/2
                -- Lazer and enemy distance.
                if math.pow((math.pow(math.abs(xDis), 2)+math.pow(math.abs(yDis), 2)),0.5) < (3*4+6*4)*6 then  --*10
                    table.insert(garbageList, i)
                    enemy.isDead = true
                end
            end

            -- Clean up garbage, in a weird way, lua is weird.
            local removedNumList = {}
            for i, item in ipairs(garbageList) do
                local indexMod = 0
                for k, number in pairs(removedNumList) do
                    if number < i then
                        indexMod = indexMod - 1
                    end
                end

                --print("dest", i+indexMod)
                --util.printTable(scene.enemyList)

                table.remove( scene.enemyList, i+indexMod )
                table.insert( removedNumList, i )
            end
        end
    end
end

gPauseCounter = 0
gPauseGame = false
gEndGame = false
function loseLife()
    if ui.lives <= 0 then -- Case: lives will go down to -1 in a second.
        loseGame()
    else
        gPauseGame = true
    end
end

-- TODO: Reset the game and show wave count.
function loseGame()
    print ("you lose")
    player.reset() -- reset player... for some reason

    -- Game stops processing.
    gPauseGame = true
    gEndGame = true

end
