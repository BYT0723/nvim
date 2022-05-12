vim.g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = true,
    position = 'right',
    relative_width = true,
    width = 25,
    auto_close = false,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = false,
    preview_bg_highlight = 'Pmenu',
    keymaps = require('keybindings').symbols_outline(),
    lsp_blacklist = {},
    symbol_blacklist = {},
    symbols = require('theme').symbols_outline.symbols
}
