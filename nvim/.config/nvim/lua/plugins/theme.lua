return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
        transparent_background = true, -- keep this
        transparent = true,      -- add this for compatibility
    },
    config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd.colorscheme("catppuccin")

        -- Make Telescope windows transparent
        local transparent = { bg = "NONE" }
        vim.api.nvim_set_hl(0, "TelescopeNormal", transparent)
        vim.api.nvim_set_hl(0, "TelescopeBorder", transparent)
        vim.api.nvim_set_hl(0, "TelescopePromptNormal", transparent)
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", transparent)
        vim.api.nvim_set_hl(0, "TelescopeResultsNormal", transparent)
        vim.api.nvim_set_hl(0, "TelescopeResultsBorder", transparent)
        vim.api.nvim_set_hl(0, "TelescopePreviewNormal", transparent)
        vim.api.nvim_set_hl(0, "TelescopePreviewBorder", transparent)
    end,
}
