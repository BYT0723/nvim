local M = {}

local api = vim.api
local util = require('util')

M.exc_file = {
  lua = { 'keybindings.lua' },
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
  have_error = {
    msg = 'current buffer have errors',
    level = vim.log.levels.ERROR,
    func = function()
      local diagnostic_list = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      return #diagnostic_list ~= 0
    end,
  },
}

return M
