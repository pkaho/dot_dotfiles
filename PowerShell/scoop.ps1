function scl { scoop cleanup -ka  }
function s   { scoop search $args }
function u   { scoop update @($args.Count -eq 0 ? '-a' : $args) }

function x {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$pkg
    )

    if ($pkg.Count -gt 1) {
        scoop uninstall $pkg
        return
    }

    $lines = scoop list | Out-String -Stream | Select-Object -Skip 3
    if (-not $lines) { Write-Host "未找到安装包" -Fore Red; return }

    if ($pkg) {
        $installedNames = $lines | ForEach-Object { ($_ -split '\s+')[0] }

        if ($installedNames -contains $pkg) {
            scoop uninstall $pkg
            return
        }

        $lines = $lines | Where-Object { ($_ -split '\s+')[0] -like "*$pkg*" }
        if (-not $lines) { Write-Host "无模糊匹配结果。" -Fore Red; return }
    }

    $selected = $lines | fzf --height 40% --reverse --ansi --prompt="📦 选择卸载 > "
    if (-not $selected) { return }

    $name = ($selected -split '\s+')[0]
    scoop uninstall $name
}

function i {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Package
    )

    if ($Package.Count -gt 1) {
        scoop install $Package
        return
    }

    $res = if ($Package) { scoop search $Package } else { scoop search }
    if ($res -match "No matches found") { Write-Warning "未找到 '$Package'"; return }

    $pkgs = @()
    $bucket = ''
    foreach ($line in $res) {
        $t = $line.Trim()
        if (-not $t) { continue }

        if ($t -match "^\s*'([^']+)' bucket:\s*$") {
            $bucket = $matches[1]
        }
        elseif ($t -match "^\s*([a-zA-Z0-9_.-]+)\s*\(") {
            $pkgs += [PSCustomObject]@{ Name = $matches[1]; Bucket = $bucket }
        }
    }

    if (-not $pkgs) { Write-Warning "无有效包"; return }

    if ($Package -and $pkgs.Count -eq 1 -and $pkgs[0].Name -eq $Package) {
        Write-Host "安装: $($pkgs[0].Name) (来自 '$($pkgs[0].Bucket)')" -Fore Green
        scoop install $Package
        return
    }

    $sel = $pkgs | ForEach-Object { "$($_.Name)|$($_.Bucket)|$($_.Name)" } | fzf `
        --height 40% --reverse --ansi --border=rounded `
        --delimiter='|' --with-nth=3 `
        --preview='echo Bucket: {2}' --preview-window='top:2:wrap' `
        --prompt='📦 安装> '

    if ($sel -and ($name = ($sel -split '\|')[0]) -match '^[a-zA-Z0-9_.-]+$') {
        Write-Host "正在安装: $name" -Fore Cyan
        scoop install $name
    }
}
