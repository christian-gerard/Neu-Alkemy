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
		vim.api.nvim_create_autocmd("BufEnter", {
			callback = function()
				if nnp_started then
					return
				end
				local ft = vim.bo.filetype
				local bt = vim.bo.buftype
				-- Skip dashboard and special buffers
				if ft == "dashboard" or ft == "" or bt ~= "" then
					return
				end
				nnp_started = true
				vim.schedule(function()
					vim.cmd("NoNeckPain")
				end)
			end,
		})

		-- Also handle case where nvim is opened directly with a file (no dashboard)
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				vim.schedule(function()
					if vim.bo.filetype ~= "dashboard" and vim.bo.buftype == "" and vim.fn.argc() > 0 then
						nnp_started = true
						vim.cmd("NoNeckPain")
					end
				end)
			end,
		})
	end,
}
