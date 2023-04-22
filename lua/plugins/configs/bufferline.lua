local exceptType = {
  ['qf'] = '',
  ['dap-repl'] = '',
  ['wiki'] = '',
  ['org'] = '~/Documents/org',
}
local icons = {
  buffer_close_icon = '',
  modified_icon = '●',
  close_icon = '',
  left_trunc_marker = '',
  right_trunc_marker = '',
}

local options = {
  highlights = function()
    if vim.fn.exists('g:neovide') == 0 then
      local bg = '#002b36'
      return {
        fill = { bg = bg },
        separator_selected = { fg = bg },
        separator_visible = { fg = bg },
        separator = { fg = bg },
        offset_separator = { fg = bg },
      }
    end
  end,
  options = {
    mode = 'buffers', -- set to "tabs" to only show tabpages instead
    numbers = 'none',
    close_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
    right_mouse_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
    left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator = {
      style = 'none', -- none / underline / icon
    },
    buffer_close_icon = icons.buffer_close_icon,
    modified_icon = icons.modified_icon,
    close_icon = icons.close_icon,
    left_trunc_marker = icons.left_trunc_marker,
    right_trunc_marker = icons.right_trunc_marker,
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
      return buf.name
    end,
    max_name_length = 18,
    max_prefix_length = 16, -- prefix used when a buffer is de-duplicated
    tab_size = 20,
    diagnostics = 'nvim_lsp',
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match('error') and ' ' or ' '
      return icon .. count
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number, buf_numbers)
      -- filter out filetypes you don't want to see
      for ft, onlyPath in pairs(exceptType) do
        if onlyPath == '' or onlyPath == nil then
          if vim.bo[buf_number].filetype == ft then
            return false
          end
        else
          if vim.fn.getcwd ~= onlyPath and vim.bo[buf_number].filetype == 'org' then
            return false
          end
        end
      end

      if vim.fn.bufname(buf_number) ~= '<?>' then
        return true
      end

      return true
    end,
    -- 显示File Explorer的偏移量
    offsets = {
      { filetype = 'NvimTree', text = 'File Explorer', highlight = 'Directory', text_align = 'center' },
      { filetype = 'lspsagaoutline', text = 'Syntax Tree', highlight = 'Directory', text_align = 'center' },
      { filetype = 'toggleterm', text = 'Terminal', highlight = 'Directory', text_align = 'center' },
    },
    color_icons = true, -- whether or not to add the filetype icon highlights
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    -- show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    -- slant / thick / thin
    separator_style = 'slant',
    -- true can't diff same buffer name
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = 'insert_after_current',
  },
}

return options
