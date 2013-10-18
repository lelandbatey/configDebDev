filetype off
call pathogen#incubate()
call pathogen#helptags()
:set virtualedit=onemore
:set t_Co=256
:set t_AB=[48;5;%dm
:set t_AF=[38;5;%dm
:colorscheme Monokai-Refined
:syntax on
:set expandtab
:set tabstop=4
:set autoindent
:set smartindent
" The following sets up a very permissive backspace command, so that you can use backspace pretty much anywhere.
:set backspace=indent,eol,start
" The following 2 *map statements allow for 'inverse tabbing' using 'shift-tab'
" for insert mode
imap <S-Tab> <Esc><<i
" for command mode
nmap <S-Tab> <<

" For more info on vim configuration, look here:
" http://sontek.net/blog/detail/turning-vim-into-a-modern-python-ide
" Maps `ctrl+movementKey` to allow you to move between vim windows.
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Code completion
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabMappingForward = '<C-Tab>'
let g:SuperTabMappingBackward = '<M-C-Tab>'

" Virtualenv code completion script:
" Add the virtualenv's site-packages to vim path
"py << EOF
"import os.path
"import sys
"import vim
"if 'VIRTUAL_ENV' in os.environ:
"    project_base_dir = os.environ['VIRTUAL_ENV']
"    sys.path.insert(0, project_base_dir)
"    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"    execfile(activate_this, dict(__file__=activate_this))
"EOF
