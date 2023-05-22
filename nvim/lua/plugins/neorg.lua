return {
  'nvim-neorg/neorg',
  build = ':Neorg sync-parsers',
  opts = {
    load = {
      ["core.defaults"] = {},  -- Loads default behaviour
      ["core.export"] = {},
      ["core.concealer"] = {}, -- Adds pretty icons to your documents
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/Amazon WorkDocs Drive/My Documents/notes",
            meetings = "~/Amazon WorkDocs Drive/My Documents/meetings",
          },
        },
      },
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
    }
  },
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
}
