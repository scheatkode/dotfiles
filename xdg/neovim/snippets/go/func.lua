local snippet = require('luasnip')

local i = snippet.insert_node
local s = snippet.s

local f = require('luasnip.extras.fmt').fmta

snippet.add_snippets('go', {
	s(
		'func',
		f(
			[[
func <name>(<params>) <ret> {
	<finish>
}
			]],
			{
				name   = i(1),
				params = i(2),
				ret    = i(3),
				finish = i(0),
			}
		)
	),
})
