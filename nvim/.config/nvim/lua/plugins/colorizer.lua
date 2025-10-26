return {
	"NvChad/nvim-colorizer.lua",
	event = "VeryLazy", -- loads when idle, lazy-load style
	opts = {},
	config = function(_, opts)
		require("colorizer").setup(nil, opts)
	end,
}
