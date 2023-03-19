local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s
local c = snippet.choice_node
local t = snippet.text_node

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("javascript", {
	s(
		"fun",
		f(
			[[
			<async>function<gen> <name>(<params>) {
				<finish>
			}
			]],
			{
				async = c(1, {
					t(""),
					t("async "),
				}),
				gen = c(2, {
					t(""),
					t("*"),
				}),
				name = i(3),
				params = i(4),
				finish = i(0),
			}
		)
	),
})
