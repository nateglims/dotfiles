return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
      local configs = require('nvim-treesitter.configs')

      configs.setup({
        ensure_installed = { "cmake", "rust", "go", "gomod", "yaml", "python", "typescript", "c", "lua", "bitbake", "java" },
        ignore_install = {},
        highlight = {
          enable = true,
          disable = {},
        },
      })
    end
  },
}
