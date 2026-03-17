return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = { theme = "auto" },
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "filetype" },
				lualine_y = {
					{
						function()
							local wins = vim.api.nvim_tabpage_list_wins(0)
							-- filter out floating windows
							local count = 0
							for _, win in ipairs(wins) do
								if vim.api.nvim_win_get_config(win).relative == "" then
									count = count + 1
								end
							end
							if count > 1 then
								local current = vim.api.nvim_win_get_number(0)
								return "SPLIT " .. current .. "/" .. count
							end
							return ""
						end,
					},
				},
				lualine_z = { "location" },
			},
		})
	end,
}
