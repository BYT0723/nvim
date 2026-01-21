local M = {}
local util = require('base.util')

-- stylua: ignore
M.Noice = {
  { '<c-u>', function() if not require('noice.lsp').scroll(-4) then return '<c-u>' end end, mode = { 'n', 'i', 's' }, desc = 'Scroll Down', expr = true },
  { '<c-d>', function() if not require('noice.lsp').scroll(4) then return '<c-d>' end end,  mode = { 'n', 'i', 's' }, desc = 'Scroll Up',   expr = true },
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
M.TodoComments = {
  { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
  { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME", "PERF" } }) end, desc = "Todo/Fix/Fixme/Perf" },
}

M.Diffview = {
  { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = 'Git Diffview' },
}

-- stylua: ignore
M.Dap = {
  { '<leader>du', function() require('plugins.configs.dap-local').DapToggle() end, desc = 'Toggle Dap UI',     },
  { '<leader>db', function() require('dap').toggle_breakpoint() end,               desc = 'Toggle Breakpoint', },
  { '<leader>dc', function() require('dap').continue() end,                        desc = 'Dap Continue',      },
  { '<leader>di', function() require('dap').step_into() end,                       desc = 'Step Into',         },
  { '<leader>do', function() require('dap').step_out() end,                        desc = 'Step Out',          },
  { '<leader>dn', function() require('dap').step_over() end,                       desc = 'Step Over',         },
  { '<leader>dk', function() require('dapui').eval() end,                          desc = 'Dap Eval',          },
}

-- stylua: ignore
M.Spectre = {
  {'<leader>Ss', function() require('spectre').toggle() end,                            desc = 'Toggle Spectre',      },
  {'<leader>Sw', function() require('spectre').open_visual({ select_word = true }) end, desc = 'Search current word', },
  {'<leader>Sw', '<esc><cmd>lua require("spectre").open_visual()<CR>',                  desc = 'Search current word', mode = 'v' },
}

-- stylua: ignore
M.DB = {
  { '<leader>ld', function() require("dbee").toggle() end, desc = 'Database Manager' },
}

-- stylua: ignore
M.Sniprun = {
  { '<leader>rl', '<cmd>SnipRun<CR>',                                   desc = 'run current line code',   ft = {"markdown", "norg", "sh"} },
  { '<leader>rb', function() require 'sniprun'.run('v') end,            desc = 'run selected code block', ft = {"markdown", "norg", "sh"}, mode = 'v', },
  { '<leader>rc', function() require 'sniprun.display'.close_all() end, desc = 'clean sniprun output',    ft = {"markdown", "norg", "sh"} },
  { '<leader>rC', function() require 'sniprun'.reset() end,             desc = 'sniprun cancel',          ft = {"markdown", "norg", "sh"} },
}

-- stylua: ignore
M.NeoCodeium = {
  { '<A-f>', function() require('neocodeium').accept() end,              desc = 'Accept Next Line',    mode = 'i' },
  { '<A-w>', function() require('neocodeium').accept_word() end,         desc = 'Accept Next Word',    mode = 'i', },
  { '<A-l>', function() require('neocodeium').accept_line() end,         desc = 'Accept suggestion',   mode = 'i' },
  { '<A-j>', function() require('neocodeium').cycle_or_complete() end,   desc = 'Next suggestion',     mode = 'i' },
  { '<A-k>', function() require('neocodeium').cycle_or_complete(-1) end, desc = 'Prev suggestion',     mode = 'i' },
  { '<A-c>', function() require('neocodeium').clear() end,               desc = 'clear ai suggestion', mode = 'i' },
}

M.Obsidian = {
  { '<leader>mn', '<cmd>Obsidian new<CR>', desc = 'obsidian new' },
  { '<leader>mt', '<cmd>Obsidian tags<CR>', desc = 'obsidian tags' },
  { '<leader>mw', '<cmd>Obsidian workspace<CR>', desc = 'obsidian workspaces' },
  { '<leader>md', '<cmd>Obsidian dailies -5 3<CR>', desc = 'obsidian daliy (last 3 day)' },
  { '<leader>mT', '<cmd>Obsidian template<CR>', desc = 'obsidian template list', ft = 'markdown' },
  { '<leader>mp', '<cmd>Obsidian paste_img<CR>', desc = 'obsidian paste image', ft = 'markdown' },
}

-- stylua: ignore
M.Kulala = {
  {"<leader>ks", function() require('kulala').search() end,           desc = "select a http file"},
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
	{
		"<leader>kes",
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
		"<leader>kee",
		function()
			vim.cmd("edit http-client.env.json")
			if vim.fn.filereadable("http-client.env.json") ~= 1 then
				vim.api.nvim_buf_set_lines(0, 0, -1, false, { "{", '  "dev": {}', "}" })
			end
		end,
		desc = "edit http environment",
		ft = "http",
	},
  {"<leader>rl", function() require('kulala').run() end,              desc = "run http request under cursor",       ft = "http"},
  {"<leader>ry", function() require('kulala').copy() end,             desc = "copy a http request to curl command", ft = "http"},
  {"<leader>rp", function() require('kulala').from_curl() end,        desc = "parse a curl command from clipboard", ft = "http"},
}

-- stylua: ignore
M.MiniFiles = {
  { '<leader>e',  function() if not MiniFiles.close() then MiniFiles.open() end end, desc = 'File Explorer' },
}

-- stylua: ignore
M.Snacks = {
  { '<leader>E',  function() Snacks.explorer({hidden=true,ignored=true}) end,     desc = 'File Explorer',  },
  { "<leader>ff", function() Snacks.picker.files({hidden=true,ignored=true}) end, desc = "Find Files" },
  { "<leader>f/", function() Snacks.picker.grep() end,                  					desc = 'Grep',           },
  { "<leader>f,", function() Snacks.picker.buffers() end,               					desc = "Buffers" },
  { "<leader>:",  function() Snacks.picker.command_history() end,       					desc = "Command History" },
  {
		"<leader>fp",
		function()
			local projectOpt = {
				dev = {'~/Workspace'},
				patterns = {
					'.git',
					'.svn',
					'.hg', -- VCS
					'Makefile',
					'CMakeLists.txt', -- 通用构建
					'package.json',
					'tsconfig.json', -- JS/TS
					'yarn.lock',
					'pnpm-lock.yaml',
					'pyproject.toml',
					'setup.py', -- Python
					'go.mod',
					'go.work', -- Go
					'Cargo.toml', -- Rust
					'Pipfile',
					'requirements.txt',
					'build.gradle',
					'pom.xml', -- Java/Kotlin
					'stylua.toml',
					'.luarc.json',
					'init.lua', -- Lua / Neovim
				},
			}
			projectOpt.projects = util.find_project_dirs(projectOpt.dev, projectOpt.patterns, 5)
			Snacks.picker.projects(projectOpt)
		end,
		desc = "Projects"
	},
  { "<leader>fr", function() Snacks.picker.recent() end,                desc = "Recent" },
  { "<leader>fn", function() Snacks.picker.notifications() end,         desc = "Notification History" },
  { '<leader>s"', function() Snacks.picker.registers() end,             desc = "Registers" },
  { '<leader>s/', function() Snacks.picker.search_history() end,        desc = "Search History" },
  { "<leader>sa", function() Snacks.picker.autocmds() end,              desc = "Autocmds" },
  { "<leader>sb", function() Snacks.picker.lines() end,                 desc = "Buffer Lines" },
  -- { "<leader>sc", function() Snacks.picker.command_history() end,       desc = "Command History" },
  { "<leader>sC", function() Snacks.picker.commands() end,              desc = "Commands" },
  { "<leader>sd", function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
  { "<leader>sD", function() Snacks.picker.diagnostics({severity={min=vim.diagnostic.severity.ERROR}}) end,           desc = "Diagnostics (ERROR)" },
  { "<leader>sh", function() Snacks.picker.help() end,                  desc = "Help Pages" },
  { "<leader>sH", function() Snacks.picker.highlights() end,            desc = "Highlights" },
  { "<leader>si", function() Snacks.picker.icons() end,                 desc = "Icons" },
  { "<leader>sj", function() Snacks.picker.jumps() end,                 desc = "Jumps" },
  { "<leader>sk", function() Snacks.picker.keymaps() end,               desc = "Keymaps" },
  { "<leader>sl", function() Snacks.picker.loclist() end,               desc = "Location List" },
  { "<leader>sm", function() Snacks.picker.marks() end,                 desc = "Marks" },
  { "<leader>sM", function() Snacks.picker.man() end,                   desc = "Man Pages" },
  { "<leader>sp", function() Snacks.picker.lazy() end,                  desc = "Search for Plugin Spec" },
  { "<leader>sq", function() Snacks.picker.qflist() end,                desc = "Quickfix List" },
  { "<leader>sR", function() Snacks.picker.resume() end,                desc = "Resume" },
  { "<leader>su", function() Snacks.picker.undo() end,                  desc = "Undo History" },
  { "<leader>sC", function() Snacks.picker.colorschemes() end,          desc = "Colorschemes" },
  { "bq", 				function() Snacks.bufdelete.delete() end,             desc = "Delete Buffer" },
  { "<leader>z",  function() Snacks.zen.zoom() end,                     desc = "Toggle Zoom" },
  { "<leader>Z",  function() Snacks.zen() end,                          desc = "Toggle Zen Mode" },
  { "<leader>nc", function() Snacks.notifier.hide() end,                desc = "Dismiss All Notifications" },
  { "]]",         function() Snacks.words.jump(vim.v.count1) end,       desc = "Next Reference" },
  { "[[",         function() Snacks.words.jump(-vim.v.count1) end,      desc = "Prev Reference" },
  { "<leader>lg", function() Snacks.lazygit() end,                                   desc = "Lazygit" },
  { "<leader>le", function() Snacks.terminal.get('yazi') end,                        desc = "Yazi" },
  { "<leader>lE", function() Snacks.terminal.get('yazi '..util.relative_path()) end, desc = "Yazi at current file" },
  { "<c-\\>",     function() Snacks.terminal.toggle() end,                           desc = "Toggle Terminal", mode = {'n', 't'} },
}

-- lsp keybind
M.maplsp = function(bufnr)
  -- stylua: ignore
  local lsp_keys = {
    { '<leader>rn', function() vim.lsp.buf.rename() end,                  desc = 'Global Rename',         },
    { '<leader>aa', function() vim.lsp.buf.code_action() end,             desc = 'Code Actions',          },
    { '<leader>aa', function() vim.lsp.buf.code_action() end,             desc = 'Code Actions of Range', mode = 'v',    },
    { '<leader>al', function() vim.lsp.codelens.run() end,                desc = 'Code Lens',             },
    { 'K',          function() vim.lsp.buf.hover() end,                   desc = 'Hover Document',        },
    { '<leader>=',  function() vim.lsp.buf.formatting() end,              desc = 'LSP Format',            },
    { '<leader>=',  function() vim.lsp.buf.range_formatting() end,        desc = 'Format of Range',       mode = 'v',    },
		{ "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
		{ "gD",         function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
		{ "gr",         function() Snacks.picker.lsp_references() end,        desc = "References",            nowait = true, },
		{ "gi",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
		{ "gtd",        function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
		{ "<leader>vs", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
		{ "<leader>vS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
  }
  for _, key in pairs(lsp_keys) do
    vim.keymap.set(key.mode or 'n', key[1], key[2], { buffer = bufnr, silent = true, desc = key.desc })
  end
end

return M
