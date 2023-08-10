return {
	setup = function()
		local pipe = require("f.function.pipe")

		local function handle_large_file()
			local threshold = 10485760 -- 10 MiB

			local backup
			local complete
			local eventignore
			local writebackup
			local undolevels

			return function()
				local size = pipe("<afile>", vim.fn.expand, vim.fn.getfsize)

				if size < threshold then
					return
				end

				backup = vim.opt.backup:get()
				complete = vim.opt.complete:get()
				eventignore = vim.opt.eventignore:get()
				undolevels = vim.opt.undolevels:get()
				writebackup = vim.opt.writebackup:get()

				vim.opt.complete:remove("wbuU")
				vim.opt.backup = false
				vim.opt.eventignore = "FileType"
				vim.opt.undolevels = -1
				vim.opt.writebackup = false

				vim.bo.bufhidden = "unload"
				vim.bo.swapfile = false
				vim.wo.foldenable = false
				vim.wo.foldmethod = "manual"
				vim.wo.wrap = false

				vim.defer_fn(function()
					vim.notify(
						"Large file detected, disabling features to prevent slowdowns",
						vim.log.levels.DEBUG
					)
				end, 100)

				local largefile_cleanup_augroup = vim.api.nvim_create_augroup(
					"LargeFileCleanup",
					{ clear = true }
				)

				vim.api.nvim_create_autocmd("BufEnter", {
					group = largefile_cleanup_augroup,
					buffer = 0,
					callback = function()
						vim.opt.complete:remove("wbuU")
						vim.opt.eventignore = "FileType"
						vim.opt.backup = false
						vim.opt.undolevels = -1
						vim.opt.writebackup = false
					end,
				})

				vim.api.nvim_create_autocmd("BufLeave", {
					group = largefile_cleanup_augroup,
					buffer = 0,
					callback = function()
						vim.opt.backup = backup
						vim.opt.complete = complete
						vim.opt.eventignore = eventignore
						vim.opt.undolevels = undolevels
						vim.opt.writebackup = writebackup
					end,
				})
			end
		end

		vim.api.nvim_create_autocmd("BufReadPre", {
			desc = "Prevent large files from causing too much overhead",
			group = vim.api.nvim_create_augroup("LargeFile", { clear = true }),
			callback = handle_large_file(),
		})
	end,
}
