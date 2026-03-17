return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",
				numbers = "ordinal",
				diagnostics = "nvim_lsp",
				separator_style = "thick",
				show_buffer_close_icons = false,
				show_close_icon = false,
				always_show_bufferline = true,
				indicator = {
					style = "underline",
				},
				name_formatter = function(buf)
					local path = vim.fn.fnamemodify(buf.path, ":p:h:t")
					local filename = vim.fn.fnamemodify(buf.path, ":t")
					return path .. "/" .. filename
				end,
			},
		})
	end,
}
