local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("jinja", {
	s(
		"set",
		f([[{%- set <variable> = <value> -%}<finish>]], {
			variable = i(1, "variable"),
			value = i(2, "value"),
			finish = i(0),
		})
	),
})
