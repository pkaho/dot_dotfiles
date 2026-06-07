local wezterm = require("wezterm")

local M = {}

local target_triple = wezterm.target_triple
local is_windows = target_triple:match("windows")

function M.is_win()
    return is_windows
end

-- Shell 配置
local shell_configs = {
    win = { "pwsh", "-nologo" },
    unix = { "zsh", "-l" },
}

function M.shell()
    return M.is_win() and shell_configs.win or shell_configs.unix
end

return M
