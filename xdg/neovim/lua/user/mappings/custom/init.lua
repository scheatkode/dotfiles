return {
	setup = function()
		require('user.mappings.custom.alternate').setup()
		require('user.mappings.custom.autocorrect').setup()
		require('user.mappings.custom.buffers').setup()
		require('user.mappings.custom.command').setup()
		require('user.mappings.custom.escape').setup()
		require('user.mappings.custom.highlight').setup()
		require('user.mappings.custom.jumplist').setup()
		require('user.mappings.custom.lines').setup()
		require('user.mappings.custom.macro').setup()
		require('user.mappings.custom.modifiers').setup()
		require('user.mappings.custom.path').setup()
		require('user.mappings.custom.resize').setup()
		require('user.mappings.custom.shame').setup()
		require('user.mappings.custom.tabs').setup()
		require('user.mappings.custom.visual').setup()
	end
}
