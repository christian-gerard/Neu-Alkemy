-- Restore cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local line_count = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Auto-compile Elixir projects so LSP formatters are loaded
local elixir_compiled = {}
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "elixir", "eelixir", "heex" },
	callback = function()
		local root = vim.fs.root(0, "mix.exs")
		if not root or elixir_compiled[root] then
			return
		end
		elixir_compiled[root] = true
		vim.notify("Compiling Elixir project...", vim.log.levels.INFO)
		vim.fn.jobstart("mix compile", {
			cwd = root,
			on_exit = function(_, code)
				if code == 0 then
					vim.schedule(function()
						vim.notify("Elixir project compiled.", vim.log.levels.INFO)
					end)
				else
					vim.schedule(function()
						vim.notify("mix compile failed (exit " .. code .. ")", vim.log.levels.WARN)
					end)
				end
			end,
		})
	end,
})
