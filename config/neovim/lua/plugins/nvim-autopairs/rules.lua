return {
	setup = function()
		local pairs = require("nvim-autopairs")
		local cond = require("nvim-autopairs.conds")
		local rule = require("nvim-autopairs.rule")

		local rules = {}

		-- additional `%` rule for tagged templates, i.e. `{%%}`
		rules[#rules + 1] = rule("%", "%", {
			"jinja",
			"sls",
			"sls.yaml",
			"yaml",
		})

		-- remove spaces between brackets
		rules[#rules + 1] = rule("[ ", " ]")
			:with_pair(cond.none())
			:with_move(function(options)
				return options.prev_char:match(".%]") ~= nil
			end)
			:use_key("]")

		pairs.add_rules(rules)
	end,
}
