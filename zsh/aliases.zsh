# ╭──────────────────────────────────────────────────────────╮
# │ dirs 目录栈                                              │
# ╰──────────────────────────────────────────────────────────╯
# 查看目录栈：倒序展示、仅保留最近10条，重新编排序号，视觉编号与 `cd -N` 行为对齐
alias dirsr='dirs -v | head -10 | tac | awk "{printf \"%d  %s\n\", NR-1, \$2}"'

# 查看目录栈：仅保留最近10条，视觉编号和 `~N` 行为对齐
alias dirsv='dirs -v | head -10 | awk "{printf \"%s  %s\n\", \$1, \$2}"'


# ╭──────────────────────────────────────────────────────────╮
# │ 文件操作增强                                             │
# ╰──────────────────────────────────────────────────────────╯
alias cp="cp -vi"
alias mv="mv -vi"
alias ln="ln -vi"

alias cpr="command cp -vf"
alias mvr="command mv -vf"

# 复制增强：带进度条，备份，人性化单位显示
cpv(){
    rsync -pogbr -hhh --backup-dir="/tmp/rsync-${USERNAME}" -e /dev/null --progress "$@"
}
compdef _files cpv


# More alias
alias bc="bc -l"
alias c="clear"
alias count="ls *|wc -l"
alias h="history"
alias j="jobs -l" # check background jobs, use fg <num> to frontground
alias mkdir="mkdir -pv"
alias path="echo -e ${PATH//:/\\n}"
alias nautilus="nautilus ."

# Get external ip, icanhazip = I can has ip
alias extip="curl icanhazip.com"

# Third party tools
alias lg="lazygit"
alias top="btop"
alias du="dust"
alias n="nvim"
alias cat="bat"
alias df="duf"

# suffix alias
# For files with a specified suffix, edit the file using the file name
alias -s {lua,py,zsh}="nvim"

# Global alias, can be used anywhere on the command line
# example: ps -ef G <keyword>
alias -g G="|rg -i"

# eza
alias ls="eza"
alias l="eza -lh"
alias la="eza -a"
alias ld="eza -D"
alias lf="eza -f"
alias ll="eza -lah"
alias lr="eza -lrh"
alias ls="eza --no-quotes"
alias lt="eza -T"
alias lab="eza --absolute"
alias lld="eza -lD"
alias llf="eza -lf"


alias i="paru -S"
alias s="paru -s"
alias x="paru -Rns"
alias u="paru -Syu"
alias sli="paru -Q"
alias xdep="paru -Rns $(paru -Qdtq)"
