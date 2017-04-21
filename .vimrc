filetype plugin on
set ignorecase
set ruler
set modeline
" Forcer à montrer la commande 
" qu'on est en train de taper :
set showcmd
set expandtab
set smartindent
set shiftwidth=2
set nocompatible
set tabstop=4
set nohlsearch
set autoindent
set number
" set mouse=a
" jamais de flash :
set vb t_vb=
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set fileencodings=utf-8,ucs-bom,default,latin1
" Folder les fonctions par défaut
" set foldmethod=indent

" keep at least 5 lines above/below
set scrolloff=5
set listchars+=space:.
set list

" 1000 undos
set undolevels=1000
syntax enable

colorscheme delek
map <C-t> :tabnew<CR>
map <C-p> :tabprevious<CR>
map <C-n> :tabnext<CR>
map <C-q> :tabclose<CR>
map <C-j> :%!python -m json.tool<CR>
