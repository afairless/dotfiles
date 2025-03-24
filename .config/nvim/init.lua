require('plugins')

local o = vim.o
local wo = vim.wo
local bo = vim.bo
local g = vim.g
local cmd = vim.cmd
local map = vim.api.nvim_set_keymap

o.termguicolors = true
o.background = 'dark' -- or 'light'
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

map('n', '<leader>tn', '<cmd>TestNearest<cr>', options)
map('n', '<leader>tf', '<cmd>TestFile<cr>', options)
map('n', '<leader>tl', '<cmd>TestLast<cr>', options)
map('n', '<leader>tv', '<cmd>TestVisit<cr>', options)
map('n', '<leader>ts', '<cmd>TestSuite<cr>', options)

map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', options)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', options)
map('n', 'gr', '<cmd>lua vim.lsp.buf.diagnostics()<cr>', options)
map('n', '<leader>K', '<cmd>lua vim.lsp.buf.show_hover()<cr>', options)
map('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', options)

map('i', '<leader>jk', '<C-\\><C-n>', options) --exits insert mode for normal mode
map('t', '<Esc>', '<C-\\><C-n>', options)      --in terminal, exits insert mode for normal mode
map('t', '<leader>jk', '<C-\\><C-n>', options) --in terminal, exits insert mode for normal mode


map('n', '<leader>/', '<Plug>(comment_toggle_linewise_current)', options)
map('v', '<leader>/', '<Plug>(comment_currenttoggle_linewise_visual)', options)

map('n', '<leader>bn', '<cmd>BufferLineCycleNext<cr>', options)
map('n', '<leader>bb', '<cmd>BufferLineCyclePrev<cr>', options)
map('n', '<leader>bh', '<cmd>BufferLineCloseLeft<cr>', options)
map('n', '<leader>bl', '<cmd>BufferLineCloseRight<cr>', options)
map('n', '<leader>bj', '<cmd>BufferLinePick<cr>', options)
map('n', '<leader>be', '<cmd>BufferLinePickClose<cr>', options)

map('n', '<leader>ft', '<cmd>Telescope<cr>', options)
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', options)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', options)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', options)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', options)

-- map('n', '<leader>zc', '<cmd>CopilotChat<cr>', options)
map('n', '<leader>zg', '<cmd>CopilotChatToggle<cr>', options)
map('n', '<leader>za', '<cmd>CopilotChatAgents<cr>', options)
map('n', '<leader>zm', '<cmd>CopilotChatModels<cr>', options)
map('n', '<leader>zp', '<cmd>CopilotChatPrompts<cr>', options)
map('n', '<leader>zpc', '<cmd>CopilotChatCommit<cr>', options)
map('n', '<leader>zpd', '<cmd>CopilotChatDocs<cr>', options)
map('n', '<leader>zpx', '<cmd>CopilotChatExplain<cr>', options)
map('n', '<leader>zpf', '<cmd>CopilotChatFix<cr>', options)
map('n', '<leader>zpo', '<cmd>CopilotChatOptimize<cr>', options)
map('n', '<leader>zpr', '<cmd>CopilotChatReview<cr>', options)
map('n', '<leader>zpt', '<cmd>CopilotChatTests<cr>', options)
map('v', '<leader>zc', '<cmd>CopilotChatCommit<cr>', options)
map('n', '<leader>zt', '<cmd>CopilotChatStop<cr>', options)
map('n', '<leader>zr', '<cmd>CopilotChatReset<cr>', options)
map('n', '<leader>zs', '<cmd>CopilotChatSave<cr>', options)
map('n', '<leader>zl', '<cmd>CopilotChatLoad<cr>', options)

cmd([[
let test#python#runner = 'pytest'
let test#python#pytest#executable = 'python -m pytest'
let test#python#pytest#options = '-s'
let test#strategy = 'neovim'
]])

require('config.lazy')

-- LSP
require('mason').setup()
require('mason-lspconfig').setup()
require('lspconfig').pyright.setup {}

require('nvim-tree').setup()
require('nvim-web-devicons').setup()
require('lualine').setup { options = { theme = 'powerline' } }
require('which-key').setup()

-- autocomplete
-- https://github.com/zbirenbaum/copilot-cmp?tab=readme-ov-file
-- Unlike other completion sources, copilot can use other lines above or below an empty line to provide a completion. This can cause problematic for individuals that select menu entries with <TAB>. This behavior is configurable via cmp's config and the following code will make it so that the menu still appears normally, but tab will fallback to indenting unless a non-whitespace character has actually been typed.
local cmp = require('cmp')
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end
cmp.setup({
    mapping = {
        ['<C-Space'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end),
    },
    sources = {
        {name = 'nvim_lsp'},
        {name = 'buffer'},
        {name = 'path'},
        {name = 'luasnip'},
        {name = 'copilot'},
    },
    -- https://github.com/zbirenbaum/copilot-cmp?tab=readme-ov-file
    -- One custom comparitor for sorting cmp entries is provided: prioritize. The prioritize comparitor causes copilot entries to appear higher in the cmp menu. It is recommended keeping priority weight at 2, or placing the exact comparitor above copilot so that better lsp matches are not stuck below poor copilot matches.
    sorting = {
      priority_weight = 2,
      comparators = {
        require("copilot_cmp.comparators").prioritize,

        -- Below is the default comparitor list and order for nvim-cmp
        cmp.config.compare.offset,
        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
})
require('luasnip.loaders.from_vscode').load()

-- AI autocomplete
require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})
require('copilot_cmp').setup()
require('CopilotChat').setup()


-- Telescope
require('telescope').setup{
  defaults = {
    -- Remap the up and down arrow keys
    mappings = {
      i = {  -- Insert mode
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
      },
      n = {  -- Normal mode (for the preview window)
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
      },
    },
  },
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')


require('nvim-autopairs').setup()
require('rainbow-delimiters')
require('bufferline').setup()
require('Comment').setup()
require('ibl').setup()

require('toggleterm').setup()

-- color scheme
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
