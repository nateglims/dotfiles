local lsp = require('lsp')
local rust_tools = require('rust-tools')

rust_tools.setup({ server = { on_attach = lsp.on_attach, capabilities = lsp.capabilities } })

-- Format rust files on save.
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 500 })
  end,
})
