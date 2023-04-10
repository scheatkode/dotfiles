------------------------ the plumbing and the porcelain ------------------------
---------------------------------- xkcd #1597 ----------------------------------
--        _____
--       /      \
--      (____/\  )
--       |___  U?(____
--       _\L.   |      \     ___
--     / /"""\ /.-'     |   |\  |
--    ( /  _/u     |    \___|_)_|
--     \|  \\      /   / \_(___ __)
--      |   \\    /   /  |  |    |
--      |    )  _/   /   )  |    |
--      _\__/.-'    /___(   |    |
--   _/  __________/     \  |    |
--  //  /  (              ) |    |
-- ( \__|___\    \______ /__|____|
--  \    (___\   |______)_/
--   \   |\   \  \     /
--    \  | \__ )  )___/
--     \  \  )/  /__(    contemplation or constipation ?
-- ___ |  /_//___|   \_________
--   _/  ( /          \
--  `----'(____________)

return {
	"lewis6991/gitsigns.nvim",

	event = {
		"BufReadPost",
		"FileReadPre",
	},

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	opts = {
		signs = {
			add = { text = "┃" },
			change = { text = "┣" },
			delete = { text = "┻" },
			topdelete = { text = "┳" },
			changedelete = { text = "╋" },
			untracked = { text = "┃" },
		},

		on_attach = function(bufnr)
			local gs = require("gitsigns")

			-- navigation
			vim.keymap.set("n", "]h", function()
				vim.schedule(gs.next_hunk)
			end, {
				buffer = bufnr,
			})
			vim.keymap.set("n", "[h", function()
				vim.schedule(gs.prev_hunk)
			end, {
				buffer = bufnr,
			})

			-- actions
			vim.keymap.set({ "n", "v" }, "<leader>gs", gs.stage_hunk, {
				buffer = bufnr,
			})
			vim.keymap.set({ "n", "v" }, "<leader>gr", gs.reset_hunk, {
				buffer = bufnr,
			})
			vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, {
				buffer = bufnr,
			})
			vim.keymap.set("n", "<leader>gS", gs.stage_buffer, {
				buffer = bufnr,
			})
			vim.keymap.set("n", "<leader>gR", gs.reset_buffer, {
				buffer = bufnr,
			})
			vim.keymap.set("n", "<leader>gp", gs.preview_hunk, {
				buffer = bufnr,
			})
			vim.keymap.set("n", "<leader>gb", function()
				gs.blame_line({ full = true })
			end, {
				buffer = bufnr,
			})
			vim.keymap.set("n", "<leader>gB", gs.toggle_current_line_blame, {
				buffer = bufnr,
			})
			vim.keymap.set("n", "<leader>gd", gs.diffthis, {
				buffer = bufnr,
			})
			vim.keymap.set("n", "<leader>gD", function()
				gs.diffthis("~")
			end, {
				buffer = bufnr,
			})

			-- text object
			vim.keymap.set({ "o", "x" }, "ih", gs.select_hunk, {
				buffer = bufnr,
			})
		end,

		linehl = false,
		numhl = false,

		watch_gitdir = {
			interval = 1000,
		},

		update_debounce = 100,

		sign_priority = 6,
		status_formatter = nil,

		diff_opts = {
			internal = true,
		},
	},
}
