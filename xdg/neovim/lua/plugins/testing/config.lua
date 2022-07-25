local function setup()
	require('neotest').setup({
		adapters = {
			require('neotest-plenary'),
		}
	})
end

return {
	setup = setup
}
