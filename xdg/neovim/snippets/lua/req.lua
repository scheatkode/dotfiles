local snippet = require('luasnip')

local i = snippet.insert_node
local s = snippet.s

local f = require('luasnip.extras.fmt').fmta

snippet.add_snippets('lua', {
	s(
		'req',
		f([[require('<path>')<finish>]], {
			path   = i(1),
			finish = i(0),
		})
	),
})
