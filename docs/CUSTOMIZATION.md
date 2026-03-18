# Customization Guide

Learn how to customize and extend the Neu-Alkemy dotfiles to fit your workflow.

## Philosophy

The Neu-Alkemy dotfiles are designed to be:
- **Modular**: Each package can be customized independently
- **Consistent**: Unified theme across all tools
- **Extensible**: Easy to add new tools and configurations
- **Personal**: Adaptable to individual preferences

## Theme Customization

### Changing Color Schemes

The dotfiles use **Catppuccin Mocha** by default. To change themes:

#### 1. Global Theme Change
```bash
# Available Catppuccin variants: Latte, Frappé, Macchiato, Mocha
THEME="macchiato"  # Change this

# Update each tool's theme
# Neovim: ~/.config/nvim/lua/plugins/colorscheme.lua
# Tmux: ~/.tmux.conf
# Ghostty: ~/.config/ghostty/config
# Starship: ~/.config/starship.toml
```

#### 2. Custom Color Palette
Create your own theme by modifying color values:

**Neovim** (`~/.config/nvim/lua/plugins/colorscheme.lua`):
```lua
require("catppuccin").setup({
  color_overrides = {
    mocha = {
      base = "#1e1e2e",      -- Background
      text = "#cdd6f4",      -- Foreground
      blue = "#89b4fa",      -- Accent
      -- Add your custom colors
    },
  },
})
```

**Tmux** (`~/.tmux.conf`):
```bash
# Custom status bar colors
set -g @catppuccin_window_current_fill "number"
set -g @catppuccin_window_current_color "#{thm_blue}"
```

**Ghostty** (`~/.config/ghostty/config`):
```ini
# Custom colors
background = 1e1e2e
foreground = cdd6f4
cursor-color = f5e0dc
```

### Creating Theme Variants

1. **Create theme directory**:
   ```bash
   mkdir themes/my-theme
   ```

2. **Copy base theme**:
   ```bash
   cp -r themes/neu-alkemy/* themes/my-theme/
   ```

3. **Modify colors** in each tool's config

4. **Apply theme**:
   ```bash
   stow -d themes -t ~/.config my-theme
   ```

## Package Customization

### Neovim

#### Adding Plugins
Edit `~/.config/nvim/lua/plugins/` and create new plugin files:

```lua
-- ~/.config/nvim/lua/plugins/my-plugin.lua
return {
  "author/plugin-name",
  config = function()
    require("plugin-name").setup({
      -- Plugin configuration
    })
  end,
}
```

#### Custom Keybindings
Edit `~/.config/nvim/lua/config/keymaps.lua`:

```lua
-- Custom keybindings
vim.keymap.set("n", "<leader>my", ":MyCommand<CR>", { desc = "My custom command" })
```

#### LSP Configuration
Add language servers in `~/.config/nvim/lua/plugins/lsp.lua`:

```lua
-- Add new language server
lspconfig.my_language_server.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
```

### Tmux

#### Custom Key Bindings
Edit `~/.tmux.conf`:

```bash
# Custom bindings
bind-key r source-file ~/.tmux.conf \; display-message "Config reloaded!"
bind-key h select-pane -L
bind-key j select-pane -D
```

#### Adding Plugins
Add to the plugin list in `~/.tmux.conf`:

```bash
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'your-plugin/name'
```

#### Custom Status Bar
Modify status bar in `~/.tmux.conf`:

```bash
# Custom status format
set -g status-left "#[fg=blue,bold]#S "
set -g status-right "#[fg=yellow]%Y-%m-%d %H:%M"
```

### AeroSpace

#### Window Management Rules
Edit `~/.aerospace.toml`:

```toml
# Custom window rules
[[on-window-detected]]
if.app-id = 'com.example.app'
run = 'move-node-to-workspace 2'

# Custom keybindings
[mode.main.binding]
alt-enter = 'exec-and-forget open -n /Applications/Ghostty.app'
```

#### Workspace Configuration
```toml
# Custom workspace names
[workspace-to-monitor-force-assignment]
1 = 'main'
2 = 'secondary'

# Workspace layout
[gaps]
inner.horizontal = 10
inner.vertical = 10
outer.left = 10
outer.bottom = 10
outer.top = 10
outer.right = 10
```

### Zsh

#### Custom Aliases
Add to `~/.zshrc`:

```bash
# Custom aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
```

#### Custom Functions
```bash
# Custom functions
mkcd() {
  mkdir -p "$1" && cd "$1"
}

extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
```

#### Oh-my-zsh Plugins
Edit the plugins array in `~/.zshrc`:

```bash
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  docker
  kubectl
  # Add your plugins here
)
```

### Starship Prompt

#### Custom Prompt Format
Edit `~/.config/starship.toml`:

```toml
# Custom format
format = """
$username\
$hostname\
$directory\
$git_branch\
$git_status\
$nodejs\
$python\
$rust\
$golang\
$cmd_duration\
$line_break\
$character"""

# Custom modules
[username]
show_always = true
format = "[$user]($style) "

[directory]
truncation_length = 3
truncation_symbol = "…/"

[git_branch]
format = "on [$symbol$branch]($style) "
symbol = " "

[nodejs]
format = "via [$symbol($version )]($style)"
symbol = " "
```

## Adding New Tools

### 1. Create Package Structure
```bash
mkdir -p new-tool/.config/new-tool
```

### 2. Add Configuration Files
```bash
# Add your tool's config files
cp /path/to/config new-tool/.config/new-tool/
```

### 3. Update Install Script
Edit `install.sh` and add to the PACKAGES array:

```bash
PACKAGES=(
    aerospace
    ghostty
    nvim
    opencode
    scripts
    tmux
    zsh
    new-tool  # Add your package
)
```

### 4. Add Dependencies
Update the dependency lists in `install.sh`:

```bash
BREW_FORMULAE=(
    # existing tools
    new-tool  # Add if available via brew
)

BREW_CASKS=(
    # existing casks
    new-tool  # Add if it's a cask
)
```

### 5. Create Package Documentation
```bash
# Create package README
touch new-tool/README.md
```

### 6. Theme Integration
If the tool supports themes, integrate with Catppuccin:

```bash
# Add theme files
mkdir themes/neu-alkemy/new-tool
# Add themed configuration
```

## Advanced Customization

### Conditional Loading
Load different configs based on system:

```bash
# In ~/.zshrc
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS specific
  source ~/.config/zsh/macos.zsh
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux specific
  source ~/.config/zsh/linux.zsh
fi
```

### Environment-Specific Configs
```bash
# Work vs personal configs
if [[ "$USER" == "work-username" ]]; then
  source ~/.config/zsh/work.zsh
else
  source ~/.config/zsh/personal.zsh
fi
```

### Dynamic Configuration
```bash
# Load configs based on hostname
case $HOST in
  "macbook-pro")
    source ~/.config/zsh/laptop.zsh
    ;;
  "imac")
    source ~/.config/zsh/desktop.zsh
    ;;
esac
```

## Backup and Sync

### Creating Personal Fork
1. **Fork the repository** on GitHub
2. **Clone your fork**:
   ```bash
   git clone https://github.com/yourusername/Neu-Alkemy.git
   ```
3. **Add upstream remote**:
   ```bash
   git remote add upstream https://github.com/christian-gerard/Neu-Alkemy.git
   ```
4. **Sync with upstream**:
   ```bash
   git fetch upstream
   git merge upstream/main
   ```

### Version Control Your Changes
```bash
# Create feature branch for customizations
git checkout -b my-customizations

# Commit your changes
git add .
git commit -m "Add personal customizations"

# Push to your fork
git push origin my-customizations
```

### Multiple Machine Sync
```bash
# Use different branches for different machines
git checkout -b laptop-config
git checkout -b desktop-config

# Or use conditional loading in configs
```

## Testing Customizations

### Safe Testing
```bash
# Create test branch
git checkout -b test-customization

# Test changes
./install.sh stow

# If satisfied, merge to main
git checkout main
git merge test-customization

# If not, revert
git checkout main
git branch -D test-customization
```

### Isolated Testing
```bash
# Test in temporary directory
mkdir /tmp/dotfiles-test
export HOME=/tmp/dotfiles-test
./install.sh
```

## Sharing Customizations

### Contributing Back
1. **Create feature branch**
2. **Make improvements**
3. **Test thoroughly**
4. **Submit pull request**

### Creating Themes
1. **Document your theme**
2. **Provide screenshots**
3. **Share installation instructions**
4. **Consider submitting to themes directory**

## Performance Optimization

### Shell Startup Time
```bash
# Profile startup time
time zsh -i -c exit

# Optimize by:
# - Lazy loading plugins
# - Reducing plugin count
# - Deferring heavy operations
```

### Neovim Performance
```bash
# Profile Neovim startup
nvim --startuptime startup.log

# Optimize by:
# - Lazy loading plugins
# - Reducing autocommands
# - Optimizing LSP settings
```

This customization guide should help you make the Neu-Alkemy dotfiles truly your own while maintaining the coherent design and functionality.