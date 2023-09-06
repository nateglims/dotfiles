return {
  { 'nvim-treesitter/nvim-treesitter',
    config = function()
      local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
      -- Tree Sitter setup
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "rust", "go", "typescript", "c", "lua", "bitbake" },
        ignore_install = {},
        highlight = {
          enable = true,
          disable = {},
        },
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,
          persist_queries = false,
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        },
      }
    end
  },
  'nvim-treesitter/playground',
}
