-- 加速启动
require("impatient").enable_profile()

-- 导入packer-plugins
require("plugins")
-- 导入快捷键绑定
require("keybindings")

-- colorscheme
require("colorscheme")

require("env")

-- lsp
require("lsp/lsp")
require("lsp/diagnostic")
require("lsp/nvim-cmp")
require("lsp/dap-local")
require("lsp/linter")
require("lsp/formatter")

-- config
require("plugin-config/filetype")
require("plugin-config/dashboard-nvim")
require("plugin-config/barbar")
require("plugin-config/lualine")
require("plugin-config/mason")
require("plugin-config/gitsigns")
require("plugin-config/telescope")
require("plugin-config/nvim-treesitter")
require("plugin-config/symbols-outline")
require("plugin-config/nvim-tree")
require("plugin-config/comment")
require("plugin-config/indent-blankline")
require("plugin-config/nvim-autopairs")
require("plugin-config/toggleterm")

-- 16进制颜色显示
require("colorizer").setup()
require("nvim-surround").setup()
require("hop").setup({ keys = "asdfghjklqwertyuiopzxcvbnm" })
require("project_nvim").setup()
