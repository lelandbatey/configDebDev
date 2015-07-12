set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

" delimiMate -- Enables SublimeText-like autocompletion for quotes, brackets, etc.
Plugin 'Raimondi/delimitMate'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"

" Tab characters '\t' are represented as 4 spaces, but they are still inserted
" as single '\t' characters
set tabstop=4
set shiftwidth=4

" Turn on autoindenting. This means a new line has the same indentation as the
" line preceding it.
set autoindent

" Makes tab and newline characters visible
" To toggle, type `set list!`
set listchars=tab:▸\ ,eol:¬

" Turns on line number for current line, then turns on relative line numbers
" for all other lines.
set number
set relativenumber

" Always show the statusline
set laststatus=2
" Our actual status line:
set statusline=%-.30f
set statusline+=%=
set statusline+=Line:\ %l
set statusline+=/%L,\ Column:
set statusline+=\ %-8c
set statusline+=\ %P

" Set total number of available colors (forcefully) to 256
set t_Co=256
" Set the background color
set t_AB=[48;5;%dm
" Set the foreground color
set t_AF=[38;5;%dm

" Lets the backspace key delete things it otherwise can't
set backspace=indent,eol,start

" Set the colorscheme
colorscheme Monokai-Refined

" Maps `ctrl+movementKey` to allow you to move between vim windows.
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Turn on delimiMate
let delimitMate_expand_cr = 1

