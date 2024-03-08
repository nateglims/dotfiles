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
  { "folke/zen-mode.nvim" },
  {
    "nvim-neorg/neorg",
    ft = 'norg',
    cmd = 'Neorg',
    build = ":Neorg sync-parser",
    keys = {
      { '<Leader>cc', '<cmd>Neorg toggle-concealer<CR>', desc = "Toggle concealer" },
    },
    config = function()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {},
          ['core.concealer'] = {},
          ['core.integrations.treesitter'] = {},
          ['core.export'] = {},
          ['core.presenter'] = {
            config = {
              zen_mode = "zen-mode",
            },
          },
          ['core.export.markdown'] = {
            config = { extensions = "all" },
          },
          ['core.dirman'] = {
            config = {
              workspaces = {
                notes = "~/WorkDocs/notes",
              },
            },
          },
        },
      }
    end,
  },
}
