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
  on_highlights = function(hl, c)
    local border = { bg = c.bg_dark, fg = c.bg_dark }
    local bg_fix = function(hl)
      return {
        bg = c.bg_dark,
        fg = hl and hl.fg or nil,
      }
    end

    -- 需要统一改背景的
    local bg_groups = {
      'BqfPreviewFloat',

      'BlinkCmpMenu',
      'BlinkCmpDoc',
      'BlinkCmpSignatureHelp',

      'LazyNormal',
      'MasonNormal',

      'SnacksPicker',
      'SnacksPickerInput',
      'SnacksPickerList',

      'SnacksNotifierInfo',
      'SnacksNotifierWarn',
      'SnacksNotifierDebug',
      'SnacksNotifierError',
      'SnacksNotifierTrace',

      'SnacksNotifierTitleInfo',
      'SnacksNotifierTitleWarn',
      'SnacksNotifierTitleDebug',
      'SnacksNotifierTitleError',
      'SnacksNotifierTitleTrace',

      'SnacksNotifierIconInfo',
      'SnacksNotifierIconWarn',
      'SnacksNotifierIconDebug',
      'SnacksNotifierIconError',
      'SnacksNotifierIconTrace',

      'NoicePopup',
      'NoiceCmdlinePopup',

      'PantranNormal',
    }

    -- 需要统一边框的
    local border_groups = {
      'BqfPreviewBorder',

      'WhichKeyBorder',

      'SnacksPickerBorder',
      'SnacksPickerInputBorder',

      'SnacksNotifierBorderInfo',
      'SnacksNotifierBorderWarn',
      'SnacksNotifierBorderDebug',
      'SnacksNotifierBorderError',
      'SnacksNotifierBorderTrace',

      'NoiceCmdlinePopupBorder',
      'NoiceCmdlinePopupBorderLua',
      'NoiceCmdlinePopupBorderInput',
      'NoiceCmdlinePopupBorderSearch',

      'PantranBorder',
    }

    for _, group in ipairs(bg_groups) do
      hl[group] = bg_fix(hl[group])
    end

    for _, group in ipairs(border_groups) do
      hl[group] = border
    end

    hl.WhichKeyTitle = { bg = c.hint, fg = c.bg_dark }
    hl.BlinkCmpSource = bg_fix(hl.Comment)

    -- LspInlayHint样式
    if vim.opt.background:get() == 'dark' then
      hl.LspInlayHint = {
        fg = '#545c7e',
      }
    end
  end,
}
