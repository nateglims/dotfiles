vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.colorcolumn = "80"

vim.opt.hidden = true

vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.completeopt = { 'fuzzy', 'menuone', 'noselect' }

vim.opt.backup=false
vim.opt.writebackup=false

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "lua", "nix" },
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2
  end
})

