local wezterm = require("wezterm")

local schemes = {
    dark = {
        "Sea Shells (Gogh)",
        "MonaLisa",
        "terafox",
        "Tomorrow Night Burns",
        "Tomorrow Night Blue (Gogh)",
        "Glacier",
        "Vacuous 2 (terminal.sexy)",
    }
}

local fontlist = wezterm.font_with_fallback({
    -- en
    { family = "JetBrainsMono Nerd Font Mono", scale = 1.0 },
    { family = "SF Mono",                      scale = 1.0 },
    { family = "MonoLisa",                     scale = 1.0 },
    { family = "TX-02",                        scale = 1.0 },
    { family = "FiraCode Nerd Font Mono",      scale = 1.0 },
    { family = "IntoneMono Nerd Font Mono",    scale = 1.0 },
    { family = "Iosevka Nerd Font Mono",       scale = 1.1 },
    { family = "Maple Mono NF",                scale = 1.0 },
    { family = "OverpassM Nerd Font Mono",     scale = 1.0 },
    { family = "RobotoMono Nerd Font",         scale = 1.0 },
    { family = "SpaceMono Nerd Font",          scale = 1.0 },
    -- cn
    { family = "LXGW Neo XiHei",               scale = 1.0 },
    { family = "Maple Mono NF CN",             scale = 1.0 },
    { family = "LXGW WenKai",                  scale = 1.0 },
})

return function(config)
    config.color_scheme = schemes.dark[5]
    config.font = fontlist
end
