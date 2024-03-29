return {
  --
  {
    'neovim/nvim-lspconfig',
    --    event = { "BufReadPost", "BufNewFile" },
    --    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
  },
  'nvim-lua/lsp_extensions.nvim',
  {
    'L3MON4D3/LuaSnip',
    version = "v2.*",
    dependencies = { 'rafamadriz/friendly-snippets' },
  },
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
    },
  },
}
