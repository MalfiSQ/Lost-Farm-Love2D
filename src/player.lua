player = {}
anim8 = require('libraries/anim8')
require("src/salvage")

function player.load()
    player.x = 540
    player.y = 400
    player.speed = 500
    player.spriteSheet = love.graphics.newImage('sprites/player.png')
    player.grid = anim8.newGrid(48, 48, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())

    player.animations = {}
    player.animations.down = anim8.newAnimation(player.grid('1-4', 1), 0.1)
    player.animations.right = anim8.newAnimation(player.grid('1-4', 4), 0.1)
    player.animations.up = anim8.newAnimation(player.grid('1-4', 2), 0.1)
    player.animations.left = anim8.newAnimation(player.grid('1-4', 3), 0.1)
    player.anim = player.animations.down

    player:initInventory()
end

function player.update(dt)
    playerMovement(dt)
end

function player.draw()
   player.anim:draw(player.spriteSheet, player.x, player.y, nil, 5, nil, 24, 24)
end

-- Player functions
function playerMovement(dt)
    local isMoving = false
    local vX = 0
    local vY = 0

    if love.keyboard.isDown("d") then
        vX = player.speed
        player.anim = player.animations.right
        isMoving = true
    end

    if love.keyboard.isDown("a") then
        vX = player.speed * -1
        player.anim = player.animations.left
        isMoving = true
    end

    if love.keyboard.isDown("s") then
        vY = player.speed
        player.anim = player.animations.down
        isMoving = true
    end

    if love.keyboard.isDown("w") then
        vY = player.speed * -1
        player.anim = player.animations.up
        isMoving = true
    end

    if isMoving == false then
        player.anim:gotoFrame(1)
    end

    player.anim:update(dt)
    local mag = math.sqrt(vX * vX + vY * vY)
    if mag ~= 0 then vX, vY = vX/mag, vY/mag end
    player.collider:setLinearVelocity(vX * player.speed, vY * player.speed)
    player.x = player.collider:getX() --player.x + vX * player.speed * dt
    player.y = player.collider:getY() --player.y + vY * player.speed * dt
end

function player:initInventory()
    self.inventory = {}
    self.inventory[SALVAGE_TYPES.ROCKS] = 0
    self.inventory[SALVAGE_TYPES.DIRT] = 0
    self.inventory[SALVAGE_TYPES.LOGS] = 0
    print(self.inventory[1])
    print(#self.inventory)
end

function player:addToInventory(items)
    for k, v in ipairs(items) do
        print(k, v)
        self.inventory[k] = self.inventory[k] + v
    end
end