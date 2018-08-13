local WaveManager = {}  -- This is a Module

WaveManager.waveEnded = false
WaveManager.enemySpawnCount = 10
WaveManager.spawnRate = 0.7 --Enemies per second.
WaveManager.finishedSpawning = false

-- Next wave calculations.
function nextWave()
    WaveManager.waveEnded = false
    WaveManager.finishedSpawning = false
    ui.wave = ui.wave + 1

    if WaveManager.enemySpawnCount < 105 then  --max enemies per round.
        WaveManager.enemySpawnCount = WaveManager.enemySpawnCount + 6
    end

    if WaveManager.spawnRate < 2.5 then  --max spawn rate for enemies.
        WaveManager.spawnRate = WaveManager.spawnRate + 0.3
    end

end

enemiesSpawned = 0
spawnCounter = 0
waveEndCounter = 0
function WaveManager.update(dt)
    if WaveManager.waveEnded == false then  -- Case: wave taking place.
        if WaveManager.finishedSpawning == false then
            spawnCounter = spawnCounter + dt

            -- Spawn an enemy WaveManager.spawnRate times a second.
            if spawnCounter >= 1/WaveManager.spawnRate then
                spawnCounter = spawnCounter - 1/WaveManager.spawnRate
                scene.addEnemy()
                enemiesSpawned = enemiesSpawned + 1
            end

            -- Case: all enemies have been spawned.
            if enemiesSpawned >= WaveManager.enemySpawnCount then
                WaveManager.finishedSpawning = true
                enemiesSpawned = 0
            end
        else
            --print ("Spawning over." .. dt)
            if table.getn(scene.enemyList) == 0 then  -- Case: all enemies are dead.
                WaveManager.waveEnded = true
            end
        end
    else
        waveEndCounter = waveEndCounter + dt
        if waveEndCounter > 1 then
            waveEndCounter = 0
            nextWave()
        end
    end
end

return WaveManager
