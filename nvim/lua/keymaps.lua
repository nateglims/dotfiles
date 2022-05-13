local opts = { noremap = true, silent = true }
local function set_keymap(...) vim.api.nvim_set_keymap(...) end

-- Keybindings
set_keymap('n', '<Leader>g', ':Telescope live_grep<CR>', opts)
set_keymap('n', '<Leader>n', ':Telescope find_files previewer=false<CR>', opts)
set_keymap('n', '<Leader>N', ':Lex 40<CR>', opts)
set_keymap('n', '<Leader>b', ':Telescope buffers<CR>', opts)

set_keymap('n', '<Leader>y', '"*y', opts)
set_keymap('n', '<Leader>p', '"*p', opts)

set_keymap('n', '<Leader>tw', '"=strftime("%Y-%m-%d %a")<CR>P', opts)
set_keymap('i', '<F5>', '<C-R>=strftime("%Y-%m-%d %a")<CR>', opts)
set_keymap('n', '<Leader>cd', ":lua require'plugins/wiki'.ConvertToDocx()<CR>", opts)
set_keymap('n', '<Leader>cx', ":lua require'plugins/wiki'.ConvertToWiki()<CR>", opts)
