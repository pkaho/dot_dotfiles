# ------------------------------
# Conda 环境
# ------------------------------
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# ------------------------------
# XDG 标准目录
# ------------------------------
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# ------------------------------
# 基础工具配置
# ------------------------------
# man 手册使用 nvim 查看
export MANPAGER='nvim +Man!'

# 默认编辑器
export EDITOR="nvim"

# ------------------------------
# CUDA 环境
# ------------------------------
export LD_LIBRARY_PATH=/usr/local/cuda/lib64/:/usr/local/cuda/extras/CUPTI/lib64/
export CUDA_HOME=/usr/local/cuda/bin
export PATH=$PATH:$LD_LIBRARY_PATH:$CUDA_HOME

# ------------------------------
# Go 模块 & 镜像
# ------------------------------
export GO111MODULE=on
export GOPROXY=https://goproxy.cn

# ------------------------------
# 系统 PATH 补充
# ------------------------------
export PATH="$HOME/.local/bin:$PATH"

# ------------------------------
# fzf 模糊搜索配置
# ------------------------------

# fzf 全局样式
export FZF_DEFAULT_OPTS="
  --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9
  --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9
  --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6
  --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4
  --height 40% --layout=reverse
"

# Ctrl+t 文件搜索
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Ctrl+r 历史命令搜索
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# Alt+c 目录跳转
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

