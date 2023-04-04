-- require("nvim-treesitter.install").prefer_git = true

require('nvim-treesitter.configs').setup({
  -- 安装 language parser
  ensure_installed = {
    'bash',
    'c',
    'cpp',
    'css',
    'dockerfile',
    'gitignore',
    'gdscript',
    'go',
    'gomod',
    'html',
    'javascript',
    'json',
    'lua',
    'markdown',
    'markdown_inline',
    'proto',
    'python',
    'rust',
    'sql',
    'vim',
    'vue',
    'yaml',
    'toml',
  },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  -- 启用代码高亮功能
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  -- 启用增量选择
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      node_decremental = '<BS>',
      scope_incremental = '<TAB>',
    },
  },
  -- 启用基于Treesitter的代码格式化(=) . NOTE: This is an experimental feature.
  indent = {
    enable = true,
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
})
-- 开启 Folding
vim.wo.foldmethod = 'indent'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.wo.foldlevel = 99
