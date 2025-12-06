-- 设置 leader 键为空格
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- 语法高亮（对应 syntax on）
vim.cmd('syntax on')

-- ========================================
-- 显示相关配置
-- ========================================
vim.opt.number = true                -- 显示行号（set number）
vim.opt.relativenumber = true        -- 显示相对行号（set relativenumber）
vim.opt.cursorline = true            -- 高亮光标行（set cursorline）
vim.opt.wrap = true                  -- 自动换行（set wrap）
vim.opt.showcmd = true               -- 显示输入的命令（set showcmd）
vim.opt.wildmenu = true              -- 开启 tab 补全提示（set wildmenu）
vim.opt.showmode = true              -- 显示当前模式（set showmode）
vim.opt.laststatus = 2               -- 始终显示状态栏（set laststatus=2）
vim.opt.scrolloff = 5                -- 光标上下保留5行滚动边距（set scrolloff=5）
vim.opt.termguicolors = true         -- 启用24bit色彩

-- ========================================
-- 剪贴板配置
-- ========================================
-- 使用系统剪贴板（对应 set clipboard=unnamed）
-- 若需 unnamedplus（跨终端），改为 "unnamedplus"（需安装 xclip/clip）
-- windows需要安装win32yank，否则可能粘贴结果不正确
--   curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
--   unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
--   chmod +x /tmp/win32yank.exe
--   sudo mv /tmp/win32yank.exe /usr/local/bin/
vim.opt.clipboard = "unnamedplus"

-- ========================================
-- 搜索相关配置
-- ========================================
vim.opt.ignorecase = true            -- 搜索忽略大小写（set ignorecase）
vim.opt.smartcase = true             -- 智能大小写（set smartcase）
vim.opt.hlsearch = true              -- 搜索结果高亮（set hlsearch）
vim.cmd('nohlsearch')                -- 初始关闭高亮（exec "nohlsearch"）
vim.opt.incsearch = true             -- 实时搜索（set incsearch）

-- ========================================
-- 文件类型 & 兼容性
-- ========================================
-- Neovim 默认开启 nocompatible，无需手动设置
-- 开启文件类型检测 + 插件 + 缩进（合并原 filetype 系列配置）
vim.cmd('filetype plugin indent on')

-- ========================================
-- 鼠标 & 编码
-- ========================================
vim.opt.mouse = "a"                  -- 启用所有模式的鼠标支持（set mouse=a）
vim.opt.encoding = "utf-8"           -- 设置编码为 utf-8（set encoding=utf-8）

-- ========================================
-- 缩进 & 制表符配置
-- ========================================
vim.opt.expandtab = true             -- 空格替代制表符（set expandtab）
vim.opt.tabstop = 2                  -- 制表符宽度2（set tabstop=2）
vim.opt.shiftwidth = 2               -- 缩进宽度2（set shiftwidth=2）
vim.opt.softtabstop = 2              -- 软制表符宽度2（set softtabstop=2）
vim.opt.list = true                  -- 显示不可见字符（set list）
-- 设置不可见字符样式（tab: ▸ , trail: ▫）
vim.opt.listchars = { tab = '▸ ', trail = '▫' }
vim.opt.smarttab = true              -- 智能制表符（set smarttab）
vim.opt.autoindent = true            -- 自动缩进（set autoindent）
vim.opt.autochdir = true             -- 自动切换工作目录（set autochdir）
vim.opt.indentexpr = ''              -- 清空缩进表达式（set indentexpr=）
-- 退格键行为（行首可回退到行尾）
vim.opt.backspace = { 'indent', 'eol', 'start' }

-- ========================================
-- 代码折叠
-- ========================================
vim.opt.foldmethod = "indent"        -- 按缩进折叠（set foldmethod=indent）
vim.opt.foldlevel = 99               -- 默认展开所有折叠（set foldlevel=99）

-- ========================================
-- 文本宽度
-- ========================================
vim.opt.textwidth = 0                -- 对应 set tw=0（textwidth 缩写为 tw）
