local wezterm = require("wezterm")
local colors = require("configs.colors")

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local title = tab.active_pane.title:gsub("%.exe$", "")
    title = wezterm.truncate_right(title, max_width - 2)

    local has_unseen = false
    for _, pane in ipairs(tab.panes) do
        if pane.has_unseen_output then
            has_unseen = true
            break
        end
    end

    local frame_bg = colors.frame_bg
    local fg_color = tab.is_active and colors.active_title_fg or colors.inactive_title_fg
    local bg_color = colors.title_bg
    local on_color = colors.unseen
    local zoom_indicator = tab.active_pane.is_zoomed and " 󰬡 " or " "
    local unseen_indicator = has_unseen and " ●" or " "

    local elements = {
        { fg = fg_color, bg = frame_bg, text = "" },
        { fg = bg_color, bg = fg_color, text = zoom_indicator .. title },
        { fg = on_color, bg = fg_color, text = unseen_indicator },
        { fg = fg_color, bg = frame_bg, text = "" },
    }

    local cells = {}
    for _, element in ipairs(elements) do
        table.insert(cells, { Foreground = { Color = element.fg } })
        table.insert(cells, { Background = { Color = element.bg } })
        table.insert(cells, { Attribute = { Intensity = "Bold" } })
        table.insert(cells, { Text = element.text })
    end

    return cells
end)
