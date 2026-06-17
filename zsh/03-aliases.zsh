# ------------------------------
# 目录栈
# ------------------------------
alias dirsv='dirs -v'

# ------------------------------
# 记账工具 hledger
# ------------------------------
export LEDGER_FILE=~/Documents/finances/hledger.journal
alias hlinc="hledger incomestatement -f ${LEDGER_FILE}"
alias hlbal="hledger balance -f ${LEDGER_FILE}"

# ------------------------------
# 基础文件操作
# ------------------------------
alias cp="cp -vi"          # 覆盖前询问+输出日志
alias mv="mv -vi"          # 覆盖前询问+输出日志
alias ln="ln -vi"          # 覆盖前询问+输出日志
alias cpf="command cp -vf" # 使用原生命令, 强制覆盖+输出日志
alias mvf="command mv -vf" # 使用原生命令, 强制覆盖+输出日志
alias mkdir="mkdir -pv"    # 递归创建目录+输出日志

# ------------------------------
# eza 目录列表（替代 ls）
# ------------------------------
alias ls="eza --no-quotes"        # 基础列表，不显示文件名引号
alias l="eza -lh"                 # 长格式 + 人性化大小
alias la="eza -a"                 # 显示所有文件(含隐藏文件)
alias ld="eza -lD"                # 仅列出目录
alias lf="eza -lf"                # 按文件名排序展示
alias ll="eza -lah"               # 长格式+隐藏文件+人性化大小
alias tree="eza -T"               # tree 命令兼容，等同树形展示

# ------------------------------
# Paru 包管理器
# ------------------------------
alias i="paru -S"                     # 安装 / 更新单个包
alias u="paru -Sy"                    # 刷新源 + 更新单个包
alias s="paru -Ss"                    # 搜索软件包
alias x="paru -Rns"                   # 卸载+清配置依赖
alias U="paru -Syu"                   # 全量滚动更新系统
alias sli="paru -Q"                   # 查询已安装包
alias xdep="paru -Rns $(paru -Qdtq)"  # 清理孤立依赖

# ------------------------------
# 后缀别名: 指定某些后缀的文件用特定工具打开
# ------------------------------
alias -s {lua,py,zsh}="nvim"

# ------------------------------
# 全局过滤器别名
# ------------------------------
alias -g G="| rg -i"  # e.g. `ps -ef G python`

# ------------------------------
# 通用快捷命令
# ------------------------------
alias c="clear"
alias path='echo -e ${PATH//:/\\n}' # PATH变量分行展示, 保持单引号, 双引号会提前解析变量
alias lg="lazygit"
alias lssh="lazyssh"
alias n="nvim"
alias extip="curl ip.sb"
