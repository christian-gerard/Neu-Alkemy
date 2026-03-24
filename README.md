<div align="center">

```
        ⠀⠀⠀⠀⠀⣀⣤⣶⣶⣶⣶⣤⣀⠀⠀⠀⠀⠀
        ⠀⠀⠀⣠⣾⣿⡟⠋⠉⠉⠋⢻⣿⣷⣄⠀⠀⠀
        ⠀⢀⣾⣿⠋⠁⊹  ⊹  ⠈⠙⣿⣷⡀⠀
             ⠀⣿⣿⠁          ⠈⣿⣿⠀ NEU ALKEMY
        ⠀⢿⣿⡄⠀ ⊹   ⊹ ⠀⢀⣿⡿⠀
        ⠀⠀⠻⣿⣦⡀⠀⠀⠀⠀⠀⢀⣴⣿⠟⠀⠀
        ⠀⠀⠀⠈⠻⣿⣶⣤⣤⣶⣿⠟⠁⠀⠀⠀
        ⠀⠀⠀⠀⠀⠈⠉⠛⠛⠉⠁⠀⠀⠀⠀⠀
```

# Neu-Alkemy Dotfiles
*By Christian Gerard*
</div>

<div align="center">
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![macOS](https://img.shields.io/badge/macOS-12%2B-blue)](https://www.apple.com/macos/)
[![Stow](https://img.shields.io/badge/GNU-Stow-green)](https://www.gnu.org/software/stow/)
[![Catppuccin](https://img.shields.io/badge/Theme-Catppuccin-pink)](https://github.com/catppuccin/catppuccin)
</div>

## 🛠️ Tech Stack

| Component | Tool | Purpose |
|-----------|------|---------|
| **OS** | macOS 12+ | Operating system |
| **Shell** | Zsh + Oh-my-zsh + Starship | Command line interface |
| **Terminal** | Ghostty | GPU-accelerated terminal |
| **Editor** | Neovim + Lazy.nvim | Modern text editor |
| **Multiplexer** | Tmux + TPM | Terminal session management |
| **Window Manager** | AeroSpace | Tiling window management |
| **Theme** | Catppuccin Mocha | Consistent color palette |

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/christian-gerard/Neu-Alkemy.git ~/Neu-Alkemy
cd ~/Neu-Alkemy

# Run the installer
./install.sh

# Preview what would be installed (optional)
./install.sh --dry-run
```

## 🎛️ Management Commands

```bash
# Install everything
./install.sh

# Install only dependencies (no stowing)
./install.sh deps

# Stow packages only (no dependency installation)
./install.sh stow

# Remove all symlinks
./install.sh unstow

# Verify installation
./install.sh verify

# Show available options
./install.sh --help
```

### Manual Stow Operations
```bash
# Stow specific packages
stow -v -d ~/Neu-Alkemy -t ~ nvim tmux zsh

# Unstow specific packages
stow -v -D -d ~/Neu-Alkemy -t ~ nvim tmux zsh

# Adopt existing files into dotfiles
stow --adopt -d ~/Neu-Alkemy -t ~ package-name
```

## 📦 Packages

| Package | Target | Description |
|---------|--------|-------------|
| **[aerospace](aerospace/)** | `~/.aerospace.toml` | Tiling window manager with vim-style navigation |
| **[ghostty](ghostty/)** | `~/.config/ghostty/` | GPU-accelerated terminal with transparency |
| **[nvim](nvim/)** | `~/.config/nvim/` | Modern Neovim setup with LSP and plugins |
| **[opencode](opencode/)** | `~/.config/opencode/` | AI coding agent configurations |
| **[scripts](scripts/)** | `~/scripts/` | Development workflow automation |
| **[tmux](tmux/)** | `~/.tmux.conf` | Terminal multiplexer with custom theme |
| **[zsh](zsh/)** | `~/.zshrc` | Zsh shell with oh-my-zsh and Starship |

> **📖 Detailed package documentation**: [docs/PACKAGES.md](docs/PACKAGES.md)

## 📚 Documentation

| Guide | Description |
|-------|-------------|
| **[Setup Guide](docs/SETUP.md)** | Detailed installation and post-setup instructions |
| **[Package Docs](docs/PACKAGES.md)** | In-depth documentation for each package |
| **[Troubleshooting](docs/TROUBLESHOOTING.md)** | Common issues and solutions |
| **[Customization](docs/CUSTOMIZATION.md)** | How to customize and extend the dotfiles |

## 🔧 Dependencies

The following tools are installed automatically:

**Core Tools:**
- [GNU Stow](https://www.gnu.org/software/stow/) - Symlink manager
- [Neovim](https://neovim.io/) - Modern text editor
- [Tmux](https://github.com/tmux/tmux) - Terminal multiplexer
- [Starship](https://starship.rs/) - Cross-shell prompt

**GUI Applications:**
- [Ghostty](https://ghostty.org/) - GPU-accelerated terminal
- [AeroSpace](https://github.com/nikitabobko/AeroSpace) - Tiling window manager
- [JetBrains Mono Nerd Font](https://www.nerdfonts.com/) - Programming font

**Additional Tools:**
- [tmuxp](https://github.com/tmux-python/tmuxp) - Session manager
- [asdf](https://asdf-vm.com/) - Runtime version manager
