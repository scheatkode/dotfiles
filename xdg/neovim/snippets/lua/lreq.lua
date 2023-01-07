local snippet = require('luasnip')

local i = snippet.insert_node
local s = snippet.s

local f = require('luasnip.extras.fmt').fmta

snippet.add_snippets('lua', {
	s(
		'lreq',
		f([[local <name> = require('<path>')<finish>]], {
			name   = i(1, 'name'),
			path   = i(2),
			finish = i(0),
		})
	),
})
