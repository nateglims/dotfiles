require("conform").formatters_by_ft.python = { "isort", "black" }
require('lint').linters_by_ft.python = { 'flake8' }


vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  callback = function(args)
    require("lint").try_lint()
  end,
})
