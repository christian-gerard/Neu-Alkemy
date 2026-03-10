return {
	"vim-test/vim-test",
	dependencies = { "preservim/vimux" },
	config = function()
		vim.g["test#strategy"] = "vimux"
		vim.g["test#elixir#exunit#executable"] = "mix test"
	end,
}
