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
  { 'nvim-lua/plenary.nvim', lazy = true },
  -- gui
  { 'MunifTanjim/nui.nvim', lazy = true },
  -- 文件图标
  { 'nvim-tree/nvim-web-devicons', lazy = true },
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
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        sections = {
          { section = 'header' },
          { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
          { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
          { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
          { section = 'startup' },
        },
      },
      explorer = { enabled = false },
      indent = { indent = { char = '╎' }, scope = { char = '╎' } },
      input = { enabled = true, icon_pos = 'title', win = { width = 40, relative = 'cursor', row = -3, col = 0 } },
      picker = { enabled = true },
      notifier = { style = 'compact' },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = keymaps.Snacks,
  },

  -- colorscheme
  {
    -- https://github.com/folke/tokyonight.nvim
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
    opts = {
      transparent = not vim.g.neovide,
      styles = {
        style = 'storm', -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
        light_style = 'day', -- The theme is used when the background is set to light
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variable = {},
        sidebars = 'dark', -- style for sidebars, see below
        floats = not vim.g.neovide and 'transparent' or 'dark', -- style for floating windows
      },
      sidebars = { 'qf' },
      on_colors = function(colors) end,
      on_highlights = function(hl, c)
        hl.WhichKeyBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.WhichKeyTitle = {
          bg = c.hint,
          fg = c.bg_dark,
        }
        hl.BlinkCmpMenu = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.BlinkCmpDoc = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.BlinkCmpSignatureHelp = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        if vim.opt.background:get() == 'dark' then
          hl.LspInlayHint = {
            fg = '#545c7e',
          }
        end
      end,
    },
  },
  -- Breadcrumbs
  {
    'Bekaboo/dropbar.nvim',
    config = function()
      local dropbar_api = require('dropbar.api')
      vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
      vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
      vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
    end,
  },
  -- git style, including blame, modify tags
  { 'lewis6991/gitsigns.nvim', opts = require('plugins.configs.gitsigns') },
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
    cmd = 'DiffviewOpen',
    keys = keymaps.Diffview,
    opts = {},
  },
  -- translator 'potamides/pantran.nvim' fork
  {
    'potamides/pantran.nvim',
    cmd = 'Pantran',
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

  -- HTTP REST-Client Interface
  {
    'mistweaverco/kulala.nvim',
    filetypes = { 'http' },
    keys = keymaps.Kulala,
    opts = {
      additional_curl_options = { '--insecure', '-A', 'Mozilla/5.0' },
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
    filetypes = { 'go', 'gomod', 'gosum', 'gotmpl' },
    opts = {
      lsp_inlay_hints = { enable = false },
      diagnostic = false,
    },
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
  {
    '3rd/image.nvim',
    ft = { 'markdown', 'norg' },
    opts = {
      backend = 'ueberzug', -- kitty or ueberzug
      processor = 'magick_rock', -- or "magick_cli"
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = true,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          floating_windows = false, -- if true, images will be rendered in floating markdown windows
          filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
        },
        neorg = {
          enabled = true,
          filetypes = { 'norg' },
        },
        typst = {
          enabled = true,
          filetypes = { 'typst' },
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.icons',
      'nvim-tree/nvim-web-devicons',
    },
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
  {
    'nvim-orgmode/orgmode',
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
    filetypes = { 'markdown' },
    opts = {
      workspaces = {
        { name = 'personal', path = '~/Documents/Vaults/Personal' },
        { name = 'work', path = '~/Documents/Vaults/Work' },
      },
      daily_notes = {
        folder = 'dailies',
        date_format = '%Y-%m-%d (%a)',
        alias_format = '%b %-d, %Y (%a)',
        default_tags = { 'daily_notes' },
        template = 'daily.md',
      },
      mappings = {
        ['<cr>'] = {
          action = function()
            return require('obsidian').util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },
      templates = {
        folder = vim.fn.stdpath('config') .. '/data/obsidian_templates',
        date_format = '%Y-%m-%d (%a)',
        time_format = '%H:%M',
        substitutions = {
          week_dates = function()
            local out = {}
            local now = os.time()
            local dow = tonumber(os.date('%w', now)) -- 0 = Sunday
            local monday = now - ((dow == 0 and 6 or dow - 1) * 86400)

            for i = 0, 6 do
              local t = monday + i * 86400
              table.insert(out, os.date('%A: [[%Y-%m-%d (%a)]]', t))
            end

            return table.concat(out, '\n')
          end,
        },
      },
      completion = {
        nvim_cmp = false,
        blink = true,
      },
      follow_url_func = function(url)
        vim.fn.jobstart({ 'xdg-open', url }) -- linux
      end,
      ui = { enable = false },
      picker = { name = 'snacks.pick' },
    },
    config = function(_, opts)
      for _, ws in ipairs(opts.workspaces or {}) do
        util.mkdir(ws.path)
      end
      require('obsidian').setup(opts)
    end,
  },
  -- Zen Mode like vscode
  {
    'folke/zen-mode.nvim',
    opts = {},
  },

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
  {
    'HakonHarnes/img-clip.nvim',
    keys = {
      { '<leader>p', '<cmd>PasteImage<cr>', desc = 'Paste image from system clipboard' },
    },
    opts = {
      -- recommended settings
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
        -- required for Windows users
        use_absolute_path = true,
      },
    },
  },
  -- completion
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      { 'saghen/blink.compat', lazy = true, version = false },
    },
    version = '*',
    opts = require('plugins.configs.cmp'),
  },
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    build = 'make install_jsregexp',
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
      require('luasnip.loaders.from_lua').load({ paths = vim.fn.stdpath('config') .. '/data/lua_snippets' })
      vim.keymap.set({ 'i', 's' }, '<C-j>', function() return ls.jumpable(1)          and '<Plug>luasnip-jump-next' end,      { expr = true })
      vim.keymap.set({ 'i', 's' }, '<C-k>', function() return ls.jumpable(-1)         and '<Plug>luasnip-jump-prev' end,      { expr = true })
      vim.keymap.set({ 'i', 's' }, '<C-n>', function() return ls.expand_or_jumpable() and '<Plug>luasnip-expand-or-jump' end, { expr = true })
			ls.setup(opts)
		end,
  },
  -- AI
  {
    'Exafunction/codeium.nvim',
    lazy = true,
    opts = {
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        filetypes = {
          mason = false,
          lazy = false,
          markdown = false,
          minifiles = false,
          snacks_terminal = false,
          snacks_picker_input = false,
          snacks_input = false,
        },
        default_filetype_enabled = true,
        accept_fallback = '<C-L>',
        key_bindings = {
          accept = '<C-L>',
          next = '<M-]>',
          prev = '<M-[>',
        },
      },
    },
  },
  {
    'yetone/avante.nvim',
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    cmd = 'AvanteChat',
    opts = {
      provider = 'deepseek',
      vendors = {
        deepseek = {
          __inherited_from = 'openai',
          api_key_name = 'DEEPSEEK_API_KEY',
          endpoint = 'https://api.deepseek.com',
          model = 'deepseek-coder',
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  },
  -- lsp
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      -- lua vim developer
      {
        'folke/neodev.nvim',
        opts = {
          library = { plugins = { 'nvim-dap-ui' }, types = true },
        },
      },
    },
    config = function()
      require('plugins.configs.lspconfig')
    end,
  },
  -- lsp 管理
  {
    'williamboman/mason.nvim',
    opts = function()
      return require('plugins.configs.mason')
    end,
    config = function(_, opts)
      require('mason').setup(opts)
      -- custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command('MasonInstallAll', function()
        vim.cmd('MasonInstall ' .. table.concat(opts.ensure_installed, ' '))
      end, {})
    end,
  },
  {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'ThePrimeagen/refactoring.nvim', lazy = true, opts = {} },
    },
    config = function(_, _)
      require('null-ls').setup(require('plugins.configs.null-ls'))

      require('plugins.configs.formatter').setup()
    end,
  },
  -- debug配置
  {
    'mfussenegger/nvim-dap',
    cmd = 'DapToggle',
    keys = keymaps.Dap,
    dependencies = {
      'rcarriga/nvim-dap-ui', -- debug UI
      'nvim-neotest/nvim-nio',
    },
    config = function()
      require('plugins.configs.dap-local')
    end,
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = function()
      return require('plugins.configs.treesitter')
    end,
    config = function(_, opts)
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      require('nvim-treesitter.configs').setup(opts)
      require('treesitter-context').setup(opts.context)
    end,
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-context', keys = keymaps.TreeSitterContext },
      { 'JoosepAlviste/nvim-ts-context-commentstring', opts = {} },
    },
  },
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
    enabled = false,
    opts = {
      max_count = 10,
      restriction_mode = 'hint',
    },
  },
  -- interview 'kawre/leetcode.nvim' fork
  {
    'BYT0723/leetcode.nvim',
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
        ['cpp'] = {
          before = { '#include <bits/stdc++.h>', 'using namespace std;' },
          after = 'int main() {}',
        },
        ['golang'] = {
          before = { 'package leetcode' },
          after = {},
        },
      },
      image_support = false,
      picker = { provider = 'snacks' },
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
  { 'wakatime/vim-wakatime', lazy = false },
  -- Personal plugin development
  { 'BYT0723/typist.nvim', opts = {} },
  { 'BYT0723/goctl.nvim', opts = {} },
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
