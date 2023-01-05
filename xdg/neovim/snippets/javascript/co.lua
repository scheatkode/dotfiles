local snippet = require('luasnip')

local i = snippet.insert_node
local s = snippet.s

local f = require('luasnip.extras.fmt').fmta

snippet.add_snippets('javascript', {
	s(
		'co',
		f(
			[[
			const <name> = <expr>
			<finish>
			]],
			{
				name   = i(1),
				expr   = i(2, 'undefined'),
				finish = i(0),
			}
		)
	),
})
