local wezterm = require("wezterm")

local rules = wezterm.default_hyperlink_rules()

local custom_rules = {
	{
		regex = [[\b[tt](\d+)\b]],
		format = "https://example.com/tasks/?t=$1",
	},
	{
		regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
		format = "https://www.github.com/$1/$3",
	},
	-- 匹配各种括号
	{
		regex = "\\((\\w+://\\S+)\\)",
		format = "$1",
		highlight = 1,
	},
	{
		regex = "\\[(\\w+://\\S+)\\]",
		format = "$1",
		highlight = 1,
	},
	{
		regex = "\\{(\\w+://\\S+)\\}",
		format = "$1",
		highlight = 1,
	},
	{
		regex = "<(\\w+://\\S+)>",
		format = "$1",
		highlight = 1,
	},
	-- Handle bare URLs
	{
		regex = "\\b\\w+://\\S+[)/a-zA-Z0-9-]+",
		format = "$0",
	},
	-- Implicit mailto links
	{
		regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
		format = "mailto:$0",
	},
}

-- Merge default rules with custom rules
for _, rule in ipairs(custom_rules) do
	table.insert(rules, rule)
end

return function(config)
	config.hyperlink_rules = rules
	return config
end
