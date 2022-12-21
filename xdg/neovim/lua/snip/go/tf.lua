return {
	setup = function()
		local snippet = require('luasnip')

		local i = snippet.insert_node
		local s = snippet.s

		local f = require('luasnip.extras.fmt').fmta

		snippet.add_snippets('go', {
			s(
				'tf',
				f(
					[[
			func Test<name>(t *testing.T) {
				<body>
			}
			<finish>]],
					{
						name   = i(1),
						body   = i(2),
						finish = i(0),
					}
				)
			),
		})
	end,
}
