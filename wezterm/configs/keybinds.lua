local wezterm = require("wezterm")
local act = wezterm.action

-- 调整窗口透明度
wezterm.on("toggle-opacity", function(window, _)
    local override = window:get_config_overrides() or {}
    override.win32_system_backdrop = "Auto" -- Auto, Disable, Acrylic, Mica, Tabbed
    if not override.window_background_opacity then
        override.window_background_opacity = 0.2
    else
        override.window_background_opacity = nil
    end
    window:set_config_overrides(override)
end)

-- 窗口最大化(非全屏)
wezterm.on("maximize", function(window)
    window:maximize()
end)

-- 还原窗口
wezterm.on("normal", function(window)
    window:restore()
end)

local keys = require("utils.keys")

return function(config)
    config.leader = { key = ",", mods = "ALT", timeout_milliseconds = 3000 }
    config.keys = keys.mappings({
        -- 杂项
        ["F3"] = act.ShowLauncher,
        ["F12"] = act.ShowDebugOverlay,

        -- 调整窗口
        ["ctrl+shift+b"] = act.Hide,
        ["alt+m"] = act.EmitEvent("maximize"),
        ["alt+n"] = act.EmitEvent("normal"),

        -- 创建/关闭标签
        ["alt+t"] = act.SpawnTab("CurrentPaneDomain"),
        ["alt+w"] = act.CloseCurrentPane({ confirm = false }),

        -- 使用管理员权限打开一个新窗口(非wezterm)
        ["ctrl+shift+alt+n"] = act.SpawnCommandInNewTab({
            args = { "pwsh", "-Command", "Start-Process pwsh -Verb RunAs" },
        }),

        -- 调整窗口透明度
        ["ctrl+shift+alt+o"] = act.EmitEvent("toggle-opacity"),

        -- 将 tab 往后/前移动
        ["ctrl+shift+{"] = act.MoveTabRelative(-1),
        ["ctrl+shift+}"] = act.MoveTabRelative(1),

        -- 在 tab 之间跳转
        ["alt+["] = act.ActivateTabRelative(-1),
        ["alt+]"] = act.ActivateTabRelative(1),

        -- 窗格最大化
        ["alt+z"] = act.TogglePaneZoomState,

        -- 调整窗格尺寸
        ["alt+left"] = act.AdjustPaneSize({ "Left", 1 }),
        ["alt+right"] = act.AdjustPaneSize({ "Right", 1 }),
        ["alt+up"] = act.AdjustPaneSize({ "Up", 1 }),
        ["alt+down"] = act.AdjustPaneSize({ "Down", 1 }),

        -- 在窗格之间跳转
        ["ctrl+shift+j"] = act.ActivatePaneDirection("Down"),
        ["ctrl+shift+k"] = act.ActivatePaneDirection("Up"),
        ["ctrl+shift+h"] = act.ActivatePaneDirection("Left"),
        ["ctrl+shift+l"] = act.ActivatePaneDirection("Right"),

        -- 移动到选择的窗格
        ["alt+p"] = act.PaneSelect({ alphabet = "123456789", mode = "Activate" }),

        -- 将选择的窗格移动到当前激活的窗格
        ["ctrl+alt+p"] = act.PaneSelect({ alphabet = "123456789", mode = "SwapWithActive" }),

        -- 分割窗格
        ["alt+\\"] = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
        ["alt+-"] = act.SplitVertical({ domain = "CurrentPaneDomain" }),

        -- 快速选择 hash 值
        ["ctrl+shift+alt+h"] = act.QuickSelectArgs({ patterns = { "[a-f0-9]{6,}" } }),

        -- 选择出现在屏幕部分的网址
        ["alt+e"] = act.QuickSelectArgs({
            label = "open url",
            patterns = {
                "https?://\\S+",
            },
            action = wezterm.action_callback(function(window, pane)
                local url = window:get_selection_text_for_pane(pane)
                wezterm.log_info("opening: " .. url)
                wezterm.open_with(url)
            end),
        }),
    })
end
