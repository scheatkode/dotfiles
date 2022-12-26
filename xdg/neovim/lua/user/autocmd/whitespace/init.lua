return {
	setup = function()
		local assertx    = require('assertx')
		local constant   = require('f.function.constant')
		local negate     = require('f.function.negate')
		local noop       = require('f.function.noop')
		local predicates = require('f.function.predicates')
		local ternary    = require('f.function.ternary')
		local when       = require('f.function.when')

		local is_file_bigger = require('user.predicates.is_file_bigger')
		local is_window_type = require('user.predicates.is_window_type')

		local function should_highlight()
			return vim.bo.filetype ~= ''
				 and vim.bo.buftype == ''
				 and vim.bo.modifiable
		end

		local function toggle_trailing(mode)
			assertx(
				mode == 'n' or mode == 'i',
				string.format, 'invalid mode: %s', mode
			)

			return function()
				local pattern = ternary(
					mode == 'i',
					constant([[\s\+\%#\@<!$]]),
					constant([[\s\+$]])
				)

				if vim.w.whitespace_match_number then
					vim.fn.matchdelete(vim.w.whitespace_match_number)
					vim.fn.matchadd(
						'ExtraWhitespace', pattern, 10, vim.w.whitespace_match_number
					)
					return
				end

				vim.w.whitespace_match_number = vim.fn.matchadd(
					'ExtraWhitespace', pattern
				)
			end
		end

		local function register_highlight()
			vim.api.nvim_set_hl(0, 'ExtraWhitespace', {
				background = '#322b2b',
				foreground = '#322b2b',
			})
		end

		local function register_autocmd(predicate)
			local augroup = vim.api.nvim_create_augroup(
				'WhitespaceHighlight', { clear = true }
			)

			vim.api.nvim_create_autocmd('ColorScheme', {
				group    = augroup,
				callback = when(predicate, register_highlight, noop()),
			})

			vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType', 'InsertLeave' }, {
				group    = augroup,
				callback = when(predicate, toggle_trailing('n'), noop()),
			})

			vim.api.nvim_create_autocmd('InsertEnter', {
				group    = augroup,
				callback = when(predicate, toggle_trailing('i'), noop()),
			})
		end

		register_highlight()
		register_autocmd(
			predicates(
				should_highlight,
				negate(is_window_type('popup')),
				negate(is_file_bigger(1048576))-- 1 MiB
			)
		)
	end
}
