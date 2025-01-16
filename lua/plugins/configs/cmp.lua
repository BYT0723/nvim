return {
  enabled = function()
    return not vim.tbl_contains({ 'DressingInput' }, vim.bo.filetype)
      and vim.bo.buftype ~= 'prompt'
      and vim.b.completion ~= false
  end,
      -- stylua: ignore
      keymap = {
        preset = 'none',
        ['<Tab>']   = { 'select_next',               'fallback' },
        ['<S-Tab>'] = { 'select_prev',               'fallback' },
        ['<CR>']    = { 'accept',                    'fallback' },
        ['<C-j>']   = { 'snippet_forward',           'fallback' },
        ['<C-k>']   = { 'snippet_backward',          'fallback' },
        ['<C-u>']   = { 'scroll_documentation_up',   'fallback' },
        ['<C-d>']   = { 'scroll_documentation_down', 'fallback' },
      },
  completion = {
    keyword = {
      -- 'prefix' will fuzzy match on the text before the cursor
      -- 'full' will fuzzy match on the text before *and* after the cursor
      -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
      range = 'prefix',
    },
    list = {
      max_items = 20,
      selection = {
        preselect = false,
        auto_insert = true,
      },
    },
    menu = {
      draw = {
        align_to = 'cursor', -- or 'none' to disable, or 'cursor' to align to the cursor
        padding = 1,
        gap = 5,
        columns = { { 'kind_icon', 'label', 'label_description', gap = 1 }, { 'kind' } },
        components = { kind = { highlight = 'Comment' } },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 100,
      window = {
        border = 'rounded',
      },
    },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono',
  },
  sources = {
    default = { 'lsp', 'snippets', 'buffer', 'path' },
    per_filetype = {
      markdown = { 'obsidian', 'obsidian_new', 'obsidian_tags', 'lsp', 'snippets', 'buffer', 'path' },
    },
    transform_items = function(_, items)
      for _, item in ipairs(items) do
        -- 将LSP提供的代码片段的优先级提高
        if item.kind == 15 and item.source_id == 'lsp' then -- Snippets
          item.score_offset = item.score_offset + 100
        end
      end
      return items
    end,
    providers = {
      obsidian = {
        name = 'obsidian',
        module = 'blink.compat.source',
      },
      obsidian_new = {
        name = 'obsidian_new',
        module = 'blink.compat.source',
      },
      obsidian_tags = {
        name = 'obsidian_tags',
        module = 'blink.compat.source',
      },
      markdown = {
        name = 'RenderMarkdown',
        module = 'render-markdown.integ.blink',
        fallbacks = { 'lsp' },
      },
    },
  },
  signature = {
    enabled = true,
    window = {
      border = 'rounded',
    },
  },
}
