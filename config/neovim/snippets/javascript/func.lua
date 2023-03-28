local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s
local c = snippet.choice_node
local t = snippet.text_node

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("javascript", {
	s(
		"func",
		f(
			[[
			const <name> = <async>(<params>) =>> {
				<body>
			}
			<finish>
			]],
			{
				name = i(1),
				async = c(2, {
					t(""),
					t("async "),
				}),
				params = i(3),
				body = i(4),
				finish = i(0),
			}
		)
	),
})
