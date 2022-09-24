require("nvim-treesitter.install").prefer_git = true

require 'nvim-treesitter.configs'.setup {
    -- 安装 language parser
    ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "dockerfile",
        "gitignore",
        "go",
        "gomod",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "proto",
        "python",
        "rust",
        "sql",
        "vim",
        "vue",
        "yaml",
        "toml",
    },
    -- 启用代码高亮功能
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    -- 启用增量选择
    incremental_selection = {
        enable = true,
        keymaps = require('keybindings').nvim_treesitter()
    },
    -- 启用基于Treesitter的代码格式化(=) . NOTE: This is an experimental feature.
    indent = {
        enable = true
    }
}
-- 开启 Folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.wo.foldlevel = 99
