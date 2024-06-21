return {
  signs = {
    add = { text = '▊' },
    change = { text = '▊' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
    untracked = { text = '┆' },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true,
  },
  auto_attach = true,
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
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
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    -- Navigation
    map('n', 'gj', function()
      if vim.wo.diff then
        vim.cmd.normal({ 'gj', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', 'gk', function()
      if vim.wo.diff then
        vim.cmd.normal({ 'gk', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- stylua: ignore
    map('n', '<leader>gb', function() gitsigns.blame_line{full=true} end, { desc = 'Show Blamer' })
    map('n', '<leader>gv', gitsigns.preview_hunk, { desc = 'Preview hunk' })
    map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
    map('v', '<leader>gr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)
    map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Reset all hunk' })
    map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
    map('v', '<leader>gs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)
    map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'Undo last stage' })
    map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { desc = 'Toggle Blamer' })
    map('n', '<leader>gts', '<cmd>Gitsigns toggle_signs<CR>', { desc = 'Toggle Sings' })
    map('n', '<leader>gtn', '<cmd>Gitsigns toggle_numhl<CR>', { desc = 'Toggle Number highlight' })
    map('n', '<leader>gtl', '<cmd>Gitsigns toggle_linehl<CR>', { desc = 'Toggle Line highlight' })
    map('n', '<leader>gtw', '<cmd>Gitsigns toggle_word_diff<CR>', { desc = 'Toggle Work_Diff' })
    map('n', '<leader>gtd', gitsigns.toggle_deleted, { desc = 'Toggle Deleted Line' })

    -- Text object
    map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
}
