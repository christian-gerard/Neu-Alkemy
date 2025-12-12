------------------------------------
---  >> >> >> KEYMAPS << << <<   ---
------------------------------------
---
---
---------------
-- >>  VIM
---------------
---
vim.g.mapleader = " "
local map = vim.keymap.set -- Shorten function call for easier mapping
vim.keymap.set("n", "<leader>s", function()
	-- Attempt to format, but don't let errors stop saving
	local ok, err = pcall(function()
		vim.lsp.buf.format()
	end)

	if not ok then
		vim.notify("Formatting failed: " .. tostring(err), vim.log.levels.WARN)
	end

	-- Always save the file
	vim.cmd("w")
end, { desc = "Save & Format file" })

map("n", "<leader>q", ":wqa<CR>", { desc = "Save & Exit" })
map("n", "<leader>w", ":bd<CR>", { desc = "Save & Exit" })
map("i", "jk", "<Esc>", { noremap = true, silent = true }) -- Exit insert mode with 'jk'
map("v", "jk", "<Esc>", { noremap = true, silent = true }) -- Exit visual mode with 'jk'
map("t", "jk", "<C-\\><C-n>", { noremap = true, silent = true }) -- Exit terminal mode with 'jk'
---
---------------
-- >>  FILE NAV
---------------
---
map("n", "<leader>b", ":Neotree toggle<CR>", { noremap = true, silent = true, desc = "Toggle Neo-Tree" })

map("n", "<leader>f", ":Telescope live_grep<CR>", { noremap = true, silent = true, desc = "Live Grep Files" })
map("n", "<leader>p", ":Telescope find_files<CR>", { noremap = true, silent = true, desc = "Find Files" })
---
---------------
-- >>   BUFFERS / TABS
---------------
---
--- >> Split Window - Vertical
map("n", "<leader>v", function()
	vim.cmd("vs")
	vim.cmd("wincmd l")
	vim.cmd("Telescope find_files")
end, { noremap = true, silent = true, desc = "Split Window Vertical" })
---
-- >> Split Window - Horizontal
map("n", "<leader>h", function()
	vim.cmd("split")
	vim.cmd("wincmd j")
	vim.cmd("Telescope find_files")
end, { noremap = true, silent = true, desc = "Split Window Horizontal" })
---------------
-- >>  GIT
---------------
---
map("n", "<leader>gb", ":Git blame<CR>", { noremap = true, silent = true, desc = "Git Blame" })
---
---------------
-- >>  TESTING
---------------
---
map("n", "<leader>t", function()
	vim.cmd("TestNearest")
end, { noremap = true, silent = true, desc = "Test Closest" })
map("n", "<leader>T", ":TestFile<CR>", { noremap = true, silent = true, desc = "Test File" })
map("n", "<leader>x", ":TestSuite<CR>", { noremap = true, silent = true, desc = "Test All" })
---
