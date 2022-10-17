local function rename()
	local current    = vim.fn.expand('<cword>')
	local parameters = vim.lsp.util.make_position_params()

	local function rename_handler(_, result, context, _)
		if not result then return end

		-- apply renames
		local client = vim.lsp.get_client_by_id(context.client_id)
		vim.lsp.util.apply_workspace_edit(result, client.offset_encoding)

		-- print renames
		local changed_files_count     = 0
		local changed_instances_count = 0

		if result.documentChanges then
			for _, changed_file in pairs(result.documentChanges) do
				changed_files_count     = changed_files_count + 1
				changed_instances_count = changed_instances_count + #changed_file.edits
			end
		elseif result.changes then
			for _, changed_file in pairs(result.changes) do
				changed_instances_count = changed_instances_count + #changed_file
				changed_files_count     = changed_files_count + 1
			end
		end

		print(string.format(
			'Renamed %s instance%s in %s file%s. %s',
			changed_instances_count,
			changed_instances_count == 1 and '' or 's',
			changed_files_count,
			changed_files_count == 1 and '' or 's',
			changed_files_count > 1 and '`:wa` to save them all' or ''
		))
	end

	local function input_handler(new)
		if not new or #new == 0 or current == new then return end

		parameters.newName = new
		vim.lsp.buf_request(0, 'textDocument/rename', parameters, rename_handler)
	end

	local opts = {
		prompt = 'New Name: ',
		default = current,
	}

	vim.ui.input(opts, input_handler)
end

return {
	rename = rename
}
