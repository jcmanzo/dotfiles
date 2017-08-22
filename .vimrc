if $TERM_PROGRAM =~ "iTerm"
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

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

set ignorecase
set smartcase
set incsearch
set nohlsearch

set nowrap
set statusline=%f
set statusline+=\ %h%w%m%r
set statusline+=%=
set statusline+=%-16(%{exists('g:loaded_fugitive')?fugitive#statusline():''}\%)
set statusline+=\ %P/%L
set statusline+=\ 

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/tyrannicaltoucan/vim-quantum.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'chriskempson/base16-vim'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/lifepillar/vim-solarized8.git'
call plug#end()
colo solarized8_dark

