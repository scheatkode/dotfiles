local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("lua", {
	s(
		"func",
		f(
			[[
function <name>(<parameters>)
	<body>
end
<finish>
			]],
			{
				name = i(1),
				parameters = i(2),
				body = i(3, "-- do something"),
				finish = i(0),
			}
		)
	),
})
