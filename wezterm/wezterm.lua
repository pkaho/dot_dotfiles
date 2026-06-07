local wezterm = require("wezterm")
local C = require("configs.colors")

local config = wezterm.config_builder()

config = {
    color_scheme = "Dracula", -- Dracula, Catppuccin: Mocha Macchiato Frappe Latte

    -- 字体
    -- stylua: ignore start
    font = wezterm.font_with_fallback({
        -- en
        -- NF 和 NFM 的区别：https://github.com/ryanoasis/nerd-fonts/discussions/945
        { family = "SF Mono",                      scale = 1.0 }, -- 手动安装
        { family = "MonoLisa",                     scale = 1.0 }, -- 手动安装
        { family = "TX-02",                        scale = 1.0 }, -- 手动安装
        { family = "FiraCode Nerd Font Mono",      scale = 1.0 }, -- scoop install FiraCode-NF-Mono
        { family = "IntoneMono Nerd Font Mono",    scale = 1.0 }, -- scoop install IntelOneMono-NF-Mono
        { family = "Iosevka Nerd Font Mono",       scale = 1.1 }, -- scoop install Iosevka-NF-Mono
        { family = "JetBrainsMono Nerd Font Mono", scale = 1.0 }, -- scoop install JetBrainsMono-NF-Mono
        { family = "Maple Mono",                   scale = 1.0 }, -- scoop install Maple-Mono
        { family = "OverpassM Nerd Font Mono",     scale = 1.0 }, -- scoop install Overpass-NF-Mono
        { family = "RobotoMono Nerd Font Mono",    scale = 1.0 }, -- scoop install RobotoMono-NF-Mono
        { family = "SpaceMono Nerd Font Mono",     scale = 1.0 }, -- scoop install SpaceMono-NF-Mono
        -- cn
        { family = "LXGW Neo XiHei",               scale = 1.0 }, -- scoop install LXGWNeoXiHei
        { family = "Maple Mono NF CN",             scale = 1.0 }, -- scoop install LXGWWenKai
        { family = "LXGW WenKai",                  scale = 1.0 }, -- scoop install Maple-Mono-NF-CN
    }),
    -- stylua: ignore end
    font_size = 12,

    -- tab
    use_fancy_tab_bar = true,
    show_new_tab_button_in_tab_bar = false,
    -- show_close_tab_button_in_tabs = false

    -- performance
    max_fps = 60,
    animation_fps = 60,

    -- 窗口行为
    window_decorations = "RESIZE",
    adjust_window_size_when_changing_font_size = false,
    window_close_confirmation = "NeverPrompt",

    -- 启动大小
    initial_cols = 70,
    initial_rows = 18,

    -- 滚动
    enable_scroll_bar = true,
    min_scroll_bar_height = "9cell",
    scrollback_lines = 3500,
    mouse_wheel_scrolls_tabs = true,
    scroll_to_bottom_on_input = true,

    -- 非活动窗格 hsb 设置
    inactive_pane_hsb = {
        saturation = 0.9,
        brightness = 0.55,
    },

    -- 窗格间隙
    window_padding = {
        left = 5,
        right = 5,
        top = 5,
        bottom = 5,
    },
}

C.setup_header_popups(config)
require("configs.domains")(config)
require("configs.keybinds")(config)
require("configs.mouse")(config)
require("configs.rules")(config)
require("utils.startup")
require("utils.tabtitle")
require("override")(config)

return config
