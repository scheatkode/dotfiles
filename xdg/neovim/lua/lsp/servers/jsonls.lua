local has_lspconfig, lspconfig = pcall(require, "lspconfig")

if not has_lspconfig then
	print("‼ Tried loading lspconfig for jsonls ... unsuccessfully.")
	return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

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

	root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
	settings = settings,
}
