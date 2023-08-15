local options = {
  rename = {
    in_select = false,
    auto_save = false,
    quit = '<C-k>',
    exec = '<CR>',
    select = 'x',
  },
  breadcrumbs = {
    enable = true,
    separator = '  ',
    hide_keyword = true,
    show_file = true,
    folder_level = 1,
    color_mode = true,
    delay = 300,
  },
  ui = {
    -- This option only works in Neovim 0.9
    title = true,
    devicon = true,
    -- Border type can be single, double, rounded, solid, shadow.
    border = 'shadow',
    winblend = 0,
    expand = '',
    collapse = '',
    code_action = '',
    actionfix = ' ',
    incoming = ' ',
    outgoing = ' ',
    hover = ' ',
    kind = {},
    lines = { '┗', '┣', '┃', '━', '┏' },
    imp_sign = '󰳛 ',
  },
}

return options
