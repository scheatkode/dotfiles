return {
	setup = function()
		local gitsigns = require("gitsigns")

		gitsigns.setup({
			signs = {
				add = { text = "┃" },
				change = { text = "┣" },
				delete = { text = "┻" },
				topdelete = { text = "┳" },
				changedelete = { text = "╋" },
				untracked = { text = "┃" },
			},

			on_attach = function(bufnr)
				-- navigation
				vim.keymap.set("n", "]h", function()
					vim.schedule(gitsigns.next_hunk)
				end, {
					buffer = bufnr,
				})
				vim.keymap.set("n", "[h", function()
					vim.schedule(gitsigns.prev_hunk)
				end, {
					buffer = bufnr,
				})

				-- actions
				vim.keymap.set({ "n", "v" }, "<leader>gs", gitsigns.stage_hunk, {
					buffer = bufnr,
				})
				vim.keymap.set({ "n", "v" }, "<leader>gr", gitsigns.reset_hunk, {
					buffer = bufnr,
				})
				vim.keymap.set("n", "<leader>gu", gitsigns.undo_stage_hunk, {
					buffer = bufnr,
				})
				vim.keymap.set("n", "<leader>gS", gitsigns.stage_buffer, {
					buffer = bufnr,
				})
				vim.keymap.set("n", "<leader>gR", gitsigns.reset_buffer, {
					buffer = bufnr,
				})
				vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, {
					buffer = bufnr,
				})
				vim.keymap.set("n", "<leader>gb", function()
					gitsigns.blame_line({ full = true })
				end, {
					buffer = bufnr,
				})
				vim.keymap.set(
					"n",
					"<leader>gB",
					gitsigns.toggle_current_line_blame,
					{
						buffer = bufnr,
					}
				)
				vim.keymap.set("n", "<leader>gd", gitsigns.diffthis, {
					buffer = bufnr,
				})
				vim.keymap.set("n", "<leader>gD", function()
					gitsigns.diffthis("~")
				end, {
					buffer = bufnr,
				})

				-- text object
				vim.keymap.set({ "o", "x" }, "ih", gitsigns.select_hunk, {
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
		})
	end,
}
