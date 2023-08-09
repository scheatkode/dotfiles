return function()
	local compat = require("compat")
	local pipe = require("f.function.pipe")
	local rpartial = require("f.function.rpartial")

	return {
		-- this one's a bit heavy, let's start it only when it's
		-- needed
		autostart = false,

		settings = {
			ltex = {
				language = "auto",

				additionalRules = {
					enablePickyRules = true,
					languageModel = pipe(
						{
							vim.fn.stdpath("data"),
							"..",
							"languagetool",
						},
						rpartial(table.concat, compat.path_separator),
						vim.fn.expand
					),
				},
			},
		},
	}
end
