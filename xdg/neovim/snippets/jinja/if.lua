local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("jinja", {
	s(
		"if",
		f(
			[[
{%- if <condition> %}
<body>
{%- endif -%}<finish>
			]],
			{
				condition = i(1, "true"),
				body = i(2, "{#- do something -#}"),
				finish = i(0),
			}
		)
	),
})
