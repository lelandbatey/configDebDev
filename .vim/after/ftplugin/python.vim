
" Within python files, allow for the running of YAPF
"autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>
"autocmd FileType python map <leader>y :0,$!yapf<Cr>

nnoremap <leader>y :0,$!yapf<Cr>
set expandtab     " enter spaces when tab is pressed
set tabstop=4     " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4  " number of spaces to use for auto indent
set autoindent    " copy indent from current line when starting a new line

" Highlight trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
