local opts = { noremap = true, silent = true }
local function set_keymap(...) vim.api.nvim_set_keymap(...) end

-- Keybindings
set_keymap('n', '<Leader>g', ':Telescope live_grep<CR>', opts)
set_keymap('n', '<Leader>s', ':Telescope lsp_document_symbols<CR>', opts)
set_keymap('n', '<Leader>n', ':Telescope find_files previewer=false<CR>', opts)
set_keymap('n', '<Leader>N', ':Lex 40<CR>', opts)
set_keymap('n', '<Leader>b', ':Telescope buffers<CR>', opts)

-- Put the date into into the buffer.
set_keymap('n', '<Leader>tw', '"=strftime("%Y-%m-%d %a")<CR>P', opts)
set_keymap('i', '<F5>', '<C-R>=strftime("%Y-%m-%d %a")<CR>', opts)

-- Yank and paste into/from OS buffer
set_keymap('n', '[y', '"*y', opts)
set_keymap('n', '[p', '"*p', opts)
