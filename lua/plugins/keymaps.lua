local M = {}

-- stylua: ignore
M.Notify = {
  { '<leader>nc', function() require('notify').dismiss({}) end, desc = 'Hide all notifications'},
}

-- stylua: ignore
M.Noice = {
  { '<c-u>', function() if not require('noice.lsp').scroll(-4) then return '<c-u>' end end, mode = { 'n', 'i', 's' }, desc = 'Scroll Down', expr = true },
  { '<c-d>', function() if not require('noice.lsp').scroll(4) then return '<c-d>' end end,  mode = { 'n', 'i', 's' }, desc = 'Scroll Up',   expr = true },
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
  { '<leader>tw', 'yiw<cmd>Pantran mode=interactive target=zh<CR>p', desc = 'Translate word under cursor',    },
  { '<leader>tw', 'y<cmd>Pantran mode=interactive target=zh<CR>p',   desc = 'Translate text in the selected', mode = 'v', },
  { '<leader>tl', '^y$<cmd>Pantran mode=interactive target=zh<CR>p', desc = 'Translate line',                 },
  { '<leader>tr', '<cmd>Pantran mode=replace target=en<CR>',         desc = 'Translate and Replace',          },
  { '<leader>ta', '<cmd>Pantran mode=append target=en<CR>',          desc = 'Translate and Append',           },
  { '<leader>ti', ':Pantran mode=interactive target=zh<CR>',         desc = 'Translate Interactive UI',       mode = 'v', },
  { '<leader>ti', '<cmd>Pantran mode=interactive<CR>',               desc = 'Translate Interactive UI',       },
}

-- stylua: ignore
M.Trouble = {
  -- { '<leader>xx', '<cmd>Trouble<CR>', desc = 'Trouble' },
  { '<leader>xw', '<cmd>Trouble diagnostics toggle<CR>',                                       desc = 'Workspace Diagnostics in Trouble', },
  { '<leader>xq', '<cmd>Trouble quickfix toggle<CR>',                                          desc = 'Quickfix in Trouble',              },
  { '<leader>xl', '<cmd>Trouble loclist toggle<CR>',                                           desc = 'Loclist in Trouble',               },
  { '<leader>vs', '<cmd>Trouble symbols toggle focus=false<cr>',                               desc = 'Symbols (Trouble)',                },
  { '<leader>xk', function() require('trouble').prev({ skip_groups = true, jump = true }) end, desc = 'Previous in Trouble',              },
  { '<leader>xj', function() require('trouble').next({ skip_groups = true, jump = true }) end, desc = 'Next in Trouble',                  },
}

-- stylua: ignore
M.TodoComments = {
  { '<leader>xt', '<cmd>Trouble todo toggle<CR>',                                    desc = 'Todo-Comments',                 },
  { '<leader>xT', '<cmd>Trouble todo toggle filter={tag={TODO,FIX,FIXME,PERF}}<CR>', desc = 'Todo-Comments [TODO|FIX|PERF]', },
}

M.Diffview = {
  { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = 'Git Diffview' },
}

M.GoNvim = {
  { '<leader>al', '<cmd>GoCodeLenAct<CR>', desc = 'Go Code Len' },
}

-- stylua: ignore
M.Dap = {
  { '<leader>du', function() require('plugins.configs.dap-local').DapToggle() end, desc = 'Toggle Dap UI',     },
  { '<leader>db', function() require('dap').toggle_breakpoint() end,               desc = 'Toggle Breakpoint', },
  { '<leader>dc', function() require('dap').continue() end,                        desc = 'Dap Continue',      },
  { '<leader>di', function() require('dap').step_into() end,                       desc = 'Step Into',         },
  { '<leader>do', function() require('dap').step_out() end,                        desc = 'Step Out',          },
  { '<leader>dO', function() require('dap').step_over() end,                       desc = 'Step Over',         },
  { '<leader>de', function() require('dapui').eval() end,                          desc = 'Dap Eval',          },
}

-- stylua: ignore
M.Telescope = {
  { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Find Files',      },
  { '<leader>fg', function() require('telescope.builtin').live_grep() end,  desc = 'Find Content',    },
  { '<leader>fb', function() require('telescope.builtin').buffers() end,    desc = 'Find Buffers',    },
  { '<leader>fh', function() require('telescope.builtin').oldfiles() end,   desc = 'Recent Files',    },
  { "<leader>f'", function() require('telescope.builtin').marks() end,      desc = 'List Marks',      },
  { '<leader>fp', '<cmd>Telescope projects theme=dropdown<CR>',             desc = 'Recent Projects', },
}

-- stylua: ignore
M.Spectre = {
  {'<leader>Ss', function() require('spectre').toggle() end,                            desc = 'Toggle Spectre',      },
  {'<leader>Sw', function() require('spectre').open_visual({ select_word = true }) end, desc = 'Search current word', },
  {'<leader>Sw', '<esc><cmd>lua require("spectre").open_visual()<CR>',                  desc = 'Search current word', mode = 'v' },
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
  { '<leader>rl', '<cmd>SnipRun<CR>',                                   desc = 'run current line code',   ft = {"markdown", "norg"} },
  { '<leader>rb', function() require 'sniprun'.run('v') end,            desc = 'run selected code block', ft = {"markdown", "norg"}, mode = 'v', },
  { '<leader>rc', function() require 'sniprun.display'.close_all() end, desc = 'clean sniprun output',    ft = {"markdown", "norg"} },
  { '<leader>rC', function() require 'sniprun'.reset() end,             desc = 'sniprun cancel',          ft = {"markdown", "norg"} },
}

-- stylua: ignore
M.Kulala = {
  {"<leader>ke", function() require('kulala').search() end,           desc = "select a http file"},
  {"<leader>kn", function()
    if vim.fn.isdirectory('.http') == 0 then
      vim.fn.mkdir('.http','p','0o755')
    end
    vim.ui.input({ prompt = '  New HTTP Request File' }, function(input)
      if not input or input == '' or vim.fn.fnamemodify(input, ':e') ~= 'http' then
        vim.notify('invalid filename', vim.log.levels.ERROR)
        return
      end
      local full_path = vim.fn.fnamemodify('.http/'..input, ':p')
      if vim.fn.filereadable(full_path) == 1 then
        vim.ui.input({ prompt = 'File Exists, Open(y/n)' }, function(flag)
          if flag == 'y' then
            vim.cmd('edit ' .. full_path)
          end
        end)
      else
        vim.cmd('edit ' .. full_path)
      end
    end)
  end, desc = "new a http file"},
  {"<leader>rl", function() require('kulala').run() end,              desc = "run http request under cursor",       ft = "http"},
  {"<leader>rc", function() require('kulala').close() end,            desc = "close current http or rest window",   ft = "http"},
  {"<leader>ry", function() require('kulala').copy() end,             desc = "copy a http request to curl command", ft = "http"},
  {"<leader>rp", function() require('kulala').from_curl() end,        desc = "parse a curl command from clipboard", ft = "http"},
  {"<leader>rv", function() require('kulala').toggle_view() end,      desc = "toggle response body with header",    ft = "http"},
  {"<leader>rk", function() require('kulala').jump_prev() end,        desc = "jump to previous http request",       ft = "http"},
  {"<leader>rj", function() require('kulala').jump_next() end,        desc = "jump to next http request",           ft = "http"},
	{
		"<leader>res",
		function()
			if vim.fn.filereadable("http-client.env.json") ~= 1 then
				vim.cmd("edit http-client.env.json")
				vim.api.nvim_buf_set_lines(0, 0, -1, false, { "{", '  "dev": {}', "}" })
			else
				require("kulala").set_selected_env()
			end
		end,
		desc = "select a http environment",
		ft = "http",
	},
	{
		"<leader>ree",
		function()
			vim.cmd("edit http-client.env.json")
			if vim.fn.filereadable("http-client.env.json") ~= 1 then
				vim.api.nvim_buf_set_lines(0, 0, -1, false, { "{", '  "dev": {}', "}" })
			end
		end,
		desc = "edit http environment",
		ft = "http",
	},
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
