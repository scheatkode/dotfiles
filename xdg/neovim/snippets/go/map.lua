local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("go", {
	s(
		"map",
		f([[map[<key>]<value><finish>]], {
			key = i(1, "type"),
			value = i(2, "type"),
			finish = i(0),
		})
	),
})
