local lazy = require('lazy.on_module_call')

return {
	new_node         = lazy('plugins.explorer.actions.new_node'),
	populate_command = lazy('plugins.explorer.actions.populate_command'),
	rename           = lazy('plugins.explorer.actions.rename'),
}
