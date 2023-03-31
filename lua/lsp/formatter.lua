local api = vim.api
local util = require('util')

local exc_file = {
  lua = { 'keybindings.lua' },
  cpp = { 'config.h' },
}

local function is_exc_file()
  if exc_file[vim.bo.filetype] == nil then
    return false
  end

  for _, v in ipairs(exc_file[vim.bo.filetype]) do
    if util.filename() == v then
      return true
    end
  end

  return false
end

require('formatter').setup({
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    lua = { require('formatter.filetypes.lua').stylua },
    c = { require('formatter.filetypes.c').clangformat },
    cpp = { require('formatter.filetypes.cpp').clangformat },
    go = {
      require('formatter.filetypes.go').goimports,
      require('formatter.filetypes.go').gofmt,
    },
    python = { require('formatter.filetypes.python').autopep8 },
    rust = { require('formatter.filetypes.rust').rustfmt },
    sh = { require('formatter.filetypes.sh').shfmt },
    toml = { require('formatter.filetypes.toml').taplo },
    json = { require('formatter.defaults').prettierd },
    html = { require('formatter.defaults').prettierd },
    javascript = { require('formatter.defaults').prettierd },
    typescript = { require('formatter.defaults').prettierd },
    yaml = { require('formatter.defaults').prettierd },
    markdown = { require('formatter.defaults').prettierd },
    css = { require('formatter.defaults').prettierd },
    less = { require('formatter.defaults').prettierd },
    scss = { require('formatter.defaults').prettierd },
    vue = { require('formatter.defaults').prettierd },
    angular = { require('formatter.defaults').prettierd },

    proto = function()
      return {
        exe = 'buf',
        args = { 'format', util.relative_path() },
        stdin = true,
      }
    end,
    sql = function()
      return {
        exe = 'sql-formatter',
        stdin = true,
      }
    end,
    goctl = function()
      return {
        exe = 'goctl api format --stdin',
        stdin = true,
      }
    end,
  },
})

-- formatting condition
local formatCond = {
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

api.nvim_create_autocmd({ 'BufWritePost' }, {
  callback = function()
    if is_exc_file() then
      return
    end
    for _, v in pairs(formatCond) do
      if v.func() then
        -- vim.notify(v.msg, v.level)
        return
      end
    end
    vim.cmd('FormatWriteLock')
  end,
})
