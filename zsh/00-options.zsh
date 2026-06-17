# ------------------------------
# 目录导航相关
# ------------------------------
setopt AUTO_CD           # 非目录命令若匹配目录名, 直接进入
setopt AUTO_PUSHD        # cd 切换目录时, 自动将原目录压入目录栈
setopt PUSHD_IGNORE_DUPS # 目录栈自动去重
setopt PUSHD_SILENT      # pushd/popd 切换目录时, 不打印目录栈
setopt CHASE_LINKS       # 解析软链接, pwd 显示真实物理路径
setopt PUSHD_MINUS       # 解析软链接, pwd 显示真实物理路径
setopt PUSHD_TO_HOME     # pushd 不带参数时, 直接切换到家目录 ~
setopt CD_SILENT         # cd 切换目录后, 不打印路径信息, 界面更清爽

# ------------------------------
# 历史文件基础配置
# ------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# ------------------------------
# 命令历史记录
# ------------------------------
setopt INC_APPEND_HISTORY     # 命令执行完立即写入历史文件(与 SHARE_HISTORY 互斥)
setopt EXTENDED_HISTORY       # 历史记录额外保存 时间戳 + 命令执行时长
setopt HIST_IGNORE_DUPS       # 不保存连续重复的命令
setopt HIST_FIND_NO_DUPS      # 上下键/Ctrl+R 搜索历史时, 自动跳过重复命令
setopt HIST_IGNORE_SPACE      # 行首带空格的命令, 不写入历史(保护密码)
setopt HIST_REDUCE_BLANKS     # 压缩命令中多余空格, 精简历史记录
setopt HIST_IGNORE_ALL_DUPS   # 全局去重, 仅保留最新一条重复命令
setopt HIST_SAVE_NO_DUPS      # 写入历史文件时, 删掉旧重复项, 仅保留最新一条重复命令
setopt HIST_EXPIRE_DUPS_FIRST # 历史条数到达上限 SAVEHIST 时, 优先删除重复命令
setopt HIST_VERIFY            # 使用 !! / !cmd 调用历史命令时, 先预览再执行(更安全)

# ------------------------------
# 通配符 & 文件名匹配
# ------------------------------
setopt EXTENDED_GLOB          # 启用 # ~ ^ 等高级通配符语法
setopt GLOB_DOTS              # 通配符自动匹配隐藏文件, 无需手动写 .*
setopt NUMERIC_GLOB_SORT      # 数字文件名按数值排序(10 排在 2 之后)
setopt NO_NOMATCH             # 通配符无匹配项时不报错, 避免中断执行

# ------------------------------
# Tab 补全优化
# ------------------------------
setopt AUTO_LIST              # 补全存在歧义时, 自动列出候选列表(默认开启)
setopt AUTO_MENU              # 连续按两次 Tab, 进入菜单式补全(默认开启)
setopt ALWAYS_TO_END          # 补全完成后, 光标自动跳至行尾
setopt LIST_TYPES             # 补全列表标注文件类型: 目录后缀 /、可执行文件标 *
setopt COMPLETE_IN_WORD       # 支持在单词中间位置按 Tab 补全

# ------------------------------
# 安全防误触
# ------------------------------
setopt NO_CLOBBER             # 禁止使用 > 直接覆盖已有文件; 强制覆盖请用 >! 或 >|
setopt IGNORE_EOF             # 禁用 Ctrl+D 关闭终端, 防止误操作
setopt RM_STAR_WAIT           # 执行 rm * 时, 增加等待和二次确认
setopt NO_FLOW_CONTROL        # 关闭 Ctrl+s/q 锁定/解锁终端

# ------------------------------
# 交互终端增强
# ------------------------------
setopt INTERACTIVE_COMMENTS   # 交互式终端支持 # 行内注释
setopt CORRECT                # 自动纠错命令拼写错误
setopt LONG_LIST_JOBS         # jobs 命令默认展示后台任务详细信息

# ------------------------------
# 后台任务(按需开启)
# ------------------------------
# setopt NO_BG_NICE
# setopt NO_CHECK_JOBS
# setopt NO_HUP

