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

# python
export PATH=$PATH:/home/panjh/.local/bin

# XDG (X Desktop Group) 基本目录
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# homebrew
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_PIP_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple"

# 使用 nvim 显示 man 页面
export MANPAGER='nvim +Man!'

# CUDA
export LD_LIBRARY_PATH=/usr/local/cuda/lib64/:/usr/local/cuda/extras/CUPTI/lib64/
export CUDA_HOME=/usr/local/cuda/bin
export PATH=$PATH:$LD_LIBRARY_PATH:$CUDA_HOME

# 使用 fc 命令启动编辑器, 默认使用 vi
# 除 fc 命令还可以使用 C-xC-e 快捷键编辑当前或上一条命令
export EDITOR="nvim"

#  >>>>>>>>>>>>> fzf >>>>>>>>>>>>>
source <(fzf --zsh)

# fzf theme
export FZF_DEFAULT_OPTS="
  --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9
  --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9
  --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6
  --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4
  --height 40% --layout=reverse
"
# C-t 文件搜索
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# C-r 历史命令
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# A-c 目录跳转
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"
#  <<<<<<<<<<<<< fzf <<<<<<<<<<<<<

# Go 镜像源
export GO111MODULE=on
export GOPROXY=https://goproxy.cn
