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
  command = 'setlocal tabstop=2 softtabstop=2 shiftwidth=2',
})

vim.api.nvim_create_autocmd('BufReadPre', {
  pattern = '*',
  callback = function()
    local file_size = vim.fn.getfsize(vim.fn.expand('%'))
    if file_size > 1 * 1024 * 1024 then
      -- vim.cmd('TSBufDisable highlight')
      vim.cmd('syntax off')
    else
      -- vim.cmd('TSBufEnable highlight')
      vim.cmd('syntax on')
    end
  end,
})

-- auto wrap line
vim.api.nvim_create_autocmd('FileType', { pattern = { 'markdown' }, command = 'set wrap' })

-- vim.api.nvim_create_autocmd('RecordingEnter', {
--   callback = function()
--     vim.notify('󰑋 ' .. vim.fn.reg_recording() .. ' RECORDING STARTED...')
--   end,
-- })
--
-- vim.api.nvim_create_autocmd('RecordingLeave', {
--   callback = function()
--     vim.notify('󰑋 ' .. vim.fn.reg_recording() .. ' RECORDING FINISHED...')
--   end,
-- })
