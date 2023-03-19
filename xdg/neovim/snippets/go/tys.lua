local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("go", {
	s(
		"tys",
		f(
			[[
type <name> struct {
	<finish>
}
			]],
			{
				name = i(1, "TypeName"),
				finish = i(0),
			}
		)
	),
})
