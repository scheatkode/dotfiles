local has_plugin, plugin = pcall(require, 'lightspeed')
local log = require('log')

if not has_plugin then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'lightspeed')
   return has_plugin
end

plugin.setup()
