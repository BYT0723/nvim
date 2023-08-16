local options = {
  signs = {
    add = { hl = 'GitSignsAdd', text = '▊', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change = { hl = 'GitSignsChange', text = '▊', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    untracked = { hl = 'GitSignsAdd', text = '┆', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = true,
  },
  current_line_blame_formatter = '  「 <author>, <author_time> • <summary> 」',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'none',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
      opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    map('n', '<leader>gk', '<cmd>Gitsigns prev_hunk<CR>', { desc = 'Jump to previous hunk' })
    map('n', '<leader>gj', '<cmd>Gitsigns next_hunk<CR>', { desc = 'Jump to next hunk' })
    map('n', '<leader>gb', 'cmd>lua require"gitsigns".blame_line{full=true}<CR>', { desc = 'Show Blamer' })
    map('n', '<leader>gv', '<cmd>Gitsigns preview_hunk<CR>', { desc = 'Preview hunk' })
    map('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>', { desc = 'Reset hunk' })
    map('v', '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>', { desc = 'Reset hunk' })
    map('n', '<leader>gR', '<cmd>Gitsigns reset_buffer<CR>', { desc = 'Reset all hunk' })
    map('n', '<leader>gs', '<cmd>Gitsigns stage_hunk<CR>', { desc = 'Stage hunk' })
    map('v', '<leader>gs', '<cmd>Gitsigns stage_hunk<CR>', { desc = 'Stage hunk' })
    map('n', '<leader>gu', '<cmd>Gitsigns undo_stage_hunk<CR>', { desc = 'Undo last stage' })
    map('n', '<leader>gtb', '<cmd>Gitsigns toggle_current_line_blame<CR>', { desc = 'Toggle Blamer' })
    map('n', '<leader>gts', '<cmd>Gitsigns toggle_signs<CR>', { desc = 'Toggle Sings' })
    map('n', '<leader>gtn', '<cmd>Gitsigns toggle_numhl<CR>', { desc = 'Toggle Number highlight' })
    map('n', '<leader>gtl', '<cmd>Gitsigns toggle_linehl<CR>', { desc = 'Toggle Line highlight' })
    map('n', '<leader>gtw', '<cmd>Gitsigns toggle_word_diff<CR>', { desc = 'Toggle Work_Diff' })
    map('n', '<leader>gtd', '<cmd>Gitsigns toggle_deleted<CR>', { desc = 'Toggle Deleted Line' })

    -- Text object
    map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
}

return options
