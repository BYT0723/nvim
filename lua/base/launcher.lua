local M = {}

local term_api = require('toggleterm.terminal')
local Terminal = require('toggleterm.terminal').Terminal
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

local runFileTerm = Terminal:new({ direction = 'horizontal', display_name = 'RUN FILE' })

-- stylua: ignore
local tools = {
  git                   = Terminal:new({ cmd = 'lazygit',    display_name ='LazyGit',    direction ='tab'   }),
  docker                = Terminal:new({ cmd = 'lazydocker', display_name ='LazyDocker', direction ='tab'   }),
  file_explorer         = Terminal:new({ cmd = 'yazi',       display_name ='Yazi',       direction ='float' }),
  file_explorer_on_file = Terminal:new({ cmd = 'yazi %:p',   display_name ='Yazi',       direction ='float' }),
}

function M.toolToggle(name)
  local tool = tools[name]
  tool.dir = vim.fn.getcwd()
  tool:toggle()
end

-- run file
function M.runFile()
  local cmd = VimCommands[vim.bo.filetype]
  if cmd ~= nil and cmd ~= '' then
    print(cmd)
    vim.cmd(cmd)
    return
  end

  cmd = runFileCmd(vim.bo.filetype)

  runFileTerm.dir = vim.fn.getcwd()

  if not runFileTerm:is_open() then
    runFileTerm:open()
  end
  runFileTerm:send(cmd, true)
end

-- get current buffer terminal id
local current_term_id = function()
  local buf_name = vim.fn.bufname()
  local start, _ = string.find(buf_name, '#%d')
  return tonumber(string.sub(buf_name, start + 1))
end

-- exchange term
local exchange_term = function(target, current)
  current:close()
  if not target:is_open() then
    target:open()
  end
  target:focus()
  vim.cmd('startinsert')
end

-- toggleterm : move to previous term in list which order by term_id
function M.term_prev()
  local id = current_term_id()
  local current_term = term_api.get(id)
  local target_term = nil

  for _, term in pairs(term_api.get_all(true)) do
    if term.id == id then
      break
    end
    target_term = term
  end

  if target_term == nil then
    vim.notify('This is the first terminal', vim.log.levels.WARN)
    return
  end

  exchange_term(target_term, current_term)
end

-- toggleterm : move to next term in list which order by term_id
function M.term_next()
  local id = current_term_id()
  local current_term = term_api.get(id)
  local target_term = nil

  for _, term in pairs(term_api.get_all(true)) do
    if term.id > id then
      target_term = term
      break
    end
  end

  if target_term == nil then
    vim.notify('This is the last terminal', vim.log.levels.WARN)
    return
  end

  exchange_term(target_term, current_term)
end

-- toggleterm : create a new terminal
function M.term_new()
  local current_term = term_api.get(current_term_id())
  local id = term_api.get_all(true)[#term_api.get_all(true)].id + 1
  local target_term = Terminal:new({ id = id })
  exchange_term(target_term, current_term)
end

return M
