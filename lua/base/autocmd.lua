-- The global indentation is 4 spaces, but some languages are more suitable for 2 spaces indentation
-- Flexible setting of 2 space indentation according to different languages
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'c',
    'cpp',
    'css',
    'dart',
    'dockerfile',
    'html',
    'gohtmltmpl',
    'javascript',
    'json',
    'less',
    'lua',
    'make',
    'markdown',
    'ruby',
    'scss',
    'toml',
    'typescript',
    'vue',
    'yaml',
  },
  command = 'setlocal shiftwidth=2 tabstop=2',
})

-- 当文件过大时，关闭语法高亮
-- When the file is too large, turn off the grammar highlight
vim.api.nvim_create_autocmd('BufReadPre', {
  pattern = '*',
  callback = function()
    local file_size = vim.fn.getfsize(vim.fn.expand('%'))
    if file_size > 1 * 1024 * 1024 then
      vim.treesitter.stop()
    end
  end,
})

-- auto set markdown
vim.api.nvim_create_autocmd('FileType', { pattern = { 'markdown' }, command = 'setlocal conceallevel=2' })
vim.api.nvim_create_autocmd('FileType', { pattern = { 'markdown' }, command = 'set wrap' })

vim.api.nvim_create_autocmd('RecordingEnter', {
  callback = function()
    vim.notify('󰑋 ' .. vim.fn.reg_recording() .. ' recording...')
  end,
})

vim.api.nvim_create_autocmd('RecordingLeave', {
  callback = function()
    vim.notify('󰑋 ' .. vim.fn.reg_recording() .. ' done.')
  end,
})

--Start and stop mini-indentint plugins
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'NvimTree',
    'toggleterm',
    'mason',
    'Outline',
    'lazy',
    'leetcode.nvim',
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

-- 当aerc等邮件客户端打开时,关闭状态栏
-- When AERC and other mail clients are opened, turn off the status bar
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'mail',
  callback = function()
    vim.opt.showtabline = 0
  end,
})

vim.api.nvim_create_autocmd('QuitPre', {
  callback = function()
    local snacks_windows = {}
    local floating_windows = {}
    local windows = vim.api.nvim_list_wins()
    for _, w in ipairs(windows) do
      local filetype = vim.api.nvim_get_option_value('filetype', { buf = vim.api.nvim_win_get_buf(w) })
      if filetype:match('snacks_') ~= nil then
        table.insert(snacks_windows, w)
      elseif vim.api.nvim_win_get_config(w).relative ~= '' then
        table.insert(floating_windows, w)
      end
    end
    if
      1 == #windows - #floating_windows - #snacks_windows
      and vim.api.nvim_win_get_config(vim.api.nvim_get_current_win()).relative == ''
    then
      for _, w in ipairs(snacks_windows) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end,
})
