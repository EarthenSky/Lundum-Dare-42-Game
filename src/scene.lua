local Scene = {}  -- This is a Module

Scene.enemyList = {} -- List of all enemies.

--for i=0, 100, 1 do
--    table.insert(Scene.enemyList, enemy:new())
--end

function Scene.addEnemy()
    table.insert(Scene.enemyList, enemy:new())
end

-- The scene contains all objects that aren't the player.
function Scene.draw()
    love.graphics.setColor(1*255, 1*255, 1*255, 1*255)
    --love.graphics.rectangle("fill", Scene.getExactX(), Scene.getExactY(), SCREEN_SIZE.x * 3, SCREEN_SIZE.y * 3)
    love.graphics.draw(spaceImg, Scene.getExactX(), Scene.getExactY())

    tileManager.draw()  -- Draw tiles over space, under enemies.

    -- Draw enemies above the background.
    for k, enemy in pairs(Scene.enemyList) do
        enemy:draw(Scene.getExactX(), Scene.getExactY())
    end
end

function Scene.update(dt)
    local garbageList = {}

    -- Update and check for garbage.
    for k, enemy in pairs(Scene.enemyList) do
        enemy:update(dt)

        if enemy.isDead == true then
            table.insert(garbageList, k)
        end
    end

    -- Clean up garbage.
    for k, item in ipairs(garbageList) do
        table.remove( Scene.enemyList, item )
    end

    --print(Scene.xPos, Scene.yPos)
end

-- Scene positions.
Scene.xPos = -SCREEN_SIZE.x
Scene.yPos = -SCREEN_SIZE.y

-- Pixel position of scene.
function Scene.getExactX()
    return util.round(Scene.xPos/4)*4
end

function Scene.getExactY()
    return util.round(Scene.yPos/4)*4
end

return Scene
