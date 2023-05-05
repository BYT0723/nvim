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
    ['Q'] = { cmd = '<cmd>q!<CR>', desc = 'Exit window'},
    -- layout
    ['<C-k>'] = '<cmd>resize -5<CR>',
    ['<C-j>'] = '<cmd>resize +5<CR>',
    ['<C-h>'] = '<cmd>vertical resize -5<CR>',
    ['<C-l>'] = '<cmd>vertical resize +5<CR>',
    -- tab
    ['tk'] = '<cmd>tabp<CR>',
    ['tj'] = '<cmd>tabn<CR>',
    ['tq'] = '<cmd>tabclose<CR>',
    -- buffer
    -- ['bk'] = '<cmd>bp<CR>',
    -- ['bj'] = '<cmd>bn<CR>',
    -- ['bq'] = '<cmd>bdelete!<CR>',
    -- quickfix
    ['ck'] = '<cmd>cp<CR>',
    ['cj'] = '<cmd>cn<CR>',
    ['cc'] = '<cmd>cc<CR>',
    ['<leader>c'] = { cmd = "<cmd>lua require('util').toggle_quickfix()<CR>", desc = 'Quickfix'},
    --launcher
    ['<leader>rf'] = { cmd = "<cmd>lua require('launcher').runFile()<CR>",             desc = "Run File" },
    ['<leader>rp'] = { cmd = "<cmd>lua require('launcher').runProject()<CR>",          desc = "Start Project" },
    ['<leader>ri'] = { cmd = "<cmd>lua require('launcher').getRunProjectCmd()<CR>",    desc = "Show project command" },
    ['<leader>re'] = { cmd = "<cmd>lua require('launcher').editRunProjectCmd()<CR>",   desc = "Edit project command" },
    ['<leader>rm'] = { cmd = "<cmd>lua require('launcher').removeRunProjectCmd()<CR>", desc = "Remove project command" },
  },
  t = {
    ['<C-q>'] = '<C-\\><C-n>',
    ['<C-w>j'] = '<cmd>wincmd j<CR>',
    ['<C-w>k'] = '<cmd>wincmd k<CR>',
    ['<C-w>h'] = '<cmd>wincmd h<CR>',
    ['<C-w>l'] = '<cmd>wincmd l<CR>',
  },
}

M.Notify = {
  n = {
    ['<leader>un'] = { cmd = "<cmd>lua require('notify').dismiss()<CR>", desc = "Hide all notifications" },
  },
}

M.PanTran = {
  n = {
    ['<leader>tw'] = { cmd = '<cmd>Pantran mode=hover target=zh<CR>',   desc = "Translate line" },
    ['<leader>tr'] = { cmd = '<cmd>Pantran mode=replace target=en<CR>', desc = "Translate and Replace" },
    ['<leader>ta'] = { cmd = '<cmd>Pantran mode=append target=en<CR>',  desc = "Translate and Append"},
    ['<leader>ti'] = { cmd = '<cmd>Pantran mode=interactive<CR>',       desc = "Translate Interactive UI" },
  },
  x = {
    ['<leader>tw'] = "<cmd>'<,'>Pantran mode=hover target=zh<CR>",
    ['<leader>tr'] = "<cmd>'<,'>Pantran mode=replace target=en<CR>",
    ['<leader>ta'] = "<cmd>'<,'>Pantran mode=append target=en<CR>",
    ['<leader>ti'] = "<cmd>'<,'>Pantran mode=interactive<CR>",
  },
}

M.Hop = {
  [''] = {
    ['f'] = '<cmd>HopChar1CurrentLine<cr>',
    ['F'] = '<cmd>HopChar2<cr>',
  },
}

M.EasyAlign = {
  n = {
    ['ga'] = '<Plug>(EasyAlign)',
  },
  x = {
    ['ga'] = '<Plug>(EasyAlign)',
  },
}

M.NvimTree = {
  n = {
    ['<leader>ee'] = { cmd = '<cmd>NvimTreeFocus<CR>', desc = "NvimTree" },
    ['<leader>ec'] = { cmd = '<cmd>NvimTreeCollapseKeepBuffers<CR>', desc = "NvimTree Collapse" },
    ['<leader>eC'] = { cmd = '<cmd>NvimTreeCollapseKeepBuffers<CR>', desc = "NvimTree Collapse All" },
  },
}

M.Lspsaga = {
  n = {
    ['<leader>v'] = '<cmd>Lspsaga outline<CR>',
  },
}

M.Gitsigns = {
  n = {
    ['<leader>gk'] = { cmd = '<cmd>Gitsigns prev_hunk<CR>',                  desc = "Jump to previous hunk" },
    ['<leader>gj'] = { cmd = '<cmd>Gitsigns next_hunk<CR>',                  desc = "Jump to next hunk" },
    ['<leader>gb'] = { cmd = '<cmd>Gitsigns blame_line<CR>',                 desc = "Show Blamer" },
    ['<leader>gv'] = { cmd = '<cmd>Gitsigns preview_hunk<CR>',               desc = "Preview hunk" },
    ['<leader>gr'] = { cmd = '<cmd>Gitsigns reset_hunk<CR>',                 desc = "Reset hunk" },
    ['<leader>gR'] = { cmd = '<cmd>Gitsigns reset_buffer<CR>',               desc = "Reset all hunk" },
    ['<leader>gs'] = { cmd = '<cmd>Gitsigns stage_hunk<CR>',                 desc = "Stage hunk" },
    ['<leader>gu'] = { cmd = '<cmd>Gitsigns undo_stage_hunk<CR>',            desc = "Undo last stage" },
    ['<leader>gtb'] = { cmd = '<cmd>Gitsigns toggle_current_line_blame<CR>', desc = "Toggle Blamer" },
    ['<leader>gts'] = { cmd = '<cmd>Gitsigns toggle_signs<CR>',              desc = "Toggle Sings" },
    ['<leader>gtn'] = { cmd = '<cmd>Gitsigns toggle_numhl<CR>',              desc = "Toggle Number highlight" },
    ['<leader>gtl'] = { cmd = '<cmd>Gitsigns toggle_linehl<CR>',             desc = "Toggle Line highlight" },
    ['<leader>gtw'] = { cmd = '<cmd>Gitsigns toggle_word_diff<CR>',          desc = "Toggle Work_Diff" },
    ['<leader>gtd'] = { cmd = '<cmd>Gitsigns toggle_deleted<CR>',            desc = "Toggle Deleted Line" },
  },
}

M.Trouble = {
  n = {
    ['<leader>xx'] = { cmd = '<cmd>TroubleToggle<CR>',                                  desc = "Trouble" },
    ['<leader>xw'] = { cmd = '<cmd>TroubleToggle workspace_diagnostics<CR>',            desc = 'Workspace Diagnostics in Trouble'},
    ['<leader>xd'] = { cmd = '<cmd>TroubleToggle document_diagnostics<CR>',             desc = 'Document Diagnostics in Trouble' },
    ['<leader>xq'] = { cmd = '<cmd>TroubleToggle quickfix<CR>',                         desc = 'Quickfix in Trouble' },
    ['<leader>xl'] = { cmd = '<cmd>TroubleToggle loclist<CR>',                          desc = 'Loclist in Trouble' },
    ['<leader>xk'] = { cmd = '<cmd>lua require("trouble").previous({skip_groups = true, jump = true})<CR>', desc = "Previous in Trouble" },
    ['<leader>xj'] = { cmd = '<cmd>lua require("trouble").next({skip_groups = true, jump = true})<CR>', desc = 'Next in Trouble' },
  },
}

M.TodoComments = {
  n = {
    ['<leader>xt'] = { cmd = '<cmd>TroubleToggle todo<CR>', desc = "Todo-Comments" },
    ['<leader>xT'] = { cmd = '<cmd>TroubleToggle todo keywords=TODO,FIX disable_not_found_warnings=true<CR>', desc = "Todo-Comments { TODO | FIX }" },
  },
}

M.Bufferline = {
  n = {
    ['bk'] = '<cmd>BufferLineCyclePrev<CR>',
    ['bj'] = '<cmd>BufferLineCycleNext<CR>',
    ['bK'] = '<cmd>BufferLineMovePrev<CR>',
    ['bJ'] = '<cmd>BufferLineMoveNext<CR>',
    ['bp'] = '<cmd>BufferLinePick<CR>',
    ['bP'] = '<cmd>BufferLineTogglePin<CR>',
    ['bq'] = '<cmd>bdelete!<CR>',
  },
}

M.Diffview = {
  n = {
    ['<leader>gd'] = '<cmd>DiffviewOpen<CR>',
  },
}

M.Dap = {
  n = {
    ['<leader>du'] = { cmd = '<cmd>DapToggle<CR>',                              desc = 'Toggle Dap UI' },
    ['<leader>db'] = { cmd = "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = 'Toggle Breakpoint' },
    ['<leader>dc'] = { cmd = "<cmd>lua require('dap').continue()<CR>",          desc = 'Dap Continue' },
    ['<leader>di'] = { cmd = "<cmd>lua require('dap').step_into()<CR>",         desc = 'Step Into' },
    ['<leader>do'] = { cmd = "<cmd>lua require('dap').step_out()<CR>",          desc = 'Step Out' },
    ['<leader>dO'] = { cmd = "<cmd>lua require('dap').step_over()<CR>",         desc = 'Step Over' },
    ['<leader>de'] = { cmd = '<cmd>lua require("dapui").eval()<CR>',            desc = 'Dap Eval' },
  },
}

M.Telescope = {
  n = {
    ['<leader>ff'] = { cmd = "<cmd>lua require('telescope.builtin').find_files()<CR>", desc = 'Find Files' },
    ['<leader>fg'] = { cmd = "<cmd>lua require('telescope.builtin').live_grep()<CR>",  desc = 'Find Content' },
    ['<leader>fr'] = { cmd = "<cmd>lua require('telescope.builtin').oldfiles()<CR>",   desc = 'Recent Files' },
    ['<leader>fp'] = { cmd = '<cmd>Telescope projects<CR>',                            desc = 'Recent Projects' },
    ["<leader>f'"] = { cmd = "<cmd>lua require('telescope.builtin').marks()<CR>",      desc = 'List Marks' },
  },
}

M.ToggleTerm = {
  n = {
    ['<leader>lr'] = { cmd = "<cmd>lua require('launcher').toolToggle('ranger')<CR>", desc = 'Ranger' },
    ['<leader>ld'] = { cmd = "<cmd>lua require('launcher').toolToggle('docker')<CR>", desc = 'LazyDocker' },
    ['<leader>lg'] = { cmd = "<cmd>lua require('launcher').toolToggle('git')<CR>",    desc = 'LazyGit' },
    ['<C-b>k'] = { cmd = "<cmd>lua require('launcher').term_prev()<CR>",              desc = 'Previous Terminal' },
    ['<C-b>j'] = { cmd = "<cmd>lua require('launcher').term_next()<CR>",              desc = 'Next Terminal' },
  },
  t = {
    ['<C-b>k'] = "<cmd>lua require('launcher').term_prev()<CR>",
    ['<C-b>j'] = "<cmd>lua require('launcher').term_next()<CR>",
  },
}

M.DB = {
  n = {
    ['<leader>zz'] = { cmd = "<cmd>DBUIToggle<CR>", desc = 'Database Manager'}
  }
}

-- lsp keybind
M.maplsp = function(mapbuf, bufnr)
  lsp_keys = {
    n = {
      -- diagnostic
      -- ['<leader>f'] = { cmd = '<cmd>lua vim.diagnostic.open_float()<CR>',                                                 desc = 'Hover Diagnostic' },
      -- ['<leader>l'] = { cmd = '<cmd>lua vim.diagnostic.setloclist()<CR>',                                                 desc = 'Loclist Diagnostic' },
      ['dk'] = { cmd = '<cmd>Lspsaga diagnostic_jump_prev<CR>',                                                              desc = "Prev Diagnostic" },
      ['dj'] = { cmd = '<cmd>Lspsaga diagnostic_jump_next<CR>',                                                              desc = "Next Diagnostic" },
      ['dK'] = { cmd = "<cmd>lua require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>", desc = "Prev Diagnostic [ERROR]" },
      ['dJ'] = { cmd = "<cmd>lua require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>", desc = "Next Diagnostic [ERROR]" },
      -- rename
      ['<leader>rn'] = { cmd = '<cmd>Lspsaga rename<CR>',                                                                    desc = "Global Rename"},
      -- code action
      ['<leader>a'] = { cmd = '<cmd>Lspsaga code_action<CR>',                                                                desc = "Code Actions"},
      -- go xx
      ['gd'] = { cmd = '<cmd>Lspsaga peek_definition<CR>',                                                                   desc = "Hover Definition"},
      ['gD'] = { cmd = '<cmd>lua vim.lsp.buf.definition()<CR>',                                                              desc = "Jump to Definition"},
      -- ["<leader>D"] = { cmd = "<cmd>lua vim.lsp.buf.type_definition()<CR>",                                               desc = 'Jump to Type Definition' },
      -- ["gD"] = { cmd = "<cmd>lua vim.lsp.buf.declaration()<CR>",                                                          desc = 'Jump to Declaration' },
      ['gi'] = { cmd = '<cmd>lua vim.lsp.buf.implementation()<CR>',                                                          desc = 'Jump to Implementation' },
      ['gr'] = { cmd = '<cmd>Lspsaga lsp_finder<CR>',                                                                        desc = 'LSP Finder' },
      ['K'] = { cmd = '<cmd>Lspsaga hover_doc<CR>',                                                                          desc = 'Hover Document' },
      ['<leader>='] = { cmd ='<cmd>lua vim.lsp.buf.formatting()<CR>',                                                        desc = 'LSP Format' },
      ['<leader>wa'] = { cmd = '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',                                            desc = 'Add Folder' },
      ['<leader>wr'] = { cmd = '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',                                         desc = 'Remove Folder' },
      ['<leader>wl'] = { cmd = '<cmd>lua vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',                 desc = 'List Workspace Folders' },
    },
    v = {
      ['<leader>a'] = { cmd = '<cmd>Lspsaga code_action<CR>',                desc = 'Code Actions of Range' },
      ['<leader>='] = { cmd = '<cmd>lua vim.lsp.buf.range_formatting()<CR>', desc = 'Format of Range' },
    }
  }
  for mode, kv in pairs(lsp_keys) do
    for key, item in pairs(kv) do
      if type(item) == 'table' then
        mapbuf(bufnr, mode, key, item.cmd, { noremap = true, silent = true, desc = item.desc })
      elseif type(item) == 'string' then
        mapbuf(bufnr, mode, key, item, { noremap = true, silent = true })
      end
    end
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
