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

