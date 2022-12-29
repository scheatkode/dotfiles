local snippet = require('luasnip')

local i = snippet.insert_node
local s = snippet.s

local f = require('luasnip.extras.fmt').fmta

snippet.add_snippets('go', {
	s(
		'bf',
		f(
			[[
func Benchmark<name>(b *testing.B) {
	for <idx> := 0; <idx> << b.N; <idx>++ {
		<body>
	}
}
<finish>]],
			{
				name   = i(1),
				idx    = i(2, 'i'),
				body   = i(3),
				finish = i(0),
			}
		)
	),
})
