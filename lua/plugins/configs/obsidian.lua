return {
  workspaces = {
    { name = 'personal', path = '~/Documents/Vaults/Personal' },
    { name = 'work', path = '~/Documents/Vaults/Work' },
  },
  daily_notes = {
    folder = 'dailies',
    date_format = '%Y-%m-%d (%a)',
    alias_format = '%b %-d, %Y (%a)',
    default_tags = { 'daily_notes' },
    template = 'daily.md',
  },
  mappings = {
    ['<cr>'] = {
      action = function()
        return require('obsidian').util.smart_action()
      end,
      opts = { buffer = true, expr = true },
    },
  },
  templates = {
    folder = vim.fn.stdpath('config') .. '/data/obsidian_templates',
    date_format = '%Y-%m-%d (%a)',
    time_format = '%H:%M',
    substitutions = {
      week_dates = function()
        local out = {}
        local now = os.time()
        local dow = tonumber(os.date('%w', now)) -- 0 = Sunday
        local monday = now - ((dow == 0 and 6 or dow - 1) * 86400)

        for i = 0, 6 do
          local t = monday + i * 86400
          table.insert(out, os.date('%A: [[%Y-%m-%d (%a)]]', t))
        end

        return table.concat(out, '\n')
      end,
    },
  },
  completion = {
    nvim_cmp = false,
    blink = true,
  },
  follow_url_func = function(url)
    vim.fn.jobstart({ 'xdg-open', url }) -- linux
  end,
  ui = { enable = false },
  picker = { name = 'snacks.pick' },
}
