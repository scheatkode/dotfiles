return {
	---Setup spellcheck behaviour.
	setup = function()
		vim.opt.spellsuggest:prepend({ 12 }) -- Max number of suggestions
		vim.opt.spelloptions  = 'camel' -- Assume camel case words as separate
		vim.opt.spellcapcheck = '' -- Don't check for capital letters beginning sentences
		vim.opt.langmenu      = 'en' -- English as the default language
	end
}
