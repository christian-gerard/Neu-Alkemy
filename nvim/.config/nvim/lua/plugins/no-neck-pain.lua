return {
    "shortcuts/no-neck-pain.nvim",
    lazy = false,
    config = function()
        local neck_pain = require("no-neck-pain")
        neck_pain.setup()
    end,
}
