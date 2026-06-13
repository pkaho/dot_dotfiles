# 模拟 SHLVL: 进入子 shell 自动 +1, 首层默认为 1
# refer: https://github.com/PowerShell/PowerShell/issues/9613#issuecomment-493098691
function Set-StarshipShellLevel {
    $env:__ShellDepth = [int] $env:__ShellDepth + 1

    $depthIcons = @(
        "", "", "󱂉", "󱂊", "󱂋", ""
    )

    if ($env:__ShellDepth -ge $depthIcons.Count) {
        $env:__ShellDepthIcon = $depthIcons[-1]
    } else {
        $env:__ShellDepthIcon = $depthIcons[$env:__ShellDepth]
    }
}
Set-StarshipShellLevel

# 初始化 Starship
Invoke-Expression (&starship init powershell)

# 开启瞬态提示符
# 历史行只保留 ❯ 符号和命令本身, 隐藏路径、Git 等冗余信息
Enable-TransientPrompt

# 仅在 Enable-TransientPrompt 时生效
# 默认情况下瞬态提示符历史行的命令左侧会默认替换为 ❯ (Windows 是乱码)
# 也可以使用其他 module 替换 character
function Invoke-Starship-TransientFunction {
    starship module character
}
