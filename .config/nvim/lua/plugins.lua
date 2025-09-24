return {
  -- LSP
  {
      "mason-org/mason-lspconfig.nvim",
      opts = {},
      dependencies = {
          { "mason-org/mason.nvim", opts = {} },
          "neovim/nvim-lspconfig",
      },
  },
  {
      "mason-org/mason.nvim",
      opts = {}
  },
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
    requires = {
      "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
    },
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require("copilot").setup({})
    end,
  },
  'zbirenbaum/copilot-cmp', 
  {"CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      -- See Configuration section for options
    },
  },
  {
    -- 'olimorris/codecompanion.nvim',
    -- forked to eliminate long file names in tests/screenshots
    'afairless/codecompanion.nvim',
    config = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },

  -- Telescope
  'nvim-lua/plenary.nvim',
  {'nvim-telescope/telescope.nvim', 
    tag = '0.1.8', 
    dependencies = { 'nvim-lua/plenary.nvim' }},
  {'nvim-telescope/telescope-fzf-native.nvim', 
    build = 'make' },
  'BurntSushi/ripgrep',

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
  'folke/tokyonight.nvim',
  { 'ellisonleao/gruvbox.nvim', 
    priority = 1000 , config = true, 
    opts = {}},
}
