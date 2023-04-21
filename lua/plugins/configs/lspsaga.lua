local options = {
  preview = {
    lines_above = 0,
    lines_below = 10,
  },
  scroll_preview = {
    scroll_down = '<C-u>',
    scroll_up = '<C-d>',
  },
  request_timeout = 2000,
  finder = {
    --percentage
    max_height = 0.5,
    keys = {
      jump_to = 'p',
      edit = { 'o', '<CR>' },
      vsplit = 's',
      split = 'i',
      tabe = 't',
      quit = { 'q' },
      close_in_preview = '<Esc>',
    },
  },
  definition = {
    edit = '<C-c>o',
    vsplit = '<C-c>v',
    split = '<C-c>i',
    tabe = '<C-c>t',
    quit = 'q',
    close = '<Esc>',
  },
  code_action = {
    num_shortcut = true,
    show_server_name = false,
    keys = {
      quit = 'q',
      exec = '<CR>',
    },
  },
  lightbulb = {
    enable = true,
    enable_in_insert = false,
    sign = true,
    sign_priority = 40,
    virtual_text = false,
  },
  diagnostic = {
    show_code_action = true,
    show_source = true,
    jump_num_shortcut = true,
    max_width = 0.7,
    custom_fix = nil,
    custom_msg = nil,
    text_hl_follow = false,
    border_follow = true,
    keys = {
      exec_action = 'o',
      quit = 'q',
      go_action = 'g',
    },
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
    win_with = '',
    win_width = 30,
    show_detail = true,
    auto_preview = true,
    auto_refresh = true,
    auto_close = true,
    custom_sort = nil,
    keys = {
      jump = '<CR>',
      expand_collapse = 'u',
      quit = 'q',
    },
  },
  callhierarchy = {
    show_detail = false,
    keys = {
      edit = 'e',
      vsplit = 's',
      split = 'i',
      tabe = 't',
      jump = 'o',
      quit = 'q',
      expand_collapse = 'u',
    },
  },
  symbol_in_winbar = {
    enable = true,
    separator = '  ',
    hide_keyword = false,
    show_file = true,
    folder_level = 2,
    respect_root = true,
    color_mode = true,
  },
  beacon = {
    enable = true,
    frequency = 7,
  },
  ui = {
    -- currently only round theme
    theme = 'round',
    title = true,
    -- border type can be single,double,rounded,solid,shadow.
    border = 'double',
    winblend = 0,
    expand = '',
    collapse = '',
    preview = ' ',
    code_action = '',
    diagnostic = '🐞',
    incoming = ' ',
    outgoing = ' ',
    kind = {},
  },
}

return options
