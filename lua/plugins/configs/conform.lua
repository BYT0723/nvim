local exc_file = {
  lua = { 'keybindings.lua' },
  cpp = { 'config.h' },
  c = { 'dwm.c', 'st.c', 'i3lock.c', 'xwinwrap.c' },
}

local function is_exc_file(bufnr)
  local ft = vim.bo[bufnr].filetype
  local patterns = exc_file[ft]
  if not patterns then
    return false
  end
  local basename = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
  return vim.tbl_contains(patterns, basename)
end

return {
  format_on_save = function(bufnr)
    if vim.b[bufnr].autoformat == false then
      return
    end
    if is_exc_file(bufnr) then
      return
    end
    local max_filesize = 1 * 1024 * 1024 -- 1MB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
    if ok and stats and stats.size > max_filesize then
      return
    end
    return { timeout_ms = 2000, lsp_format = 'fallback' }
  end,
  formatters_by_ft = {
    lua = { 'stylua' },
    go = { 'gofumpt', 'goimports' },
    sh = { 'shfmt' },
    python = { 'ruff_format' },
    toml = { 'taplo' },
    proto = { 'buf' },
    sql = { 'sqruff' },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    css = { 'prettierd', 'prettier', stop_after_first = true },
    html = { 'prettierd', 'prettier', stop_after_first = true },
    json = { 'prettierd', 'prettier', stop_after_first = true },
    yaml = { 'prettierd', 'prettier', stop_after_first = true },
    markdown = { 'prettierd', 'prettier', stop_after_first = true },
  },
}
