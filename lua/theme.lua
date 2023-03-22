local M = {}

M.diagnostic = {
  error = '',
  warning = '',
  hint = '',
  information = '',
  other = '﫠',
}

M.lualine = {
  component_separators = { left = '', right = '' },
  section_separators = { left = '', right = '' },
  git = { added = ' ', modified = '柳', removed = ' ' },
}

M.gitsigns = {
  current_line_blame_formatter = '  「 <author>, <author_time> • <summary> 」',
  signs = {
    add = { hl = 'GitSignsAdd', text = '▊', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change = { hl = 'GitSignsChange', text = '▊', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    untracked = { hl = 'GitSignsAdd', text = '┆', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
  },
}

M.nvim_tree = {
  webdev_colors = true,
  git_placement = 'after',
  padding = ' ',
  symlink_arrow = ' ➛ ',
  show = {
    file = true,
    folder = true,
    folder_arrow = true,
    git = true,
  },
  glyphs = {
    default = '',
    symlink = '',
    git = {
      unstaged = '',
      staged = '',
      unmerged = '',
      renamed = 'ﲖ',
      untracked = '',
      deleted = '',
      ignored = '',
    },
    folder = {
      arrow_open = '',
      arrow_closed = '',
      default = '',
      open = '',
      empty = '',
      empty_open = '',
      symlink = '',
      symlink_open = '',
    },
  },
}

return M
