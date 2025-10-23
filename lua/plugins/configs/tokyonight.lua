return {
  transparent = not vim.g.neovide,
  styles = {
    style = 'storm', -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
    light_style = 'day', -- The theme is used when the background is set to light
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variable = {},
    sidebars = 'dark', -- style for sidebars, see below
    floats = not vim.g.neovide and 'transparent' or 'dark', -- style for floating windows
  },
  sidebars = { 'qf' },
  on_colors = function(colors) end,
  on_highlights = function(hl, c)
    hl.BqfPreviewFloat = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.BqfPreviewBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.WhichKeyBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.WhichKeyTitle = {
      bg = c.hint,
      fg = c.bg_dark,
    }
    hl.BlinkCmpMenu = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.BlinkCmpSource = {
      fg = hl.Comment.fg,
      bg = hl.Comment.bg,
    }
    hl.BlinkCmpDoc = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.BlinkCmpSignatureHelp = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    if vim.opt.background:get() == 'dark' then
      hl.LspInlayHint = {
        fg = '#545c7e',
      }
    end
  end,
}
