local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("go", {
	s(
		"tyf",
		f(
			[[
func (<type>) <name>(<params>) <return> {
	<finish>
}
			]],
			{
				type = i(1, "t Type"),
				name = i(2, "FuncName"),
				params = i(3),
				["return"] = i(4, "error"),
				finish = i(0),
			}
		)
	),
})
