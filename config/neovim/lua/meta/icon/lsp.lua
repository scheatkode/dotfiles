local f = require("f")

local order = {
	"Text",
	"Method",
	"Function",
	"Constructor",
	"Field",
	"Variable",
	"Class",
	"Interface",
	"Module",
	"Property",
	"Unit",
	"Value",
	"Enum",
	"Keyword",
	"Snippet",
	"Color",
	"File",
	"Reference",
	"Folder",
	"EnumMember",
	"Constant",
	"Struct",
	"Event",
	"Operator",
	"TypeParameter",
}

local presets = {
	default = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "ﰠ",
		Variable = "",
		Class = "ﴯ",
		Interface = "",
		Module = "",
		Property = "ﰠ",
		Unit = "塞",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "פּ",
		Event = "",
		Operator = "",
		TypeParameter = "",
	},

	codicons = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "",
		Variable = "",
		Class = "",
		Interface = "",
		Module = "",
		Property = "",
		Unit = "",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Event = "",
		Operator = "",
		TypeParameter = "",
	},
}

local function setup(options)
	local with_text = (options == nil) or options.with_text

	local preset

	if not options or not options.preset then
		preset = "default"
	else
		preset = options.preset
	end

	local symbol_map = (
		options
		and options["symbol_map"]
		and vim.tbl_extend("force", presets[preset], options["symbol_map"])
	) or presets[preset]

	local symbols = {}
	local length = 25

	if with_text == true or with_text == nil then
		f.range(length):foreach(function(i)
			local name = order[i]
			local symbol = symbol_map[name]

			symbol = symbol and (symbol .. " ") or ""
			symbols[i] = symbol .. name
		end)
	else
		f.range(length):foreach(function(i)
			local name = order[i]

			symbols[i] = symbol_map[name]
		end)
	end

	f.iterate(symbols):foreach(function(k, v)
		require("vim.lsp.protocol").CompletionItemKind[k] = v
	end)
end

return {
	presets = presets,
	setup = setup,
}
