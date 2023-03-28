return {
	setup = function()
		require("lualine").setup({
			options = {
				always_divide_middle = true,
				component_separators = { left = " ", right = " " },
				icons_enabled = true,
				section_separators = { left = " ", right = " " },
				theme = require("lualine.themes.gruvbox_dark"),
				disabled_filetypes = {
					statusline = {
						"dapui_breakpoints",
						"dapui_scopes",
						"dapui_stacks",
						"dapui_watches",
					},
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})
	end,
}
