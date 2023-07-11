local M = {}

local term_api = require('toggleterm.terminal')
local Terminal = require('toggleterm.terminal').Terminal
local util = require('base.util')

-- The file path containing the project run command
local launchFile = '~/.config/nvim/lua/base/launcher.lua'

-- command dictionary [ project's path --- command ]
local runProjectCmd = {
  ['/home/walter/Workspace/Study/js/electron-demo'] = 'npm run dev',
  ['/home/walter/Workspace/Study/go/QManager'] = 'go run main.go',
  ['/home/walter/Workspace/Study/rust/yew-demo'] = 'trunk serve',
  ['/home/walter/Workspace/Study/rust/rocket-demo'] = 'cargo run',
  -- run project command
}

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
local runProjectTerm = Terminal:new({ direction = 'horizontal', display_name = 'RUN PROJECT' })

local tools = {
  git = Terminal:new({ cmd = 'lazygit', display_name = 'LazyGit', direction = 'tab' }),
  docker = Terminal:new({ cmd = 'lazydocker', display_name = 'LazyDocker', direction = 'tab' }),
  ranger = Terminal:new({ cmd = 'ranger', display_name = 'Ranger', direction = 'float' }),
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

-- run project cmd
function M.runProject()
  local cmd = runProjectCmd[util.cwd()]

  runProjectTerm.dir = vim.fn.getcwd()

  if cmd == nil then
    M.editRunProjectCmd()
    cmd = runProjectCmd[util.cwd()]
    if cmd == nil then
      vim.notify('Failed to set run project command!')
      return
    end
  end

  if not runProjectTerm:is_open() then
    runProjectTerm:open()
  end
  runProjectTerm:send(cmd, true)
end

-- edit run project command
function M.editRunProjectCmd()
  local cmd = runProjectCmd[util.cwd()]
  vim.ui.input({ prompt = 'Project [' .. util.project_name() .. '] Run ==> ', default = cmd }, function(input)
    if input == nil or input == '' then
      return
    end
    -- 写入 run project command
    -- 1. 不存在则Insert
    -- 2. 存在则Update
    if cmd == nil or cmd == '' then
      local lineNum =
        io.popen('cat ' .. launchFile .. " | grep 'local runProjectCmd' -n | awk -F ':' '{print $1}' | head -n 1")
          :read()
      vim.cmd(string.format('!sed -i \'%sa\\\t["%s"] = "%s",\' %s', tonumber(lineNum), util.cwd(), input, launchFile))
    else
      vim.cmd(
        string.format(
          '!sed -i \'s/\\["%s"\\] = "%s"/\\["%s"\\] = "%s"/1\' %s',
          string.gsub(util.cwd(), '/', '\\/'),
          runProjectCmd[util.cwd()],
          string.gsub(util.cwd(), '/', '\\/'),
          input,
          launchFile
        )
      )
    end
  end)
  package.loaded['base.launcher'] = nil
  require('base.launcher')
end

-- remove run project command
function M.removeRunProjectCmd()
  local res = io.popen("sed -i '/" .. string.gsub(util.cwd(), '/', '\\/') .. "/d' " .. launchFile):close()
  if res then
    print('SUCCESS!')
  else
    print('FAILED!')
  end
  package.loaded['base.launcher'] = nil
end

-- get run project command
function M.getRunProjectCmd()
  -- local cmd = io.popen("sed -n '/" .. string.gsub(util.cwd(), "/", "\\/") .. "/p' " .. lf):read()
  local cmd = runProjectCmd[util.cwd()]
  if cmd == nil then
    cmd = ''
  end
  print('Project [ ' .. util.project_name() .. ' ] Run ==> [ ' .. cmd .. ' ]')
  package.loaded['base.launcher'] = nil
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
