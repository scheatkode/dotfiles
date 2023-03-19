return {
	---Disable `vi` compatibility. I only ever use it rarely in
	---some remote servers I don't personally manage either way.
	setup = function()
		vim.opt.compatible = false
	end,
}
