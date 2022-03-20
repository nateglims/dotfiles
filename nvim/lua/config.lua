vim.cmd([[
set encoding=utf-8

set bg=dark
set termguicolors
colorscheme gruvbox
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

let g:coq_settings = { 'auto_start': v:true }

" Completion setup
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Do inlay hints on rust files.
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs
  \ lua require'lsp_extensions'.inlay_hints{ prefix = ' ➤ ', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"}}

" Format rust files on save.
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
]])

-- Keybindings
vim.api.nvim_set_keymap('n', '<Leader>rg', ':Rg<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>n', ':NERDTreeToggle<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>y', '"*y', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>p', '"*p', { noremap = true, silent = true})

