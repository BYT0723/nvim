return {
  input = {
    enabled = true,
    border = 'shadow',
    relative = 'editor',
    min_width = { 50, 0.5 },
    win_options = {
      winblend = 0,
    },
    get_config = function(opts)
      if opts.prompt == 'New Name: ' then
        return {
          relative = 'cursor',
          min_width = { 15, 0.1 },
        }
      end
    end,
  },
  select = {
    enabled = true,
    get_config = function(opts)
      if opts.kind == 'codeaction' then
        return {
          nui = {
            position = { row = 2, col = 0 },
            relative = 'cursor',
          },
        }
      end
    end,
  },
}
