local M = {}

-- stylua: ignore
M.Notify = {
  { '<leader>un', function() require('notify').dismiss({}) end, desc = 'Hide all notifications'},
}

-- stylua: ignore
M.Noice = {
  { '<c-f>', function() if not require('noice.lsp').scroll(4) then return '<c-f>' end end, mode = { 'n', 'i', 's' }, desc = 'Scroll Down', },
  { '<c-u>', function() if not require('noice.lsp').scroll(4) then return '<c-b>' end end, mode = { 'n', 'i', 's' }, desc = 'Scroll Up', },
}

-- stylua: ignore
M.MiniFiles = {
  {'<leader>e' , function() require('mini.files').open() end     , desc = 'Files Explorer'},
}

-- stylua: ignore
M.MiniSession = {
  {'<leader>fs', function() require('mini.sessions').select() end, desc = 'Find Session'},
}

-- stylua: ignore
M.MiniMap = {
  {'<leader>vm', function() require('mini.map').toggle() end, desc = 'Code Viewer'},
  {'<leader>vi', function() require('mini.map').toggle_focus() end, desc = 'Get in Code Viewer'}
}

-- stylua: ignore
M.PanTran = {
  { '<leader>tw', '<cmd>Pantran mode=hover target=zh<CR>',   mode = 'n', desc = 'Translate line' },
  { '<leader>tr', '<cmd>Pantran mode=replace target=en<CR>', mode = 'n', desc = 'Translate and Replace' },
  { '<leader>ta', '<cmd>Pantran mode=append target=en<CR>',  mode = 'n', desc = 'Translate and Append' },
  { '<leader>ti', '<cmd>Pantran mode=interactive<CR>',       mode = 'n', desc = 'Translate Interactive UI' },
}

M.Lspsaga = {
  { '<leader>v', '<cmd>Lspsaga outline<CR>', desc = 'Syntax Tree' },
}

-- stylua: ignore
M.Trouble = {
  { '<leader>xx', '<cmd>TroubleToggle<CR>', desc = 'Trouble' },
  { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Workspace Diagnostics in Trouble' },
  { '<leader>xd', '<cmd>TroubleToggle document_diagnostics<CR>', desc = 'Document Diagnostics in Trouble' },
  { '<leader>xq', '<cmd>TroubleToggle quickfix<CR>', desc = 'Quickfix in Trouble' },
  { '<leader>xl', '<cmd>TroubleToggle loclist<CR>', desc = 'Loclist in Trouble' },
  { '<leader>xk', function() require('trouble').previous({ skip_groups = true, jump = true }) end, desc = 'Previous in Trouble' },
  { '<leader>xj', function() require('trouble').next({ skip_groups = true, jump = true }) end, desc = 'Next in Trouble' },
}

-- stylua: ignore
M.TodoComments = {
  { '<leader>xt', '<cmd>TroubleToggle todo<CR>', desc = 'Todo-Comments' },
  { '<leader>xT', '<cmd>TroubleToggle todo keywords=TODO,FIX disable_not_found_warnings=true<CR>', desc = 'Todo-Comments [TODO|FIX]' },
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

-- stylua: ignore
M.Telescope = {
  { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Find Files' },
  { '<leader>fg', function() require('telescope.builtin').live_grep() end,  desc = 'Find Content' },
  { '<leader>fb', function() require('telescope.builtin').buffers() end,    desc = 'Find Buffers' },
  { '<leader>fr', function() require('telescope.builtin').oldfiles() end,   desc = 'Recent Files' },
  { "<leader>f'", function() require('telescope.builtin').marks() end,      desc = 'List Marks' },
  { '<leader>fp', '<cmd>Telescope projects<CR>',                            desc = 'Recent Projects' },
}

M.DB = {
  { '<leader>zz', '<cmd>DBUIToggle<CR>', desc = 'Database Manager' },
}

-- stylua: ignore
M.TreesitterContext = {
  { '[c', function() require('treesitter-context').go_to_context() end, desc = 'previous context item', },
}

-- stylua: ignore
M.Refactor = {
  {'<leader>rs', function() require('refactoring').select_refactor() end, desc = 'list of refactoring suggestions',},
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
    { '<leader>a',  function() vim.lsp.buf.code_action() end, desc = 'Code Actions of Range', mode = 'v', },
    -- goto xx
    { 'gD',  function() vim.lsp.buf.declaration() end,     desc = 'Jump to Declaration' },
    { 'gd',  function() vim.lsp.buf.definition() end,      desc = 'Jump to Definition' },
    { 'gtd', function() vim.lsp.buf.type_definition() end, desc = 'Jump to Type Definition' },
    { 'gi',  function() vim.lsp.buf.implementation() end,  desc = 'List Implementation' },
    { 'gr',  function() vim.lsp.buf.references() end,      desc = 'LSP Finder' },
    { 'K',   function() vim.lsp.buf.hover() end,           desc = 'Hover Document' },

    -- { 'dk', '<cmd>Lspsaga diagnostic_jump_prev<CR>', desc = 'Prev Diagnostic', },
    -- { 'dj', '<cmd>Lspsaga diagnostic_jump_next<CR>', desc = 'Next Diagnostic', },
    -- { 'dK', function() require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, desc = 'Prev Diagnostic [ERROR]', },
    -- { 'dJ', function() require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR }) end, desc = 'Next Diagnostic [ERROR]', },
    -- { '<leader>rn', '<cmd>Lspsaga rename<CR>', desc = 'Global Rename', },
    -- { '<leader>a', '<cmd>Lspsaga code_action<CR>', desc = 'Code Actions', },
    -- { 'gD', function() vim.lsp.buf.declaration() end, desc = 'Jump to Declaration', },
    -- { 'gd', function() vim.lsp.buf.definition() end, desc = 'Jump to Definition', },
    -- { 'gtd', function() vim.lsp.buf.type_definition() end, desc = 'Jump to Type Definition', },
    -- { 'gi', function() vim.lsp.buf.implementation() end, desc = 'List Implementation', },
    -- { 'gr', function() vim.lsp.buf.references() end, desc = 'LSP Finder', },
    -- { 'K', '<cmd>Lspsaga hover_doc<CR>', desc = 'Hover Document', },
    { '<leader>=', function() vim.lsp.buf.formatting() end, desc = 'LSP Format', },
    { '<leader>=', function() vim.lsp.buf.range_formatting() end, mode = 'v', desc = 'Format of Range', },
  }
  for _, key in pairs(lsp_keys) do
    vim.keymap.set(key.mode or 'n', key[1], key[2], { buffer = bufnr, silent = true, desc = key.desc })
  end
end

return M
