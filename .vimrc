set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" User-specified vim plugins
Plugin 'tpope/vim-fugitive'

" In-file identifier completion, like Sublime Text
Plugin 'Valloric/YouCompleteMe'

" Airline, for better buffer displays
Plugin 'bling/vim-airline'

" delimiMate -- Enables SublimeText-like autocompletion for quotes, brackets, etc.
Plugin 'Raimondi/delimitMate'

" Monokai colorscheme
Plugin 'sickill/vim-monokai'

" File side view
Plugin 'scrooloose/nerdtree'

" Nerdtree plugin for better display
Bundle 'jistr/vim-nerdtree-tabs'

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

" Turn on delimiMate
let delimitMate_expand_cr = 1

" Enable airline's smarter tabline
let g:airline#extensions#tabline#enabled = 1

" When opening a new buffer, moves the previous buffer into the background and
" allows the new buffer to be opened, and hides the previous buffer, instead
" of forcing changes to be saved before opening a new buffer.
set hidden

" Switching to a buffer means switching to the existing tab if the buffer is
" open, or creating a new one if it's not.
se switchbuf=usetab,newtab

" Turn on syntax highlighting
syntax on

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
colorscheme monokai

" Map space to leader
map <space> <leader>
" For compatability, map double space to double leader.
map <space><space> <leader><leader>

" Maps `ctrl+movementKey` to allow you to move between vim windows.
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Fast resizing of windows
nnoremap <silent> <leader><leader>h :exe "vertical resize" . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <leader><leader>l :exe "vertical resize" . (winwidth(0) * 2/3)<CR>
nnoremap <silent> <leader><leader>j :exe "resize" . (winheight(0) * 3/2)<CR>
nnoremap <silent> <leader><leader>k :exe "resize" . (winheight(0) * 2/3)<CR>

" Create map to edit vimrc
map <leader>v :sp ~/.vimrc<enter>G

" Function to source `vimrc` again. Originally from here:
" https://github.com/adamryman/dotfiles/blob/c794063815e674c956bc2450c3bafa9067722016/home/adamryman/.vimrc#L124
if !exists("*SourceAgain")
	function! SourceAgain()
		execute "source ~/.vimrc"
		execute "set filetype=" . &filetype
	endfunction
endif
:map <leader>s :call SourceAgain()<enter>

" Toggle Nerdtree file view on and off
map <leader>f <plug>NERDTreeTabsToggle<CR>

" Quick opening tabs
map <leader>t :tabe<space>

" Toggleing viewing whitespace
nmap <leader>w :set list!<enter>

" Moving between buffers in normal mode
nmap <leader>m :tabnext<enter>
nmap <leader>n :tabprevious<enter>

" Inserting newlines in normal mode without moving your cursor, from here:
" http://vim.wikia.com/wiki/Insert_newline_without_entering_insert_mode
" Bind <Shift-Enter> to insert a line below you without moving your cursor
nmap <leader><Enter> o<Esc>k

" Fix filetype associations for Markdown.
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
