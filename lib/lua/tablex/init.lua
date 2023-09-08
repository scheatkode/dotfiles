local lazy = require("load.on_module_call")

return {
	deep_extend = lazy("tablex.deep_extend"),
	extend = lazy("tablex.extend"),
	filter = lazy("tablex.filter"),
	is_empty = lazy("tablex.is_empty"),
	is_list = lazy("tablex.is_list"),
}
