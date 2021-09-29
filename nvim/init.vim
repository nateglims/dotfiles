set nocompatible
filetype off 

call plug#begin('~/.local/share/nvim/plugged')
" The good stuff.
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'     " Better Completions
Plug 'nvim-lua/lsp_extensions.nvim' " Inlays!
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}    " Highlighting among other things.
Plug 'nvim-treesitter/playground', {'do': ':TSInstall query'}  " This is neat but idk yet.
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Utilities
Plug 'scrooloose/nerdtree'
Plug 'vimwiki/vimwiki'
" Plug 'tpope/vim-unimpaired'
" Plug 'jremmen/vim-ripgrep'

" Other language stuff
Plug 'othree/xml.vim'
Plug 'fatih/vim-go'
" Plug 'rust-lang/rust.vim'

" Style Stuff
Plug 'famiu/feline.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'morhetz/gruvbox'
call plug#end()

set encoding=utf-8


" Set up UI theme stuff.
set bg=dark
set termguicolors
colorscheme gruvbox
highlight Comment cterm=italic

set number
set ruler


set ts=4 et sw=4 sts=4

autocmd FileType yaml setlocal ts=2 sts=2 sw=2

if has("win32")
    set mouse=a
    source $VIMRUNTIME/mswin.vim
endif

noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>y "*y
noremap <leader>p "*p

" Function Key Bindings
set pastetoggle=<F3>

nnoremap <F5> "=strftime("%Y-%m-%d %a")<CR>P
inoremap <F5> <C-R>=strftime("%Y-%m-%d %a")<CR>

set hidden
set nobackup
set nowritebackup
set signcolumn=yes

lua <<EOF
require('feline').setup()
-- Tree Sitter setup
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = false,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
}

-- Icon Setup
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  require'completion'.on_attach(client, bufnr)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

EOF

" Completion setup
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs
            \ lua require'lsp_extensions'.inlay_hints{ prefix = ' ➤ ', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"}}
