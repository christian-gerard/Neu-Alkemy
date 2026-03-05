return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright" },
				automatic_enable = {
					exclude = { "elixirls" },
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config("lua_ls", {
				cmd = { "lua-language-server" },
				root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
				filetypes = { "lua" },
			})
			vim.lsp.enable("lua_ls")

			vim.lsp.config("pyright", {
				cmd = { "pyright-langserver", "--stdio" },
				root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
				filetypes = { "python" },
			})
			vim.lsp.enable("pyright")

			-- Expert LS (Elixir's official language server)
			vim.lsp.config("expert", {
				cmd = { "/Users/christiangerard/.local/bin/expert_darwin_arm64", "--stdio" },
				root_markers = { "mix.exs", ".git" },
				filetypes = { "elixir", "eelixir", "heex" },
			})
			vim.lsp.enable("expert")

			-- Disable elixirls to avoid conflict with expert
			vim.lsp.enable("elixirls", false)
		end,
	},
}
