return {
	setup = function()
		local has_bufdel, bufdel = pcall(require, 'bufdel')

		if not has_bufdel then
			print('‼ Tried loading bufdel ... unsuccessfully.')
			return has_bufdel
		end

		bufdel.setup({
			next = 'alternate',
			quit = false,
		})
	end
}
