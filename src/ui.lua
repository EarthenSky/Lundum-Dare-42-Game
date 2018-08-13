local UI = {}  -- This is a Module

-- Sets the font to use.
MAIN_FONT = love.graphics.newFont("resc/fonts/manaspc.ttf", 48)
love.graphics.setFont(MAIN_FONT)

-- Counters
UI.wave = 1
UI.lives = 3

function UI.draw()
    love.graphics.setColor(1*255, 1*255, 1*255, 1*255)
    love.graphics.print("Wave: " .. UI.wave, 4, 8)

    if UI.lives == 0 then love.graphics.setColor(1*255, 0.25*255, 0.25*255, 1*255) end
    love.graphics.print("Lives: " .. UI.lives, 4, 52)

    if gEndGame == true then
        love.graphics.setColor(1*255, 0.25*255, 0.25*255, 1*255)
        love.graphics.print("YOU LOSE", 4*14, 4*48)
        love.graphics.setColor(1*255, 1*255, 1*255, 1*255)
        love.graphics.print("to try again", 4*6, 4*48+48)
        love.graphics.print("re-enter the game", 4*6, 4*48+(48*2))
    end
end

return UI
