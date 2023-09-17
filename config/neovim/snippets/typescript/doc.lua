local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmta

snippet.add_snippets("typescript", {
	s(
		"doc",
		f(
			[[
			/**
			 * <body>
			 */<finish>
			]],
			{
				body = i(1),
				finish = i(0),
			}
		)
	),
})
