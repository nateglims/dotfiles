local opts = { noremap = true, silent = true }
local function set_keymap(...) vim.api.nvim_set_keymap(...) end

-- Put the date into into the buffer.
set_keymap('n', '<Leader>tw', '"=strftime("%Y-%m-%d %a")<CR>P', opts)
set_keymap('i', '<F5>', '<C-R>=strftime("%Y-%m-%d %a")<CR>', opts)

-- Yank and paste into/from OS buffer
set_keymap('n', '<Leader>yy', '"*yy', opts)
set_keymap('n', '<Leader>y', '"*y', opts)
set_keymap('v', '<Leader>y', '"*y', opts)
set_keymap('n', '<Leader>p', '"*p', opts)
set_keymap('n', '<Leader>P', '"*P', opts)
set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
