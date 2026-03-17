return {
	"vim-test/vim-test",
	dependencies = { "preservim/vimux" },
	config = function()
		vim.g["test#strategy"] = "vimux"
		vim.g["test#elixir#exunit#executable"] = "mix test"

		-- Parse test failures into quickfix list
		-- Run :copen after tests to jump between failures
		vim.api.nvim_create_autocmd("QuickFixCmdPost", {
			pattern = "*",
			callback = function()
				local qflist = vim.fn.getqflist()
				if #qflist > 0 then
					vim.cmd("copen")
				end
			end,
		})

		-- ExUnit error format: file:line
		vim.opt.errorformat:prepend("%f:%l: %m")
		vim.opt.errorformat:prepend("     %f:%l")
	end,
}
