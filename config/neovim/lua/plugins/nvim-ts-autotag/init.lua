return {
	"windwp/nvim-ts-autotag",

	ft = {
		"html",
		"javascript",
		"javascriptreact",
		"jsx",
		"rescript",
		"svelte",
		"tsx",
		"typescript",
		"typescriptreact",
		"vue",
		"xml",
	},

	config = function()
		require("nvim-ts-autotag").setup()
	end,
}
