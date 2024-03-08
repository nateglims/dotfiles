local lsp = require('lsp')

lsp.setup_lsp('rust_analyzer')

-- Format rust files on save.
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    print("formatting...")
    vim.lsp.buf.format({ timeout_ms = 500 })
  end,
})
