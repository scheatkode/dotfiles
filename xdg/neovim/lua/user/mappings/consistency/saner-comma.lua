return {
	---saner behavior of ; and , (search character forward and
	---backward, respectively)
	setup = function()
		local function search(forward)
			return function()
				return vim.fn.getcharsearch().forward == forward and ';' or ','
			end
		end

		vim.keymap.set({ 'n', 'x', 'o' }, ':', search(1), { expr = true })
		vim.keymap.set({ 'n', 'x', 'o' }, ',', search(0), { expr = true })
	end
}
