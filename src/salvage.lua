function protect(t)
    return setmetatable({}, {
        __index = t,
        __newindex = function (t, k, v)
            error("error: attempt to change value " .. tostring(k) .. " to " .. tostring(v) .. " in protected table", 2)
        end
    })
end

SALVAGE_TYPES = {
    NONE = 0,
    ROCKS = 1,
    DIRT = 2,
    LOGS = 3
}

SALVAGE_TYPES = protect(SALVAGE_TYPES)

invItems = {
    "Rocks",
    "Dirt",
    "Logs"
}