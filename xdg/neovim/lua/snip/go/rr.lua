return {
	setup = function()
		local snippet = require('luasnip')

		local i = snippet.insert_node
		local s = snippet.s

		local f = require('luasnip.extras.fmt').fmta

		snippet.add_snippets('go', {
			s(
				'rr',
				f(
					[[return fmt.Errorf("<message>"<error>)<finish>]],
					{
						message = i(1, 'error message'),
						error   = i(2, ', err'),
						finish  = i(0),
					}
				)
			),
		})
	end,
}
