local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmt

snippet.add_snippets("svelte", {
	s(
		"li",
		f([[<li>{content}</li>{finish}]], {
			content = i(1),
			finish = i(0),
		})
	),
})
