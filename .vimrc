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

" Convenient commenting
Plugin 'scrooloose/nerdcommenter'

" Nerdtree plugin for better display
Bundle 'jistr/vim-nerdtree-tabs'

" Autoindent
Plugin 'tpope/vim-sleuth'

" Handlebars support
Plugin 'mustache/vim-mustache-handlebars'

" Rust language support
Plugin 'rust-lang/rust.vim'

" Vim-orgmode
Plugin 'jceb/vim-orgmode'

" Improved C syntax highlighting
Plugin 'justinmk/vim-syntax-extra'

" Nice Go integrations and autocompletions
Plugin 'fatih/vim-go'

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
" Set the number next to the filename in the tab to show splits and tab number
let g:airline#extensions#tabline#tab_nr_type = 2

" Have NERDTree ignore certain files
let NERDTreeIgnore = ['\.pyc$', '\.sqlite3$', '\.png$', '\.jpg$']
" Ensure NERDTree window size is sufficiently small
let NERDTreeWinSize=20

" Make YouCompleteMe close it's preview window once you leave insert mode
let g:ycm_autoclose_preview_window_after_insertion = 1

" Add powerline font support
let g:airline_powerline_fonts = 1

" When opening a new buffer, moves the previous buffer into the background and
" allows the new buffer to be opened, and hides the previous buffer, instead
" of forcing changes to be saved before opening a new buffer.
set hidden

" Switching to a buffer means switching to the existing tab if the buffer is
" open, or creating a new one if it's not.
set switchbuf=usetab,newtab

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
set listchars=tab:▸\ ,eol:¬,space:·,trail:␣

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

" Highlight matching search terms
set hlsearch

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

" Clear last search
noremap <silent> <leader>/ :let @/ = ""<CR>
" Change search highlight color
highlight Search ctermbg=yellow ctermfg=black

" Create a "crosshair" on the current position
set cursorline
set cursorcolumn

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

" Toggle paste
nmap <leader><leader>p :set paste!<enter>

" Global yank/put modifier for easy system copy/paste
" For example, let's say you've made a selection in visual mode and you'd like
" to copy it to your system clipboard. Assuming the selection is active, you'd
" type "<leader><shift><quote>y" and that would copy the selection to system
" keyboard.
map <leader>" "+

" Fix filetype associations for Markdown.
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" Fix filetype associations for Gotemplate files.
autocmd BufNewFile,BufReadPost *.gotemplate set filetype=go


map <leader>cd <plug>NERDCommenterToggle

nmap <F5> :silent !tmux split-window -h '/usr/bin/env python -i "%:p"' <CR>

" Golang syntax highlighting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Show info about current syntax highlighting unit below cursor
map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>


" Function to allow syntax highlighting within golang templates. Sets the
" syntax highlighting on lines containing a backtick to be a bogus type,
" turning off syntax highlighting for that line, thus enabling it for the
" following lines which contain templated go code
if !exists("*RemoveHighlight")
function! RemoveHighlight()
	let curline = line('.')
	let linenos = []

	let firstmatch = search('`')
	execute printf('syntax match synIgnoreLine /\%%%dl/', line('.'))

	while search('`') != firstmatch
		execute printf('syntax match synIgnoreLine /\%%%dl/', line('.'))
	endwhile

	call cursor(curline,0)
endfunction
endif
map <leader>r :call RemoveHighlight()<enter>
