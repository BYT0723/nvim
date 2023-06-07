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
    ['<C-k>'] = { cmd = '<cmd>resize -5<CR>',          desc = 'Reduce window width' },
    ['<C-j>'] = { cmd = '<cmd>resize +5<CR>',          desc = 'Increase window width' },
    ['<C-h>'] = { cmd = '<cmd>vertical resize -5<CR>', desc = 'Reduce form height' },
    ['<C-l>'] = { cmd = '<cmd>vertical resize +5<CR>', desc = 'Increase window height' },
    -- tab
    ['tk'] = { cmd = '<cmd>tabp<CR>',     desc = 'previous tab' },
    ['tj'] = { cmd = '<cmd>tabn<CR>',     desc = 'next tab' },
    ['tq'] = { cmd = '<cmd>tabclose<CR>', desc = 'close tab' },
    -- buffer
    -- ['bk'] = '<cmd>bp<CR>',
    -- ['bj'] = '<cmd>bn<CR>',
    -- ['bq'] = '<cmd>bdelete!<CR>',
    -- quickfix
    ['ck']        = { cmd = '<cmd>cp<CR>',                                    desc = 'previous item in quickfix' },
    ['cj']        = { cmd = '<cmd>cn<CR>',                                    desc = 'next item in quickfix' },
    ['cc']        = { cmd = '<cmd>cc<CR>',                                    desc = 'current item in quickfix' },
    ['<leader>c'] = { cmd = "<cmd>lua require('util').toggle_quickfix()<CR>", desc = 'Quickfix' },
    --launcher
    ['<leader>rf'] = { cmd = "<cmd>lua require('launcher').runFile()<CR>",             desc = 'Run File' },
    ['<leader>rp'] = { cmd = "<cmd>lua require('launcher').runProject()<CR>",          desc = 'Start Project' },
    ['<leader>ri'] = { cmd = "<cmd>lua require('launcher').getRunProjectCmd()<CR>",    desc = 'Show project command' },
    ['<leader>re'] = { cmd = "<cmd>lua require('launcher').editRunProjectCmd()<CR>",   desc = 'Edit project command' },
    ['<leader>rm'] = { cmd = "<cmd>lua require('launcher').removeRunProjectCmd()<CR>", desc = 'Remove project command' },
  },
  t = {
    ['<C-q>']  = { cmd = '<C-\\><C-n>',       desc = 'Exit terminal mode' },
    ['<C-w>j'] = { cmd = '<cmd>wincmd j<CR>', desc = 'Move to window below' },
    ['<C-w>k'] = { cmd = '<cmd>wincmd k<CR>', desc = 'Move to upper window' },
    ['<C-w>h'] = { cmd = '<cmd>wincmd h<CR>', desc = 'Move to left window' },
    ['<C-w>l'] = { cmd = '<cmd>wincmd l<CR>', desc = 'Move to right window' },
  },
}

M.Notify = {
  n = {
    ['<leader>un'] = { cmd = "<cmd>lua require('notify').dismiss()<CR>", desc = 'Hide all notifications' },
  },
}

M.PanTran = {
  n = {
    ['<leader>tw'] = { cmd = '<cmd>Pantran mode=hover target=zh<CR>',   desc = 'Translate line' },
    ['<leader>tr'] = { cmd = '<cmd>Pantran mode=replace target=en<CR>', desc = 'Translate and Replace' },
    ['<leader>ta'] = { cmd = '<cmd>Pantran mode=append target=en<CR>',  desc = 'Translate and Append' },
    ['<leader>ti'] = { cmd = '<cmd>Pantran mode=interactive<CR>',       desc = 'Translate Interactive UI' },
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
    ['f'] = { cmd = '<cmd>HopChar1CurrentLine<cr>', desc = 'find single char in current line' },
    ['F'] = { cmd = '<cmd>HopChar2<cr>',            desc = 'find two connected char' },
  },
}

M.EasyAlign = {
  n = {
    ['ga'] = { cmd = '<Plug>(EasyAlign)', desc = 'text align' },
  },
  x = {
    ['ga'] = { cmd = '<Plug>(EasyAlign)', desc = 'text align' },
  },
}

M.NvimTree = {
  n = {
    ['<leader>e'] = { cmd = '<cmd>NvimTreeToggle<CR>', desc = 'NvimTree' },
  },
}

M.Lspsaga = {
  n = {
    ['<leader>v'] = { cmd = '<cmd>Lspsaga outline<CR>', desc = 'Syntax Tree' },
  },
}

M.Gitsigns = {
  n = {
    ['<leader>gk']  = { cmd = '<cmd>Gitsigns prev_hunk<CR>',                 desc = 'Jump to previous hunk' },
    ['<leader>gj']  = { cmd = '<cmd>Gitsigns next_hunk<CR>',                 desc = 'Jump to next hunk' },
    ['<leader>gb']  = { cmd = '<cmd>Gitsigns blame_line<CR>',                desc = 'Show Blamer' },
    ['<leader>gv']  = { cmd = '<cmd>Gitsigns preview_hunk<CR>',              desc = 'Preview hunk' },
    ['<leader>gr']  = { cmd = '<cmd>Gitsigns reset_hunk<CR>',                desc = 'Reset hunk' },
    ['<leader>gR']  = { cmd = '<cmd>Gitsigns reset_buffer<CR>',              desc = 'Reset all hunk' },
    ['<leader>gs']  = { cmd = '<cmd>Gitsigns stage_hunk<CR>',                desc = 'Stage hunk' },
    ['<leader>gu']  = { cmd = '<cmd>Gitsigns undo_stage_hunk<CR>',           desc = 'Undo last stage' },
    ['<leader>gtb'] = { cmd = '<cmd>Gitsigns toggle_current_line_blame<CR>', desc = 'Toggle Blamer' },
    ['<leader>gts'] = { cmd = '<cmd>Gitsigns toggle_signs<CR>',              desc = 'Toggle Sings' },
    ['<leader>gtn'] = { cmd = '<cmd>Gitsigns toggle_numhl<CR>',              desc = 'Toggle Number highlight' },
    ['<leader>gtl'] = { cmd = '<cmd>Gitsigns toggle_linehl<CR>',             desc = 'Toggle Line highlight' },
    ['<leader>gtw'] = { cmd = '<cmd>Gitsigns toggle_word_diff<CR>',          desc = 'Toggle Work_Diff' },
    ['<leader>gtd'] = { cmd = '<cmd>Gitsigns toggle_deleted<CR>',            desc = 'Toggle Deleted Line' },
  },
}

M.Trouble = {
  n = {
    ['<leader>xx'] = { cmd = '<cmd>TroubleToggle<CR>',                                                     desc = 'Trouble' },
    ['<leader>xw'] = { cmd = '<cmd>TroubleToggle workspace_diagnostics<CR>',                               desc = 'Workspace Diagnostics in Trouble', },
    ['<leader>xd'] = { cmd = '<cmd>TroubleToggle document_diagnostics<CR>',                                desc = 'Document Diagnostics in Trouble', },
    ['<leader>xq'] = { cmd = '<cmd>TroubleToggle quickfix<CR>',                                            desc = 'Quickfix in Trouble' },
    ['<leader>xl'] = { cmd = '<cmd>TroubleToggle loclist<CR>',                                             desc = 'Loclist in Trouble' },
    ['<leader>xk'] = { cmd = '<cmd>lua require("trouble").previous({skip_groups = true,jump = true})<CR>', desc = 'Previous in Trouble', },
    ['<leader>xj'] = { cmd = '<cmd>lua require("trouble").next({skip_groups = true,jump = true})<CR>',     desc = 'Next in Trouble', },
  },
}

M.LspInlayHints = {
  n = {
    ['<leader>it'] = { cmd = '<cmd>lua require("lsp-inlayhints").toggle()<CR>', desc = 'LspInlayHints Toggle' },
    ['<leader>ir'] = { cmd = '<cmd>lua require("lsp-inlayhints").reset()<CR>',  desc = 'LspInlayHints Reset' },
  }
}

M.TodoComments = {
  n = {
    ['<leader>xt'] = { cmd = '<cmd>TroubleToggle todo<CR>',                                                   desc = 'Todo-Comments' },
    ['<leader>xT'] = { cmd = '<cmd>TroubleToggle todo keywords=TODO,FIX disable_not_found_warnings=true<CR>', desc = 'Todo-Comments [TODO|FIX]' },
  },
}

M.Bufferline = {
  n = {
    ['bk'] = { cmd = '<cmd>BufferLineCyclePrev<CR>', desc = 'previous buffer'},
    ['bj'] = { cmd = '<cmd>BufferLineCycleNext<CR>', desc = 'next buffer'},
    ['bK'] = { cmd = '<cmd>BufferLineMovePrev<CR>',  desc = 'Move buffer forward' },
    ['bJ'] = { cmd = '<cmd>BufferLineMoveNext<CR>',  desc = 'Move buffer backward' },
    ['bp'] = { cmd = '<cmd>BufferLinePick<CR>',      desc = 'pick a buffer' },
    ['bP'] = { cmd = '<cmd>BufferLineTogglePin<CR>', desc = 'pin a buffer' },
    ['bq'] = { cmd = '<cmd>bdelete!<CR>',            desc = 'close buffer'},
  },
}

M.Diffview = {
  n = {
    ['<leader>gd'] = { cmd = '<cmd>DiffviewOpen<CR>', desc = 'Git Diffview'},
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
    ['<C-b>n']     = { cmd = "<cmd>lua require('launcher').term_new()<CR>",           desc = 'New Terminal' },
    ['<C-b>k']     = { cmd = "<cmd>lua require('launcher').term_prev()<CR>",          desc = 'Previous Terminal' },
    ['<C-b>j']     = { cmd = "<cmd>lua require('launcher').term_next()<CR>",          desc = 'Next Terminal' },
  },
  t = {
    ['<C-b>n'] = { cmd = "<cmd>lua require('launcher').term_new()<CR>",  desc = 'new terminal' },
    ['<C-b>k'] = { cmd = "<cmd>lua require('launcher').term_prev()<CR>", desc = 'previous terminal'},
    ['<C-b>j'] = { cmd = "<cmd>lua require('launcher').term_next()<CR>", desc = 'next terminal'},
  },
}

M.DB = {
  n = {
    ['<leader>zz'] = { cmd = '<cmd>DBUIToggle<CR>', desc = 'Database Manager' },
  },
}

-- lsp keybind
M.maplsp = function(mapbuf, bufnr)
  local lsp_keys = {
    n = {
      -- diagnostic
      -- ['<leader>f'] = { cmd = '<cmd>lua vim.diagnostic.open_float()<CR>',                                                 desc = 'Hover Diagnostic' },
      -- ['<leader>l'] = { cmd = '<cmd>lua vim.diagnostic.setloclist()<CR>',                                                 desc = 'Loclist Diagnostic' },
      ['dk'] = { cmd = '<cmd>Lspsaga diagnostic_jump_prev<CR>',                                                              desc = 'Prev Diagnostic', },
      ['dj'] = { cmd = '<cmd>Lspsaga diagnostic_jump_next<CR>',                                                              desc = 'Next Diagnostic', },
      ['dK'] = { cmd = "<cmd>lua require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>", desc = 'Prev Diagnostic [ERROR]', },
      ['dJ'] = { cmd = "<cmd>lua require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>", desc = 'Next Diagnostic [ERROR]', },
      -- rename and code_action
      ['<leader>rn'] = { cmd = '<cmd>Lspsaga rename<CR>',      desc = 'Global Rename' },
      ['<leader>a']  = { cmd = '<cmd>Lspsaga code_action<CR>', desc = 'Code Actions' },
      -- goto xx
      ['gD']  = { cmd = '<cmd>lua vim.lsp.buf.declaration()<CR>',     desc = 'Jump to Declaration' },
      ['gd']  = { cmd = '<cmd>lua vim.lsp.buf.definition()<CR>',      desc = 'Jump to Definition' },
      ['gtd'] = { cmd = '<cmd>lua vim.lsp.buf.type_definition()<CR>', desc = 'Jump to Type Definition' },
      ['gi']  = { cmd = '<cmd>lua vim.lsp.buf.implementation()<CR>',  desc = 'List Implementation' },
      ['gr']  = { cmd = '<cmd>Lspsaga lsp_finder<CR>',                desc = 'LSP Finder' },
      ['K']   = { cmd = '<cmd>Lspsaga hover_doc<CR>',                 desc = 'Hover Document' },

      ['<leader>=']  = { cmd = '<cmd>lua vim.lsp.buf.formatting()<CR>',                                      desc = 'LSP Format', },
      ['<leader>wa'] = { cmd = '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',                            desc = 'Add Folder', },
      ['<leader>wr'] = { cmd = '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',                         desc = 'Remove Folder', },
      ['<leader>wl'] = { cmd = '<cmd>lua vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', desc = 'List Workspace Folders', },
    },
    v = {
      ['<leader>a'] = { cmd = '<cmd>Lspsaga code_action<CR>',                desc = 'Code Actions of Range' },
      ['<leader>='] = { cmd = '<cmd>lua vim.lsp.buf.range_formatting()<CR>', desc = 'Format of Range' },
    },
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
