local M = {}

local mods_map = {
    ctrl = "CTRL",
    shift = "SHIFT",
    alt = "ALT",
    super = "SUPER",
    leader = "LEADER",
}

local key_aliases = {
    left = "LeftArrow",
    right = "RightArrow",
    up = "UpArrow",
    down = "DownArrow",
}

local binding_pattern = "^([%a%+]+)%+(.+)$"

-- 解析函数(e.g. ctrl+shift+x --> CTRL|SHIFT|x)
function M.parse_mods(mod_str)
    local mods = {}

    -- 分割修饰键字符串（支持 ctrl+shift+alt 格式）
    for mod_name in mod_str:gmatch("[%a]+") do
        local mod = mods_map[mod_name:lower()]
        if mod then
            table.insert(mods, mod)
        end
    end

    return #mods > 0 and table.concat(mods, "|") or nil
end

-- 单个映射函数
function M.map(binding, action)
    local mod_str, key_char = binding:match(binding_pattern)

    local result = { action = action }

    local actual_key = key_aliases[key_char] or key_char

    if mod_str and key_char then
        result.key = actual_key
        result.mods = M.parse_mods(mod_str)
        return result
    else
        -- 如果没有修饰键或者是无效格式
        result.key = binding
        return result
    end
end

-- 批量映射函数
function M.mappings(mappings_table)
    local result = {}
    for binding, action in pairs(mappings_table) do
        table.insert(result, M.map(binding, action))
    end
    return result
end

return M
