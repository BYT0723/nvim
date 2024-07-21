local M = {}

-- stylua: ignore
M.Notify = {
  { '<leader>nc', function() require('notify').dismiss({}) end, desc = 'Hide all notifications'},
}

-- stylua: ignore
M.Noice = {
  { '<c-f>', function() if not require('noice.lsp').scroll(4) then return '<c-f>' end end, mode = { 'n', 'i', 's' }, desc = 'Scroll Down', },
  { '<c-u>', function() if not require('noice.lsp').scroll(4) then return '<c-b>' end end, mode = { 'n', 'i', 's' }, desc = 'Scroll Up', },
}

-- stylua: ignore
M.NvimTree = {
  {'<leader>e', "<cmd>NvimTreeToggle<CR>", desc = 'Files Explorer',},
}

-- stylua: ignore
M.MiniSession = {
  {'<leader>fs', function() require('mini.sessions').select() end, desc = 'Find Session',},
  {
    '<leader>sw',
    function()
      vim.ui.input({ prompt = 'Write session:' }, function(response)
        if string.len(response) > 0 then
          require('mini.sessions').write(response)
        else
          require('mini.sessions').write('autosession')
        end
      end)
    end,
    desc = 'Write Session',
  },
}

-- stylua: ignore
M.PanTran = {
  { '<leader>tw', 'yiw<cmd>Pantran mode=interactive target=zh<CR>p', mode = 'n', desc = 'Translate word under cursor' },
  { '<leader>tw', 'y<cmd>Pantran mode=interactive target=zh<CR>p',   mode = 'v', desc = 'Translate text in the selected' },
  { '<leader>tl', '^y$<cmd>Pantran mode=interactive target=zh<CR>p', mode = 'n', desc = 'Translate line' },
  { '<leader>tr', '<cmd>Pantran mode=replace target=en<CR>',         mode = 'n', desc = 'Translate and Replace' },
  { '<leader>ta', '<cmd>Pantran mode=append target=en<CR>',          mode = 'n', desc = 'Translate and Append' },
  { '<leader>ti', ':Pantran mode=interactive target=zh<CR>',         mode = 'v', desc = 'Translate Interactive UI' },
  { '<leader>ti', '<cmd>Pantran mode=interactive<CR>',               mode = 'n', desc = 'Translate Interactive UI' },
}

-- stylua: ignore
M.Trouble = {
  -- { '<leader>xx', '<cmd>Trouble<CR>', desc = 'Trouble' },
  { '<leader>xw', '<cmd>Trouble diagnostics toggle<CR>',                   desc = 'Workspace Diagnostics in Trouble' },
  { '<leader>xq', '<cmd>Trouble quickfix toggle<CR>',                      desc = 'Quickfix in Trouble' },
  { '<leader>xl', '<cmd>Trouble loclist toggle<CR>',                       desc = 'Loclist in Trouble' },
  { '<leader>vs', '<cmd>Trouble symbols toggle focus=false<cr>',           desc = 'Symbols (Trouble)' },
  { '<leader>xk', function() require('trouble').prev({ skip_groups = true, jump = true }) end, desc = 'Previous in Trouble', },
  { '<leader>xj', function() require('trouble').next({ skip_groups = true, jump = true }) end, desc = 'Next in Trouble',     },
}

-- stylua: ignore
M.TodoComments = {
  { '<leader>xt', '<cmd>Trouble todo toggle<CR>',                                    desc = 'Todo-Comments' },
  { '<leader>xT', '<cmd>Trouble todo toggle filter={tag={TODO,FIX,FIXME,PERF}}<CR>', desc = 'Todo-Comments [TODO|FIX|PERF]' },
}

M.Diffview = {
  { '<leader>gd', '<cmd>DiffviewOpen<CR>', mode = 'n', desc = 'Git Diffview' },
}

M.GoNvim = {
  { '<leader>al', '<cmd>GoCodeLenAct<CR>', mode = 'n', desc = 'Go Code Len' },
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
  { '<leader>fp', '<cmd>Telescope projects theme=dropdown<CR>',             desc = 'Recent Projects' },
}

-- stylua: ignore
M.Spectre = {
  {'<leader>Ss' , function() require('spectre').toggle() end                               , mode = 'n', desc = 'Toggle Spectre'        },
  {'<leader>Sw', function() require('spectre').open_visual({ select_word = true }) end     , mode = 'n', desc = 'Search current word'   },
  {'<leader>Sw', '<esc><cmd>lua require("spectre").open_visual()<CR>'                      , mode = 'v', desc = 'Search current word'   },
}

M.DB = {
  { '<leader>zz', '<cmd>DBUIToggle<CR>', desc = 'Database Manager' },
}

-- stylua: ignore
M.TreeSitterContext = {
  { '[c', function() require("treesitter-context").go_to_context(vim.v.count1) end, desc = 'previous context item', },
}

-- stylua: ignore
M.Sniprun = {
  { 'rl', '<cmd>SnipRun<CR>',                                   desc = 'run current line code',   mode = 'n' },
  { 'rb', function() require 'sniprun'.run('v') end,            desc = 'run selected code block', mode = 'v' },
  { 'rc', function() require 'sniprun.display'.close_all() end, desc = 'clean sniprun output',    mode = 'n' },
  { 'rC', function() require 'sniprun'.reset() end,             desc = 'sniprun cancel',          mode = 'n' },
}

-- lsp keybind
M.maplsp = function(bufnr)
  -- stylua: ignore
  local lsp_keys = {
    { '<leader>rn', function() vim.lsp.buf.rename() end,            desc = 'Global Rename',           },
    { '<leader>aa', function() vim.lsp.buf.code_action() end,       desc = 'Code Actions',            },
    { '<leader>aa', function() vim.lsp.buf.code_action() end,       desc = 'Code Actions of Range',   mode = 'v', },
    { 'gD',         function() vim.lsp.buf.declaration() end,       desc = 'Jump to Declaration',     },
    { 'gd',         "<cmd>Trouble lsp_definitions toggle<CR>",      desc = 'Jump to Definition',      },
    { 'gtd',        "<cmd>Trouble lsp_type_definitions toggle<CR>", desc = 'Jump to Type Definition', },
    { 'gi',         '<cmd>Trouble lsp_implementations toggle<CR>',  desc = 'List Implementation',     },
    { 'gr',         '<cmd>Trouble lsp_references toggle<CR>',       desc = 'LSP Finder',              },
    { 'K',          function() vim.lsp.buf.hover() end,             desc = 'Hover Document',          },
    { '<leader>=',  function() vim.lsp.buf.formatting() end,        desc = 'LSP Format',              },
    { '<leader>=',  function() vim.lsp.buf.range_formatting() end,  desc = 'Format of Range',         mode = 'v', },
  }
  for _, key in pairs(lsp_keys) do
    vim.keymap.set(key.mode or 'n', key[1], key[2], { buffer = bufnr, silent = true, desc = key.desc })
  end
end

return M
