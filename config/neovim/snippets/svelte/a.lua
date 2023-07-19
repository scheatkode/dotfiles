local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmt

snippet.add_snippets("svelte", {
	s(
		"a",
		f([[<a href="{href}">{content}</a>{finish}]], {
			href = i(1),
			content = i(2),
			finish = i(0),
		})
	),
})
