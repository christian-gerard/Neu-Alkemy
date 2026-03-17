return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		wk.setup({
			win = {
				border = "rounded",
			},
		})
		wk.add({
			{ "<leader>g", group = "Git" },
		})
	end,
}
