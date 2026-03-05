<div align="center">

```
        ⠀⠀⠀⠀⠀⣀⣤⣶⣶⣶⣶⣤⣀⠀⠀⠀⠀⠀
        ⠀⠀⠀⣠⣾⣿⡟⠋⠉⠉⠋⢻⣿⣷⣄⠀⠀⠀
        ⠀⢀⣾⣿⠋⠁  ⊹ ◈ ⊹  ⠈⠙⣿⣷⡀⠀
        ⠀       ⣿⣿⠁  N E U - A L K E M Y  ⠈⣿⣿⠀
        ⠀⢿⣿⡄⠀  ⊹ ◈ ⊹  ⠀⢀⣿⡿⠀
        ⠀⠀⠻⣿⣦⡀⠀⠀⠀⠀⠀⢀⣴⣿⠟⠀⠀
        ⠀⠀⠀⠈⠻⣿⣶⣤⣤⣶⣿⠟⠁⠀⠀⠀
        ⠀⠀⠀⠀⠀⠈⠉⠛⠛⠉⠁⠀⠀⠀⠀⠀
```

</div>

<p align="center">
  <a href="#-structure">Structure</a> •
  <a href="#-quickstart">Quickstart</a> •
  <a href="#-packages">Packages</a> •
  <a href="#-dependencies">Dependencies</a>
</p>

<p align="center">
  <i>Personal dotfiles managed with <b>GNU Stow</b> — unified under <b>Catppuccin Mocha</b></i>
</p>

---

```
      ╭──────────────────────────────────────╮
      │  **OS**        **macOS**                      │
      │  Shell     zsh + oh-my-zsh + starship│
      │  Terminal  Ghostty                   │
      │  Editor    Neovim                    │
      │  Mux       tmux + tmuxp              │
      │  WM        AeroSpace                 │
      │  Theme     Catppuccin Mocha          │
      ╰──────────────────────────────────────╯
```

---

### Structure

Each top-level directory is a **stow package** that symlinks into `$HOME`:

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

---

### Quickstart

```bash
git clone <your-repo-url> ~/Neu-Alkemy
cd ~/Neu-Alkemy
./install.sh
```

The install script will:
1. Install Homebrew (if missing)
2. Install all dependencies via `brew`
3. Stow every package into `$HOME`

To stow individual packages:
```bash
stow -v -d ~/Neu-Alkemy -t ~ nvim tmux zsh
```

To unstow (remove symlinks):
```bash
stow -v -D -d ~/Neu-Alkemy -t ~ nvim tmux zsh
```

---

### Packages

| Package | Config | Description |
|---------|--------|-------------|
| **aerospace** | `~/.aerospace.toml` | Tiling window manager — vim-style `alt+hjkl` focus/move |
| **ghostty** | `~/.config/ghostty/config` | GPU-accelerated terminal — JetBrainsMono Nerd Font, 40% opacity blur |
| **nvim** | `~/.config/nvim/` | Neovim w/ lazy.nvim — LSP, Telescope, Treesitter, Neo-tree, Catppuccin transparent |
| **opencode** | `~/.config/opencode/` | AI coding agent config — custom agents & prompts |
| **scripts** | `~/scripts/` | Dev workflow launchers — tmuxp session bootstrappers |
| **tmux** | `~/.tmux.conf` | tmux — Catppuccin status bar, vim-tmux-navigator, prefix `C-a` |
| **zsh** | `~/.zshrc` | Zsh — oh-my-zsh, vi-mode, Starship prompt (Catppuccin Mocha palette) |

---

### Dependencies

Installed automatically by `install.sh`:

| Tool | Purpose |
|------|---------|
| [GNU Stow](https://www.gnu.org/software/stow/) | Symlink manager |
| [Neovim](https://neovim.io/) | Editor |
| [tmux](https://github.com/tmux/tmux) | Terminal multiplexer |
| [Ghostty](https://ghostty.org/) | Terminal emulator |
| [Starship](https://starship.rs/) | Cross-shell prompt |
| [AeroSpace](https://github.com/nikitabobko/AeroSpace) | Tiling WM for macOS |
| [JetBrainsMono Nerd Font](https://www.nerdfonts.com/) | Patched font with icons |
| [tmuxp](https://github.com/tmux-python/tmuxp) | tmux session manager |
| [asdf](https://asdf-vm.com/) | Runtime version manager |
| [nvm](https://github.com/nvm-sh/nvm) | Node version manager |

