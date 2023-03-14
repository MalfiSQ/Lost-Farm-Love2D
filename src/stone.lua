function addStone(x, y, width, height)
    local x, y, width, height = x or 0, y or 0, width or 128, height or 128
    local stone = world:newBSGRectangleCollider(x, y, width, height, 40)
    print(stone:getX(), stone:getY())
    stone:setType('static')
    stone.x = x
    stone.y = y
    stone.w = width
    stone.h = height
    stone.salvage = {}
    stone.salvage[SALVAGE_TYPES.ROCKS] = 5
    stone.salvage[SALVAGE_TYPES.DIRT] = 2
    print(stone.salvage[1])
    table.insert(stones, stone)
end

function removeStone(id)
    for i, s in ipairs(stones) do
        if s == id then
            s:destroy()
            if s.salvage then player:addToInventory(s.salvage) end
            table.remove(stones, i)
        end
    end
end

function getStone(x, y)
    for _, v in ipairs(stones) do
        print(v.x, v.y, v.w, v.h)
        if x > v.x and x < v.x + v.w and y > v.y and y < v.y + v.h then
            return v
        end
    end
end