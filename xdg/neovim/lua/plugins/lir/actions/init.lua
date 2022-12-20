local lazy = require('load.on_module_call')

return {
	new_node         = lazy('plugins.lir.actions.new_node'),
	populate_command = lazy('plugins.lir.actions.populate_command'),
	rename           = lazy('plugins.lir.actions.rename'),
}
