-- set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local M = {}

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

M.Common = {
  [''] = {
    ['gh'] = '^',
    ['ge'] = '$',
  },
  n = {
    ['W'] = '<cmd>w!<CR>',
    ['Q'] = '<cmd>q!<CR>',
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
    ['<leader>c'] = "<cmd>lua require('util').toggle_quickfix()<CR>",
    --launcher
    ['<leader>rf'] = "<cmd>lua require('launcher').runFile()<CR>",
    ['<leader>rp'] = "<cmd>lua require('launcher').runProject()<CR>",
    ['<leader>ri'] = "<cmd>lua require('launcher').getRunProjectCmd()<CR>",
    ['<leader>re'] = "<cmd>lua require('launcher').editRunProjectCmd()<CR>",
    ['<leader>rm'] = "<cmd>lua require('launcher').removeRunProjectCmd()<CR>",
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
    ['<leader>un'] = "<cmd>lua require('notify').dismiss()<CR>",
  },
}

M.PanTran = {
  n = {
    ['<leader>tw'] = '<cmd>Pantran mode=hover target=zh<CR>',
    ['<leader>tr'] = '<cmd>Pantran mode=replace target=en<CR>',
    ['<leader>ta'] = '<cmd>Pantran mode=append target=en<CR>',
    ['<leader>ti'] = '<cmd>Pantran mode=interactive<CR>',
  },
  x = {
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
    ['<leader>e'] = '<cmd>NvimTreeToggle<CR>',
  },
}

M.Lspsaga = {
  n = {
    ['<leader>v'] = '<cmd>Lspsaga outline<CR>',
  },
}

M.Gitsigns = {
  n = {
    ['<leader>gb'] = '<cmd>Gitsigns blame_line<CR>'
  }
}

M.Trouble = {
  n = {
    ['<leader>xx'] = '<cmd>TroubleToggle<CR>',
    ['<leader>xw'] = '<cmd>TroubleToggle workspace_diagnostics<CR>',
    ['<leader>xd'] = '<cmd>TroubleToggle document_diagnostics<CR>',
    ['<leader>xq'] = '<cmd>TroubleToggle quickfix<CR>',
    ['<leader>xl'] = '<cmd>TroubleToggle loclist<CR>',
    ['<leader>xk'] = '<cmd>lua require("trouble").previous({skip_groups = true, jump = true})<CR>',
    ['<leader>xj'] = '<cmd>lua require("trouble").next({skip_groups = true, jump = true})<CR>',
  },
}

M.TodoComments = {
  n = {
    ['<leader>xt'] = '<cmd>TroubleToggle todo<CR>',
    ['<leader>xT'] = '<cmd>TroubleToggle todo keywords=TODO,FIX disable_not_found_warnings=true<CR>',
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
    ['<leader>du'] = '<cmd>DapToggle<CR>',
    ['<leader>db'] = "<cmd>lua require('dap').toggle_breakpoint()<CR>",
    ['<leader>dc'] = "<cmd>lua require('dap').continue()<CR>",
    ['<leader>di'] = "<cmd>lua require('dap').step_into()<CR>",
    ['<leader>do'] = "<cmd>lua require('dap').step_out()<CR>",
    ['<leader>dO'] = "<cmd>lua require('dap').step_over()<CR>",
    ['<leader>de'] = '<cmd>lua require("dapui").eval()<CR>',
  },
}

M.Telescope = {
  n = {
    ['<leader>ff'] = "<cmd>lua require('telescope.builtin').find_files()<CR>",
    ['<leader>fg'] = "<cmd>lua require('telescope.builtin').live_grep()<CR>",
    ['<leader>fr'] = "<cmd>lua require('telescope.builtin').oldfiles()<CR>",
    ['<leader>fp'] = '<cmd>Telescope projects<CR>',
    ["<leader>f'"] = "<cmd>lua require('telescope.builtin').marks()<CR>",
  },
}

M.ToggleTerm = {
  n = {
    ['<leader>lr'] = "<cmd>lua require('launcher').toolToggle('ranger')<CR>",
    ['<leader>ld'] = "<cmd>lua require('launcher').toolToggle('docker')<CR>",
    ['<leader>lg'] = "<cmd>lua require('launcher').toolToggle('git')<CR>",
    ['<C-b>k'] = "<cmd>lua require('launcher').term_prev()<CR>",
    ['<C-b>j'] = "<cmd>lua require('launcher').term_next()<CR>",
  },
  t = {
    ['<C-b>k'] = "<cmd>lua require('launcher').term_prev()<CR>",
    ['<C-b>j'] = "<cmd>lua require('launcher').term_next()<CR>",
  },
}

-- lsp keybind
M.maplsp = function(mapbuf, bufnr)
  -- diagnostic
  -- map('n', '<leader>f', '<cmd>lua vim.diagnostic.open_float()<CR>', opt)
  -- map('n', '<leader>l', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  mapbuf(bufnr, 'n', 'dk', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opt)
  mapbuf(bufnr, 'n', 'dj', '<cmd>Lspsaga diagnostic_jump_next<CR>', opt)
  mapbuf(bufnr, 'n', 'dK', "<cmd>lua require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>", opt)
  mapbuf(bufnr, 'n', 'dJ', "<cmd>lua require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>", opt)
  -- rename
  mapbuf(bufnr, 'n', '<leader>rn', '<cmd>Lspsaga rename<CR>', opt)
  -- code action
  mapbuf(bufnr, 'n', '<leader>a', '<cmd>Lspsaga code_action<CR>', opt)
  mapbuf(bufnr, 'v', '<leader>a', '<cmd>Lspsaga code_action<CR>', opt)
  -- go xx
  mapbuf(bufnr, 'n', 'gd', '<cmd>Lspsaga peek_definition<CR>', opt)
  -- mapbuf(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opt)
  -- mapbuf(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
  mapbuf(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
  mapbuf(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
  mapbuf(bufnr, 'n', 'gr', '<cmd>Lspsaga lsp_finder<CR>', opt)
  mapbuf(bufnr, 'n', 'K', '<cmd>Lspsaga hover_doc<CR>', opt)
  -- leader + =
  mapbuf(bufnr, 'n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opt)
  mapbuf(bufnr, 'v', '<leader>=', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opt)
  -- mapbuf(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
  mapbuf(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  mapbuf(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  mapbuf(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
end

function M.Load_Keys(keys)
  for mode, kv in pairs(M[keys]) do
    for key, cmd in pairs(kv) do
      map(mode, key, cmd, opt)
    end
  end
end

return M
