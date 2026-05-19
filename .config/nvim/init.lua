require('plugins')

local o = vim.o
local wo = vim.wo
local bo = vim.bo
local g = vim.g
local cmd = vim.cmd
local nvim_cmd = vim.api.nvim_create_autocmd
local map = vim.api.nvim_set_keymap

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

vim.opt.list = true
vim.opt.listchars = {
  tab = '→ ',
  trail = '·',
  eol = '↲',
  space = '·',
  nbsp = '␣',
  extends = '»',
  precedes = '«',
  lead = '·',
}

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

nvim_cmd('FileType', {
  pattern = {'python', 'rust', 'c', 'cpp', 'javascript', 'css', 'lua', 'vim', 'sh'},
  command = 'setlocal nowrap'
})

g.mapleader = ' '
-- g.floaterm_width = 0.9
-- g.floaterm_height = 0.9
g.nvim_tree_side = 'left'

g.slime_target = 'neovim'
--g.slime_target = 'tmux'
--cmd("let g:slime_default_config = {'socket_name': 'default', 'target_pane': '{last}'}")
-- for CPython for Python <3.12, set g.slime_bracketed_paste = 0
g.slime_bracketed_paste = 1
g.slime_python_ipython = 0
map('n', '<C-c><C-c>', [[<Plug>SlimeLineSend]], { noremap = false, silent = true })
-- failed vim-slime troubleshooting
-- g.slime_cell_delimiter = '^$'
-- map('n', '<C-x>', [[<Plug>SlimeSendCell]], { noremap = false, silent = true })

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
map('n', '<leader>rc', ':source $MYVIMRC<cr>', options)
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
map('v', '<leader>/', '<Plug>(comment_toggle_linewise_current)', options)
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

map('n', '<C-a>', '<cmd>CodeCompanionActions<cr>', options)
map('v', '<C-a>', '<cmd>CodeCompanionActions<cr>', options)
map('n', '<leader>ah', '<cmd>CodeCompanionChat Toggle<cr>', options)
map('v', '<leader>ah', '<cmd>CodeCompanionChat Toggle<cr>', options)
map('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', options)
--map('n', '<leader>al', '<cmd>CodeCompanionCLI<cr>', options)
--map('n', '<leader>al1', '<cmd>CodeCompanionCLI agent=opencode<cr>', options)
--map('n', '<leader>al2', '<cmd>CodeCompanionCLI agent=claude_code<cr>', options)


local function open_assistant(cmd)
  vim.cmd('botright vsplit')
  vim.cmd('wincmd l')
  vim.cmd('vertical resize ' .. math.floor(vim.o.columns * 0.5))
  vim.cmd('enew')

  vim.fn.termopen({
    'tmux',
    'new-session',
    '-A',
    '-s',
    'assistant',
    cmd,
  })

  vim.cmd('startinsert')
end

local assistants = {
  al1 = 'pi',
  al2 = 'opencode',
  al3 = 'claude',
}

for key, cmd in pairs(assistants) do
  vim.keymap.set('n', '<leader>' .. key, function()
    open_assistant(cmd)
  end, { noremap = true, silent = true })
  vim.keymap.set('v', '<leader>' .. key, function()
    open_assistant(cmd)
  end, { noremap = true, silent = true })
end



-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

cmd([[
let test#python#runner = 'pytest'
let test#python#pytest#executable = 'python -m pytest'
let test#python#pytest#options = '-s'
let test#strategy = 'neovim'
]])

require('config.lazy')

-- LSP
require('mason-lspconfig').setup()
require('mason').setup()

require('nvim-tree').setup({
  git = {
    enable = true,     -- still enables git status icons
    ignore = false,    -- show files even if in .gitignore
  },
  -- other settings can go here
})

require('nvim-web-devicons').setup()
require('lualine').setup { options = { theme = 'powerline' } }
require('which-key').setup()

-- autocomplete
local cmp = require('cmp')
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end
cmp.setup({
    mapping = {
        ['<C-Space'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        -- ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        -- ['<Tab>'] = vim.schedule_wrap(function(fallback)
        --   if cmp.visible() and has_words_before() then
        --     cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        --   else
        --     fallback()
        --   end
        -- end),
    },
    sources = {
        {name = 'nvim_lsp'},
        {name = 'buffer'},
        {name = 'path'},
        {name = 'luasnip'},
    },
})
require('luasnip.loaders.from_vscode').load()

-- AI autocomplete
require('codecompanion').setup({
  adapters = {
    http = {
      ollama_local = function()
        return require('codecompanion.adapters').extend('ollama', {
          schema = {
            model = {
              default = 'qwen2.5-coder:3b',
            },

            num_ctx = {
              default = 8192,
            },
          },
          env = {
            url = 'http://127.0.0.1:11434',
          },
        })
      end,
      ollama_server = function()
        return require('codecompanion.adapters').extend('ollama', {
          schema = {
            model = {
              default = 'qwen3.5:9b',
            },

            num_ctx = {
              default = 8192,
            },
          },
          env = {
            url = 'http://192.168.8.132:11434',
          },
        })
      end,
    },
  },
  interactions = {
    chat = {
      adapter = 'ollama_server',
    },
    inline = {
      adapter = 'ollama_local',
    },
    cmd = {
      adapter = 'opencode',
    },
    cli = {
      agent = 'opencode',
      agents = {
        claude_code = {
          cmd = 'claude',
          args = {},
          description = 'Claude Code CLI',
          provider = 'terminal',
        },
        opencode = {
          cmd = 'opencode',
          args = {},
          description = 'OpenCode CLI',
          provider = 'terminal',
        },
      },
    },
  },

  display = {
    chat = {
      window = {
        layout = 'vertical',
        height = 0.33,
        width = 0.33,
      },
    },

    cli = {
      window = {
        layout = 'vertical',
        position = 'right',
        height = 0.5,
        width = 0.5,
      },
    },
  },
})
-- Telescope
require('telescope').setup{
  defaults = {
    -- Remap the up and down arrow keys
    mappings = {
      i = {  -- Insert mode
        ['<C-j>'] = require('telescope.actions').move_selection_next,
        ['<C-k>'] = require('telescope.actions').move_selection_previous,
      },
      n = {  -- Normal mode (for the preview window)
        ['<C-j>'] = require('telescope.actions').move_selection_next,
        ['<C-k>'] = require('telescope.actions').move_selection_previous,
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

vim.cmd([[
function! _EscapeText_python(text)
  echom "Patched _EscapeText_python called"
  if slime#config#resolve("python_ipython") && len(split(a:text,"\n")) > 1
    return ["%cpaste -q\n", slime#config#resolve("dispatch_ipython_pause"), a:text, "--\n"]
  else
    let empty_lines_pat = '\(^\|\n\)\zs\(\s*\n\+\)\+'
    let no_empty_lines = substitute(a:text, empty_lines_pat, "", "g")
    let dedent_pat = '\(^\|\n\)\zs'.matchstr(no_empty_lines, '^\s*')
    let dedented_lines = substitute(no_empty_lines, dedent_pat, "", "g")
    let except_pat = '\(elif\|else\|except\|finally\)\@!'
    let add_eol_pat = '\n\s[^\n]\+\n\zs\ze\('.except_pat.'\S\|$\)'
    let result = substitute(dedented_lines, add_eol_pat, "\n", "g")
    " Ensure at least two trailing newlines for Python REPL
    if result !~ '\n\n$'
      if result =~ '\n$'
        let result .= "\n"
      else
        let result .= "\n\n"
      endif
    endif
    return result
  end
endfunction
]])
