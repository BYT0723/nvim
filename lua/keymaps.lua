-- set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local M = {}

M.Common = {
  [''] = {
    ['gh'] = { cmd = '^', desc = 'Line Head' },
    ['ge'] = { cmd = '$', desc = 'Line end' },
  },
  n = {
    ['W'] = { cmd = '<cmd>w!<CR>', desc = 'Save file' },
    ['Q'] = { cmd = '<cmd>q!<CR>', desc = 'Exit window' },
    -- layout
    ['<C-k>'] = { cmd = '<cmd>resize -5<CR>', desc = 'Reduce window width' },
    ['<C-j>'] = { cmd = '<cmd>resize +5<CR>', desc = 'Increase window width' },
    ['<C-h>'] = { cmd = '<cmd>vertical resize -5<CR>', desc = 'Reduce form height' },
    ['<C-l>'] = { cmd = '<cmd>vertical resize +5<CR>', desc = 'Increase window height' },
    -- tab
    ['tk'] = { cmd = '<cmd>tabp<CR>', desc = 'previous tab' },
    ['tj'] = { cmd = '<cmd>tabn<CR>', desc = 'next tab' },
    ['tq'] = { cmd = '<cmd>tabclose<CR>', desc = 'close tab' },
    -- buffer
    -- ['bk'] = '<cmd>bp<CR>',
    -- ['bj'] = '<cmd>bn<CR>',
    -- ['bq'] = '<cmd>bdelete!<CR>',
    -- quickfix
    ['ck'] = { cmd = '<cmd>cp<CR>', desc = 'previous item in quickfix' },
    ['cj'] = { cmd = '<cmd>cn<CR>', desc = 'next item in quickfix' },
    ['cc'] = { cmd = '<cmd>cc<CR>', desc = 'current item in quickfix' },
    ['<leader>c'] = { cmd = "<cmd>lua require('util').toggle_quickfix()<CR>", desc = 'Quickfix' },
    --launcher
    ['<leader>rf'] = { cmd = "<cmd>lua require('launcher').runFile()<CR>", desc = 'Run File' },
    ['<leader>rp'] = { cmd = "<cmd>lua require('launcher').runProject()<CR>", desc = 'Start Project' },
    ['<leader>ri'] = { cmd = "<cmd>lua require('launcher').getRunProjectCmd()<CR>", desc = 'Show project command' },
    ['<leader>re'] = { cmd = "<cmd>lua require('launcher').editRunProjectCmd()<CR>", desc = 'Edit project command' },
    ['<leader>rm'] = { cmd = "<cmd>lua require('launcher').removeRunProjectCmd()<CR>", desc = 'Remove project command' },
  },
  t = {
    ['<C-q>'] = { cmd = '<C-\\><C-n>', desc = 'Exit terminal mode' },
    ['<C-w>j'] = { cmd = '<cmd>wincmd j<CR>', desc = 'Move to window below' },
    ['<C-w>k'] = { cmd = '<cmd>wincmd k<CR>', desc = 'Move to upper window' },
    ['<C-w>h'] = { cmd = '<cmd>wincmd h<CR>', desc = 'Move to left window' },
    ['<C-w>l'] = { cmd = '<cmd>wincmd l<CR>', desc = 'Move to right window' },
  },
}

M.Bufferline = {
  { 'bk', '<cmd>BufferLineCyclePrev<CR>', mode = 'n', desc = 'previous buffer' },
  { 'bj', '<cmd>BufferLineCycleNext<CR>', mode = 'n', desc = 'next buffer' },
  { 'bK', '<cmd>BufferLineMovePrev<CR>', mode = 'n', desc = 'Move buffer forward' },
  { 'bJ', '<cmd>BufferLineMoveNext<CR>', mode = 'n', desc = 'Move buffer backward' },
  { 'bp', '<cmd>BufferLinePick<CR>', mode = 'n', desc = 'pick a buffer' },
  { 'bP', '<cmd>BufferLineTogglePin<CR>', mode = 'n', desc = 'pin a buffer' },
  { 'bq', '<cmd>bdelete!<CR>', mode = 'n', desc = 'close buffer' },
}

-- stylua: ignore
M.Notify = {
  { '<leader>un', function() require('notify').dismiss({}) end, desc = 'Hide all notifications', },
}

-- stylua: ignore
M.Noice = {
  { '<c-d>', function() if not require('noice.lsp').scroll(4) then return '<c-d>' end end, mode = { 'n', 'i', 's' }, desc = 'Scroll Down', },
  { '<c-u>', function() if not require('noice.lsp').scroll(4) then return '<c-u>' end end, mode = { 'n', 'i', 's' }, desc = 'Scroll Up', },
}

-- stylua: ignore
M.NvimTree = { { '<leader>e', function() require('nvim-tree.api').tree.toggle() end, desc = 'NvimTree', }, }

-- stylua: ignore
M.ToggleTerm = {
  { '<leader>lr', function() require('launcher').toolToggle('ranger') end, mode = { 'n', 't' }, desc = 'Ranger' },
  { '<leader>ld', function() require('launcher').toolToggle('docker') end, mode = { 'n', 't' }, desc = 'LazyDocker' },
  { '<leader>lg', function() require('launcher').toolToggle('git') end,    mode = { 'n', 't' }, desc = 'LazyGit' },
  { '<C-b>n',     function() require('launcher').term_new() end,           mode = { 'n', 't' }, desc = 'New Terminal' },
  { '<C-b>k',     function() require('launcher').term_prev() end,          mode = { 'n', 't' }, desc = 'Previous Terminal' },
  { '<C-b>j',     function() require('launcher').term_next() end,          mode = { 'n', 't' }, desc = 'Next Terminal' },
}

-- stylua: ignore
M.PanTran = {
  { '<leader>tw', '<cmd>Pantran mode=hover target=zh<CR>',   mode = 'n', desc = 'Translate line' },
  { '<leader>tr', '<cmd>Pantran mode=replace target=en<CR>', mode = 'n', desc = 'Translate and Replace' },
  { '<leader>ta', '<cmd>Pantran mode=append target=en<CR>',  mode = 'n', desc = 'Translate and Append' },
  { '<leader>ti', '<cmd>Pantran mode=interactive<CR>',       mode = 'n', desc = 'Translate Interactive UI' },
}

-- stylua: ignore
M.Hop = {
  { 'f', '<cmd>HopChar1CurrentLine<cr>', mode = { 'n', 'v', 'x' }, desc = 'find single char in current line' },
  { 'F', '<cmd>HopChar2<cr>',            mode = { 'n', 'v', 'x' }, desc = 'find two connected char' },
}

-- stylua: ignore
M.EasyAlign = {
  { 'ga',  '<Plug>(EasyAlign)', mode = { 'n', 'v', 'x' }, desc = 'Text Align' },
  { 'gla', '<Plug>(EasyAlign)', mode = { 'n', 'v', 'x' }, desc = 'Text Align' },
}

M.Lspsaga = {
  { '<leader>v', '<cmd>Lspsaga outline<CR>', desc = 'Syntax Tree' },
}

M.Trouble = {
  { '<leader>xx', '<cmd>TroubleToggle<CR>', desc = 'Trouble' },
  { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Workspace Diagnostics in Trouble' },
  { '<leader>xd', '<cmd>TroubleToggle document_diagnostics<CR>', desc = 'Document Diagnostics in Trouble' },
  { '<leader>xq', '<cmd>TroubleToggle quickfix<CR>', desc = 'Quickfix in Trouble' },
  { '<leader>xl', '<cmd>TroubleToggle loclist<CR>', desc = 'Loclist in Trouble' },
  {
    '<leader>xk',
    function()
      require('trouble').previous({ skip_groups = true, jump = true })
    end,
    desc = 'Previous in Trouble',
  },
  {
    '<leader>xj',
    function()
      require('trouble').next({ skip_groups = true, jump = true })
    end,
    desc = 'Next in Trouble',
  },
}

M.TodoComments = {
  { '<leader>xt', '<cmd>TroubleToggle todo<CR>', desc = 'Todo-Comments' },
  {
    '<leader>xT',
    '<cmd>TroubleToggle todo keywords=TODO,FIX disable_not_found_warnings=true<CR>',
    desc = 'Todo-Comments [TODO|FIX]',
  },
}

-- stylua: ignore
M.LspInlayHints = {
  { '<leader>it', function() require("lsp-inlayhints").toggle() end, desc = 'LspInlayHints Toggle' },
  { '<leader>ir', function() require("lsp-inlayhints").reset() end,  desc = 'LspInlayHints Reset' },
}

M.Diffview = {
  { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = 'Git Diffview' },
}

-- stylua: ignore
M.Dap = {
  { '<leader>du', function() require('plugins.configs.dap-local').DapToggle() end, mode = 'n', desc = 'Toggle Dap UI',     },
  { '<leader>db', function() require('dap').toggle_breakpoint() end,               mode = 'n', desc = 'Toggle Breakpoint', },
  { '<leader>dc', function() require('dap').continue() end,                        mode = 'n', desc = 'Dap Continue',      },
  { '<leader>di', function() require('dap').step_into() end,                       mode = 'n', desc = 'Step Into',         },
  { '<leader>do', function() require('dap').step_out() end,                        mode = 'n', desc = 'Step Out',          },
  { '<leader>dO', function() require('dap').step_over() end,                       mode = 'n', desc = 'Step Over',         },
  { '<leader>de', function() require('dapui').eval() end,                          mode = 'n', desc = 'Dap Eval',          },
}

M.Telescope = {
  { '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<CR>", desc = 'Find Files' },
  { '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<CR>", desc = 'Find Content' },
  { '<leader>fr', "<cmd>lua require('telescope.builtin').oldfiles()<CR>", desc = 'Recent Files' },
  { '<leader>fp', '<cmd>Telescope projects<CR>', desc = 'Recent Projects' },
  { "<leader>f'", "<cmd>lua require('telescope.builtin').marks()<CR>", desc = 'List Marks' },
}

M.DB = {
  { '<leader>zz', '<cmd>DBUIToggle<CR>', desc = 'Database Manager' },
}

-- lsp keybind
M.maplsp = function(bufnr)
  -- stylua: ignore
  local lsp_keys = {
    -- diagnostic
    -- { '<leader>f', function() vim.diagnostic.open_float() end, desc = 'Hover Diagnostic', },
    -- { '<leader>l', function() vim.diagnostic.setloclist() end, desc = 'Loclist Diagnostic', },
    { 'dk', function() vim.diagnostic.goto_prev() end, desc = 'Prev Diagnostic', },
    { 'dj', function() vim.diagnostic.goto_next() end, desc = 'Next Diagnostic', },
    { 'dK', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, desc = 'Prev Diagnostic [ERROR]', },
    { 'dJ', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, desc = 'Next Diagnostic [ERROR]', },
    -- rename and code_action
    { '<leader>rn', function() vim.lsp.buf.rename() end,      desc = 'Global Rename', },
    { '<leader>a',  function() vim.lsp.buf.code_action() end, desc = 'Code Actions',  },
    { '<leader>a',  function() vim.lsp.buf.code_action() end, mode = 'v',             desc = 'Code Actions of Range' },
    -- goto xx
    { 'gD',  function() vim.lsp.buf.declaration() end,     desc = 'Jump to Declaration' },
    { 'gd',  function() vim.lsp.buf.definition() end,      desc = 'Jump to Definition' },
    { 'gtd', function() vim.lsp.buf.type_definition() end, desc = 'Jump to Type Definition' },
    { 'gi',  function() vim.lsp.buf.implementation() end,  desc = 'List Implementation' },
    { 'gr',  function() vim.lsp.buf.references() end,      desc = 'LSP Finder' },
    { 'K',   function() vim.lsp.buf.hover() end,           desc = 'Hover Document' },
    -- format
    {'<leader>=', function() vim.lsp.buf.formatting() end,       desc = 'LSP Format', },
    {'<leader>=', function() vim.lsp.buf.range_formatting() end, mode = 'v',          desc = 'Format of Range' },
  }
  for _, key in pairs(lsp_keys) do
    vim.keymap.set(key.mode or 'n', key[1], key[2], { buffer = bufnr, silent = true })
  end
end

function M.Load_Keys(keys)
  for mode, kv in pairs(M[keys]) do
    for key, item in pairs(kv) do
      if type(item) == 'table' then
        vim.api.nvim_set_keymap(mode, key, item.cmd, { noremap = true, silent = true, desc = item.desc })
      elseif type(item) == 'string' then
        vim.api.nvim_set_keymap(mode, key, item, { noremap = true, silent = true })
      end
    end
  end
end

return M
