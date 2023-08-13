return {
	settings = {
		Lua = {
			telemetry = {
				enable = false,
			},

			codeLens = {
				enable = true,
			},

			diagnostics = {
				enable = true,
			},

			hint = {
				enable = true,
				paramName = "Literal",
				setType = true,
			},
		},
	},

	on_init = function(client)
		local compat = require("compat")
		local path = client.workspace_folders[1].name

		if
			vim.loop.fs_stat(
				string.format("%s%s.luarc.json", path, compat.path_separator)
			)
			or vim.loop.fs_stat(
				string.format("%s%s.luarc.jsonc", path, compat.path_separator)
			)
		then
			return
		end

		local sx = require("stringx")
		local tx = require("tablex")

		local constant = require("f.function.constant")
		local ternary = require("f.function.ternary")

		local in_dotfiles = sx.endswith(path, "/scheatkode/dotfiles")
		local settings = tx.deep_extend("force", client.config.settings, {
			Lua = {
				diagnostics = {
					enable = true,
					-- Get the language server to recognize some globals.
					globals = ternary(
						in_dotfiles,
						constant({
							-- Neovim specific
							"vim",

							-- Busted specific
							"describe",
							"it",
							"before_each",
							"after_each",

							-- AwesomeWM specific
							"awesome",
							"client",
							"root",
							"screen",
						}),
						constant(nil)
					),
				},

				runtime = {
					version = "LuaJIT",
				},

				workspace = ternary(
					in_dotfiles,
					constant({ library = { vim.env.VIMRUNTIME } }),
					constant(nil)
				),
			},
		})

		client.notify(
			"workspace/didChangeConfiguration",
			{ settings = settings }
		)
	end,
}
