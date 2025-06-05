---@type snacks.Config
return {
  bigfile = { enabled = true },
  dashboard = {
    sections = {
      { section = 'header' },
      { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
      { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
      { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
      { section = 'startup' },
    },
  },
  explorer = { enabled = false },
  indent = { indent = { char = '╎' }, scope = { char = '╎' } },
  input = { enabled = true, icon_pos = 'title', win = { width = 40, relative = 'cursor', row = -3, col = 0 } },
  picker = { enabled = true },
  notifier = { style = 'compact' },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
}
