return {
  workspaces = {
    { name = 'personal', path = '~/Documents/Vaults/Personal' },
    { name = 'work', path = '~/Documents/Vaults/Work' },
  },
  daily_notes = {
    folder = 'dailies',
    date_format = '%Y-%m-%d',
    alias_format = '%B %-d, %Y (%A)',
    default_tags = { 'daily_notes' },
    template = 'daily.md',
  },
  templates = {
    folder = 'templates',
    date_format = '%Y-%m-%d (%A)',
    time_format = '%H:%M',
    substitutions = {
      week_dates = function()
        local out = {}
        local now = os.time()
        local dow = tonumber(os.date('%w', now)) -- 0 = Sunday
        local monday = now - ((dow == 0 and 6 or dow - 1) * 86400)

        for i = 0, 6 do
          local t = monday + i * 86400
          table.insert(out, os.date('%A: [[%Y-%m-%d]]', t))
        end

        return table.concat(out, '\n')
      end,
    },
  },
  completion = {
    nvim_cmp = false,
    blink = true,
  },
  picker = {
    name = 'snacks.picker',
  },
  footer = {
    format = '  {{backlinks}} |  {{properties}} |   {{words}} |  {{chars}} ',
    enabled = true,
  },
  legacy_commands = false,
}
