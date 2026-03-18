# Detailed Setup Guide

This guide provides comprehensive setup instructions for the Neu-Alkemy dotfiles.

## Prerequisites

### System Requirements
- **macOS** (tested on macOS 12+)
- **Homebrew** (installed automatically by the script)
- **Git** (for cloning the repository)

### Recommended Tools
- **Terminal app** that supports true color (iTerm2, Ghostty, etc.)
- **Nerd Font** compatible terminal (JetBrains Mono Nerd Font installed by script)

## Installation Methods

### Quick Install (Recommended)
```bash
git clone https://github.com/christian-gerard/Neu-Alkemy.git ~/Neu-Alkemy
cd ~/Neu-Alkemy
./install.sh
```

### Custom Installation
```bash
# Install dependencies only
./install.sh deps

# Stow specific packages
stow -v -d ~/Neu-Alkemy -t ~ nvim tmux zsh

# Stow all packages
./install.sh stow
```

### Manual Installation
If you prefer to install manually:

1. **Install Homebrew**:
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install dependencies**:
   ```bash
   brew install stow neovim tmux starship tmuxp asdf
   brew install --cask ghostty nikitabobko/tap/aerospace font-jetbrains-mono-nerd-font
   ```

3. **Install TPM (Tmux Plugin Manager)**:
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

4. **Stow configurations**:
   ```bash
   cd ~/Neu-Alkemy
   stow aerospace ghostty nvim opencode scripts tmux zsh
   ```

## Post-Installation Setup

### 1. Terminal Configuration
- Set your terminal font to "JetBrains Mono Nerd Font"
- Enable true color support
- Restart your terminal

### 2. Tmux Plugins
- Start tmux: `tmux`
- Install plugins: `prefix + I` (default prefix is `Ctrl-a`)

### 3. Neovim
- Open Neovim: `nvim`
- Lazy.nvim will automatically install plugins on first run
- Wait for all plugins to install

### 4. AeroSpace Window Manager
- Log out and log back in for AeroSpace to start
- Or manually start: `open -a AeroSpace`

### 5. Shell Configuration
- Open a new terminal session to load zsh configuration
- Starship prompt should appear automatically

## Verification

Run these commands to verify everything is working:

```bash
# Check tool versions
nvim --version
tmux -V
starship --version

# Check configurations are linked
ls -la ~/.zshrc ~/.tmux.conf ~/.config/nvim

# Test tmux session manager
tmuxp ls
```

## Troubleshooting

### Common Issues

**Stow conflicts**:
```bash
# If you have existing configs, use --adopt to merge
stow --adopt -d ~/Neu-Alkemy -t ~ package-name
```

**Tmux plugins not working**:
```bash
# Manually reload tmux config
tmux source-file ~/.tmux.conf
# Then install plugins: prefix + I
```

**Neovim errors**:
```bash
# Clear Neovim cache and reinstall plugins
rm -rf ~/.local/share/nvim
nvim
```

**AeroSpace not starting**:
```bash
# Check if AeroSpace is running
pgrep -f AeroSpace
# Manually start
open -a AeroSpace
```

For more troubleshooting help, see [TROUBLESHOOTING.md](TROUBLESHOOTING.md).

## Customization

See [CUSTOMIZATION.md](CUSTOMIZATION.md) for detailed customization guides.