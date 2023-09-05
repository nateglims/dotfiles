-- Move these out of vimscript over time...
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.colorcolumn = "80"

vim.opt.hidden = true

vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.cmd([[
set encoding=utf-8

set termguicolors
highlight Comment cterm=italic

autocmd FileType yaml,lua,nix setlocal ts=2 sts=2 sw=2

if has("win32")
  set mouse=a
  source $VIMRUNTIME/mswin.vim
endif

set nobackup
set nowritebackup
set signcolumn=yes

" Completion setup
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

]])

