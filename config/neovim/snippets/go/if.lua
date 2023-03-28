local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("go", {
	s(
		"if",
		f(
			[[
if <expr> {
	<body>
}
<finish>
			]],
			{
				expr = i(1),
				body = i(2),
				finish = i(0),
			}
		)
	),
})
