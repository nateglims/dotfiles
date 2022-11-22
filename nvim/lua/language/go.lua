--
-- https://github.com/ray-x/go.nvim
local lsp = require('lsp')

require('go').setup()

lsp.setup_lsp('gopls')

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = format_sync_grp,
})
