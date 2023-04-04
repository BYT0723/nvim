-- import packer-plugins
require('plugins')

-- quick start
require('impatient').enable_profile()

-- vim environment (some variable)
require('environment')

-- keymap binding
require('keybindings')

-- colorscheme
require('colorscheme')

require('plugin-config/nvim-notify')
require('plugin-config/noice')

-- lsp
require('plugin-config/mason')
require('lsp/lsp')
require('lsp/diagnostic')
require('lsp/lsp-saga')
require('lsp/nvim-cmp')
require('lsp/dap-local')
require('lsp/linter')
require('lsp/formatter')

-- plugin startup to be configured
require('plugin-config/filetype')
require('plugin-config/dashboard-nvim')
require('plugin-config/bufferline')
require('plugin-config/lualine')
require('plugin-config/toggleterm')
require('plugin-config/gitsigns')
require('plugin-config/telescope')
require('plugin-config/nvim-treesitter')
require('plugin-config/nvim-treesitter-context')
require('plugin-config/nvim-tree')
require('plugin-config/comment')
require('plugin-config/indent-blankline')
require('plugin-config/nvim-autopairs')
-- key highlight
require('plugin-config/vim-illuminate')

-- plugin quick startup
require('colorizer').setup()
require('nvim-surround').setup()
require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
require('project_nvim').setup()
require('crates').setup()
require('goctl').setup()

-- when lua config be saved, source lua file in neovim now.
vim.api.nvim_command("au BufWritePost *.lua lua require('util').source_luafile()")
