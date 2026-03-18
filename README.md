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

*Modern macOS development environment with consistent theming*

</div>

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![macOS](https://img.shields.io/badge/macOS-12%2B-blue)](https://www.apple.com/macos/)
[![Stow](https://img.shields.io/badge/GNU-Stow-green)](https://www.gnu.org/software/stow/)
[![Catppuccin](https://img.shields.io/badge/Theme-Catppuccin-pink)](https://github.com/catppuccin/catppuccin)

[🚀 Quick Start](#-quick-start) • [📖 Documentation](docs/) • [🎨 Customization](docs/CUSTOMIZATION.md) • [🔧 Troubleshooting](docs/TROUBLESHOOTING.md)

</div>


## ✨ Features

- **🎯 Unified Theme**: Catppuccin Mocha across all tools
- **⚡ Modern Tools**: Neovim, Ghostty, AeroSpace, Starship
- **🔧 Easy Management**: GNU Stow for clean symlink management
- **📦 One-Click Setup**: Automated installation with dependency management
- **🛡️ Safe Installation**: Automatic backups and rollback support
- **📚 Comprehensive Docs**: Detailed guides for setup and customization

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

## 📋 Prerequisites

- **macOS 12+** (Monterey or later)
- **Xcode Command Line Tools**: `xcode-select --install`
- **Internet connection** for downloading dependencies
- **1GB+ free disk space**

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

The installer will:
1. ✅ Check system compatibility and prerequisites
2. 🍺 Install Homebrew and all dependencies
3. 🔗 Create symlinks using GNU Stow
4. 💾 Backup existing configurations automatically
5. ✨ Set up all tools with unified theming

> **💡 Tip**: Use `./install.sh --help` to see all available options

## 📁 Structure

```
Neu-Alkemy/
├── aerospace/           # → ~/.aerospace.toml
│   └── .aerospace.toml
├── ghostty/             # → ~/.config/ghostty/
│   └── .config/ghostty/config
├── nvim/                # → ~/.config/nvim/
│   └── .config/nvim/
│       ├── init.lua
│       ├── lazy-lock.json
│       └── lua/
│           ├── config/        # keymaps, autocommands
│           ├── options.lua
│           └── plugins/       # lazy.nvim plugin specs
├── opencode/            # → ~/.config/opencode/
│   └── .config/opencode/
│       ├── opencode.jsonc
│       ├── AGENTS.md
│       └── prompts/
├── scripts/             # → ~/scripts/
│   └── scripts/
│       ├── start_jump.sh
│       └── start_learn.sh
├── tmux/                # → ~/.tmux.conf, ~/.tmux/, ~/.tmuxp/
│   ├── .tmux.conf
│   ├── .tmux/plugins/
│   └── .tmuxp/
│       ├── jump.yaml
│       └── neu-alkemy.yaml
└── zsh/                 # → ~/.zshrc, ~/.config/starship.toml
    ├── .zshrc
    └── .config/starship.toml
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

## 🎨 Theming

All tools are configured with the **Catppuccin Mocha** color palette for a cohesive experience:

- **Background**: `#1e1e2e` (Base)
- **Foreground**: `#cdd6f4` (Text)  
- **Accent**: `#89b4fa` (Blue)
- **Success**: `#a6e3a1` (Green)
- **Warning**: `#f9e2af` (Yellow)
- **Error**: `#f38ba8` (Red)

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

## 🚨 Troubleshooting

**Common Issues:**
- **Stow conflicts**: Use `./install.sh --force` or see [troubleshooting guide](docs/TROUBLESHOOTING.md)
- **Permission errors**: Ensure Xcode Command Line Tools are installed
- **Missing tools**: Run `./install.sh verify` to check installation

**Getting Help:**
1. Check the [troubleshooting guide](docs/TROUBLESHOOTING.md)
2. Search [existing issues](https://github.com/christian-gerard/Neu-Alkemy/issues)
3. Create a [new issue](https://github.com/christian-gerard/Neu-Alkemy/issues/new) with details

## 🤝 Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Catppuccin](https://github.com/catppuccin/catppuccin) for the beautiful color palette
- [GNU Stow](https://www.gnu.org/software/stow/) for elegant symlink management
- The open-source community for all the amazing tools

