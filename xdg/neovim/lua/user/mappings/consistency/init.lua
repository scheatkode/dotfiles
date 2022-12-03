return {
	---
	setup = function()
		require('user.mappings.consistency.command').setup()
		require('user.mappings.consistency.macro').setup()
		require('user.mappings.consistency.jumplist').setup()
		require('user.mappings.consistency.marks').setup()
		require('user.mappings.consistency.quickfix').setup()
		require('user.mappings.consistency.saner-comma').setup()
		require('user.mappings.consistency.saner-n').setup()
		require('user.mappings.consistency.saner-halfpage').setup()
		require('user.mappings.consistency.selection-indent').setup()
		require('user.mappings.consistency.shell').setup()
		require('user.mappings.consistency.refresh').setup()
	end
}
