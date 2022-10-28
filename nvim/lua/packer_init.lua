local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
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

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp_extensions.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- Snippets are needed for nvim-cmp
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- Tree Sitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/playground', run = ':TSInstall query' }

  -- Utilities
  use 'vimwiki/vimwiki'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  -- Other languages
  use 'othree/xml.vim'
  use 'fatih/vim-go'
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
