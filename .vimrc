:set virtualedit=onemore
:colorscheme smyck
:set expandtab
:set tabstop=4
:set autoindent
:set smartindent
" The following 2 *map statements allow for 'inverse tabbing' using 'shift-tab'
" for insert mode
imap <S-Tab> <Esc><<i
" for command mode
nmap <S-Tab> <<
