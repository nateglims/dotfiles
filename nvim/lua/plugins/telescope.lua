return {
  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-dap.nvim',
    },
    config = function()
      local opts = { noremap = true, silent = true }
      local function set_keymap(...) vim.api.nvim_set_keymap(...) end

      -- Keybindings
      set_keymap('n', '<Leader>g', ':Telescope live_grep<CR>', opts)
      set_keymap('n', '<Leader>s', ':Telescope lsp_document_symbols<CR>', opts)
      set_keymap('n', '<Leader>S', ':Telescope lsp_workspace_symbols<CR>', opts)
      set_keymap('n', '<Leader>n', ':Telescope find_files previewer=false<CR>', opts)
      set_keymap('n', '<Leader>b', ':Telescope buffers<CR>', opts)

      local telescope = require('telescope')
      telescope.setup {
        extensions = {
          ["ui-select"] = {
            require('telescope.themes').get_dropdown {}
          }
        }
      }

      telescope.load_extension("ui-select")
      telescope.load_extension("dap")
    end
  },
}
