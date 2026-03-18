# Ghostty Configuration

GPU-accelerated terminal emulator with modern features and transparency support.

## Overview

Ghostty is a fast, native terminal emulator that leverages GPU acceleration for smooth performance. This configuration provides a beautiful, transparent terminal experience with the Catppuccin Mocha theme.

## Files

- `.config/ghostty/config` → `~/.config/ghostty/config` - Main Ghostty configuration

## Key Features

- **GPU Acceleration**: Hardware-accelerated rendering for smooth performance
- **True Color Support**: 24-bit color for rich themes and syntax highlighting
- **Transparency**: Customizable background opacity with blur effects
- **Nerd Font Support**: Full icon and symbol support with JetBrains Mono
- **Catppuccin Theme**: Beautiful Mocha color palette integration

## Configuration Highlights

### Font Settings
```ini
# JetBrains Mono Nerd Font for programming
font-family = "JetBrains Mono Nerd Font"
font-size = 14
font-weight = normal
```

### Theme (Catppuccin Mocha)
```ini
# Background and transparency
background = 1e1e2e
background-opacity = 0.85
background-blur-radius = 20

# Foreground and cursor
foreground = cdd6f4
cursor-color = f5e0dc
cursor-text = 1e1e2e
```

### Performance
```ini
# GPU acceleration
gpu-acceleration = true
vsync = true

# Scrollback
scrollback-limit = 10000
```

## Appearance

### Transparency
- **Background Opacity**: 85% for subtle transparency
- **Blur Radius**: 20px for aesthetic background blur
- **Dynamic**: Transparency adjusts based on focus

### Colors
The configuration uses the full Catppuccin Mocha palette:
- **Base Colors**: Rosewater, Flamingo, Pink, Mauve
- **Syntax Colors**: Red, Maroon, Peach, Yellow, Green, Teal, Sky, Sapphire, Blue, Lavender
- **UI Colors**: Text, Subtext, Overlay, Surface, Base, Mantle, Crust

### Font
- **Family**: JetBrains Mono Nerd Font
- **Size**: 14pt (adjustable)
- **Features**: Ligatures, icons, and programming symbols

## Setup

1. **Install Ghostty**:
   ```bash
   brew install --cask ghostty
   ```

2. **Stow configuration**:
   ```bash
   stow -d ~/Neu-Alkemy -t ~ ghostty
   ```

3. **Set as default terminal** (optional):
   - Terminal → Preferences → General → Default Terminal

## Customization

### Adjusting Transparency
Edit `~/.config/ghostty/config`:
```ini
# More transparent (60%)
background-opacity = 0.6

# Less transparent (95%)
background-opacity = 0.95

# No transparency
background-opacity = 1.0
```

### Font Size
```ini
# Larger font
font-size = 16

# Smaller font  
font-size = 12
```

### Alternative Themes
```ini
# Catppuccin Latte (light theme)
background = eff1f5
foreground = 4c4f69

# Catppuccin Frappé
background = 303446
foreground = c6d0f5
```

### Window Settings
```ini
# Window decorations
window-decoration = true
window-title-font-family = "JetBrains Mono Nerd Font"

# Initial window size
window-width = 120
window-height = 40

# Padding
window-padding-x = 10
window-padding-y = 10
```

## Key Bindings

Ghostty uses standard macOS terminal shortcuts:

### Text Selection
- `cmd+a` - Select all
- `cmd+c` - Copy
- `cmd+v` - Paste
- `shift+arrows` - Select text

### Window Management
- `cmd+n` - New window
- `cmd+t` - New tab
- `cmd+w` - Close tab/window
- `cmd+1-9` - Switch to tab

### Font Size
- `cmd+plus` - Increase font size
- `cmd+minus` - Decrease font size
- `cmd+0` - Reset font size

## Integration

### With Tmux
Ghostty works excellently with tmux:
- True color support for tmux themes
- Smooth scrolling and performance
- Proper key handling for tmux shortcuts

### With Neovim
Perfect for Neovim development:
- True color support for syntax highlighting
- Fast rendering for large files
- Proper terminal integration

### With AeroSpace
Integrates seamlessly with AeroSpace window management:
- Tiling support
- Workspace assignment
- Focus management

## Performance Tips

### Optimization
```ini
# Reduce memory usage
scrollback-limit = 5000

# Improve performance on older hardware
gpu-acceleration = false
vsync = false
```

### Debugging
```ini
# Enable debug logging
debug = true
debug-font = true
```

## Troubleshooting

### Font Issues
1. **Font not found**: Install JetBrains Mono Nerd Font via Homebrew
2. **Icons missing**: Ensure you're using the Nerd Font variant
3. **Size issues**: Adjust `font-size` in config

### Transparency Issues
1. **No transparency**: Check macOS version (requires 10.14+)
2. **Performance issues**: Reduce `background-blur-radius` or disable
3. **Visibility issues**: Increase `background-opacity`

### Performance Issues
1. **Slow rendering**: Disable GPU acceleration temporarily
2. **High memory usage**: Reduce scrollback limit
3. **Lag**: Check for conflicting applications

## Resources

- [Ghostty Documentation](https://ghostty.org/docs)
- [Catppuccin Theme](https://github.com/catppuccin/ghostty)
- [JetBrains Mono Font](https://www.jetbrains.com/lp/mono/)