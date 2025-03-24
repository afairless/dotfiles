return {
  -- LSP
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',

  {'nvim-tree/nvim-tree.lua', 
    dependencies = { 'nvim-tree/nvim-web-devicons'}},
  'nvim-lualine/lualine.nvim',
  'folke/which-key.nvim',

  -- autocomplete
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  {'L3MON4D3/LuaSnip', 
    version = 'v2.*', 
    dependencies = 'rafamadriz/friendly-snippets',
    build = 'make install_jsregexp'},
  {'rafamadriz/friendly-snippets'},

  -- AI autocomplete
  {'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter'},
  {'zbirenbaum/copilot-cmp', 
    config = function () 
        require('copilot_cmp').setup()
    end
  },

  -- Telescope
  'nvim-lua/plenary.nvim',
  {'nvim-telescope/telescope.nvim', 
    tag = '0.1.8', 
    dependencies = { 'nvim-lua/plenary.nvim' }},
  {'nvim-telescope/telescope-fzf-native.nvim', 
    build = 'make' },

  'windwp/nvim-autopairs',
  'hiphish/rainbow-delimiters.nvim',
  {'akinsho/bufferline.nvim', 
    version = '*', 
    dependencies = 'nvim-tree/nvim-web-devicons'},
  'numToStr/Comment.nvim',
  {'lukas-reineke/indent-blankline.nvim',
    main = 'ibl', opts = {}},
  'RRethy/vim-illuminate',

  'jpalardy/vim-slime',
  'vim-test/vim-test',
  -- 'voldikss/vim-floaterm',
  {'akinsho/toggleterm.nvim', 
    version = '*', config = true},

  -- color scheme
  { 'ellisonleao/gruvbox.nvim', 
    priority = 1000 , config = true, 
    opts = {}},
}
