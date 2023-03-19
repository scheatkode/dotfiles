local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("lua", {
	s(
		"do",
		f(
			[[
do
	<body>
end
<finish>
			]],
			{
				body = i(1, "-- do something"),
				finish = i(0),
			}
		)
	),
})
