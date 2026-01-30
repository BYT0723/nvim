local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local keymaps = require('plugins.keymaps')
local util = require('base.util')

require('lazy').setup({
  -- base or lib
  { 'nvim-lua/plenary.nvim' },
  -- gui
  { 'MunifTanjim/nui.nvim' },
  -- 文件图标
  { 'nvim-tree/nvim-web-devicons' },
  -- notify
  { 'rcarriga/nvim-notify', opts = {} },
  -- A series of mini.nvim plugins
  require('plugins.configs.mini'),

  -- UI美化
  {
    'folke/noice.nvim',
    lazy = false,
    keys = keymaps.Noice,
    opts = require('plugins.configs.noice'),
  },

  {
    'folke/snacks.nvim',
    lazy = false,
    opts = require('plugins.configs.snacks'),
    keys = keymaps.Snacks,
  },
  -- quickfix
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
  },

  -- colorscheme
  {
    -- https://github.com/folke/tokyonight.nvim
    'folke/tokyonight.nvim',
    lazy = false,
    init = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
    opts = require('plugins.configs.tokyonight'),
  },
  -- Breadcrumbs
  {
    'Bekaboo/dropbar.nvim',
    enabled = false,
    config = function()
      local dropbar_api = require('dropbar.api')
      vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
      vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
      vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
    end,
  },
  -- git style, including blame, modify tags
  {
    'lewis6991/gitsigns.nvim',
    opts = require('plugins.configs.gitsigns'),
  },
  -- todo comment
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    keys = keymaps.TodoComments,
    opts = {},
  },
  -- search and replace
  {
    'nvim-pack/nvim-spectre',
    keys = keymaps.Spectre,
    opts = {},
  },
  -- diffview
  {
    'sindrets/diffview.nvim',
    keys = keymaps.Diffview,
    opts = {},
  },
  -- translator
  {
    'potamides/pantran.nvim',
    keys = keymaps.PanTran,
    opts = {
      default_engine = 'google',
      engines = {
        google = {
          default_source = 'auto',
          default_target = 'en',
        },
      },
      window = {
        window_config = {
          border = 'rounded',
        },
      },
    },
  },

  -- github issue
  {
    'pwntester/octo.nvim',
    cmd = 'Octo',
    opts = {
      -- or "fzf-lua" or "snacks" or "default"
      picker = 'telescope',
      -- bare Octo command opens picker of commands
      enable_builtin = true,
      users = 'assignable',
    },
    keys = {
      {
        '<leader>oi',
        '<CMD>Octo issue list<CR>',
        desc = 'List GitHub Issues',
      },
      {
        '<leader>op',
        '<CMD>Octo pr list<CR>',
        desc = 'List GitHub PullRequests',
      },
      {
        '<leader>od',
        '<CMD>Octo discussion list<CR>',
        desc = 'List GitHub Discussions',
      },
      {
        '<leader>on',
        '<CMD>Octo notification list<CR>',
        desc = 'List GitHub Notifications',
      },
      {
        '<leader>os',
        function()
          require('octo.utils').create_base_search_command({ include_current_repo = true })
        end,
        desc = 'Search GitHub',
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      -- OR "ibhagwan/fzf-lua",
      -- OR "folke/snacks.nvim",
      'nvim-tree/nvim-web-devicons',
    },
  },

  -- HTTP REST-Client Interface
  {
    'mistweaverco/kulala.nvim',
    ft = 'http',
    keys = keymaps.Kulala,
    opts = {
      lsp = {
        formatter = {
          sort = {
            metadata = true,
            variables = false,
            commands = false,
            json = false,
          },
          -- quote_json_variables = false,
        },
      },
      -- debug = 0,
    },
  },

  -- language
  -- rust
  { 'mrcjkb/rustaceanvim', version = '^6', lazy = false },
  { 'saecki/crates.nvim', ft = 'toml', opts = {} },
  -- golang
  {
    'ray-x/go.nvim',
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    dependencies = { 'ray-x/guihua.lua' },
    ft = { 'go', 'gomod', 'gosum', 'gotmpl' },
    opts = {
      lsp_inlay_hints = { enable = false }, -- disable inlay hints, because it will conflict with Neovim's built-in inlay hints
      diagnostic = false, -- disable diagnostic because it will overwrite custom diagnostic configuration
    },
		-- stylua: ignore
    config = function(_, opts)
      require('go').setup(opts)
      vim.keymap.set('n', '<leader>rc',  '<cmd>GoCoverage -p<CR>',                { buffer = true, desc = 'Go coverage package of the current buffer'  })
      vim.keymap.set('n', '<leader>rC',  '<cmd>GoTool cover -html=cover.cov<CR>', { buffer = true, desc = 'Show go coverage by browser'  })
    end,
  },
  -- godot
  { 'habamax/vim-godot', ft = { 'gdscript', 'gdresource' } },
  -- sql
  {
    'kndndrj/nvim-dbee',
    build = function()
      require('dbee').install()
    end,
    keys = keymaps.DB,
    opts = {},
  },
  -- markdown preview
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  -- image preview
  -- 关闭此插件，会覆盖tui,导致遮盖内容
  {
    '3rd/image.nvim',
    ft = { 'markdown', 'norg' },
    opts = {},
  },
  -- neorg
  {
    'nvim-neorg/neorg',
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '*', -- Pin Neorg to the latest stable release
    opts = require('plugins.configs.neorg'),
  },
  -- markdown render in editor
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'Avante' },
    -- stylua: ignore
    init = function()
      vim.api.nvim_set_hl(0, 'RenderMarkdownCheckboxProgress',      { bold = true, fg = '#00AFFF' })
      vim.api.nvim_set_hl(0, 'RenderMarkdownCheckboxInterrupt',     { bold = true, fg = '#888888' })
      vim.api.nvim_set_hl(0, 'RenderMarkdownCheckboxImportant',     { bold = true, fg = '#d73128' })
      vim.api.nvim_set_hl(0, 'RenderMarkdownCheckboxCancelled',     { link = '@comment' })
      vim.api.nvim_set_hl(0, 'RenderMarkdownCheckboxCancelledText',	{ link = '@markup.strikethrough' })
    end,
    opts = {
      -- stylua: ignore
      checkbox = {
        unchecked = { icon = '󰄱', highlight = 'RenderMarkdownUnchecked', scope_highlight = nil },
        checked   = { icon = '󰄵', highlight = 'RenderMarkdownChecked',   scope_highlight = 'RenderMarkdownCheckboxDoneText',},
        custom = {
          progress  = { raw = '[>]', rendered = '', highlight = 'RenderMarkdownCheckboxProgress',  scope_highlight = nil },
          interrupt = { raw = '[~]', rendered = '', highlight = 'RenderMarkdownCheckboxInterrupt', scope_highlight = nil },
          important = { raw = '[!]', rendered = '', highlight = 'RenderMarkdownCheckboxImportant', scope_highlight = nil },
					cancelled  = { raw = '[-]', rendered = '', highlight = 'RenderMarkdownCheckboxCancelled', scope_highlight = 'RenderMarkdownCheckboxCancelledText' },
        },
      },
      file_types = { 'markdown', 'Avante' },
    },
  },
  -- orgmode
  {
    'nvim-orgmode/orgmode',
    enabled = false,
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '~/Documents/Orgfiles/**/*',
        org_default_notes_file = '~/Documents/Orgfiles/refile.org',
      })
    end,
  },
  -- fold
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    init = function()
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = false
    end,
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
    },
  },
  -- obsidian
  {
    'obsidian-nvim/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    keys = keymaps.Obsidian,
    ft = { 'markdown' },
    opts = require('plugins.configs.obsidian'),
    config = function(_, opts)
      local src_dir = vim.fn.stdpath('config') .. '/data/obsidian_templates'
      for _, ws in ipairs(opts.workspaces or {}) do
        local target_dir = ws.path .. '/' .. opts.templates.folder
        util.mkdir(target_dir)
        local ok, _, code = os.execute('cp -rn ' .. src_dir .. '/* ' .. target_dir)
        if not ok then
          vim.notify('obsidian copy default templates error: ' .. code)
        end
      end
      require('obsidian').setup(opts)
    end,
  },
  -- Zen Mode like vscode
  { 'folke/zen-mode.nvim', opts = {} },

  -- run code in document or comment
  {
    'michaelb/sniprun',
    keys = keymaps.Sniprun,
    branch = 'master',
    build = 'sh install.sh',
    opts = {
      display = { 'Terminal', 'VirtualText' },
    },
  },
  -- paste image
  {
    'HakonHarnes/img-clip.nvim',
    keys = {
      { '<leader>p', '<cmd>PasteImage<cr>', desc = 'Paste image from system clipboard' },
    },
    opts = {
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
      },
    },
  },
  -- completion
  {
    'saghen/blink.cmp',
    event = 'VeryLazy',
    dependencies = {
      'rafamadriz/friendly-snippets',
      { 'saghen/blink.compat', version = '2.*', lazy = true, opts = {} },
      { 'Kaiser-Yang/blink-cmp-avante' },
      { 'moyiz/blink-emoji.nvim' },
    },
    version = '*',
    opts = require('plugins.configs.cmp'),
  },
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    build = 'make install_jsregexp',
    event = 'VeryLazy',
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
    },
		-- stylua: ignore
    config = function(_, opts)
      local ls = require('luasnip')
      local auto_expand = ls.expand_auto
      ls.expand_auto = function(...)
        vim.o.undolevels = vim.o.undolevels
        auto_expand(...)
      end
      require('luasnip.loaders.from_lua').load({ paths = {vim.fn.stdpath('config') .. '/data/lua_snippets'} })
      vim.keymap.set({ 'i', 's' }, '<C-j>', function() return ls.jumpable(1)          and '<Plug>luasnip-jump-next' end,      { expr = true })
      vim.keymap.set({ 'i', 's' }, '<C-k>', function() return ls.jumpable(-1)         and '<Plug>luasnip-jump-prev' end,      { expr = true })
      vim.keymap.set({ 'i', 's' }, '<C-n>', function() return ls.expand_or_jumpable() and '<Plug>luasnip-expand-or-jump' end, { expr = true })
			ls.setup(opts)
		end,
  },
  -- AI
  {
    'monkoose/neocodeium',
    event = 'VeryLazy',
    keys = keymaps.NeoCodeium,
    opts = {
      show_label = false,
      silent = true,
      filter = function(bufnr)
        return vim.tbl_contains(
          { 'lua', 'go', 'python', 'rust' },
          vim.api.nvim_get_option_value('filetype', { buf = bufnr })
        )
      end,
    },
  },
  -- AI Chat
  {
    'yetone/avante.nvim',
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    build = 'make',
    event = 'VeryLazy',
    dependencies = {
      -- Github Copilot
      { 'zbirenbaum/copilot.lua', opts = {} },
    },
    opts = {
      provider = 'deepseek',
      providers = {
        deepseek = {
          __inherited_from = 'openai',
          api_key_name = 'DEEPSEEK_API_KEY',
          endpoint = 'https://api.deepseek.com',
          model = 'deepseek-coder',
        },
      },
    },
  },
  -- lsp
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('plugins.configs.lspconfig')
    end,
  },
  -- lsp manager
  {
    'williamboman/mason.nvim',
    event = 'VeryLazy',
    opts = require('plugins.configs.mason'),
  },
  -- lint / formatter / actioner manager
  {
    'nvimtools/none-ls.nvim',
    event = 'VeryLazy',
    dependencies = { { 'ThePrimeagen/refactoring.nvim', opts = {} } },
    config = function(_, _)
      require('null-ls').setup(require('plugins.configs.null-ls'))
      require('plugins.configs.formatter').setup()
    end,
  },
  -- debug配置
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
      { 'leoluz/nvim-dap-go', opts = {} },
    },
    keys = keymaps.Dap,
    config = function()
      require('plugins.configs.dap-local')
    end,
  },
  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ts = require('nvim-treesitter')
      local ts_cfg = require('plugins.configs.treesitter')

      -- install treesitter
      pcall(ts.install, ts_cfg.ensure_installed)

      -- load select keys
      local select = require('nvim-treesitter-textobjects.select')
      for _, value in ipairs(ts_cfg.select_keys) do
        vim.keymap.set(value[1], value[2], function()
          select.select_textobject(value[3], 'textobjects')
        end, value[4])
      end

      -- set autocommand
      vim.api.nvim_create_autocmd('FileType', {
        pattern = '*',
        callback = function()
          if pcall(vim.treesitter.start) then
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo.foldlevel = 99

            vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
          end
        end,
      })
    end,
  },
  -- treesitter textobjects
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    opts = {
      select = { lookahead = true },
      move = { set_jumps = true },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup({ enable = true })
      vim.keymap.set('n', '[c', function()
        require('treesitter-context').go_to_context(vim.v.count1)
      end, { desc = 'previous context item' })
    end,
  },
  { 'JoosepAlviste/nvim-ts-context-commentstring', opts = {} },
  -- which key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = { preset = 'helix' },
  },
  -- normal/insert模式切换的输入法记忆
  { 'h-hg/fcitx.nvim', event = 'VeryLazy' },

  -- Correct bad habits
  {
    'm4xshen/hardtime.nvim',
    event = 'VeryLazy',
    opts = { max_count = 10, restriction_mode = 'hint' },
  },
  -- interview
  {
    'kawre/leetcode.nvim',
    cmd = 'Leet',
    build = ':TSUpdate html', -- if you have `nvim-treesitter` installed
    opts = {
      cn = { -- leetcode.cn
        enabled = true,
        translator = true,
        translate_problems = true,
      },
      lang = 'golang',
      injector = {
        ['golang'] = {
          before = { 'package leetcode' },
          after = {},
        },
      },
      image_support = false,
      picker = { provider = 'snacks-picker' },
    },
    config = function(_, opts)
      local dir = vim.fn.stdpath('data') .. '/leetcode'
      util.mkdir(dir)
      if vim.fn.filereadable(dir .. '/go.mod') == 0 then
        vim.fn.system('cd ' .. dir .. ' && go mod init leetcode')
      end
      require('leetcode').setup(opts)
    end,
  },
  -- Statistics
  { 'wakatime/vim-wakatime', event = 'VeryLazy' },
  -- Personal plugin development
  { 'BYT0723/typist.nvim', opts = {}, event = 'VeryLazy' },
  { 'BYT0723/goctl.nvim', enabled = false, opts = {} },
  -- Game
  {
    'jim-fx/sudoku.nvim',
    cmd = 'Sudoku',
    opts = {},
  },
  -- plugin dev
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
}, {
  rocks = {
    hererocks = true, -- recommended if you do not have global installation of Lua 5.1.
  },
  ui = {
    border = 'double',
    backdrop = 100,
  },
  dev = {
    path = '~/Workspace/Github/Neovim',
    patterns = {},
    fallback = false,
  },
})
