-- Setup lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    'lambdalisue/nerdfont.vim',
  },
  {
    'ellisonleao/gruvbox.nvim',
  },
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup()
    end
  },
  {
    "kdheepak/tabline.nvim",
    config = function()
      require('tabline').setup({enable = false})
    end,
    requires = { 'nvim-lualine/lualine.nvim', 'nvim-tree/nvim-web-devicons' }
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { text = '+' },
        },
      })
    end
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup()
    end
  },
  {
    "echasnovski/mini.indentscope",
    config = function()
      require('mini.indentscope').setup({
        symbol = "▏"
      })
    end
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true
  },
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.4',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
  {
    'sindrets/diffview.nvim',
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'sindrets/diffview.nvim'
    },
    config = function()
      require('neogit').setup({
        kind = 'vsplit',
        signs = {
          section = { " ", " " },
          item = { " ", " " },
          hunk = { "", "" },
        },
        integrations = { diffview = true },
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    tag = 'v0.1.3'
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/vim-vsnip',
  'hrsh7th/cmp-cmdline',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-buffer',
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "neovim/nvim-lspconfig" },
      { "echasnovski/mini.completion", version = false },
    },
    config = function()
      local lspconfig = require("lspconfig")
      --require('mini.completion').setup({})
      require('cmp').setup({})
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({})
        end,
        ["vtsls"] = function()
          lspconfig["vtsls"].setup({})
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(_)
          --vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
          vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
          vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
          vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
          vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
          vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
          vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
          vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
        end
      })

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
      )
    end
  },
  'lukas-reineke/indent-blankline.nvim',
  {
    'MunifTanjim/nui.nvim'
  },
  {
    'rcarriga/nvim-notify'
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'c', 'lua', 'vim', 'python', 'json', 'yaml', 'markdown', 'toml', 'dockerfile' },
        sync_install = true,
        highlight = { enable = true }
      })
    end
  },
  {
    'kkharji/lspsaga.nvim',
    config = function()
      require('lspsaga').setup()
    end
  },
  {
    'folke/lsp-colors.nvim',
    config = function()
      require("lsp-colors").setup({
        Error = "#db4b4b",
        Warning = "#e0af68",
        Information = "#0db9d7",
        Hint = "#10B981"
      })
    end
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'numToStr/Comment.nvim',
    lazy=false,
    config = function()
      require('Comment').setup()
    end
  },
  {
    'machakann/vim-sandwich',
  }
})

require('diffview').setup()

require('neogit').setup({
  disable_hint = false,
  disable_context_highlighting = false,
  disable_signs = false,
  disable_commit_confirmation = false,
  disable_insert_on_commit =true,
  filewatcher = { interval = 1000, enabled = true },
  graph_style = 'ascii',
})

require('noice').setup({
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.uitl.stylize_markdown'] = true,
      ['cmp.entry.get_dcumentation'] = true,
    }
  },
  presets = {
    bottom_search = false,
    command_palette = false,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  }
})

require('tokyonight').setup({
  style = 'night',
--  transparent = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
  }
})

require('gruvbox').setup({
  italic = { keywords = true },
})

require('lualine').setup {
  options = {
    -- ... your lualine config
    -- theme = 'tokyonight'
    theme = 'gruvbox'
    -- ... your lualine config
    
  },
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { require('tabline').tabline_buffers },
    lualine_x = { require('tabline').tabline_tabs },
    lualine_y = {},
    lualine_z = {}
  }
}

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- activate LSP for poetry virtualenv


-- Setup cmp
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
  })
})
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'path' },
		{name = 'cmdline'},
	}
})

-- set termguicolors to enable highlight groups
-- vim.opt.termguicolors = true

local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', 'i', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
end
require("nvim-tree").setup({
  on_attach = my_on_attach,
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false
      }
    }
  },
})

vim.cmd([[
  colorscheme gruvbox
]])

vim.opt.termguicolors = true

vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.number = true
vim.opt.title = true
vim.opt.ambiwidth = "double"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"lua"},
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
    end
})
-- vim.opt.smartindent = true
vim.opt.hidden = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.virtualedit = "onemore"
vim.opt.wildmenu = true

vim.api.nvim_set_keymap('n', 'J', '<C-d>', {noremap = true})
vim.api.nvim_set_keymap('n', 'K', '<C-u>', {noremap = true})

vim.api.nvim_set_keymap('i', 'jj', '<esc>', {noremap = true})
vim.api.nvim_set_keymap('i', '{', '{}<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '{}', '{}', { noremap = true })
vim.api.nvim_set_keymap('i', '{<Return>', '{}<Left><CR><ESC><S-o>', { noremap = true })
vim.api.nvim_set_keymap('i', '[', '[]<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '[]', '[]', { noremap = true })
vim.api.nvim_set_keymap('i', '(', '()<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '()', '()', { noremap = true })
vim.api.nvim_set_keymap('i', '"', '""<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '""', '""', { noremap = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"python", "lua"},
  callback = function()
    vim.api.nvim_set_keymap('i', "'", "''<Left>", { noremap = true })
    vim.api.nvim_set_keymap('i', "''", "''", { noremap = true })
  end
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"python"},
  callback = function()
    vim.api.nvim_set_keymap('i', '"<Return>', '""""""<Left><Left><Left><CR><ESC><S-o>', { noremap = true })
  end
})

-- タブ操作
vim.api.nvim_set_keymap('n', 'tc', ':tablast <bar> tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'tx', ':tabclose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'tn', ':tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'tp', ':tabprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'tt', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- 分割操作
vim.api.nvim_set_keymap('n', 'ti', '<C-w>s', { noremap = true })
vim.api.nvim_set_keymap('n', 'ts', '<C-w>v', { noremap = true })

vim.api.nvim_set_keymap('n', 'tr', ':ToggleTerm<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'ftr', ':ToggleTerm direction=float<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gg', ':Neogit<CR>', { noremap = true })

-- ウィンドウのナビゲーション
-- vim.api.nvim_set_keymap('n', 'vi', '<C-w>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tl', '<C-w><C-l>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tk', '<C-w><C-k>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tj', '<C-w><C-j>', { noremap = true })
vim.api.nvim_set_keymap('n', 'th', '<C-w><C-h>', { noremap = true })
vim.api.nvim_set_keymap('n', 'tL', '<C-w>L', { noremap = true })
vim.api.nvim_set_keymap('n', 'tK', '<C-w>K', { noremap = true })
vim.api.nvim_set_keymap('n', 'tJ', '<C-w>J', { noremap = true })
vim.api.nvim_set_keymap('n', 'tH', '<C-w>H', { noremap = true })

vim.api.nvim_set_keymap('n', 't+s', '<C-w>>', { noremap = true })
vim.api.nvim_set_keymap('n', 't-s', '<C-w><', { noremap = true })
vim.api.nvim_set_keymap('n', 't+i', '<C-w>+', { noremap = true })
vim.api.nvim_set_keymap('n', 't-i', '<C-w>-', { noremap = true })

vim.api.nvim_set_keymap('t', 'jj', '<C-\\><C-n>', { noremap = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})

--require('ibl').setup()

vim.opt.number = true
vim.o.fillchars = "vert: " 
