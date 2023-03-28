local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("jinja", {
	s(
		"elif",
		f([[{%- elif <condition> %}<finish>]], {
			condition = i(1, "true"),
			finish    = i(0),
		})
	),
})
