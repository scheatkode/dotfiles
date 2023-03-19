return {
	---Setup diffing behaviour.
	setup = function()
		vim.opt.formatoptions = {
			["1"] = true,
			["2"] = true, -- Use indent from second line of a paragraph

			q = true, -- Continue comments with `gq`
			c = true, -- Auto-wrap comments using `textwidth`
			r = true, -- Continue comments when pressing `<CR>`
			n = true, -- Recognize numbered lists
			t = false, -- Autowrap lines using `textwidth`
			j = true, -- Remove a comment leader when joining lines

			-- Only break if the line was no longer than
			-- `textwidth` when the insert started and only at
			-- a white character that has been entered during the
			-- current insert command.
			l = true,
			v = true,
		}
	end,
}
