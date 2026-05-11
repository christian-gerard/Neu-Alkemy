-- Neu Alkemy palette — descriptive names for what each color actually is.
-- Mapped into catppuccin's fixed slot keys below.
local alkemy = {
    cream      = "#E8D5D0",
    rose       = "#D5A6A6",
    orchid     = "#DBA8D4",
    mauve      = "#B07CC6",
    crimson    = "#E05A5A",
    rosewood   = "#D4727A",
    coral      = "#D96AAA",
    aqua       = "#6CE5F0",
    sage       = "#8FBF9A",
    mint       = "#8AC5C0",
    steel      = "#89B8D4",
    cornflower = "#7EAAF0",
    indigo     = "#7C6FE0",
    lavender   = "#C4A7E7",
}

return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
        transparent_background = true,
        transparent = true,
        color_overrides = {
            -- catppuccin slot = alkemy color (slot keys are catppuccin's API)
            mocha = {
                rosewater = alkemy.cream,
                flamingo  = alkemy.rose,
                pink      = alkemy.orchid,
                mauve     = alkemy.mauve,
                red       = alkemy.crimson,
                maroon    = alkemy.rosewood,
                peach     = alkemy.coral,
                yellow    = alkemy.aqua,
                green     = alkemy.sage,
                teal      = alkemy.mint,
                sky       = alkemy.steel,
                sapphire  = alkemy.cornflower,
                blue      = alkemy.indigo,
                lavender  = alkemy.lavender,
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
