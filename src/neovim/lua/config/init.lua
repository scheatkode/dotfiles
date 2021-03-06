--- ux

require('config.keymaps')
require('config.options')

--- plugin configuration

if not require('config.plugins') then
   return false
end

require('config.plugins.whichkey')

require('config.plugins.bufdel')
require('config.plugins.compe')
require('config.plugins.easy-align')
require('config.plugins.galaxyline')
require('config.plugins.git')
require('config.plugins.gruvbox')
require('config.plugins.indent-guides')
require('config.plugins.kommentary')
require('config.plugins.lspsaga')
require('config.plugins.lspsignature')
require('config.plugins.lsptrouble')
require('config.plugins.neoscroll')
require('config.plugins.nvim-tree')
require('config.plugins.pears')
require('config.plugins.sandwich')
require('config.plugins.suda')
require('config.plugins.symbols')
require('config.plugins.telescope')
require('config.plugins.treesitter')
require('config.plugins.undo-tree')

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:
