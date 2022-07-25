local pipe    = require('f.function.pipe')
local to_path = require('util').parts_to_path

return {
	-- this one's a bit heavy, let's start it only when it's
	-- needed
	autostart = false,

	settings = {
		ltex = {
			language = 'auto',

			additionalRules = {
				enablePickyRules = true,
				languageModel    = pipe({
					vim.fn.stdpath('data'),
					'..',
					'languagetool',
				},
					to_path,
					vim.fn.expand
				)
			},
		},
	}
}
