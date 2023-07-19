local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmt

snippet.add_snippets("svelte", {
	s(
		"p",
		f(
			[[
			<p>
				{finish}
			</p>
			]],
			{
				finish = i(0),
			}
		)
	),
})
