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
								icons = {
									"█",
									"█",
									"█",
									"█",
									"█",
									"█",
								},
							},
							todo = {
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
						default_keybinds = true,
						neorg_leader = "<localleader>",
					},
				},

				["core.dirman"] = {
					config = {
						workspaces = {
							brain = "~/brain/agenda",
						},
					},
				},

				["core.itero"] = {
					config = {},
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
