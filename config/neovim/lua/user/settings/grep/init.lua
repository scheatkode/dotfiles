return {
	---Setup grepping behaviour.
	setup = function()
		if vim.fn.executable("rg") == 1 then
			vim.opt.grepprg =
				[[rg --glob "!.git" --no-heading --vimgrep --follow $*]]
			vim.opt.grepformat:prepend({ "%f:%l:%c:%m" })
		elseif vim.fn.executable("ag") == 1 then
			vim.opt.grepprg = [[ag --nogroup --nocolor --vimgrep]]
			vim.opt.grepformat:prepend({ "%f:%l:%c:%m" })
		end
	end,
}
