# ----------------------------------------------------------------------------
#  历史记录设置
# ----------------------------------------------------------------------------

# 添加重复命令时自动删除旧记录，保持历史列表唯一
setopt HIST_IGNORE_ALL_DUPS

# ----------------------------------------------------------------------------
#  行编辑器设置
# ----------------------------------------------------------------------------

# 编辑模式：emacs 快捷键（-e）或 vim 快捷键（-v）
bindkey -e

# 定义单词边界字符（删除 '/' 使快捷键在路径分隔符处停留）
# 查看效果：echo ${WORDCHARS//[\/]}
WORDCHARS=${WORDCHARS//[\/]}

# ----------------------------------------------------------------------------
#  命令纠错
# ----------------------------------------------------------------------------

# 开启命令名拼写纠错
setopt CORRECT
# 自定义纠错提示信息（红色为错误词，绿色为建议词）
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# ----------------------------------------------------------------------------
#  Zsh Autosuggestions（自动补全建议）
# ----------------------------------------------------------------------------

# 禁用每次 precmd 时自动重新绑定小部件（需确保 zim 中该模块为最后一个）
# 参考：https://github.com/zimfw/zimfw/issues?q=autosuggest
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# 自定义建议文本样式：灰色 + 下划线 + 粗体
# 参考：https://github.com/zsh-users/zsh-autosuggestions#suggestion-highlight-style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242,underline,bold'

# ----------------------------------------------------------------------------
#  Zsh Syntax Highlighting（命令语法高亮）
# ----------------------------------------------------------------------------

# 启用高亮器：main（主高亮）+ brackets（括号匹配）
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# 自定义各语法元素的显示颜色
typeset -A ZSH_HIGHLIGHT_STYLES
# 注释（# 开头的内容）显示为灰色
ZSH_HIGHLIGHT_STYLES[comment]='fg=242'
# 可在此添加更多自定义样式，例如：
# ZSH_HIGHLIGHT_STYLES[command]='fg=green'
# ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'


# ----------------------------------------------------------------------------
#  Zim 模块管理框架（可选配置，默认注释）
# ----------------------------------------------------------------------------

# 为 git 模块的别名添加自定义前缀
# zstyle ':zim:git' aliases-prefix 'g'

# 输入连续点号自动扩展为路径（.. -> ../，... -> ../../）
zstyle ':zim:input' double-dot-expand yes


# ============================================================================
#  初始化 Zim 模块框架
# ============================================================================

ZIM_HOME="${ZDOTDIR:-$HOME}/.zim"

# 如果 zimfw 脚本不存在，则自动下载
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o "${ZIM_HOME}/zimfw.zsh" \
        "https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh"
  else
    mkdir -p "${ZIM_HOME}" && wget -nv -O "${ZIM_HOME}/zimfw.zsh" \
        "https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh"
  fi
fi

# 当 .zimrc 比 init.zsh 新时，重新生成初始化脚本
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-$HOME}/.zimrc} ]]; then
  source "${ZIM_HOME}/zimfw.zsh" init
fi

# 加载 Zim 初始化脚本
source "${ZIM_HOME}/init.zsh"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# ----------------------------------------------------------------------------
# 批量加载模块文件
# ----------------------------------------------------------------------------

# 如果希望只在交互终端生效，脚本执行时不加载，取消下面的注释
# if [[ $- == *i* ]]; then
for file in ~/.zsh/*.zsh; do
    [[ -f "$file" ]] && source "$file"
done
# fi
