require('src/player')
require('src/loadMap')
require("src/stone")
require('src/log')

function love.load()
    acc = 0
    love.graphics.setDefaultFilter('nearest', 'nearest')
    wf = require('libraries/windfield')
    camera = require('libraries/camera')
    
    world = wf.newWorld(0, 0)
    cam = camera()
    loadMap('lostFarm1')
    player.load()

    player.collider = world:newBSGRectangleCollider(player.x, player.y, 55, 80, 10)
    player.collider:setFixedRotation(true)

    sprites = {}
    sprites.stone = love.graphics.newImage('sprites/stone.png')
    sprites.log = love.graphics.newImage('sprites/log.png')

    font = love.graphics.newFont(30)
    text = love.graphics.newText(font, "")

    music = love.audio.newSource("music/calm_01.ogg", "stream")
    music:setLooping(true)
    music:setVolume(0.7)
    music:play()

    addStone(500, 500)
    addStone(700, 800)
    addStone(1000, 600)
    addLog(400, 300)
    addLog(300, 700)
    addLog(100, 200)
end

function love.update(dt)
    world:update(dt)
    player.update(dt)
    cam:lookAt(player.x, player.y)

    acc = acc + dt
    if acc > 1 then
        acc = acc - 1
        print(cam:worldCoords(love.mouse.getPosition()))
        print(#SALVAGE_TYPES)
    end
end

function love.draw()
    cam:attach()
        gameMap:drawLayer(gameMap.layers['Grass'])
        gameMap:drawLayer(gameMap.layers['Path'])
        gameMap:drawLayer(gameMap.layers['Fences'])
        gameMap:drawLayer(gameMap.layers['Water'])

        for _, stone in ipairs(stones) do
            love.graphics.draw(sprites.stone, stone:getX(), stone:getY(), 0, 1, 1, sprites.stone:getWidth() / 2, sprites.stone:getHeight() / 2)
        end

        for _, log in ipairs(logs) do
            love.graphics.draw(sprites.log, log:getX() + - 5, log:getY() - 10, 0, 1, 1, sprites.log:getWidth() / 2, sprites.log:getHeight() / 2)
        end

        player.draw()
        world:draw()
    cam:detach()

    for i, v in ipairs(player.inventory) do
        if player.inventory[i] ~= 0 then
            local string = invItems[i] .. ":   " .. v
            text:set(string)
            love.graphics.draw(text, 20, 32*i)
        end
    end
end

function love.keypressed(key)
    if key == "m" then
        if music:isPlaying() then music:pause() else music:play() end
    end
    if key == "r" then
        addStone(cam:worldCoords(love.mouse.getPosition()))
    end
    if key == "e" then
        removeStone(getStone(cam:worldCoords(love.mouse.getPosition())))
    end
    if key == "l" then
        addLog(cam:worldCoords(love.mouse.getPosition()))
    end
    if key == "k" then
        removeLog(getLog(cam:worldCoords(love.mouse.getPosition())))
    end
end