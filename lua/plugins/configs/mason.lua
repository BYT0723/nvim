local ensure_installed = {
  -- LSP
  -- 'angular-language-server',
  'asm-lsp',
  'bash-language-server',
  'buf-language-server',
  'clangd',
  'cmake-language-server',
  'css-lsp',
  'dockerfile-language-server',
  'docker-compose-language-service',
  'dot-language-server',
  'emmet-ls',
  'eslint-lsp',
  'gopls',
  'html-lsp',
  'json-lsp',
  'lua-language-server',
  'marksman',
  'pyright',
  'rust-analyzer',
  'sqlls',
  'taplo',
  'typescript-language-server',
  'vim-language-server',
  'vue-language-server',
  'yaml-language-server',
  --- DAP
  'cpptools',
  'delve',
  -- Linter
  'buf',
  'cmakelang',
  'codespell',
  'cpplint',
  'eslint_d',
  'golangci-lint',
  -- Formatter
  'autopep8',
  'goimports',
  'prettierd',
  'shfmt',
  'sql-formatter',
  'stylua',
}

return {
  -- Where Mason should put its bin location in your PATH. Can be one of:
  -- - "prepend" (default, Mason's bin location is put first in PATH)
  -- - "append" (Mason's bin location is put at the end of PATH)
  -- - "skip" (doesn't modify PATH)
  ---@type '"prepend"' | '"append"' | '"skip"'
  PATH = 'prepend',

  -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
  -- debugging issues with package installations.
  log_level = vim.log.levels.INFO,

  -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
  -- packages that are requested to be installed will be put in a queue.
  max_concurrent_installers = 8,

  ui = {
    -- Whether to automatically check for new versions when opening the :Mason window.
    check_outdated_packages_on_open = true,

    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = 'double', -- none / single / double / rounded / solid / shadow
    -- Width of the window. Accepts:
    -- - Integer greater than 1 for fixed width.
    -- - Float in the range of 0-1 for a percentage of screen width.
    width = 0.8,

    -- Height of the window. Accepts:
    -- - Integer greater than 1 for fixed height.
    -- - Float in the range of 0-1 for a percentage of screen height.
    height = 0.8,

    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
    keymaps = {
      toggle_package_expand = '<CR>',
      install_package = 'i',
      update_package = 'u',
      check_package_version = 'c',
      update_all_packages = 'U',
      -- Keymap to check which installed packages are outdated
      check_outdated_packages = 'C',
      uninstall_package = 'X',
      cancel_installation = '<C-c>',
      apply_language_filter = '<C-f>',
    },
  },
  ensure_installed = ensure_installed,
}
