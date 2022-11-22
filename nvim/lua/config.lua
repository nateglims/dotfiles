vim.cmd([[
set encoding=utf-8

set bg=dark
set termguicolors
colorscheme tokyonight-night
highlight Comment cterm=italic

set number
set ruler

set ts=4 et sw=4 sts=4

autocmd FileType yaml,lua setlocal ts=2 sts=2 sw=2

if has("win32")
  set mouse=a
  source $VIMRUNTIME/mswin.vim
endif

set hidden
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

-- Auto sync packer when saving the plugin list file.
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]
