local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("jinja", {
	s(
		"else",
		f([[{%- else %}<finish>]], {
			finish = i(0),
		})
	),
})
