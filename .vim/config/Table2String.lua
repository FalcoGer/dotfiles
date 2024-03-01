-- Turns a table into a string

function Table2String(val, indentWidth, level, tableKey)
    if level == nil then level = 0 end
    if indentWidth == nil then indentWidth = 4 end
    -- get indent for current level
    local singleIndent = ""
    for _ = 1, indentWidth do
        singleIndent = singleIndent .. " "
    end
    local indent = ""
    for _ = 1, level do
        indent = indent .. singleIndent
    end
    -- if it isn't a table, just print the value
    if type(val) ~= "table" then
        if type(val) == "string" then
            return "\"" .. val .. "\"" .. ", -- " .. type(val) .. "\n"
        end
        return tostring(val) .. ", -- " .. type(val) .. "\n"
    end
    -- Is table
    local ret = "{\n"
    for k, v in pairs(val) do
        local keyRepr = ""
        if type(k) == "string" then
            keyRepr = k
        elseif type(k) == "number" then
            keyRepr = "[" .. tostring(k) .. "]"
        else
            keyRepr = tostring(k) .. " (" .. tostring(type(k)) .. ")"
        end
        ret = ret .. (indent .. singleIndent .. keyRepr .. " = " .. Table2String(v, indentWidth, level + 1, k))
    end
    ret = ret .. indent .. "}, -- " .. type(val) .. "  /" .. tostring(tableKey) .. "\n"
    return ret
end

function Table2StringArray(val, indentWidth)
    local tableString = Table2String(val, indentWidth, nil, nil)
    local result = {}
    for s in string.gmatch(tableString, "[^\n]+") do
        table.insert(result, s)
    end
    return result
end
