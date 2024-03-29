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
      })
    end
  },
  'nvim-treesitter/playground',
}
