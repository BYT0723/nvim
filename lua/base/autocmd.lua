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
    end
  end,
})

-- auto wrap line
vim.api.nvim_create_autocmd('FileType', { pattern = { 'markdown' }, command = 'set wrap' })

vim.api.nvim_create_autocmd('RecordingEnter', {
  callback = function()
    vim.notify('󰑋 ' .. vim.fn.reg_recording() .. ' RECORDING STARTED...')
  end,
})

vim.api.nvim_create_autocmd('RecordingLeave', {
  callback = function()
    vim.notify('󰑋 ' .. vim.fn.reg_recording() .. ' RECORDING FINISHED...')
  end,
})

--Start and stop mini.nvim plugins
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'NvimTree',
    'toggleterm',
    'mason',
    'Outline',
    'lazy',
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

-- 创建自动命令来监听 ModeChanged 事件
vim.api.nvim_create_autocmd('ModeChanged', {
  callback = function()
    if not vim.lsp.inlay_hint then
      return
    end
    if vim.fn.mode() == 'n' then
      -- 关闭 inlay hint
      if vim.lsp.inlay_hint and not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }) then
        vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
      end
    else
      -- 启用 inlay hint
      if vim.lsp.inlay_hint and vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }) then
        vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
      end
    end
  end,
})
