return {
	"shortcuts/no-neck-pain.nvim",
	lazy = false,
	config = function()
		require("no-neck-pain").setup({
			width = 160,
			autocmds = {
				enableOnVimEnter = false,
			},
		})

		-- Enable NoNeckPain after dashboard closes (when a real file buffer is entered)
		local nnp_started = false
	end,
}
