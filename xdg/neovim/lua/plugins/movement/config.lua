local has_plugin, plugin = pcall(require, 'leap')
local log = require('log')

if not has_plugin then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'leap')
   return has_plugin
end

plugin.setup({})
plugin.set_default_keymaps()
