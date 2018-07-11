set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'rust-lang/rust.vim'
"
" Snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
" Python
Plugin 'klen/python-mode'
Plugin 'vim-scripts/indentpython.vim'
" Git
Plugin 'tpope/vim-fugitive'
" Status
Plugin 'bling/vim-airline'
Plugin 'jistr/vim-nerdtree-tabs'
" " plugin from http://vim-scripts.org/vim/scripts.html
" " Plugin 'L9'
" " Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Install L9 and avoid a Naming conflict if you've already installed a
" " different version somewhere else.
" " Plugin 'ascenator/L9', {'name': 'newL9'}
"
" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
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
set paste

" 1000 undos
set undolevels=1000
syntax enable

colorscheme delek
map <C-t> :tabnew<CR>
map <C-p> :tabprevious<CR>
map <C-n> :tabnext<CR>
map <C-q> :tabclose<CR>
map <C-j> :%!python -m json.tool<CR>

command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

if exists('+colorcolumn')
    set colorcolumn=80
    hi ColorColumn ctermbg=grey guibg=grey
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
    hi ColorColumn ctermbg=lightgrey guibg=lightgrey
endif

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
"define BadWhitespace before using in a match
highlight BadWhitespace ctermbg=red guibg=darkred
let g:airline#extensions#tabline#enabled = 1
