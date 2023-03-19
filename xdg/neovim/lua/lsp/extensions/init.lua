local lazy = require("load.on_module_call")

return {
	rename = lazy("lsp.extensions.rename"),
}
