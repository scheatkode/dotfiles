return {
	---Setup buffer and window management behaviour.
	setup = function()
		vim.opt.hidden = true -- Hide abandoned buffers but keep them around
		vim.opt.splitbelow = true -- Split the new pane below the current one
		vim.opt.splitright = true -- Split the new pane to the right
		vim.opt.splitkeep = "screen" -- Keep text on the same screen line when splitting
		vim.opt.equalalways = true -- Equalize window sizes when layout changes
		vim.opt.eadirection = "both" -- Tells when 'equalalways' applies
		vim.opt.switchbuf = { -- Buffers cycle between open and last used
			"useopen",
			"uselast",
		}
	end,
}
