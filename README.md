<!--toc:start-->

- [Previews](#previews)
- [Required](#required)
- [Startup process of lua configuration](#startup-process-of-lua-configuration)
- [Plugins be Loaded in `lua/plugins/init.lua` by `lazy.nvim`](#plugins-be-loaded-in-luapluginsinitlua-by-lazynvim)
- [Plugin configuration in `lua/plugins/config/`](#plugin-configuration-in-luapluginsconfig)
- [Custom Keymap in `lua/keybindings.lua`](#custom-keymap-in-luakeybindingslua)
<!--toc:end-->

> neovim configuration of lua only

### Previews

![neovim-preview](https://i.imgur.com/2TEvcP4.png)

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
│   │   ├── environment.lua
│   │   ├── init.lua
│   │   ├── keymaps.lua
│   │   ├── launcher.lua
│   │   └── util.lua
│   └── plugins
│       ├── configs
│       │   ├── bufferline.lua
│       │   ├── cmp.lua
│       │   ├── dap-local.lua
│       │   ├── dashboard.lua
│       │   ├── diffview.lua
│       │   ├── dressing.lua
│       │   ├── formatter.lua
│       │   ├── gitsigns.lua
│       │   ├── lspconfig.lua
│       │   ├── lspsaga.lua
│       │   ├── lualine.lua
│       │   ├── mason.lua
│       │   ├── noice.lua
│       │   ├── notify.lua
│       │   ├── telescope.lua
│       │   ├── toggleterm.lua
│       │   ├── tokyonight.lua
│       │   ├── tree.lua
│       │   ├── treesitter.lua
│       │   └── trouble.lua
│       ├── init.lua
│       └── keymaps.lua
├── README.md
├── snippets
│   ├── crontab.json
│   ├── dot.json
│   ├── goctl.json
│   ├── go.json
│   ├── json.json
│   ├── lua.json
│   ├── markdown.json
│   ├── proto.json
│   ├── README.md
│   ├── rust.json
│   └── vim.json
└── stylua.toml
```

1. `init.lua`

> Require Load the configuration files of each plug-in function

```lua
-- vim environment (some variable)
require('environment')

-- import packer-plugins
require('plugins')

-- keymap binding
require('keybindings').Load_Keys('Common')

-- input method
require('plugins.fcitx')
```

### Plugins be Loaded in `lua/plugins/init.lua` by `lazy.nvim`

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

require('lazy').setup({
  -- base or lib
  'nvim-lua/plenary.nvim',
  { 'MunifTanjim/nui.nvim', lazy = true },

  -- develop
  'wakatime/vim-wakatime',

  -- gui
  {
    'rcarriga/nvim-notify',
    opts = function()
      return require('plugins.configs.notify')
    end,
    config = function(_, opts)
      local notify = require('notify')
      notify.setup(opts)
      vim.notify = notify
    end,
  },
  ......
})
```

### Plugin configuration in `lua/plugins/config/`

if you want to custom yourself plugin, create a lua configuration in `lua/plugins/config/` and add property `opts` and `config` for your custom plugin in `lua/plugins/init.lua`.

### Custom Keymap in `lua/keybindings.lua`

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
