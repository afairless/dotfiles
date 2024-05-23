return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use {'kyazdani42/nvim-tree.lua', 
    requires = {'kyazdani42/nvim-web-devicons'}}                                

  --use 'hrsh7th/cmp-nvim-lsp'
  --use 'hrsh7th/cmp-buffer'
  --use 'hrsh7th/cmp-path'
  --use 'hrsh7th/nvim-cmp'
  --use {'L3MON4D3/LuaSnip', run = 'make install_jsregexp'}
  --use 'saadparwaiz1/cmp_luasnip'
  --use 'rafamadriz/friendly-snippets'

  use 'nvim-lualine/lualine.nvim'
  use 'jpalardy/vim-slime'
  use 'voldikss/vim-floaterm'
  use 'vim-test/vim-test'
  use 'windwp/nvim-autopairs'
  use 'hiphish/rainbow-delimiters.nvim'
  use {'morhetz/gruvbox', 
    config = function() vim.cmd.colorscheme('gruvbox') end}
end)
