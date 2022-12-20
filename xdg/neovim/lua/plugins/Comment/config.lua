return {
	setup = function()
		local comment = require('Comment')
		local ts = require('ts_context_commentstring.integrations.comment_nvim')

		return comment.setup({
			-- add a space between comment and the line
			padding = true,

			-- lines that should be ignored while (un)commenting
			-- example: use '^$' to ignore empty lines
			ignore = '^$',

			-- whether to create basic (operator-pending) and extra
			-- mappings for normal/visual mode
			mappings = {
				-- operator-pending mapping
				basic    = false,
				-- extra mapping
				extra    = false,
				-- extended mapping
				extended = false,
			},

			-- pre-hook, called before commenting the line
			pre_hook = ts.create_pre_hook(),

			-- post-hook, called after commenting is done
			post_hook = nil,
		})
	end,
}
