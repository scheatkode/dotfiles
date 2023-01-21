----------------------------------------------------------------
--              ░█▀▀░█▀▀░▀█▀░▀█▀░▀█▀░█▀█░█▀▀░█▀▀              --
--              ░▀▀█░█▀▀░░█░░░█░░░█░░█░█░█░█░▀▀█              --
--              ░▀▀▀░▀▀▀░░▀░░░▀░░▀▀▀░▀░▀░▀▀▀░▀▀▀              --
----------------------------------------------------------------

return {
	setup = function()
		require('user.settings.compat').setup()
		require('user.settings.interface').setup()
		require('user.settings.files').setup()
		require('user.settings.timing').setup()
		require('user.settings.buffers').setup()
		require('user.settings.diff').setup()
		require('user.settings.format').setup()
		require('user.settings.fold').setup()
		require('user.settings.grep').setup()
		require('user.settings.lines').setup()
		require('user.settings.indent').setup()
		require('user.settings.search').setup()
		require('user.settings.spell').setup()
		require('user.settings.misc').setup()
		require('user.settings.backup').setup()
		require('user.settings.wrap').setup()
		require('user.settings.menus').setup()
	end
}
