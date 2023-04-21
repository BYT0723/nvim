local linters_by_ft = {
  c = { 'cpplint' },
  cpp = { 'cpplint' },
  go = { 'golangcilint' },
  vimscript = { 'vint' },
  markdown = { 'proselint' },
  javascript = { 'eslint_d' },
  typescript = { 'eslint_d' },
}

local global_linters = { 'codespell' }

local function addGlobals(linters)
  local res = {}
  for k, v in pairs(linters) do
    res[k] = { unpack(v), unpack(global_linters) }
  end
  return res
end

return addGlobals(linters_by_ft)

