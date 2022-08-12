return {
	setup = function()
		local has_comment, comment = pcall(require, 'Comment')

		if not has_comment then
			print('‼ Tried loading Comment.nvim ... unsuccessfully.')
			return has_comment
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
			pre_hook = function(context)
				local u = require('Comment.utils')

				-- determine whether to use linewise or blockwise
				-- commentstring
				local type = context.ctype == u.ctype.line
					 and '__default'
					 or '__multiline'

				-- determine the location from which to calculate the
				-- commentstring
				local location = nil

				if context.ctype == u.ctype.block then
					location = require('ts_context_commentstring.utils').get_cursor_location()
				elseif context.cmation == u.cmotion.v or context.cmotion == u.cmotion.V then
					location = require('ts_context_commentstring.utils').get_visual_start_location()
				end

				return require('ts_context_commentstring.internal').calculate_commentstring({
					key = type,
					location = location
				})
			end,

			-- post-hook, called after commenting is done
			post_hook = nil,
		}
	end
}
