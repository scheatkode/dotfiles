return {
	setup = function()
		local neorg = require("neorg")

		neorg.setup({
			load = {
				["core.defaults"] = {},

				["core.esupports.metagen"] = {
					config = {
						type = "auto",
					},
				},

				["core.esupports.indent"] = {
					config = {
						format_on_enter = false,
						format_on_escape = false,
					},
				},

				["core.concealer"] = {
					config = {
						icons = {
							heading = {
								level_1 = { enabled = true, icon = "█" },
								level_2 = { enabled = true, icon = "██" },
								level_3 = { enabled = true, icon = "███" },
								level_4 = { enabled = true, icon = "████" },
								level_5 = { enabled = true, icon = "█████" },
								level_6 = {
									enabled = true,
									icon = "██████",
								},
							},
							todo = {
								enable = true,
								pending = {
									icon = "",
								},
								uncertain = {
									icon = "?",
								},
								urgent = {
									icon = "",
								},
								on_hold = {
									icon = "",
								},
								cancelled = {
									icon = "",
								},
							},
						},
					},
				},

				["core.journal"] = {
					config = {
						workspace = "brain",
						journal_folder = "journal",
					},
				},

				["core.keybinds"] = {
					config = {
						default_keybinds = false,
						neorg_leader = "<leader>o",
					},
				},

				["core.dirman"] = {
					config = {
						workspaces = {
							brain = "~/brain",
						},
					},
				},

				["core.qol.toc"] = {
					config = {
						close_split_on_jump = false,
						toc_split_placement = "right",
					},
				},

				["core.export"] = {},
				["core.export.markdown"] = {},
			},
		})
	end,
}
