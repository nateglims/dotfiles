return {
  {
    'othree/xml.vim',
    ft = "xml",
  },
  {
    'ray-x/go.nvim',
    ft = "go",
  },
  --{
  --  'mrcjkb/rustaceanvim',
  --  version = '^4', -- Recommended
  --  ft = { 'rust' },
  --},
  {
    'stevearc/conform.nvim',
    opts = {},
  },
  {
    'mfussenegger/nvim-lint',
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
  },
}
