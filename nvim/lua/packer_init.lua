local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

-- Prevent error dump when packer isn't initialized.
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Packer not installed.")
  return
end

-- Use a floating window instead of splitting.
packer.init {
  display = {
    open_fn = function()
      -- This takes the same options as `nvim_open_win`
      return require("packer.util").float {}
    end
  }
}

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'


  -- Snippets are needed for nvim-cmp
  use 'rafamadriz/friendly-snippets'
  use({ "L3MON4D3/LuaSnip", tag = "v1.*" })
  use 'saadparwaiz1/cmp_luasnip'


  -- Tree Sitter

  -- Utilities
  use 'vimwiki/vimwiki'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use {
    "nvim-neorg/neorg",
    run = ":Neorg sync-parsers", -- This is the important bit!
    config = function()
      require("neorg").setup {
        -- configuration here
        load = {
          ["core.defaults"] = {},       -- Loads default behaviour
          ["core.export"] = {},
          ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.norg.dirman"] = {
            config = {
              workspaces = {
                notes = "~/Amazon WorkDocs Drive/My Documents/notes",
                meetings = "~/Amazon WorkDocs Drive/My Documents/meetings",
              },
            },
          },
          ["core.norg.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
        }
      }
    end,
  }

  -- Other languages
  use 'othree/xml.vim'
  use 'ray-x/go.nvim'
  use 'simrat39/rust-tools.nvim'

  -- Style and UI
  use 'kyazdani42/nvim-web-devicons'
  use 'folke/tokyonight.nvim'
  use 'morhetz/gruvbox'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- Bootstrap packer if not run yet.
  if packer_bootstrap then
    require('packer').sync()
  end
end)
