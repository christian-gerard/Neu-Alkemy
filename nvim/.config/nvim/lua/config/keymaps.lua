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

map("n", "<leader><Esc>", ":wqa<CR>", { desc = "Save & Exit" })
map("n", "<leader>w", ":q<CR>", { desc = "Save & Exit" })
map("i", "jk", "<Esc>", { noremap = true, silent = true }) -- Exit insert mode with 'jk'
map("v", "jk", "<Esc>", { noremap = true, silent = true }) -- Exit visual mode with 'jk'
map("t", "jk", "<C-\\><C-n>", { noremap = true, silent = true }) -- Exit terminal mode with 'jk'
---
---------------
-- >>  FILE NAV
---------------
---
map("n", "<leader>b", ":Neotree toggle<CR>", { noremap = true, silent = true, desc = "Toggle Neo-Tree" })
map("n", "<leader>g", ":Neotree git_status<CR>", { noremap = true, silent = true, desc = "Show Git status" })

map("n", "<leader>f", ":Telescope live_grep<CR>", { noremap = true, silent = true, desc = "Live Grep Files" })
map("n", "<leader>p", ":Telescope find_files<CR>", { noremap = true, silent = true, desc = "Find Files" })
---
---------------
-- >>   BUFFERS / TABS
---------------
map("n", "<leader>ts", ":tab split<CR>", { noremap = true, silent = true, desc = "Tab Split" })
map("n", "<leader>tl", ":tabNext<CR>", { noremap = true, silent = true, desc = "Tab Next" })
map("n", "<leader>th", ":tabprevious<CR>", { noremap = true, silent = true, desc = "Tab Previous" })
---
--- >> Split Window - Vertical
map("n", "<leader>v", function()
	vim.cmd("vs")
	vim.cmd("wincmd l")
end, { noremap = true, silent = true, desc = "Split Window Vertical" })
---
-- >> Split Window - Horizontal
map("n", "<leader>h", function()
	vim.cmd("split")
	vim.cmd("wincmd j")
end, { noremap = true, silent = true, desc = "Split Window Horizontal" })
---------------
-- >>  GIT
---------------
---
map("n", "<leader>gb", ":Git blame<CR>", { noremap = true, silent = true, desc = "Git Blame" })
map("n", "<leader>gl", ":Git blame_line<CR>", { noremap = true, silent = true, desc = "Git Blame_Line" })
---
---------------
-- >>  TESTING
---------------
---
map("n", "<leader>r", function()
	vim.cmd("TestNearest")
end, { noremap = true, silent = true, desc = "Test Closest" })
map("n", "<leader>R", ":TestFile<CR>", { noremap = true, silent = true, desc = "Test File" })
map("n", "<leader>a", ":TestSuite<CR>", { noremap = true, silent = true, desc = "Test All" })
---
