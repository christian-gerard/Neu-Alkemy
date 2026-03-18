# Troubleshooting Guide

Common issues and solutions for Neu-Alkemy dotfiles.

## Installation Issues

### Homebrew Installation Fails
**Problem**: Homebrew installation script fails or hangs

**Solutions**:
```bash
# Check if Homebrew is already installed
which brew

# Manual Homebrew installation
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH (Apple Silicon)
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Stow Conflicts
**Problem**: `stow` fails with "existing target is not owned by stow"

**Solutions**:
```bash
# Option 1: Backup existing files
mkdir ~/dotfiles-backup
mv ~/.zshrc ~/.tmux.conf ~/.config/nvim ~/dotfiles-backup/

# Option 2: Use --adopt to merge existing files
stow --adopt -d ~/Neu-Alkemy -t ~ package-name

# Option 3: Force overwrite (CAUTION: will delete existing files)
stow --override='.*' -d ~/Neu-Alkemy -t ~ package-name
```

### Permission Errors
**Problem**: Permission denied errors during installation

**Solutions**:
```bash
# Fix ownership of Homebrew directory
sudo chown -R $(whoami) /opt/homebrew

# Fix permissions on dotfiles
chmod +x ~/Neu-Alkemy/install.sh
chmod +x ~/Neu-Alkemy/scripts/*.sh
```

## Application-Specific Issues

### Neovim

#### Plugin Installation Fails
**Problem**: Lazy.nvim fails to install plugins

**Solutions**:
```bash
# Clear Neovim cache
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Reinstall plugins
nvim --headless "+Lazy! sync" +qa
```

#### LSP Not Working
**Problem**: Language servers not starting or providing completions

**Solutions**:
```bash
# Check LSP status in Neovim
:LspInfo

# Install language servers manually
:Mason
# Then install required servers

# Check if language servers are in PATH
which lua-language-server
which typescript-language-server
```

#### Treesitter Errors
**Problem**: Syntax highlighting not working or parser errors

**Solutions**:
```bash
# Update Treesitter parsers in Neovim
:TSUpdate

# Install specific parser
:TSInstall lua javascript typescript

# Clear Treesitter cache
rm -rf ~/.local/share/nvim/lazy/nvim-treesitter/parser
```

### Tmux

#### Plugins Not Loading
**Problem**: Tmux plugins not working after installation

**Solutions**:
```bash
# Install TPM if missing
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Reload tmux configuration
tmux source-file ~/.tmux.conf

# Install plugins (inside tmux)
# Press: prefix + I (Ctrl-a + I)

# Update plugins
# Press: prefix + U

# Uninstall unused plugins
# Press: prefix + alt + u
```

#### Status Bar Not Showing
**Problem**: Tmux status bar missing or not themed

**Solutions**:
```bash
# Check if catppuccin plugin is installed
ls ~/.tmux/plugins/

# Manually install catppuccin
git clone https://github.com/catppuccin/tmux.git ~/.tmux/plugins/catppuccin

# Reload configuration
tmux source-file ~/.tmux.conf
```

#### Pane Navigation Not Working
**Problem**: Vim-tmux-navigator not working

**Solutions**:
```bash
# Check if plugin is installed
ls ~/.tmux/plugins/vim-tmux-navigator

# Verify Neovim has corresponding plugin
# Check in Neovim: :Lazy

# Test navigation
# Try: Ctrl-h, Ctrl-j, Ctrl-k, Ctrl-l
```

### AeroSpace

#### Not Starting on Login
**Problem**: AeroSpace doesn't start automatically

**Solutions**:
```bash
# Check if AeroSpace is running
pgrep -f AeroSpace

# Start manually
open -a AeroSpace

# Add to login items
# System Preferences > Users & Groups > Login Items
# Add AeroSpace.app

# Check configuration syntax
aerospace --check-config
```

#### Keybindings Not Working
**Problem**: AeroSpace shortcuts not responding

**Solutions**:
```bash
# Check accessibility permissions
# System Preferences > Security & Privacy > Accessibility
# Ensure AeroSpace has permission

# Verify configuration
cat ~/.aerospace.toml

# Restart AeroSpace
killall AeroSpace
open -a AeroSpace
```

### Ghostty

#### Font Not Loading
**Problem**: JetBrains Mono Nerd Font not displaying correctly

**Solutions**:
```bash
# Verify font installation
fc-list | grep -i jetbrains

# Reinstall font
brew reinstall --cask font-jetbrains-mono-nerd-font

# Check Ghostty configuration
cat ~/.config/ghostty/config

# Test font in terminal
echo "  "  # Should show icons
```

#### Transparency Not Working
**Problem**: Background transparency not applying

**Solutions**:
```bash
# Check macOS version (requires macOS 10.14+)
sw_vers

# Verify Ghostty configuration
grep -i opacity ~/.config/ghostty/config

# Restart Ghostty
killall ghostty
open -a Ghostty
```

### Zsh/Shell

#### Starship Prompt Not Loading
**Problem**: Default prompt instead of Starship

**Solutions**:
```bash
# Check if Starship is installed
which starship

# Verify initialization in .zshrc
grep starship ~/.zshrc

# Manually initialize
eval "$(starship init zsh)"

# Check configuration
starship config
```

#### Oh-my-zsh Issues
**Problem**: Zsh plugins or themes not working

**Solutions**:
```bash
# Check oh-my-zsh installation
ls ~/.oh-my-zsh

# Reinstall oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Update oh-my-zsh
omz update

# Check plugin loading
grep plugins ~/.zshrc
```

## Performance Issues

### Slow Shell Startup
**Problem**: Terminal takes long time to open

**Solutions**:
```bash
# Profile zsh startup
time zsh -i -c exit

# Disable plugins temporarily
# Comment out plugins in ~/.zshrc

# Check for slow commands
# Add to ~/.zshrc for debugging:
# zmodload zsh/zprof
# # ... rest of config
# zprof
```

### High CPU Usage
**Problem**: Applications using excessive CPU

**Solutions**:
```bash
# Check running processes
top -o cpu

# Common culprits:
# - AeroSpace (check config for loops)
# - Neovim (LSP servers)
# - Tmux (status bar updates)

# Reduce status bar update frequency
# In ~/.tmux.conf:
# set -g status-interval 5  # Default is 1 second
```

## Recovery Procedures

### Complete Reset
If everything is broken, start fresh:

```bash
# Backup current configs
mkdir ~/config-backup
cp -r ~/.config ~/config-backup/
cp ~/.zshrc ~/.tmux.conf ~/config-backup/

# Unstow all packages
cd ~/Neu-Alkemy
./install.sh unstow

# Remove installed configs
rm -rf ~/.config/nvim ~/.config/ghostty ~/.config/opencode
rm ~/.zshrc ~/.tmux.conf ~/.aerospace.toml

# Reinstall
./install.sh
```

### Selective Reset
Reset individual packages:

```bash
# Unstow specific package
stow -D -d ~/Neu-Alkemy -t ~ package-name

# Remove package configs
rm -rf ~/.config/package-name

# Restow package
stow -d ~/Neu-Alkemy -t ~ package-name
```

## Getting Help

### Log Files
Check these locations for error logs:
- Neovim: `~/.local/state/nvim/log`
- Tmux: Check tmux server with `tmux info`
- AeroSpace: Console.app → search "AeroSpace"
- Homebrew: `/opt/homebrew/var/log/`

### Debug Commands
```bash
# Check system info
uname -a
sw_vers

# Check shell
echo $SHELL
zsh --version

# Check PATH
echo $PATH

# Check environment
env | grep -E "(TERM|SHELL|PATH)"
```

### Community Support
- [GitHub Issues](https://github.com/christian-gerard/Neu-Alkemy/issues)
- Check individual tool documentation
- Search existing issues before creating new ones

### Reporting Bugs
When reporting issues, include:
1. Operating system version
2. Shell version (`zsh --version`)
3. Error messages (full output)
4. Steps to reproduce
5. Configuration files (if relevant)