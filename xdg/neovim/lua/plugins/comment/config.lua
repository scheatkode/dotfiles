return {
	setup = function()
		local has_comment, comment = pcall(require, 'Comment')
		local has_ts, ts           = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')

		if not has_comment then
			print('‼ Tried loading Comment.nvim ... unsuccessfully.')
			return has_comment
		end

		if not has_ts then
			print('‼ nvim-ts-context-commentstring unavailable, comments may not be correct.')
		end

		return comment.setup {
			-- add a space between comment and the line
			padding = true,

			-- lines that should be ignored while (un)commenting
			-- example: use '^$' to ignore empty lines
			ignore = '^$',

			-- whether to create basic (operator-pending) and extra
			-- mappings for normal/visual mode
			mappings = {
				-- operator-pending mapping
				basic = false,

				-- extra mapping
				extra = false,

				-- extended mapping
				extended = false,
			},

			-- pre-hook, called before commenting the line
			pre_hook = has_ts
				 and ts.create_pre_hook()
				 or nil,

			-- post-hook, called after commenting is done
			post_hook = nil,
		}
	end
}
