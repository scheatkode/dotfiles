local snippet = require('luasnip')

local i = snippet.insert_node
local s = snippet.s

local f = require('luasnip.extras.fmt').fmta

snippet.add_snippets('go', {
	s(
		'vars',
		f(
			[[
var (
	<name> <type> = <value>
)
<finish>
			]],
			{
				name   = i(1, 'name'),
				type   = i(2, 'type'),
				value  = i(3, '"value"'),
				finish = i(0),
			}
		)
	),
})
