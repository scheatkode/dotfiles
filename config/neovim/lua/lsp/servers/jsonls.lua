return function()
	local has_schemastore, schemastore = pcall(require, "schemastore")

	local settings = has_schemastore
			and {
				json = { schemas = schemastore.json.schemas() },
				validate = true,
			}
		or nil

	return {
		filetypes = {
			"json",
			"jsonc",
		},

		settings = settings,
	}
end
