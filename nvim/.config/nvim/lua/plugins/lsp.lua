return {
    {
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup()
    end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "elixirls", "pyright" }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.pyright.setup({})
            lspconfig.elixirls.setup({
                cmd = { "/Users/christiangerard/.elixir-ls/release/language_server.sh" },
              settings = {
                elixirLS = {
                  dialyzerEnabled = false, -- Optional: speeds up startup
                  fetchDeps = false -- Optional: avoids unnecessary fetches
                }
              }
            })
        end
    }
}
