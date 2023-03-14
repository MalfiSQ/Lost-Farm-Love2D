sti = require('libraries/sti')

function loadMap(mapName)
    gameMap = sti('maps/' .. mapName .. '.lua')

    borders = {}
    if gameMap.layers["Borders"] then
        for i, obj in pairs(gameMap.layers["Borders"].objects) do
            border = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            border:setType('static')
            table.insert(borders, border)
        end
    end

    stones = {}
    logs = {}
end