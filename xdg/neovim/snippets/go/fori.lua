local snippet = require('luasnip')

local i = snippet.insert_node
local s = snippet.s

local f = require('luasnip.extras.fmt').fmta

snippet.add_snippets('go', {
	s(
		'fori',
		f(
			[[
for <index> := <start>; <index> << <end>; <index><increment> {
	<finish>
}
			]],
			{
				['index']     = i(1, 'i'),
				['start']     = i(2, '0'),
				['end']       = i(3, 'count'),
				['increment'] = i(4, '++'),
				['finish']    = i(0),
			}
		)
	),
})
