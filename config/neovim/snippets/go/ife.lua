local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("go", {
	s(
		"ife",
		f(
			[[
if err != nil {
	return <body>
}
<finish>
			]],
			{
				body = i(1, "err"),
				finish = i(0),
			}
		)
	),
})
