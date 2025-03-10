local M = {}

local util = require('base.util')

local VimCommands = {
  ['vim'] = 'source %',
  ['lua'] = 'luafile %',
  ['dot'] = '!vimdot %',
  ['markdown'] = 'MarkdownPreviewToggle',
}

-- Map file types to corresponding commands
local function runFileCmd(type)
  local relativePath = util.relative_path()
  local relativePathExclueName = util.relative_path_ex_name()
  local filenameExcludeSuffix = util.filename_ex_suffix()

  local cmd = ''
  if type == 'c' or type == 'cpp' then
    -- Create a directory to store binaries
    local binDir = util.cwd() .. '/.bin'
    if vim.fn.isdirectory(binDir) == 0 then
      vim.fn.mkdir(binDir)
    end
    cmd = string.format(
      'g++ -o %s/%s %s && %s/%s',
      binDir,
      filenameExcludeSuffix,
      relativePath,
      binDir,
      filenameExcludeSuffix
    )
  elseif type == 'rust' then
    cmd = 'cargo run'
  elseif type == 'go' then
    cmd = 'go run ' .. relativePath
  elseif type == 'sh' or type == 'bash' then
    cmd = 'bash ' .. relativePath
  elseif type == 'zsh' then
    cmd = 'zsh ' .. relativePath
  elseif type == 'javascript' or type == 'typescript' then
    cmd = 'node ' .. relativePath
  elseif type == 'html' then
    cmd = 'surf ' .. relativePath
  elseif type == 'python' then
    cmd = 'python ' .. relativePath
  elseif type == 'proto' then
    cmd = 'protoc --proto_path='
      .. relativePathExclueName
      .. ' --go-grpc_out='
      .. relativePathExclueName
      .. '/pb '
      .. relativePath
  elseif type == 'gdscript' then
    cmd = 'godot ' .. relativePath
  end
  return cmd
end

-- run file
function M.runFile()
  local cmd = VimCommands[vim.bo.filetype]
  if cmd ~= nil and cmd ~= '' then
    vim.cmd(cmd)
    return
  end

  cmd = runFileCmd(vim.bo.filetype)
  local win, _ = Snacks.terminal.get(nil, { start_insert = false })
  win:show()
  vim.fn.chansend(vim.api.nvim_buf_get_var(win.buf, 'terminal_job_id'), cmd .. '\n')
end

return M
