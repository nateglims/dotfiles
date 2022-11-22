local lsp = require('lsp')

lsp.setup_lsp('sumneko_lua')

-- Format lua files on save.
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.lua",
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 500 })
  end,
})
