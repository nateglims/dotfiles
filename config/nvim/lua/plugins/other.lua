return {
  {
    'othree/xml.vim',
    ft = "xml",
  },
  {
    'ray-x/go.nvim',
    ft = "go",
  },
  {
    'simrat39/rust-tools.nvim',
    ft = "rust",
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  }
}
