return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
        transparent_background = true,
        transparent = true,
        color_overrides = {
            mocha = {
                rosewater = "#E8D5D0",
                flamingo  = "#D5A6A6",
                pink      = "#DBA8D4",
                mauve     = "#B07CC6",
                red       = "#E05A5A",
                maroon    = "#D4727A",
                peach     = "#D96A8C",
                yellow    = "#6CE5F0",
                green     = "#8FBF9A",
                teal      = "#8AC5C0",
                sky       = "#89B8D4",
                sapphire  = "#7EAAF0",
                blue      = "#7C6FE0",
                lavender  = "#C4A7E7",
                text      = "#D4D8F0",
                subtext1  = "#B8BDD0",
                subtext0  = "#A0A5B8",
                overlay2  = "#9399B2",
                overlay1  = "#7F849C",
                overlay0  = "#6C7086",
                surface2  = "#585B70",
                surface1  = "#45475A",
                surface0  = "#313244",
                base      = "#1E1E2E",
                mantle    = "#181825",
                crust     = "#11111B",
            },
        },
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
