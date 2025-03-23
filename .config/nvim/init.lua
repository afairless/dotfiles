require('plugins')

local o = vim.o
local wo = vim.wo
local bo = vim.bo
local g = vim.g
local cmd = vim.cmd
local map = vim.api.nvim_set_keymap

o.termguicolors = true
o.mouse = 'a'
o.clipboard = [[unnamed,unnamedplus]]
o.inccommand = 'nosplit'
o.expandtab = true
o.showmode = false
o.completeopt = [[menuone,noselect]]
o.updatetime = 300
o.hidden = true
o.tabstop = 4
o.softtabstop = 0 --'0' matches value of 'tabstop'
o.shiftwidth = 0  --'0' matches value of 'tabstop'
wo.signcolumn = 'yes'
wo.number = true
wo.relativenumber = true
bo.swapfile = true

g.mapleader = ' '
-- g.floaterm_width = 0.9
-- g.floaterm_height = 0.9
g.nvim_tree_side = 'left'
g.slime_target = 'neovim'
--g.slime_target = 'tmux'
--cmd("let g:slime_default_config = {'socket_name': 'default', 'target_pane': '{last}'}")

local options = { noremap = true, silent = true }
--map('i', '<tab>', 'v:lua.tab_complete()', {expr=true})
--map('i', '<s-tab>', 'v:lua.s_tab_complete()', {expr=true})
map('n', '<C-h>', '<C-W>h', options)
map('n', '<C-j>', '<C-W>j', options)
map('n', '<C-k>', '<C-W>k', options)
map('n', '<C-l>', '<C-W>l', options)
map('n', '<leader>h', '<cmd>hide<cr>', options)
map('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', options)
map('n', '<leader>rn', ':set relativenumber<cr>', options)
-- map('n', '<leader>ft', '<cmd>FloatermToggle<cr>', options)
map('n', "<leader>tn", "<cmd>TestNearest<cr>", options)
map('n', "<leader>tf", "<cmd>TestFile<cr>", options)
map('n', "<leader>tl", "<cmd>TestLast<cr>", options)
map('n', "<leader>tv", "<cmd>TestVisit<cr>", options)
map('n', "<leader>ts", "<cmd>TestSuite<cr>", options)
map('n', "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", options)
map('n', "gr", "<cmd>lua vim.lsp.buf.references()<cr>", options)
map('i', '<leader>jk', '<C-\\><C-n>', options) --exits insert mode for normal mode
map('t', '<Esc>', '<C-\\><C-n>', options)      --in terminal, exits insert mode for normal mode
map('t', '<leader>jk', '<C-\\><C-n>', options) --in terminal, exits insert mode for normal mode

map('n', "<leader>K", "<cmd>lua vim.lsp.buf.show_hover()<cr>", options)
map('n', "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", options)

map('n', "<leader>/", "<Plug>(comment_toggle_linewise_current)", options)
map('v', "<leader>/", "<Plug>(comment_currenttoggle_linewise_visual)", options)

map('n', "<leader>bn", "<cmd>BufferLineCycleNext<cr>", options)
map('n', "<leader>bb", "<cmd>BufferLineCyclePrev<cr>", options)
map('n', "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", options)
map('n', "<leader>bl", "<cmd>BufferLineCloseRight<cr>", options)
map('n', "<leader>bj", "<cmd>BufferLinePick<cr>", options)
map('n', "<leader>be", "<cmd>BufferLinePickClose<cr>", options)

vim.o.background = 'dark' -- or 'light'

cmd([[
let test#python#runner = 'pytest'
let test#python#pytest#executable = 'python -m pytest'
let test#python#pytest#options = '-s'
let test#strategy = 'neovim'
]])

require('config.lazy')
require('lspconfig').pyright.setup {}
require('nvim-tree').setup()
require('lualine').setup { options = { theme = 'powerline' } }
require('nvim-autopairs').setup()
require('nvim-web-devicons').setup()
require('rainbow-delimiters')
require('mason').setup()
require('mason-lspconfig').setup()
require('which-key').setup()
require('Comment').setup()
require('bufferline').setup()
require('ibl').setup()
require('toggleterm').setup()

require('gruvbox').setup({
    italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
    },
})
vim.cmd([[colorscheme gruvbox]])

cmd([[highlight link CompeDocumentation NormalFloat]])

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 100 }
  end,
})
