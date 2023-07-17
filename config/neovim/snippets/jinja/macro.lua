local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("jinja", {
	s(
		"macro",
		f(
			[[
{%- macro <name>(<arguments>) -%}
<body>
{%- endmacro -%}<finish>
			]],
			{
				name = i(1, "macro_name"),
				arguments = i(1, "args"),
				body = i(2, "{#- do something -#}"),
				finish = i(0),
			}
		)
	),
})
