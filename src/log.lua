function addLog(x, y, width, height)
    local x, y, width, height = x or 0, y or 0, width or 80, height or 30
    local log = world:newBSGRectangleCollider(x, y, width, height, 10)
    print(log:getX(), log:getY())
    log:setType('static')
    log.x = x
    log.y = y
    log.w = width
    log.h = height
    log.salvage = {}
    log.salvage[SALVAGE_TYPES.LOGS] = 3
    log.salvage[SALVAGE_TYPES.DIRT] = 2
    print(log.salvage[1])
    table.insert(logs, log)
end

function removeLog(id)
    for i, l in ipairs(logs) do
        if l == id then
            l:destroy()
            if l.salvage then player:addToInventory(l.salvage) end
            table.remove(logs, i)
        end
    end
end

function getLog(x, y)
    for _, v in ipairs(logs) do
        print(v.x, v.y, v.w, v.h)
        if x > v.x and x < v.x + v.w and y > v.y and y < v.y + v.h then
            return v
        end
    end
end