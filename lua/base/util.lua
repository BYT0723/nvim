local M = {}

local uv = vim.loop

function M.cwd()
  return vim.fn.getcwd()
end

function M.project_name()
  return vim.fn.fnamemodify(M.cwd(), ':t')
end

function M.absolute_path()
  return vim.api.nvim_buf_get_name(0)
end

function M.relative_path()
  return vim.fn.fnamemodify(M.absolute_path(), ':.')
end

function M.relative_path_ex_name()
  return vim.fn.fnamemodify(M.absolute_path(), ':h')
end

function M.filename()
  return vim.fn.fnamemodify(M.absolute_path(), ':t')
end

function M.filename_ex_suffix()
  return vim.fn.fnamemodify(M.absolute_path(), ':t:r')
end

function M.filename_suffix()
  return vim.fn.fnamemodify(M.absolute_path(), ':e')
end

function M.toggle_quickfix()
  local id = vim.fn.getqflist({ winid = 1 }).winid
  if id > 0 then
    vim.cmd('cclose')
  else
    vim.cmd('copen')
  end
end

function M.string_split(src, delimiter)
  if type(delimiter) ~= 'string' or #delimiter <= 0 then
    return
  end
  local start = 1
  local arr = {}
  while true do
    local pos = string.find(src, delimiter, start, true)
    if not pos then
      break
    end
    table.insert(arr, string.sub(src, start, pos - 1))
    start = pos + string.len(delimiter)
  end
  table.insert(arr, string.sub(src, start))
  return arr
end

function M.source_luafile()
  local pwd = M.cwd()
  local runtimepath = M.string_split(vim.o.runtimepath, ',')
  if runtimepath == nil or runtimepath == '' then
    return
  end
  for _, v in pairs(runtimepath) do
    if v == pwd then
      local path = vim.fn.fnamemodify(M.relative_path(), ':r')
      local rp_col = string.find(path, '/')
      if rp_col == nil then
        return
      end
      local res = string.sub(path, string.find(path, '/') + 1, string.len(path))
      package.loaded[res] = nil
      require(res)
      break
    end
  end
end

--- 创建目录
--- @param path string 目录
--- @return integer
function M.mkdir(path)
  local full = vim.fn.expand(path)
  if vim.fn.isdirectory(full) == 0 then
    return vim.fn.mkdir(full, 'p')
  end
  return 0
end

---递归收集符合 project marker 的子目录
---@param roots string[] 起始目录
---@param patterns string[] 项目标志
---@param max_depth integer 最大递归深度
---@return string[] 匹配到的目录路径
function M.find_project_dirs(roots, patterns, max_depth)
  local results = {}

  local function scan(dir, depth)
    if depth < 0 then
      return
    end

    -- 符合project patterns, 不进行遍历
    for _, pat in ipairs(patterns) do
      local path = dir .. '/' .. pat
      local stat = uv.fs_stat(path)
      if stat then
        table.insert(results, dir)
        return
      end
    end

    local handle = uv.fs_scandir(dir)
    if not handle then
      return
    end

    while true do
      local name, type = uv.fs_scandir_next(handle)
      if not name then
        break
      end
      if type == 'directory' then
        scan(dir .. '/' .. name, depth - 1)
      end
    end
  end

  for _, root in ipairs(roots) do
    scan(vim.fn.expand(root), max_depth or 2)
  end

  return results
end

return M
