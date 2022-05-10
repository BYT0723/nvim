vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true}

map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', opt)

local pluginKeys = {}

-- lsp 回调函数快捷键设置
pluginKeys.maplsp = function(mapbuf,bufnr)
  -- map('n', '<leader>f', '<cmd>lua vim.diagnostic.open_float()<CR>', opt)
  map('n', 'dk', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opt)
  map('n', 'dj', '<cmd>lua vim.diagnostic.goto_next()<CR>', opt)
  -- map('n', '<leader>l', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- rename
  mapbuf(bufnr,'n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)
  -- code action
  mapbuf(bufnr,'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opt)
  -- go xx
  mapbuf(bufnr,'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
  mapbuf(bufnr,'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
  mapbuf(bufnr,'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
  mapbuf(bufnr,'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opt)
  mapbuf(bufnr,'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
  -- leader + =
  mapbuf(bufnr,'n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opt)
  -- mapbuf(bufnr,'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opt)
  -- mapbuf(bufnr,'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf(bufnr,'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf(bufnr,'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapbuf(bufnr,'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
  return {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-k>'] = cmp.mapping.scroll_docs(-2),
    ['<C-j>'] = cmp.mapping.scroll_docs(2),
    -- 出现补全
    ['<A-.>'] = cmp.mapping.complete(),
    -- 取消
    ['<A-,>'] = cmp.mapping.abort(),
    -- 确认
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }
end

return pluginKeys
