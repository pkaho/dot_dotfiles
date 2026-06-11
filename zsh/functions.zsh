# ╭──────────────────────────────────────────────────────────╮
# │ yazi                                                     │
# ╰──────────────────────────────────────────────────────────╯
# refer: https://yazi-rs.github.io/docs/quick-start/#shell-wrapper
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# ╭──────────────────────────────────────────────────────────╮
# │ extract start                                            │
# ╰──────────────────────────────────────────────────────────╯
# refer: https://github.com/xvoland/Extract
SAVEIFS=$IFS
IFS="$(printf '\n\t')"

function ex {
    if [ $# -eq 0 ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|.zlib|.cso|.zst>"
        echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    fi
    for n in "$@"; do
        if [ ! -f "$n" ]; then
            echo "'$n' - file doesn't exist"
            return 1
        fi

        case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                        tar zxvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar) unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip) unzip ./"$n"   ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar|*.vhd)
                        7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace) unace x ./"$n"     ;;
            *.zpaq)      zpaq x ./"$n"      ;;
            *.arc)       arc e ./"$n"       ;;
            *.cso)       ciso 0 ./"$n" ./"$n.iso" && \
                            extract "$n.iso" && \rm -f "$n" ;;
            *.zlib)      zlib-flate -uncompress < ./"$n" > ./"$n.tmp" && \
                            mv ./"$n.tmp" ./"${n%.*zlib}" && rm -f "$n"   ;;
            *.dmg)
                        hdiutil mount ./"$n" -mountpoint "./$n.mounted" ;;
            *.tar.zst)  tar -I zstd -xvf ./"$n"  ;;
            *.zst)      zstd -d ./"$n"  ;;
            *)
                        echo "extract: '$n' - unknown archive method"
                        return 1
                        ;;
        esac
    done
}

IFS=$SAVEIFS

# ╭──────────────────────────────────────────────────────────╮
# │ 复制增强                                                 │
# ╰──────────────────────────────────────────────────────────╯

# 复制地址
# copypath <pwd>
function copypath {
    # 不传参数时，默认使用当前目录
    local file="${1:-.}"

    # 如果传入的不是绝对路径，拼接上当前工作目录路径
    [[ $file = /* ]] || file="$PWD/$file"

    # 复制绝对路径（不解析软链接）
    # 剪贴板操作失败则终止函数并返回错误码
    print -n "${file:a}" | wl-copy || return 1

    # 输出提示信息：已将路径复制到剪贴板
    echo ${(%):-"%B${file:a}%b 已复制到剪贴板。"}
}

# ╭──────────────────────────────────────────────────────────╮
# │ 可视化进度 cp                                            │
# ╰──────────────────────────────────────────────────────────╯

# 在任意目录下都可以使用 dotter
function dsource {
    # 进入 dotfiles 目录执行部署，执行完成后重新启动 zsh
    pushd ~/.dotfiles >/dev/null
    dotter deploy -vf
    popd >/dev/null
    exec zsh
}
