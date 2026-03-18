# Neovim Configuration

Modern Neovim setup with LSP, Treesitter, and a curated plugin ecosystem.

## Overview

This Neovim configuration provides a full-featured development environment with language server support, fuzzy finding, file exploration, and beautiful syntax highlighting. Built with Lazy.nvim for fast startup and efficient plugin management.

## Files

- `.config/nvim/` → `~/.config/nvim/` - Complete Neovim configuration
  - `init.lua` - Main configuration entry point
  - `lua/config/` - Core configuration (keymaps, options, autocmds)
  - `lua/plugins/` - Plugin specifications for Lazy.nvim
  - `lazy-lock.json` - Plugin version lockfile

## Key Features

- **🚀 Fast Startup**: Lazy-loaded plugins with Lazy.nvim
- **🔍 Fuzzy Finding**: Telescope for files, buffers, and live grep
- **🌳 File Explorer**: Neo-tree with git integration
- **🎨 Syntax Highlighting**: Treesitter with accurate parsing
- **🔧 LSP Integration**: Built-in language server support
- **🎯 Code Completion**: nvim-cmp with multiple sources
- **🌙 Beautiful Theme**: Catppuccin with transparency
- **⚡ Git Integration**: Gitsigns and Fugitive
- **🔀 Session Management**: Auto-session for project persistence

## Plugin Ecosystem

### Core Plugins
- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Modern plugin manager
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)** - File explorer
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting

### Language Support
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP client
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP installer
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Completion engine
- **[conform.nvim](https://github.com/stevearc/conform.nvim)** - Formatting

### UI & Theme
- **[catppuccin](https://github.com/catppuccin/nvim)** - Color scheme
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Status line
- **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim)** - Buffer tabs
- **[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)** - Indent guides

## Key Bindings

### Leader Key
- **Leader**: `<Space>`

### File Operations
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fr` - Recent files
- `<leader>e` - Toggle file explorer
- `<leader>w` - Save file
- `<leader>q` - Quit

### Navigation
- `<C-h/j/k/l>` - Navigate between windows
- `<S-h/l>` - Switch buffers
- `<leader>bd` - Delete buffer
- `<leader>bn` - New buffer

### Code Actions
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>f` - Format document

### Git Integration
- `<leader>gs` - Git status
- `<leader>gc` - Git commit
- `<leader>gp` - Git push
- `<leader>gl` - Git log
- `]c` / `[c` - Next/previous git hunk

### Search & Replace
- `/` - Search forward
- `?` - Search backward
- `<leader>sr` - Search and replace
- `<leader>sw` - Search word under cursor

## Language Server Setup

### Supported Languages
- **Lua**: lua_ls (Lua development)
- **TypeScript/JavaScript**: tsserver
- **Python**: pyright
- **Rust**: rust_analyzer
- **Go**: gopls
- **JSON**: jsonls
- **YAML**: yamlls
- **Bash**: bashls

### Adding New Language Servers
1. Install via Mason: `:Mason`
2. Configure in `lua/plugins/lsp.lua`:
```lua
lspconfig.new_language_server.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
```

## Customization

### Theme Configuration
Edit `lua/plugins/colorscheme.lua`:
```lua
require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  transparent_background = true,
  integrations = {
    telescope = true,
    neo_tree = true,
    -- Add more integrations
  },
})
```

### Adding Plugins
Create new files in `lua/plugins/`:
```lua
-- lua/plugins/my-plugin.lua
return {
  "author/plugin-name",
  config = function()
    require("plugin-name").setup({
      -- Plugin configuration
    })
  end,
}
```

### Custom Keymaps
Edit `lua/config/keymaps.lua`:
```lua
-- Custom keybinding
vim.keymap.set("n", "<leader>my", ":MyCommand<CR>", { desc = "My custom command" })
```

## Setup

1. **Install Neovim**:
   ```bash
   brew install neovim
   ```

2. **Stow configuration**:
   ```bash
   stow -d ~/Neu-Alkemy -t ~ nvim
   ```

3. **First launch**:
   ```bash
   nvim
   ```
   Lazy.nvim will automatically install all plugins.

4. **Install language servers**:
   ```
   :Mason
   ```
   Install desired language servers from the UI.

## Post-Setup

### Essential Commands
```vim
:Lazy sync          " Update plugins
:Mason              " Manage language servers
:checkhealth        " Verify installation
:Telescope          " Open fuzzy finder
:Neotree            " Open file explorer
```

### Health Check
```vim
:checkhealth telescope
:checkhealth treesitter
:checkhealth lsp
```

## Troubleshooting

### Plugin Issues
```vim
:Lazy clean         " Remove unused plugins
:Lazy sync          " Update all plugins
:Lazy log           " View plugin logs
```

### LSP Issues
```vim
:LspInfo            " Check LSP status
:LspRestart         " Restart language servers
:Mason              " Reinstall language servers
```

### Performance Issues
1. **Slow startup**: Check `:Lazy profile`
2. **High memory**: Disable unused plugins
3. **Treesitter errors**: `:TSUpdate` to update parsers

### Common Fixes
```bash
# Clear Neovim cache
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Reinstall everything
nvim --headless "+Lazy! sync" +qa
```

## File Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lazy-lock.json          # Plugin lockfile
└── lua/
    ├── config/
    │   ├── autocmds.lua    # Auto commands
    │   ├── keymaps.lua     # Key mappings
    │   └── options.lua     # Vim options
    └── plugins/
        ├── colorscheme.lua # Theme configuration
        ├── completion.lua  # Completion setup
        ├── editor.lua      # Editor enhancements
        ├── formatting.lua  # Code formatting
        ├── git.lua         # Git integration
        ├── lsp.lua         # Language servers
        ├── telescope.lua   # Fuzzy finder
        ├── treesitter.lua  # Syntax highlighting
        └── ui.lua          # UI components
```

## Integration

### With Tmux
- Seamless navigation between Neovim and tmux panes
- Shared clipboard integration
- Consistent key bindings

### With Git
- Gitsigns for inline git information
- Fugitive for git operations
- Telescope git integration

### With Terminal
- Built-in terminal support
- Floating terminal windows
- Shell integration

## Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim Guide](https://github.com/folke/lazy.nvim)
- [LSP Configuration](https://github.com/neovim/nvim-lspconfig)
- [Telescope Usage](https://github.com/nvim-telescope/telescope.nvim)