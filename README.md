> neovim configuration of lua only

### Previews

![neovim-preview](https://i.imgur.com/fY6sbBh.png)

### Required

- lua
- python (pynvim)

check your depend by `:checkhealth`

### Startup process of lua configuration

```
.
├── init.lua
├── lazy-lock.json
├── lua
│   ├── base
│   │   ├── autocmd.lua
│   │   ├── diagnostic.lua
│   │   ├── environment.lua
│   │   ├── init.lua
│   │   ├── keymaps.lua
│   │   ├── launcher.lua
│   │   └── util.lua
│   └── plugins
│       ├── configs
│       │   ├── cmp.lua
│       │   ├── dap-local.lua
│       │   ├── diffview.lua
│       │   ├── formatter.lua
│       │   ├── gitsigns.lua
│       │   ├── lspconfig.lua
│       │   ├── mason.lua
│       │   ├── mini.lua
│       │   ├── noice.lua
│       │   ├── notify.lua
│       │   ├── null-ls.lua
│       │   ├── nvim-tree.lua
│       │   ├── telescope.lua
│       │   ├── treesitter.lua
│       │   └── trouble.lua
│       ├── init.lua
│       └── keymaps.lua
├── README.md
├── snippets
│   ├── crontab.json
│   ├── ...
│   ├── go.json
└── stylua.toml
6 directories, 39 files
```

### Startup

- `init.lua`

```lua
-- vim environment (base environment for non-plugins), will load base/init.lua
require('base')

-- import plugins, will load plugins/init.lua
require('plugins')
```

- `base/init.lua`

```lua
-- global variable
require('base.environment')

-- basic keymap
require('base.keymaps')

-- autocmd
require('base.autocmd')

-- diagnostic
require('base.diagnostic')
```

- `plugins/init.lua`

```lua

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

require('lazy').setup({
  -- base or lib
  { 'nvim-lua/plenary.nvim', lazy = true },
  -- gui
  { 'MunifTanjim/nui.nvim', lazy = true },
  -- 文件图标
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- A series of mini.nvim plugins
  require('plugins.configs.mini'),

  -- colorscheme
  {
    -- https://github.com/folke/tokyonight.nvim
    'folke/tokyonight.nvim',
    enabled = true,
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
    opts = {
      transparent = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variable = {},
        sidebars = 'dark', -- style for sidebars, see below
        floats = 'transparent', -- style for floating windows
      },
      sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' },
    },
  },
  -- Wrap the input and select of vim.ui
  { 'stevearc/dressing.nvim', event = 'VeryLazy', opts = {} },
  -- UI美化
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    keys = keymaps.Noice,
    opts = function()
      return require('plugins.configs.noice')
    end,
  },
  ....
}, {
  ui = {
    border = 'shadow',
  },
  dev = {
    path = '~/Workspace/Github/Neovim',
    patterns = {},
    fallback = false,
  },
})
```

### Plugin configuration in `lua/plugins/config/`

if you want to custom yourself plugin, create a lua configuration in `lua/plugins/config/` and add property `opts` and `config` for your custom plugin in `lua/plugins/init.lua`.

### Custom Keymap in `lua/base/keybindings.lua` and `lua/plugins/keybindings.lua`

```lua
-- set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

M.Translator = {
  -- all mode
  [""] = {...}
  -- normal mode
  n = {
    ['<leader>tw'] = '<Plug>TranslateW',
    ['<leader>tr'] = '<Plug>TranslateR --target_lang=en',
  },
  -- visual mode
  v = {
    ['<leader>tw'] = '<Plug>TranslateWV',
    ['<leader>tr'] = '<Plug>TranslateRV --target_lang=en',
  },
}
```
