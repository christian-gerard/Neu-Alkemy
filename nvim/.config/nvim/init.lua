---@diagnostic disable: undefined-field
-- Install Lazy.Vim
local lazypath = vim.fn.stdpath("data") .. "/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazypath("--branch=stable"),
	})
end
vim.opt.rtp:prepend(lazypath)

-- Require
require("options")
require("config")
require("lazy").setup("plugins")
