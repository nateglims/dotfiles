return {
  -- Zen mode is needed for neorg presentations.
  { "folke/zen-mode.nvim" },
  {
    "nvim-neorg/neorg",
    ft = 'norg',
    lazy = true,
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
