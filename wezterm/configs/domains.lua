local wezterm = require("wezterm")
local platform = require("utils.platform")

return function(config)
    config.default_prog = platform.shell()
    config.default_domain = "local"
    config.wsl_domains = wezterm.default_wsl_domains()
    config.ssh_domains = wezterm.default_ssh_domains()
end
