return {
	---Setup diffing behaviour.
	setup = function()
		-- Use in vertical diff mode, blank lines to keep sides
		-- aligned, ignore whitespace changes.
		vim.opt.diffopt = {
			"internal",
			"filler",
			"closeoff",
			"vertical",
			"iwhite",
			"hiddenoff",
			"foldcolumn:0",
			"context:16",
			"linematch:60",
			"indent-heuristic",
			"algorithm:histogram",
		}
	end,
}
