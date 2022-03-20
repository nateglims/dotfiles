local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp_extensions.nvim'
  use 'ms-jpq/coq_nvim'

  -- Tree Sitter
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {'nvim-treesitter/playground', run = ':TSInstall query' }

  -- Utilities
  use 'scrooloose/nerdtree'
  use 'vimwiki/vimwiki'
  use {'junegunn/fzf', run = function() vim.fn['fzf#install()']() end }
  use {'junegunn/fzf.vim', after = 'fzf' }

  -- Other languages
  use 'othree/xml.vim'
  use 'fatih/vim-go'

  -- Style and UI
  use 'famiu/feline.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'morhetz/gruvbox'

  -- Bootstrap packer if not run yet.
  if packer_bootstrap then
    require('packer').sync()
  end

end)
