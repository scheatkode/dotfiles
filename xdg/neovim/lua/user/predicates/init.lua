local lazy = require("load.on_module_call")

return {
	is_file_bigger = lazy("user.predicates.is_file_bigger"),
	is_window_type = lazy("user.predicates.is_window_type"),
}
