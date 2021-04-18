--- ux

require('config.keymaps')
require('config.options')

--- plugin configuration

if not require('config.plugins') then
   return false
end

require('config.plugins.whichkey')

require('config.plugins.autopairs')
require('config.plugins.compe')
require('config.plugins.easy-align')
require('config.plugins.galaxyline')
require('config.plugins.git')
require('config.plugins.gruvbox')
require('config.plugins.indent-guides')
require('config.plugins.kommentary')
require('config.plugins.lspsaga')
require('config.plugins.neoscroll')
require('config.plugins.nvim-tree')
require('config.plugins.sandwich')
require('config.plugins.suda')
require('config.plugins.telescope')
require('config.plugins.treesitter')

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80
