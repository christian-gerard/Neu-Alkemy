return {
	"NickvanDyke/opencode.nvim",
	dependencies = {
		-- Recommended for `ask()` and `select()`.
		-- Required for default `toggle()` implementation.
		{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
	},
	config = function()
		---@type opencode.Opts
		vim.g.opencode_opts = {
			-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
		}

		-- Required for `opts.auto_reload`.
		vim.o.autoread = true

		-- Recommended/example keymaps.
		vim.keymap.set({ "n", "x" }, "<leader>ol", function()
			require("opencode").ask("@this: ", { submit = true })
		end, { desc = "Ask opencode" })
		vim.keymap.set({ "n", "x" }, "<leader>oe", function()
			require("opencode").select()
		end, { desc = "Execute opencode action…" })
		vim.keymap.set({ "n", "x" }, "<leader>oa", function()
			require("opencode").prompt("@this")
		end, { desc = "Add to opencode" })
		vim.keymap.set({ "n", "t" }, "<C-x>", function()
			require("opencode").toggle()
		end, { desc = "Toggle opencode" })
		vim.keymap.set("n", "+", "<leader>o=", { desc = "Increment", noremap = true })
		vim.keymap.set("n", "-", "<leader>o-", { desc = "Decrement", noremap = true })
	end,
}
