return {
  input = {
    enabled = true,
    border = 'double',
    relative = 'editor',
    min_width = { 50, 0.5 },
    win_options = {
      winblend = 50,
    },
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
