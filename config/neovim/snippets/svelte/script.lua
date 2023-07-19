local snippet = require("luasnip")

local i = snippet.insert_node
local s = snippet.s

local f = require("luasnip.extras.fmt").fmt

snippet.add_snippets("svelte", {
	s(
		"script",
		f(
			[[
			<script lang="ts">
				{finish}
			</script>
			]],
			{
				finish = i(0),
			}
		)
	),
})
