-- Global and Constant variables go here.
SCREEN_SIZE = {x=640, y=640}

function love.load()
    -- Set up the window.
    love.window.setTitle("This is a Game")
    love.window.setMode(SCREEN_SIZE.x, SCREEN_SIZE.y, {resizable=false, vsync=true})
    love.graphics.setBackgroundColor(0.5, 0.5, 0.5, 1)

    -- Modules and classes are loaded here.
    util = require("util")

    -- Any initialization code goes here.

    -- Init modules

end

function love.draw()
    --love.graphics.setColor(1, 1, 1, 1)
end

function love.update(dt)

end
