-- set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

-- translator
map('n','<leader>tw',"<Plug>TranslateW",opt)
map('v','<leader>tw',"<Plug>TranslateWV",opt)
map('v','<leader>tr',"<Plug>TranslateRV",opt)

-- quickfix
map("n", "ck", "<cmd>cp<CR>", opt)
map("n", "cj", "<cmd>cn<CR>", opt)
map("n", "cc", "<cmd>cc<CR>", opt)
map("n", "<leader>c", "<cmd>lua require('util').toggle_quickfix()<CR>", opt)

-- launcher
map("n", "<leader>rf", "<cmd>lua require('launcher').runFile()<CR>", opt)
map("n", "<leader>rp", "<cmd>lua require('launcher').runProject()<CR>", opt)
map("n", "<leader>ri", "<cmd>lua require('launcher').getRunProjectCmd()<CR>", opt)
map("n", "<leader>re", "<cmd>lua require('launcher').editRunProjectCmd()<CR>", opt)
map("n", "<leader>rm", "<cmd>lua require('launcher').removeRunProjectCmd()<CR>", opt)

-- hop
map("", "f", "<cmd>lua require'hop'.hint_char1({ current_line_only = true })<cr>", opt)

-- dashboard
map("n", "<leader>n", "<cmd>DashboardNewFile<CR>", opt)

-- NvimTree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opt)
-- syntax tree
map("n", "<leader>v", "<cmd>Lspsaga outline<CR>", opt)
-- trouble
map("n", "<leader>d", "<cmd>TroubleToggle<CR>", opt)

-- bufferline.nvim
map("n", "bk", "<cmd>BufferLineCyclePrev<CR>", opt)
map("n", "bj", "<cmd>BufferLineCycleNext<CR>", opt)
map("n", "bK", "<cmd>BufferLineMovePrev<CR>", opt)
map("n", "bJ", "<cmd>BufferLineMoveNext<CR>", opt)
map("n", "bs", "<cmd>BufferLinePick<CR>", opt)
map("n", "bp", "<cmd>BufferLineTogglePin<CR>", opt) -- buffer pin
map("n", "bq", "<cmd>bdelete!<CR>", opt) -- buffer quit

-- docker
map("n", "<leader>ld", "<cmd>lua require('launcher').toolToggle('lazydocker', 'Docker')<CR>", opt)
-- git
map("n", "<leader>lg", "<cmd>lua require('launcher').toolToggle('lazygit', 'Git')<CR>", opt)
map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", opt)

-- debug
map("n", "<leader>D", "<cmd>lua require('lsp/dap-local').DapToggle()<CR>", opt)
map("n", "<leader>bp", "<cmd>lua require('dap').toggle_breakpoint()<CR>", opt)
map("n", "<leader>si", "<cmd>lua require('dap').step_into()<CR>", opt)
map("n", "<leader>so", "<cmd>lua require('dap').step_over()<CR>", opt)

-- telescope
map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", opt)
map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", opt)
map("n", "<leader>fr", "<cmd>lua require('telescope.builtin').oldfiles()<CR>", opt)
map("n", "<leader>p", "<cmd>Telescope projects<CR>", opt)
-- map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", opt)
-- map("n", "<leader>ft", "<cmd>lua require('telescope.builtin').help_tags()<CR>", opt)

-- terminal
map("t", "<C-q>", "<C-\\><C-n>", opt)
map("t", "<C-b>j","<cmd>lua require('launcher').term_next()<CR>" ,opt)
map("t", "<C-b>k","<cmd>lua require('launcher').term_prev()<CR>" ,opt)
map("t", "<C-w>j", "<cmd>wincmd j<CR>", opt)
map("t", "<C-w>k", "<cmd>wincmd k<CR>", opt)
map("t", "<C-w>h", "<cmd>wincmd h<CR>", opt)
map("t", "<C-w>l", "<cmd>wincmd l<CR>", opt)

-- map("n", "w", "<C-w>", opt)
map("n", "<C-h>", "<cmd>vertical resize -5<CR>", opt)
map("n", "<C-l>", "<cmd>vertical resize +5<CR>", opt)
map("n", "<C-j>", "<cmd>resize +5<CR>", opt)
map("n", "<C-k>", "<cmd>resize -5<CR>", opt)

map("", "gh", "^", opt)
map("", "ge", "$", opt)

map("n", "tk", "<cmd>tabp<CR>", opt)
map("n", "tj", "<cmd>tabn<CR>", opt)
map("n", "tq", "<cmd>tabclose<CR>", opt)

map("n", "W", "<cmd>w!<CR>", opt)
map("n", "Q", "<cmd>q!<CR>", opt)

-- go file keymap only
vim.api.nvim_command("au FileType go nnoremap <leader>ta :GoAddTags json <CR>")
vim.api.nvim_command("au FileType go nnoremap <leader>to :GoAddTags json,omitempty <CR>")
vim.api.nvim_command("au FileType go nnoremap <leader>tr :GoRemoveTags json <CR>")

local pluginKeys = {}

-- lsp keybind
pluginKeys.maplsp = function(mapbuf, bufnr)
    -- diagnostic
	-- map('n', '<leader>f', '<cmd>lua vim.diagnostic.open_float()<CR>', opt)
	-- map('n', '<leader>l', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
	map("n", "dk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opt)
	map("n", "dj", "<cmd>Lspsaga diagnostic_jump_next<CR>", opt)
	map("n", "dh", "<cmd>lua require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>", opt)
	map("n", "dl", "<cmd>lua require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>", opt)
	-- rename
	mapbuf(bufnr, "n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opt)
	-- code action
	mapbuf(bufnr, "n", "<leader>a", "<cmd>Lspsaga code_action<CR>", opt)
	-- go xx
	mapbuf(bufnr, "n", "gd", "<cmd>Lspsaga peek_definition<CR>", opt)
	-- mapbuf(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opt)
	-- mapbuf(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
	mapbuf(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
	mapbuf(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
	mapbuf(bufnr, "n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opt)
	mapbuf(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", opt)
	-- leader + =
	mapbuf(bufnr, "n", "<leader>=", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
	mapbuf(bufnr, "v", "<leader>=", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opt)
	-- mapbuf(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
	mapbuf(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opt)
	mapbuf(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opt)
	mapbuf(bufnr, "n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opt)
end

-- nvim-cmp
pluginKeys.cmp = function(cmp)
	local feedkey = function(key, mode)
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
	end
	return {
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping(function()
			feedkey("<Plug>(vsnip-jump-next)", "")
		end, { "i", "s" }),
		["<C-k>"] = cmp.mapping(function()
			feedkey("<Plug>(vsnip-jump-prev)", "")
		end, { "i", "s" }),

		-- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-u>"] = cmp.mapping.scroll_docs(-2),
		["<C-d>"] = cmp.mapping.scroll_docs(2),
		-- 出现补全
		["<A-.>"] = cmp.mapping.complete(),
		-- 取消
		["<A-,>"] = cmp.mapping.abort(),
		-- 确认
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}
end

pluginKeys.trouble = function()
	return { -- key mappings for actions in the trouble list
		-- map to {} to remove a mapping, for example:
		-- close = {},
		close = "q", -- close the list
		cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
		refresh = "r", -- manually refresh
		jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
		open_split = { "<c-s>" }, -- open buffer in new split
		open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
		open_tab = { "<c-t>" }, -- open buffer in new tab
		jump_close = { "o" }, -- jump to the diagnostic and close the list
		toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
		toggle_preview = "P", -- toggle auto_preview
		hover = "K", -- opens a small popup with the full multiline message
		preview = "p", -- preview the diagnostic location
		close_folds = { "zM", "zm" }, -- close all folds
		open_folds = { "zR", "zr" }, -- open all folds
		toggle_fold = { "zA", "za" }, -- toggle fold of current file
		previous = "k", -- preview item
		next = "j", -- next item
	}
end

pluginKeys.nvim_treesitter = function()
	return {
		init_selection = "<CR>",
		node_incremental = "<CR>",
		node_decremental = "<BS>",
		scope_incremental = "<TAB>",
	}
end

pluginKeys.telescope = function()
	return {
		["<C-h>"] = "which_key",
		["<C-j>"] = "move_selection_next",
		["<C-k>"] = "move_selection_previous",
	}
end

pluginKeys.mason = function()
	return {
		toggle_package_expand = "<CR>",
		install_package = "i",
		update_package = "u",
		check_package_version = "c",
		update_all_packages = "U",
		-- Keymap to check which installed packages are outdated
		check_outdated_packages = "C",
		uninstall_package = "X",
		cancel_installation = "<C-c>",
		apply_language_filter = "<C-f>",
	}
end

pluginKeys.nvim_tree = function()
	return {
		{ key = { "<CR>", "l", "<2-LeftMouse>" }, action = "edit" },
		{ key = "<C-e>", action = "edit_in_place" },
		{ key = { "O" }, action = "edit_no_picker" },
		{ key = { "<2-RightMouse>", "<C-]>" }, action = "cd" },
		{ key = "<C-v>", action = "vsplit" },
		{ key = "<C-s>", action = "split" },
		{ key = "<C-t>", action = "tabnew" },
		{ key = "<", action = "prev_sibling" },
		{ key = ">", action = "next_sibling" },
		{ key = "P", action = "parent_node" },
		{ key = "h", action = "close_node" },
		{ key = "<Tab>", action = "preview" },
		{ key = "K", action = "first_sibling" },
		{ key = "J", action = "last_sibling" },
		{ key = "I", action = "toggle_git_ignored" },
		{ key = "H", action = "toggle_dotfiles" },
		{ key = "R", action = "refresh" },
		{ key = "a", action = "create" },
		{ key = "DD", action = "remove" },
		{ key = "D", action = "trash" },
		{ key = "r", action = "rename" },
		{ key = "<C-r>", action = "full_rename" },
		{ key = "d", action = "cut" },
		{ key = "y", action = "copy" },
		{ key = "p", action = "paste" },
		{ key = "yn", action = "copy_name" },
		{ key = "yp", action = "copy_path" },
		{ key = "yap", action = "copy_absolute_path" },
		{ key = "gk", action = "prev_git_item" },
		{ key = "gj", action = "next_git_item" },
		{ key = "-", action = "dir_up" },
		{ key = "i", action = "system_open" },
		{ key = "q", action = "close" },
		{ key = "g?", action = "toggle_help" },
		{ key = "W", action = "collapse_all" },
		{ key = "S", action = "search_node" },
		{ key = "<C-k>", action = "toggle_file_info" },
		{ key = ".", action = "run_file_command" },
	}
end

return pluginKeys
