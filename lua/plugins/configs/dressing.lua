return {
  input = {
    enabled = true,
    border = 'double',
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
    backend = 'nui',
    nui = {
      position = '30%',
      border = {
        style = 'double',
      },
      win_options = {
        winblend = 0,
      },
      max_width = 80,
      max_height = 40,
      min_width = 40,
      min_height = 1,
    },
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
