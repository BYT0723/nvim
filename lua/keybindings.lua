-- 设置leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true}

-- Nvim-Tree
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', opt)

-- bufferline
map('n', 'bk', '<cmd>BufferLineCyclePrev<CR>', opt)
map('n', 'bj', '<cmd>BufferLineCycleNext<CR>', opt)

-- symbols-outline
map('n', '<leader>v', '<cmd>SymbolsOutline<CR>', opt)

-- trouble
map('n', '<leader>d', '<cmd>TroubleToggle<CR>', opt)

-- telescope
map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<CR>", opt)
map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<CR>", opt)
map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<CR>", opt)
map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<CR>", opt)

-- lazygit
map('n', '<leader>g', '<cmd>LazyGit<CR>', opt)

local pluginKeys = {}

-- lsp keybind
pluginKeys.maplsp = function(mapbuf,bufnr)
  -- map('n', '<leader>f', '<cmd>lua vim.diagnostic.open_float()<CR>', opt)
  map('n', 'dk', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opt)
  map('n', 'dj', '<cmd>lua vim.diagnostic.goto_next()<CR>', opt)
  -- map('n', '<leader>l', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- rename
  mapbuf(bufnr,'n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)
  -- code action
  mapbuf(bufnr,'n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opt)
  -- go xx
  mapbuf(bufnr,'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
  mapbuf(bufnr,'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
  mapbuf(bufnr,'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
  mapbuf(bufnr,'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opt)
  mapbuf(bufnr,'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
  -- leader + =
  mapbuf(bufnr,'n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opt)
  -- mapbuf(bufnr,'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opt)
  -- mapbuf(bufnr,'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf(bufnr,'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf(bufnr,'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapbuf(bufnr,'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end

-- nvim-cmp
pluginKeys.cmp = function(cmp)
  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end
  return {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping(function()
      feedkey("<Plug>(vsnip-jump-next)", "")
    end, { 'i', 's' }),
    ['<C-k>'] = cmp.mapping(function()
      feedkey("<Plug>(vsnip-jump-prev)", "")
    end, { "i", "s" }),

    -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-u>'] = cmp.mapping.scroll_docs(-2),
    ['<C-d>'] = cmp.mapping.scroll_docs(2),
    -- 出现补全
    ['<A-.>'] = cmp.mapping.complete(),
    -- 取消
    ['<A-,>'] = cmp.mapping.abort(),
    -- 确认
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }
end

pluginKeys.trouble = function ()
  return { -- key mappings for actions in the trouble list
    -- map to {} to remove a mapping, for example:
    -- close = {},
    close = "q", -- close the list
    cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
    refresh = "r", -- manually refresh
    jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
    open_split = { "<c-s>" }, -- open buffer in new split
    open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
    open_tab = { "<c-t>" }, -- open buffer in new tab
    jump_close = {"o"}, -- jump to the diagnostic and close the list
    toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
    toggle_preview = "P", -- toggle auto_preview
    hover = "K", -- opens a small popup with the full multiline message
    preview = "p", -- preview the diagnostic location
    close_folds = {"zM", "zm"}, -- close all folds
    open_folds = {"zR", "zr"}, -- open all folds
    toggle_fold = {"zA", "za"}, -- toggle fold of current file
    previous = "k", -- preview item
    next = "j" -- next item
  }
end

pluginKeys.symbols_outline = function ()
  return { -- These keymaps can be a string or a table for multiple keys
    close = {"<Esc>", "q"},
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
  }
end

pluginKeys.nvim_treesitter = function ()
  return {
    init_selection = '<CR>',
    node_incremental = '<CR>',
    node_decremental = '<BS>',
    scope_incremental = '<TAB>',
  }
end

pluginKeys.nvim_tree = function ()
  return {
    { key = {"<CR>", "l", "<2-LeftMouse>"}, action = "edit" },
    { key = "<C-e>",                        action = "edit_in_place" },
    { key = {"O"},                          action = "edit_no_picker" },
    { key = {"<2-RightMouse>", "<C-]>"},    action = "cd" },
    { key = "<C-v>",                        action = "vsplit" },
    { key = "<C-s>",                        action = "split" },
    { key = "<C-t>",                        action = "tabnew" },
    { key = "<",                            action = "prev_sibling" },
    { key = ">",                            action = "next_sibling" },
    { key = "P",                            action = "parent_node" },
    { key = "h",                            action = "close_node" },
    { key = "<Tab>",                        action = "preview" },
    { key = "K",                            action = "first_sibling" },
    { key = "J",                            action = "last_sibling" },
    { key = "I",                            action = "toggle_git_ignored" },
    { key = "H",                            action = "toggle_dotfiles" },
    { key = "R",                            action = "refresh" },
    { key = "a",                            action = "create" },
    { key = "DD",                           action = "remove" },
    { key = "D",                            action = "trash" },
    { key = "r",                            action = "rename" },
    { key = "<C-r>",                        action = "full_rename" },
    { key = "d",                            action = "cut" },
    { key = "y",                            action = "copy" },
    { key = "p",                            action = "paste" },
    { key = "yn",                           action = "copy_name" },
    { key = "yp",                           action = "copy_path" },
    { key = "yap",                          action = "copy_absolute_path" },
    { key = "gk",                           action = "prev_git_item" },
    { key = "gj",                           action = "next_git_item" },
    { key = "-",                            action = "dir_up" },
    { key = "s",                            action = "system_open" },
    { key = "q",                            action = "close" },
    { key = "g?",                           action = "toggle_help" },
    { key = "W",                            action = "collapse_all" },
    { key = "S",                            action = "search_node" },
    { key = "<C-k>",                        action = "toggle_file_info" },
    { key = ".",                            action = "run_file_command" }
  }
end

return pluginKeys
