-- Global and Constant variables go here.
SCREEN_SIZE = {x=640, y=640}

function love.load()
    -- Set up the window.
    love.window.setTitle("This is a Game")
    love.window.setMode(SCREEN_SIZE.x, SCREEN_SIZE.y, {resizable=false, vsync=true})
    love.graphics.setBackgroundColor(0.75, 0.5, 0.25, 1)

    -- Load images here.
    playerImg = love.graphics.newImage("resc/img/PlayerShip.png")
    spaceImg = love.graphics.newImage("resc/img/Background.png")
    enemyImg = love.graphics.newImage("resc/img/Enemy.png")

    -- Modules and classes are loaded here.
    util = require("util")

    lazer = require("src/lazer")
    enemy = require("src/enemy")

    player = require("src/player")
    scene = require("src/scene")
    ui = require("src/ui")
    waveManager = require("src/waveManager")

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
    else
        gPauseCounter = gPauseCounter + dt
        if gPauseCounter > 0.75 then  -- Wait 2 seconds until moving player.
            gPauseGame = false
            gPauseCounter = 0

            player.reset()

            scene.xPos = -SCREEN_SIZE.x
            scene.yPos = -SCREEN_SIZE.y

            ui.lives = ui.lives - 1
        end
    end
end

gPauseCounter = 0
gPauseGame = false
function loseLife()
    if ui.lives <= 0 then -- Case: lives will go down to -1 in a second.
        -- TODO: Reset the game and show wave count.
        print ("you lose")
    end

    gPauseGame = true
end
