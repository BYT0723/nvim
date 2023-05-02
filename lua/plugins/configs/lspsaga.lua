local options = {
  scroll_preview = {
    scroll_down = '<C-d>',
    scroll_up = '<C-u>',
  },
  finder = {
    keys = {
      jump_to = 'p',
      edit = { 'o', '<CR>' },
      vsplit = 's',
      split = 'i',
      tabe = 't',
      tabnew = 'r',
      quit = { 'q', '<ESC>' },
      close_in_preview = '<Esc>',
    },
  },
  definition = {
    edit = '<C-c>o',
    vsplit = '<C-c>v',
    split = '<C-c>i',
    tabe = '<C-c>t',
    quit = 'q',
  },
  rename = {
    quit = '<Esc>',
    exec = '<CR>',
    mark = 'x',
    confirm = '<CR>',
    in_select = true,
  },
  outline = {
    win_position = 'right',
    win_width = 30,
    preview_width = 0.4,
    show_detail = true,
    auto_preview = true,
    auto_refresh = true,
    auto_close = true,
    custom_sort = nil,
  },
  symbol_in_winbar = {
    enable = false,
    separator = '  ',
  },
  ui = {
    -- border type can be single,double,rounded,solid,shadow.
    border = 'double',
  },
}

return options
