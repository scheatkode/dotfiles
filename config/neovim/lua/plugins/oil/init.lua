return {
	"stevearc/oil.nvim",

	keys = {
		"-",
	},

	opts = {
		columns = {
			"permissions",
			"size",
			"mtime",
			"icon",
		},

		skip_confirm_for_simple_edits = true,

		float = {
			border = "none",
		},

		use_default_keymaps = false,

		keymaps = {
			["g?"] = "actions.show_help",

			["<CR>"] = "actions.select",
			["<Esc>"] = "actions.close",
			["<C-c>"] = "actions.close",
			["q"] = "actions.close",

			["<M-v>"] = "actions.select_vsplit",
			["<M-s>"] = "actions.select_split",
			["<C-p>"] = "actions.preview",
			["<C-l>"] = "actions.refresh",

			["."] = "actions.open_cmdline",

			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["~"] = "actions.tcd",
			["H"] = "actions.toggle_hidden",

			["K"] = "actions.preview",
			["<C-b>"] = "actions.preview_scroll_up",
			["<C-f>"] = "actions.preview_scroll_down",
		},
	},

	config = function(_, opts)
		local oil = require("oil")

		oil.setup(opts)

		vim.keymap.set("n", "-", oil.open, {
			desc = "Toggle file explorer",
		})
	end,
}
