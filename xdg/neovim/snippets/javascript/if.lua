local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("javascript", {
	s(
		"if",
		f(
			[[
			if (<cond>) {
				<body>
			}
			<finish>
			]],
			{
				cond = i(1),
				body = i(2),
				finish = i(0),
			}
		)
	),
})
