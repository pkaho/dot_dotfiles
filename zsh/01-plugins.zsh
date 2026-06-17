# =============================================================================
# Zim 模块框架初始化
# =============================================================================

ZIM_HOME="${ZDOTDIR:-$HOME}/.zim"

# 自动下载 zimfw 管理器
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o "${ZIM_HOME}/zimfw.zsh" \
        "https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh"
  else
    mkdir -p "${ZIM_HOME}" && wget -nv -O "${ZIM_HOME}/zimfw.zsh" \
        "https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh"
  fi
fi

# 配置文件变更时重新生成初始化脚本
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-$HOME}/.zimrc} ]]; then
  source "${ZIM_HOME}/zimfw.zsh" init
fi

# Zim 模块自定义样式, 放在加载 ~/.zim/init.zsh 前
zstyle ':zim:git' aliases-prefix 'G'
zstyle ':zim:input' double-dot-expand yes

# 加载 Zim 运行脚本
source "${ZIM_HOME}/init.zsh"

# =============================================================================
# Zsh 插件专项配置
# =============================================================================

# Zsh Autosuggestions 自动建议
# 禁用每次 precmd 时自动重新绑定小部件, 可以大幅提升性能
# 需确保 .zimrc 中最后加载此插件
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#808080,underline,bold' # 提示样式
ZSH_AUTOSUGGEST_STRATEGY=(history completion)               # 优先匹配历史记录, 其次补全

# Zsh Syntax Highlighting 语法高亮
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]='fg=#808080'
ZSH_HIGHLIGHT_STYLES[command]='fg=#19c623'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#efe545'

