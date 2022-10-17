local lazy = require('lazy.on_module_call')

return {
	deep_extend = lazy('tablex.deep_extend'),
	extend      = lazy('tablex.extend'),
	is_empty    = lazy('tablex.is_empty'),
	is_list     = lazy('tablex.is_list'),
}
