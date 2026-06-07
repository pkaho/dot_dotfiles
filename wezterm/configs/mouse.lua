local wezterm = require("wezterm")
local act = wezterm.action

return function(config)
	config.mouse_bindings = {
		-- Ctrl+鼠标左键, 打开链接
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = act.OpenLinkAtMouseCursor,
		},
		-- 鼠标左键复制, 右键粘贴
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = act.CompleteSelection("PrimarySelection"),
		},
		{
			event = { Up = { streak = 1, button = "Right" } },
			mods = "NONE",
			action = act.PasteFrom("Clipboard"),
		},
		-- ALT+窗口按住鼠标左键, 快速拖动窗口
		{
			event = { Drag = { streak = 1, button = "Left" } },
			mods = "ALT",
			action = act.StartWindowDrag,
		},
		-- 按住Ctrl+滚动滚轮, 调整字体大小
		{
			event = { Down = { streak = 1, button = { WheelUp = 1 } } },
			mods = "CTRL",
			action = act.IncreaseFontSize,
		},
		{
			event = { Down = { streak = 1, button = { WheelDown = 1 } } },
			mods = "CTRL",
			action = act.DecreaseFontSize,
		},
	}

	return config
end
