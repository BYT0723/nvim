local M = {}

local api = vim.api
local util = require('base.util')

M.exc_file = {
  lua = { 'keybindings.lua', 'dwm.c', 'st.c' },
  cpp = { 'config.h' },
}

function M.is_exc_file()
  if M.exc_file[vim.bo.filetype] == nil then
    return false
  end

  for _, v in ipairs(M.exc_file[vim.bo.filetype]) do
    if util.filename() == v then
      return true
    end
  end

  return false
end

-- formatting condition
M.formatCond = {
  is_empty = {
    msg = 'buffer is empty',
    level = vim.log.levels.INFO,
    func = function()
      return table.concat(api.nvim_buf_get_lines(0, 0, api.nvim_buf_line_count(0), false)) == ''
    end,
  },
  -- have_error = {
  --   msg = 'current buffer have errors',
  --   level = vim.log.levels.ERROR,
  --   func = function()
  --     local diagnostic_list = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  --     return #diagnostic_list ~= 0
  --   end,
  -- },
}

function M.format()
  local buf = vim.api.nvim_get_current_buf()
  if vim.b.autoformat == false and not (opts and opts.force) then
    return
  end

  local formatters = M.get_formatters(buf)
  local client_ids = vim.tbl_map(function(client)
    return client.id
  end, formatters.active)

  if #client_ids == 0 then
    return
  end

  vim.lsp.buf.format(vim.tbl_deep_extend('force', {
    bufnr = buf,
    filter = function(client)
      return vim.tbl_contains(client_ids, client.id)
    end,
  }, {}))
end

-- Gets all lsp clients that support formatting.
-- When a null-ls formatter is available for the current filetype,
-- only null-ls formatters are returned.
function M.get_formatters(bufnr)
  local ft = vim.bo[bufnr].filetype
  -- check if we have any null-ls formatters for the current filetype
  local null_ls = package.loaded['null-ls'] and require('null-ls.sources').get_available(ft, 'NULL_LS_FORMATTING') or {}

  ---@class LazyVimFormatters
  local ret = {
    ---@type lsp.Client[]
    active = {},
    ---@type lsp.Client[]
    available = {},
    null_ls = null_ls,
  }

  ---@type lsp.Client[]
  local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    if M.supports_format(client) then
      if (#null_ls > 0 and client.name == 'null-ls') or #null_ls == 0 then
        table.insert(ret.active, client)
      else
        table.insert(ret.available, client)
      end
    end
  end

  return ret
end

-- Gets all lsp clients that support formatting
-- and have not disabled it in their client config
---@param client lsp.Client
function M.supports_format(client)
  if
    client.config
    and client.config.capabilities
    and client.config.capabilities.documentFormattingProvider == false
  then
    return false
  end
  return client.supports_method('textDocument/formatting') or client.supports_method('textDocument/rangeFormatting')
end

function M.setup()
  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    callback = function()
      -- stylua: ignore
      -- 如果是排除文件则不进行格式化
      if M.is_exc_file() then return end
      -- stylua: ignore
      for _, v in pairs(M.formatCond) do
        -- 如果不符合格式化条件则不进行格式化
        if v.func() then return end
      end
      M.format()
    end,
  })
end

return M
