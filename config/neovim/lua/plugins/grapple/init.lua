return {
	"cbochs/grapple.nvim",

	keys = {
		"<leader>h",
		"<leader>hh",
		"<leader>ha",
		"<leader>hn",
		"<leader>hp",
		"<leader>h1",
		"<leader>h2",
		"<leader>h3",
		"<leader>h4",
		"<leader>h5",
		"<leader>h6",
		"<leader>h7",
		"<leader>h8",
		"<leader>h9",
	},

	config = function(_, opts)
		local grapple = require("grapple")

		grapple.setup(opts)

		local function nav_file(n)
			return function()
				grapple.select({ key = n })
			end
		end

		vim.keymap.set("n", "<leader>hh", grapple.popup_tags, {
			desc = "Open the grappling window",
		})

		vim.keymap.set("n", "<leader>ha", grapple.tag, {
			desc = "Add a grappling anchor",
		})

		vim.keymap.set("n", "<leader>hd", grapple.untag, {
			desc = "Delete the current grappling anchor",
		})

		vim.keymap.set("n", "<leader>hq", grapple.quickfix, {
			desc = "List the stored grappling anchors in the quickfix window",
		})

		for i = 1, 9 do
			vim.keymap.set("n", string.format("<leader>h%d", i), nav_file(i), {
				desc = string.format("Grapple to file %d", i),
			})
		end
	end,

	opts = {
		popup_options = {
			border = "none",
		},
	},
}
