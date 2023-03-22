local M = {}

-- help filename-modifiers

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

return M
