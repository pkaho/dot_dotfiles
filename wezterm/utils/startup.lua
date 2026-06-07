local wezterm = require('wezterm')

wezterm.on("gui-startup", function(cmd)
    local cwd = cmd and cmd.cwd or nil
    local screen = wezterm.gui.screens().active
    local ratio = 0.5               -- 窗口占当前屏幕的比例
    local w = screen.width * ratio  -- 窗口宽度
    local h = screen.height * ratio -- 窗口高度

    -- 窗口继承工作目录
    local _, _, window = wezterm.mux.spawn_window { cwd = cwd }

    local win = window:gui_window()
    win:set_inner_size(w, h)
    win:set_position(
        (screen.width - w) / 2,
        (screen.height - h) / 2,
        'ActiveScreen'
    )
end)
