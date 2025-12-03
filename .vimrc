syntax on
set nocompatible
set number
set cursorline
set wrap
set showcmd
" wildmenu 打开vim tab提示
set wildmenu

set clipboard=unnamedplus

" 搜索时忽略大小写
set ignorecase
" 智能搜索, 大小写
set smartcase
set ignorecase
set hlsearch " 搜索高亮
set incsearch " 搜索实时高亮
set showmode
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse=a
set encoding=utf-8
set list
set autochdir
set scrolloff=5
set ts=4
set tabstop=4
set expandtab
set shiftwidth=4
set smarttab
set autoindent

let mapleader=" "

noremap <c-j> 5j
noremap <c-k> 5k
noremap <c-h> 5h
noremap <c-l> 5l
noremap <c-s> :w<cr>

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

map sv <c-w>t<c-w>H
map sh <c-w>t<c-w>K

