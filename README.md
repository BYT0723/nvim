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
├── data
│   ├── lua_snippets       # lua_snippets code snippets
│   └── obsidian_templates # obsidian模板
├── init.lua
├── lua
│   ├── base               # neovim basic configuration, does not rely on plugins
│   │   ├── autocmd.lua
│   │   ├── diagnostic.lua
│   │   ├── environment.lua
│   │   ├── init.lua
│   │   ├── keymaps.lua
│   │   ├── launcher.lua
│   │   └── util.lua
│   └── plugins            # neovim plugin configuration
│       ├── configs
│       │   ├── cmp.lua
│       │   ├── dap-local.lua
│       │   ├── formatter.lua
│       │   ├── gitsigns.lua
│       │   ├── lspconfig.lua
│       │   ├── mason.lua
│       │   ├── mini.lua
│       │   ├── noice.lua
│       │   ├── null-ls.lua
│       │   ├── obsidian.lua
│       │   ├── snacks.lua
│       │   ├── sniprun.lua
│       │   ├── tokyonight.lua
│       │   └── treesitter.lua
│       ├── init.lua
│       └── keymaps.lua
└── snippets               #json code snippets
```

### Feature

- Theme : `tokyonight.nvim`
- File Manager: `mini.files`
- Picker : `snacks-picker`
- Completion : `blink.cmp`
