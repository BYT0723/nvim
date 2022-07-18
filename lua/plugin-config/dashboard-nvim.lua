local home = os.getenv('HOME')
local db = require('dashboard')
-- db.preview_command = 'figlet -cW Neovim | lolcat -F 0.3'
-- db.preview_file_path = ''
db.preview_file_height = 6
db.preview_file_width = 80
db.custom_center = {
  {
    icon = '  ',
    desc ='New Buffer                               ',
    action = 'DashboardNewFile',
    -- shortcut = 'SPC f b'
  },
  {
    icon = '  ',
    desc ='Open File Tree                           ',
    action =  'NvimTreeOpen',
    -- shortcut = 'SPC f b'
  },
  {
    icon = '  ',
    desc ='Recent Projects                          ',
    action =  'Telescope projects',
    -- shortcut = 'SPC f b'
  },
  {
    icon = '  ',
    desc = 'Configuration                           ',
    action = 'edit '..home..'/.config/nvim/init.vim',
    -- shortcut = 'SPC f d'
  },
}
