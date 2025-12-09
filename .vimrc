let mapleader=" "
syntax on
set number
set relativenumber
set cursorline
set wrap
set showcmd
" wildmenu 打开vim tab提示
set wildmenu

" 使用前需要安装xclip或clip库
" set clipboard=unnamedplus
" windows 系统下有时候unnamedplus会有问题
set clipboard=unnamed

" 搜索时忽略大小写
set ignorecase
" 智能搜索, 大小写
set smartcase
set ignorecase
set hlsearch " 搜索高亮
exec "nohlsearch"
set incsearch " 搜索实时高亮
set showmode

set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse=a
set encoding=utf-8
let &t_ut=''
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set list
set listchars=tab:▸\ ,trail:▫
set scrolloff=5
set tw=0
set smarttab
set autoindent
set autochdir
set indentexpr=
" 让退格键在行首时按一下能自动回到行尾
set backspace=indent,eol,start
" 缩进代码
set foldmethod=indent
set foldlevel=99
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_SR = "\<Esc>]50;CursorShape=2\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set laststatus=2
" 让光标回到上一次编辑的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

noremap <c-j> 5j
noremap <c-k> 5k
noremap <c-h> 5h
noremap <c-l> 5l
noremap <c-s> :w<cr>
noremap Q :q<enter>

" 查找下一个或上一个时自动居中

noremap n nzz

map <c-u> <c-r>

map <leader>k <c-w>k
map <leader>j <c-w>j
map <leader>h <c-w>h
map <leader>l <c-w>l

map <up> :res -5<cr>
map <down> :res +5<cr>
map <left> :vertical resize-5<cr>
map <right> :vertical resize+5<cr>

map te :tabe<cr>
map tn :tabn<cr>
map tp :tabp<cr>
map tc :tabc<cr>

map sv <c-w>v
map sh <c-w>s

vnoremap > >gv
vnoremap < <gv

