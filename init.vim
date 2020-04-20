set nocompatible
filetype off 

call plug#begin('~/.local/share/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'rust-lang/rust.vim'
Plug 'morhetz/gruvbox'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-unimpaired'
Plug 'jremmen/vim-ripgrep'
Plug 'othree/xml.vim'
Plug 'fatih/vim-go'
call plug#end()

" set term=xterm-256color
set encoding=utf-8
set bg=dark
colorscheme gruvbox

set number
set ruler

set ts=8 et sw=4 sts=4

if has("win32")
    set mouse=a
    source $VIMRUNTIME/mswin.vim
elseif has("macunix")
else
    set term=xterm-256color
endif

noremap <leader>b :make build<CR>
noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>t :make test <CR>
noremap <leader>y "*y
noremap <leader>p "*p

" Function Key Bindings
set pastetoggle=<F3>

nnoremap <F5> "=strftime("%Y-%m-%d %a")<CR>P
inoremap <F5> <C-R>=strftime("%Y-%m-%d %a")<CR>
