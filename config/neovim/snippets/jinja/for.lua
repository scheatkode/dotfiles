local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("jinja", {
	s(
		"for",
		f(
			[[
{%- for <item> in <list> %}
<body>
{%- endfor %}<finish>
			]],
			{
				item = i(1, "item"),
				list = i(2, "list"),
				body = i(3, "{#- do something -#}"),
				finish = i(0),
			}
		)
	),
})
