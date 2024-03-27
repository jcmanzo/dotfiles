syntax on
filetype indent plugin on

set backspace=indent,eol,start

" Show line numbers
set number

set numberwidth=2

" Show file stats
set ruler

" Security
set modelines=0

" Encoding
set encoding=utf-8

set tabstop=4
set shiftwidth=4
set expandtab

let g:airline#extensions#tagbar#enabled = 1
let g:airline_theme='quantum'

set ignorecase
set smartcase
set incsearch
set nohlsearch

set wrap

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/tyrannicaltoucan/vim-quantum.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'vim-airline/vim-airline'
Plug 'https://github.com/matze/vim-move.git'
call plug#end()
