# ------------------------------
# Yazi 文件管理器 目录跳转封装
# ------------------------------
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# ------------------------------
# 通用解压函数 ex
# ------------------------------
SAVEIFS=$IFS
IFS="$(printf '\n\t')"

function ex {
    if [ $# -eq 0 ]; then
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

# ------------------------------
# 复制文件/目录绝对路径到剪贴板
# ------------------------------
function copypath {
    local file="${1:-.}"
    [[ $file = /* ]] || file="$PWD/$file"
    print -n "${file:a}" | wl-copy || return 1
    echo ${(%):-"%B${file:a}%b 已复制到剪贴板。"}
}

# ------------------------------
# 带进度条复制 cpv, 复制的同时备份到 --backup-dir
# ------------------------------
cpv(){
    rsync -pogbr -hhh --backup-dir="/tmp/rsync-${USERNAME}" -e /dev/null --progress "$@"
}
compdef _files cpv

