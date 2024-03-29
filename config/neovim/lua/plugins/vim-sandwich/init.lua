return {
	"machakann/vim-sandwich",

	keys = {
		{ "<leader>sa", mode = { "n", "x" } },
		{ "<leader>ts", mode = { "n", "x" } },
		{ "<leader>tsa", mode = { "n", "x" } },
		{ "<leader>tsc", mode = { "n", "x" } },
		{ "<leader>tsC", mode = { "n", "x" } },
		{ "<leader>tsd", mode = { "n", "x" } },
		{ "<leader>tsD", mode = { "n", "x" } },
	},

	init = function()
		vim.g.sandwich_no_default_key_mappings = 1
	end,

	config = function()
		vim.keymap.set(
			{ "n", "x" },
			"<leader>tsa",
			"<Plug>(operator-sandwich-add)",
			{
				remap = true,
				desc = "Add surrounding character",
			}
		)

		vim.keymap.set(
			{ "n", "x" },
			"<leader>sa",
			"<Plug>(operator-sandwich-add)",
			{
				remap = true,
				desc = "Add surrounding character",
			}
		)

		vim.keymap.set(
			"n",
			"<leader>tsd",
			"<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)",
			{ remap = true, desc = "Delete surrounding character" }
		)
		vim.keymap.set(
			"n",
			"<leader>tsD",
			"<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)",
			{ remap = true, desc = "Delete surrounding character automatically" }
		)
		vim.keymap.set(
			"n",
			"<leader>tsc",
			"<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)",
			{ remap = true, desc = "Change surrounding character" }
		)
		vim.keymap.set(
			"n",
			"<leader>tsC",
			"<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)",
			{ remap = true, desc = "Change surrounding character automatically" }
		)

		vim.keymap.set({ "x", "o" }, "is", "<Plug>(textobj-sandwich-query-i)", {
			remap = true,
			desc = "Select inside surrounding character",
		})
		vim.keymap.set({ "x", "o" }, "as", "<Plug>(textobj-sandwich-query-a)", {
			remap = true,
			desc = "Select around surrounding character",
		})
		vim.keymap.set({ "x", "o" }, "iS", "<Plug>(textobj-sandwich-auto-i)", {
			remap = true,
			desc = "Select inside surrounding character automatically",
		})
		vim.keymap.set({ "x", "o" }, "aS", "<Plug>(textobj-sandwich-auto-a)", {
			remap = true,
			desc = "Select around surrounding character automatically",
		})
		vim.keymap.set(
			{ "x", "o" },
			"im",
			"<Plug>(textobj-sandwich-literal-query-i)",
			{
				remap = true,
				desc = "Select inside surrounding character literally",
			}
		)
		vim.keymap.set(
			{ "x", "o" },
			"am",
			"<Plug>(textobj-sandwich-literal-query-a)",
			{
				remap = true,
				desc = "Select around surrounding character literally",
			}
		)
	end,
}
