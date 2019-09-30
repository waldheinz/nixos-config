" trim tailing whitespace
autocmd BufWritePre * %s/\s\+$//e

syntax enable
set background=dark
" let g:solarized_termcolors=256
colorscheme solarized

" AirlineTheme solarized

" Spaces & Tabs {{{
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
set textwidth=120
" }}} Spaces & Tabs

" UI Config {{{
set hidden
set number                   " show line number
set showcmd                  " show command in bottom bar
set cursorline               " highlight current line
set wildmenu                 " visual autocomplete for command menu
set showmatch                " highlight matching brace
" set laststatus=2             " window will always have a status line
set updatetime=100
set nobackup
set noswapfile
set cc=+1
" }}} UI Config
