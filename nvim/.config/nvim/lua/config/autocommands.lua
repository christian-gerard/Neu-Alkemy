vim.cmd("let test#strategy = 'vimux'")

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd("Neotree toggle")
	end,
})
