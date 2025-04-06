vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.colorcolumn = "80"

vim.opt.hidden = true

vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.completeopt = { 'fuzzy', 'menuone', 'noselect', 'popup' }

vim.opt.backup = false
vim.opt.writebackup = false

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "lua", "nix" },
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2
  end
})

-- Use native LSP features for completion.
-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(args)
--     local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--     if client:supports_method('textDocument/completion') then
--       print("Ha!")
--       vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
--     end
--   end
-- })

-- Show a diagnostic if the cursor is over it.
vim.o.updatetime = 250
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

vim.o.winborder = 'rounded'
