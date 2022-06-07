local theme = require('theme')
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = theme.lualine.component_separators,
    section_separators = theme.lualine.section_separators,
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  -- mode/branch/diff/diagnostics/filename/encoding/fileformat/filetype/progress/location
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      'branch',
      {
        'diff',
        colored = true, -- Displays a colored diff status if set to true
        symbols = theme.lualine.git, -- Changes the symbols used by the diff.
        source = nil, -- A function that works as a data source for diff.
                      -- It must return a table as such:
                      --   { added = add_count, modified = modified_count, removed = removed_count }
                      -- or nil on failure. count <= 0 won't be displayed.
      },
      {
        'diagnostics',
        -- Table of diagnostic sources, available sources are:
        --   'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'.
        -- or a function that returns a table as such:
        --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
        sources = { 'nvim_diagnostic','coc','vim_lsp'},
        -- Displays diagnostics for the defined severity types
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = theme.diagnostic,
        colored = true,           -- Displays diagnostics status in color if set to true.
        update_in_insert = false, -- Update diagnostics in insert mode.
        always_visible = false,   -- Show diagnostics even if there are none.
      },
    },
    lualine_c = {
      {
        'filename',
        file_status = true,      -- Displays file status (readonly status, modified status)
        path = 1,                -- 0: Just the filename
                                 -- 1: Relative path
                                 -- 2: Absolute path

        shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
                                 -- for other components. (terrible name, any suggestions?)
        symbols = {
          modified = '[+]',      -- Text to show when the file is modified.
          readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
        }
      }
    },
    lualine_x = {'filetype'},
    lualine_y = {'encoding'},
    lualine_z = {'progress', 'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
