local snippet = require('luasnip')

local i = snippet.insert_node
local s = snippet.s

local f = require('luasnip.extras.fmt').fmta

snippet.add_snippets('go', {
	s(
		'forr',
		f(
			[[
for <index>, <value> := range <collection> {
	<finish>
}
			]],
			{
				index = i(1, '_'),
				value = i(2, 'v'),
				collection = i(3, 'v'),
				finish = i(0),
			}
		)
	),
})
