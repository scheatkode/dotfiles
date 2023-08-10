return {
	["lua"] = {
		adapter = function(callback, config)
			callback({
				type = "server",
				host = config.host or "127.0.0.1",
				port = config.port or 8086,
			})
		end,

		configuration = {
			{
				name = "Attach to running Neovim instance",
				request = "attach",
				type = "lua",
			},
		},
	},
}
