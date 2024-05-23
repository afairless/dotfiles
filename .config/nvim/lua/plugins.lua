return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind-nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use {'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons'}}
  use 'simrat39/symbols-outline.nvim'
  use 'glepnir/lspsaga.nvim'
  use 'hrsh7th/nvim-compe'
  use 'hoob3rt/lualine.nvim'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'jpalardy/vim-slime'
  use 'voldikss/vim-floaterm'
  use 'christoomey/vim-tmux-navigator'
  use 'vim-test/vim-test'
  use 'windwp/nvim-autopairs'
  use 'p00f/nvim-ts-rainbow'
  use 'glepnir/indent-guides.nvim'
  use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
end)
