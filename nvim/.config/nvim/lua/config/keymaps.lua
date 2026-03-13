local map = vim.keymap.set

-- General
map("n", "<leader>s", function()
	local ok, err = pcall(vim.lsp.buf.format)
	if not ok then
		local ft = vim.bo.filetype
		if ft == "elixir" or ft == "eelixir" or ft == "heex" then
			vim.notify("Format failed — compiling project and retrying...", vim.log.levels.INFO)
			local compile_result = vim.fn.system("mix compile")
			if vim.v.shell_error ~= 0 then
				vim.notify("mix compile failed:\n" .. compile_result, vim.log.levels.ERROR)
			else
				local ok2, err2 = pcall(vim.lsp.buf.format)
				if not ok2 then
					vim.notify("Format still failed after compile: " .. tostring(err2), vim.log.levels.WARN)
				end
			end
		else
			vim.notify("Formatting failed: " .. tostring(err), vim.log.levels.WARN)
		end
	end
	vim.cmd("w")
end, { desc = "Format + Save" })

map("n", "<leader>q", ":wqa<CR>", { desc = "Save All + Quit" })
map("n", "<leader>w", ":bd<CR>", { desc = "Close Buffer" })
map("i", "jk", "<Esc>", { noremap = true, silent = true })
map("v", "jk", "<Esc>", { noremap = true, silent = true })
map("t", "jk", "<C-\\><C-n>", { noremap = true, silent = true })

-- File Navigation
map("n", "<leader>b", ":Neotree toggle<CR>", { silent = true, desc = "Toggle Neo-Tree" })
map("n", "<leader>f", ":Telescope live_grep<CR>", { silent = true, desc = "Live Grep" })
map("n", "<leader>p", ":Telescope find_files<CR>", { silent = true, desc = "Find Files" })

-- Splits
map("n", "<leader>v", function()
	vim.cmd("vs")
	vim.cmd("wincmd l")
	vim.cmd("Telescope find_files")
end, { silent = true, desc = "Vertical Split + Find" })

map("n", "<leader>h", function()
	vim.cmd("split")
	vim.cmd("wincmd j")
	vim.cmd("Telescope find_files")
end, { silent = true, desc = "Horizontal Split + Find" })

-- Git
map("n", "<leader>gb", ":Git blame<CR>", { silent = true, desc = "Git Blame" })

-- Testing
local function find_test_file()
	local file = vim.fn.expand("%:p")
	if file:match("_test%.exs$") then
		return nil -- already a test file
	end
	-- user.ex -> user_test.exs (same directory)
	local test_file = file:gsub("%.ex$", "_test.exs")
	if vim.fn.filereadable(test_file) == 1 then
		return test_file
	end
	return nil
end

local function open_test_split_and_run(cmd)
	local test_file = find_test_file()
	if not test_file then
		vim.cmd(cmd)
		return
	end
	vim.cmd("vsplit " .. vim.fn.fnameescape(test_file))
	vim.cmd(cmd)
end

map("n", "<leader>t", function()
	open_test_split_and_run("TestNearest")
end, { silent = true, desc = "Test Nearest" })
map("n", "<leader>T", function()
	open_test_split_and_run("TestFile")
end, { silent = true, desc = "Test File" })
map("n", "<leader>x", ":TestSuite<CR>", { silent = true, desc = "Test Suite" })
