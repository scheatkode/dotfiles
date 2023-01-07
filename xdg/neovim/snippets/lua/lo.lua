local snippet = require('luasnip')

local i = snippet.insert_node
local s = snippet.s

local f = require('luasnip.extras.fmt').fmta

snippet.add_snippets('lua', {
	s(
		'lo',
		f([[local <name> = <finish>]], {
			name   = i(1, 'name'),
			finish = i(0),
		})
	),
})
