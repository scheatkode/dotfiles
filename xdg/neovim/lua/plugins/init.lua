return {
	---schedule plugin loading to a later time, that is when
	---neovim finishes starting
	setup = vim.schedule_wrap(require('plugins.manager').setup)
}
