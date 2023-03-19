return {
	setup = function()
		require("user.mappings.navigation.insert").setup()
		require("user.mappings.navigation.inline").setup()
		require("user.mappings.navigation.move").setup()
		require("user.mappings.navigation.screen").setup()
		require("user.mappings.navigation.wezterm").setup()
	end,
}
