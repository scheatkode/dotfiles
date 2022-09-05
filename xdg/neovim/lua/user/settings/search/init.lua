return {
	---Setup search/substitute behaviour.
	setup = function()
		vim.opt.hlsearch     = true -- Highlight search results
		vim.opt.ignorecase   = true -- Ignore case when searching
		vim.opt.smartcase    = true -- .. Unless there is a capital letter in the query
		vim.opt.incsearch    = true -- Search incrementally
		vim.opt.magic        = true -- Turn magic on for regular expressions
		vim.opt.regexpengine = 0 -- Set regexp engine to auto
		vim.opt.wrapscan     = true -- Searches wrap around the end of the file
		vim.opt.inccommand   = 'split' -- Preview substitute results

		-- Dynamically disable `smartcase` in command mode complete while
		-- ignoring case.
		local augroup = vim.api.nvim_create_augroup('DynamicSmartcase', { clear = true })

		vim.api.nvim_create_autocmd('CmdLineEnter', {
			group = augroup,
			pattern = ':',
			callback = function() vim.opt.smartcase = false end,
		})


		vim.api.nvim_create_autocmd('CmdLineLeave', {
			group = augroup,
			pattern = ':',
			callback = function() vim.opt.smartcase = true end,
		})
	end
}
