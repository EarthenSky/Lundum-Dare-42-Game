local UI = {}  -- This is a Module

-- Sets the font to use.
MAIN_FONT = love.graphics.newFont("resc/fonts/manaspc.ttf", 48)
love.graphics.setFont(MAIN_FONT)

-- Counters
UI.wave = 1
UI.lives = 3

function UI.draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Wave: " .. UI.wave, 4, 8)

    if UI.lives == 0 then love.graphics.setColor(1, 0.25, 0.25, 1) end
    love.graphics.print("Lives: " .. UI.lives, 4, 52)
end

function UI.update(dt)

end

return UI
