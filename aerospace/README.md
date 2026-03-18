# AeroSpace Configuration

Tiling window manager for macOS with vim-style navigation.

## Overview

AeroSpace provides automatic window tiling and workspace management with keyboard-driven navigation. This configuration sets up a productive window management environment with vim-style keybindings.

## Files

- `.aerospace.toml` → `~/.aerospace.toml` - Main AeroSpace configuration

## Key Features

- **Vim-style Navigation**: `alt+hjkl` for window focus and movement
- **Workspace Management**: 9 workspaces with quick switching
- **Automatic Tiling**: Windows automatically arrange in optimal layouts
- **Application Rules**: Specific apps assigned to designated workspaces

## Key Bindings

### Window Navigation
- `alt+h` - Focus left window
- `alt+j` - Focus down window  
- `alt+k` - Focus up window
- `alt+l` - Focus right window

### Window Movement
- `alt+shift+h` - Move window left
- `alt+shift+j` - Move window down
- `alt+shift+k` - Move window up
- `alt+shift+l` - Move window right

### Workspace Management
- `alt+1-9` - Switch to workspace 1-9
- `alt+shift+1-9` - Move window to workspace 1-9

### Layout Controls
- `alt+f` - Toggle fullscreen
- `alt+shift+space` - Toggle floating mode
- `alt+r` - Resize mode (use hjkl to resize)

### Application Shortcuts
- `alt+enter` - Open terminal (Ghostty)
- `alt+shift+enter` - Open new terminal window

## Configuration Highlights

### Workspace Layout
```toml
# Gaps between windows
[gaps]
inner.horizontal = 10
inner.vertical = 10
outer.left = 10
outer.bottom = 10
outer.top = 10
outer.right = 10

# Default layout for new workspaces
default-root-container-layout = 'tiles'
```

### Application Rules
```toml
# Browsers go to workspace 1
[[on-window-detected]]
if.app-id = 'com.google.Chrome'
run = 'move-node-to-workspace 1'

# Development tools go to workspace 2
[[on-window-detected]]
if.app-id = 'com.microsoft.VSCode'
run = 'move-node-to-workspace 2'
```

## Setup

1. **Install AeroSpace**:
   ```bash
   brew install --cask nikitabobko/tap/aerospace
   ```

2. **Stow configuration**:
   ```bash
   stow -d ~/Neu-Alkemy -t ~ aerospace
   ```

3. **Start AeroSpace**:
   ```bash
   open -a AeroSpace
   ```

4. **Enable at login**:
   - System Preferences → Users & Groups → Login Items
   - Add AeroSpace.app

## Accessibility Permissions

AeroSpace requires accessibility permissions to control windows:

1. System Preferences → Security & Privacy → Privacy → Accessibility
2. Click the lock and enter your password
3. Check the box next to AeroSpace

## Customization

### Adding Custom Keybindings
Edit `.aerospace.toml`:
```toml
[mode.main.binding]
alt-t = 'exec-and-forget open -n /Applications/Terminal.app'
alt-b = 'exec-and-forget open -n /Applications/Safari.app'
```

### Workspace Names
```toml
[workspace-to-monitor-force-assignment]
1 = 'main'      # Primary monitor
2 = 'secondary' # Secondary monitor
```

### Window Rules
```toml
# Float specific applications
[[on-window-detected]]
if.app-id = 'com.apple.calculator'
run = 'layout floating'

# Assign apps to specific workspaces
[[on-window-detected]]
if.app-id = 'com.spotify.client'
run = 'move-node-to-workspace 9'
```

## Troubleshooting

### AeroSpace Not Starting
```bash
# Check if running
pgrep -f AeroSpace

# Check configuration syntax
aerospace --check-config

# View logs
log show --predicate 'process == "AeroSpace"' --last 1h
```

### Keybindings Not Working
1. Verify accessibility permissions are granted
2. Check for conflicting system shortcuts in System Preferences
3. Restart AeroSpace after configuration changes

### Windows Not Tiling
1. Some apps (like System Preferences) can't be tiled
2. Check if the app is set to floating mode
3. Try `alt+shift+space` to toggle floating mode

## Integration

### With Tmux
AeroSpace works seamlessly with tmux for terminal management:
- AeroSpace manages terminal windows
- Tmux manages sessions within terminals

### With Neovim
The vim-style keybindings in AeroSpace complement Neovim navigation:
- Same `hjkl` muscle memory
- Consistent navigation patterns

## Resources

- [AeroSpace Documentation](https://github.com/nikitabobko/AeroSpace)
- [Configuration Reference](https://nikitabobko.github.io/AeroSpace/config-ref)
- [Troubleshooting Guide](https://nikitabobko.github.io/AeroSpace/troubleshooting)