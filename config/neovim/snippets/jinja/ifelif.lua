local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("jinja", {
	s(
		"ifelif",
		f(
			[[
{%- if <condition> %}
<truthy>
{%- elif <condition2> %}
<falsy>
{%- endif -%}<finish>
			]],
			{
				condition = i(1, "true"),
				condition2 = i(1, "true"),
				truthy = i(2, "{#- do something -#}"),
				falsy = i(3, "{#- do something else -#}"),
				finish = i(0),
			}
		)
	),
})
