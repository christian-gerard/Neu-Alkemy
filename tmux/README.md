# Tmux Configuration

Terminal multiplexer setup with Catppuccin theme and vim-style navigation.

## Overview

This tmux configuration provides a powerful terminal session management system with beautiful theming, plugin support, and seamless integration with Neovim and other tools.

## Files

- `.tmux.conf` → `~/.tmux.conf` - Main tmux configuration
- `.tmux/` → `~/.tmux/` - Plugin directory and additional configs
- `.tmuxp/` → `~/.tmuxp/` - Session templates

## Key Features

- **🎨 Catppuccin Theme**: Beautiful status bar with Mocha color palette
- **⌨️ Vim Navigation**: Seamless navigation between tmux and Neovim
- **🔌 Plugin Management**: TPM (Tmux Plugin Manager) integration
- **📁 Session Templates**: tmuxp for reproducible development environments
- **🖱️ Mouse Support**: Optional mouse interaction
- **📋 Clipboard Integration**: System clipboard support

## Key Bindings

### Prefix Key
- **Prefix**: `Ctrl-a` (instead of default `Ctrl-b`)

### Session Management
- `prefix + s` - List sessions
- `prefix + $` - Rename session
- `prefix + d` - Detach from session

### Window Management
- `prefix + c` - Create new window
- `prefix + &` - Kill current window
- `prefix + ,` - Rename window
- `prefix + 1-9` - Switch to window 1-9
- `prefix + n` - Next window
- `prefix + p` - Previous window

### Pane Management
- `prefix + |` - Split vertically
- `prefix + -` - Split horizontally
- `prefix + x` - Kill current pane
- `prefix + z` - Toggle pane zoom
- `prefix + {` - Move pane left
- `prefix + }` - Move pane right

### Vim-Style Navigation
- `Ctrl-h` - Move to left pane (or Neovim window)
- `Ctrl-j` - Move to bottom pane (or Neovim window)
- `Ctrl-k` - Move to top pane (or Neovim window)
- `Ctrl-l` - Move to right pane (or Neovim window)

### Plugin Management
- `prefix + I` - Install plugins
- `prefix + U` - Update plugins
- `prefix + alt + u` - Uninstall unused plugins

## Plugins

### Installed Plugins
- **[catppuccin/tmux](https://github.com/catppuccin/tmux)** - Beautiful Catppuccin theme
- **[christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)** - Seamless vim/tmux navigation
- **[tmux-plugins/tmux-sensible](https://github.com/tmux-plugins/tmux-sensible)** - Sensible defaults
- **[tmux-plugins/tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)** - Session persistence
- **[tmux-plugins/tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)** - Automatic session saving

### Adding New Plugins
Edit `~/.tmux.conf`:
```bash
# Add to plugin list
set -g @plugin 'author/plugin-name'

# Reload config and install
prefix + I
```

## Session Templates (tmuxp)

### Available Templates
- `jump.yaml` - Jump development environment
- `neu-alkemy.yaml` - Dotfiles development setup

### Using Templates
```bash
# List available sessions
tmuxp ls

# Load a session
tmuxp load jump
tmuxp load neu-alkemy

# Create new session from template
tmuxp load -s session-name template.yaml
```

### Creating Custom Templates
Create `~/.tmuxp/my-project.yaml`:
```yaml
session_name: my-project
start_directory: ~/projects/my-project
windows:
  - window_name: editor
    panes:
      - nvim
  - window_name: server
    panes:
      - npm run dev
  - window_name: terminal
    panes:
      - # Empty pane for general use
```

## Theme Configuration

### Catppuccin Settings
The status bar uses Catppuccin Mocha with these customizations:
```bash
# Window status format
set -g @catppuccin_window_left_separator ""
set -g @catppuccin_window_right_separator " "
set -g @catppuccin_window_middle_separator " █"
set -g @catppuccin_window_number_position "right"

# Status modules
set -g @catppuccin_status_modules_right "directory session"
set -g @catppuccin_status_left_separator  " "
set -g @catppuccin_status_right_separator ""
```

### Custom Status Bar
```bash
# Left status
set -g status-left "#[fg=blue,bold]#S "

# Right status  
set -g status-right "#[fg=yellow]%Y-%m-%d %H:%M"

# Window status
setw -g window-status-current-format "#[fg=magenta,bold] #I:#W "
```

## Setup

1. **Install tmux**:
   ```bash
   brew install tmux
   ```

2. **Install TPM**:
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

3. **Stow configuration**:
   ```bash
   stow -d ~/Neu-Alkemy -t ~ tmux
   ```

4. **Install plugins**:
   ```bash
   tmux
   # Press: prefix + I
   ```

5. **Install tmuxp**:
   ```bash
   brew install tmuxp
   ```

## Customization

### Changing Prefix Key
Edit `~/.tmux.conf`:
```bash
# Change prefix from Ctrl-a to Ctrl-space
unbind C-a
set -g prefix C-space
bind C-space send-prefix
```

### Mouse Support
```bash
# Enable mouse support
set -g mouse on

# Disable mouse support
set -g mouse off
```

### Copy Mode Settings
```bash
# Vim-style copy mode
setw -g mode-keys vi
bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
```

### Pane Borders
```bash
# Custom pane border colors
set -g pane-border-style fg=colour8
set -g pane-active-border-style fg=colour4
```

## Integration

### With Neovim
Perfect integration via vim-tmux-navigator:
- Seamless navigation between Neovim splits and tmux panes
- Consistent key bindings (`Ctrl-hjkl`)
- Shared clipboard support

### With AeroSpace
Works well with AeroSpace window management:
- tmux manages terminal sessions
- AeroSpace manages terminal windows
- Complementary tiling approaches

### With Git
Enhanced git workflow:
- Dedicated panes for git operations
- Session templates with git-aware layouts
- Integration with Neovim's git plugins

## Troubleshooting

### Plugin Issues
```bash
# Reinstall TPM
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Reload config
tmux source-file ~/.tmux.conf

# Install plugins
prefix + I
```

### Navigation Issues
1. **Vim navigation not working**: Ensure vim-tmux-navigator is installed in both tmux and Neovim
2. **Key conflicts**: Check for conflicting key bindings in terminal or other apps
3. **Prefix not working**: Verify prefix key setting and terminal key handling

### Theme Issues
```bash
# Check if catppuccin plugin is loaded
tmux list-sessions
tmux show-options -g @plugin

# Manually reload theme
prefix + I
tmux source-file ~/.tmux.conf
```

### Performance Issues
```bash
# Reduce status update frequency
set -g status-interval 5  # Default is 1 second

# Limit scrollback
set -g history-limit 5000  # Default is 2000
```

## Advanced Usage

### Session Management
```bash
# Create named session
tmux new-session -s work

# Attach to existing session
tmux attach-session -t work

# List all sessions
tmux list-sessions

# Kill session
tmux kill-session -t work
```

### Window and Pane Management
```bash
# Create window with specific command
tmux new-window -n "server" "npm run dev"

# Split with specific command
tmux split-window -h "htop"

# Send commands to pane
tmux send-keys -t 1 "ls -la" Enter
```

### Scripting
```bash
#!/bin/bash
# Create development session
tmux new-session -d -s dev
tmux split-window -h
tmux select-pane -t 0
tmux send-keys 'nvim' Enter
tmux select-pane -t 1
tmux send-keys 'npm run dev' Enter
tmux attach-session -t dev
```

## Resources

- [Tmux Manual](https://man7.org/linux/man-pages/man1/tmux.1.html)
- [TPM Documentation](https://github.com/tmux-plugins/tpm)
- [Catppuccin Tmux](https://github.com/catppuccin/tmux)
- [tmuxp Documentation](https://tmuxp.git-pull.com/)