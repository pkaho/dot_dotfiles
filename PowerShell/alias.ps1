Set-Alias -Name n     -Value nvim
Set-Alias -Name vim   -Value nvim
Set-Alias -Name lg    -Value lazygit
Set-Alias -Name c     -Value clear
Set-Alias -Name ff    -Value fastfetch
Set-Alias -Name of    -Value onefetch

function nm     { nvim -u ~/AppData/Local/nvim/minimal.lua @args }
function crb    { Clear-RecycleBin -Force }
function rm     { Remove-Item -Force -Recurse -Path @args }
function imgcat { wezterm imgcat @args }
function labelme  { uvx labelme @args }                      # uv tool install -w onnxruntime==1.20.1 labelme
function labelimg { uvx --from labelimg labelImg.exe @args } # uv tool install -w setuptools labelimg

# hledger
$LEDGER_FILE = "~\Documents\finances\hledger.journal"
function hlinc { hledger incomestatement @args -f $LEDGER_FILE }
function hlbal { hledger balance @args -f $LEDGER_FILE }

# eza
Remove-Item alias:ls -Force
function l    { eza --icons -1 @args }
function la   { eza --icons -la @args }
function ld   { eza --icons -D @args }
function lf   { eza --icons -f @args }
function ll   { eza --icons -lah @args }
function ln   { eza --icons '--no-quotes' @args }
function lr   { eza --icons -lhr @args }
function ls   { eza --icons @args }
function lab  { eza --icons --absolute @args }
function tree { eza --icons -T @args }

# change dir
function cd..  { cd .. }
function ..    { cd .. }
function ...   { cd ../.. }
function ....  { cd ../../.. }

# chezmoi
function ccd  { chezmoi cd }
function cap  { chezmoi apply -v }
function cdf  { chezmoi diff @args }
function cmg  { chezmoi merge @args }
function cmga { chezmoi merge-all }

function gitc { git clone https://github.com/$args }

function open {
    param([string]$path = $null)

    if ([string]::IsNullOrWhiteSpace($path)) {
        explorer .
    } else {
        explorer $path
    }
}

function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi @args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -Path $cwd
    }
    Remove-Item -Path $tmp
}

$registryPath = "HKCU:/SOFTWARE/Microsoft/InputMethod/Settings/CHS"
function setqp {
    # 如果不存在则创建注册表项
    if (-not (Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force
    }

    New-ItemProperty -Path $registryPath -Name "Enable Double Pinyin" -Value 0 -PropertyType DWORD -Force
        New-ItemProperty -Path $registryPath -Name "DoublePinyinScheme" -Value 0 -PropertyType DWORD -Force
        New-ItemProperty -Path $registryPath -Name "UserDefinedDoublePinyinScheme0" -Value "" -Force
}

function setxh {
    # 如果不存在则创建注册表项
    if (-not (Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force
    }

    # 启用小鹤双拼
    New-ItemProperty -Path $registryPath -Name "Enable Double Pinyin" -Value 1 -PropertyType DWORD -Force
    New-ItemProperty -Path $registryPath -Name "DoublePinyinScheme" -Value 10 -PropertyType DWORD -Force
    New-ItemProperty -Path $registryPath -Name "UserDefinedDoublePinyinScheme0" -Value "小鹤双拼*2*^*iuvdjhcwfg^xmlnpbksqszxkrltvyovt" -Force
}
