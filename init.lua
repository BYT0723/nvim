-- lua module logder
vim.loader.enable()

-- vim environment (base environment for non-plugins), will load base/init.lua
require('base')

-- import plugins, will load plugins/init.lua
require('plugins')
