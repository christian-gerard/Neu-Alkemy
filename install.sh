#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME"

# All stow packages in the repo
PACKAGES=(
    aerospace
    ghostty
    nvim
    opencode
    scripts
    tmux
    zsh
)

# Colors (Catppuccin Mocha palette)
BLUE='\033[38;2;137;180;250m'
MAUVE='\033[38;2;203;166;247m'
GREEN='\033[38;2;166;227;161m'
RED='\033[38;2;243;139;168m'
YELLOW='\033[38;2;249;226;175m'
RESET='\033[0m'

info()  { echo -e "${BLUE}[info]${RESET}  $*"; }
ok()    { echo -e "${GREEN}[ok]${RESET}    $*"; }
warn()  { echo -e "${YELLOW}[warn]${RESET}  $*"; }
err()   { echo -e "${RED}[err]${RESET}   $*"; }

# ─────────────────────────────────────────────
# Banner
# ─────────────────────────────────────────────
echo -e "${MAUVE}"
cat << 'EOF'

    ╔╗╔┌─┐┬ ┬   ╔═╗┬  ┬┌─┌─┐┌┬┐┬ ┬
    ║║║├┤ │ │───╠═╣│  ├┴┐├┤ │││└┬┘
    ╝╚╝└─┘└─┘   ╩ ╩┴─┘┴ ┴└─┘┴ ┴ ┴

    dotfiles installer
EOF
echo -e "${RESET}"

# ─────────────────────────────────────────────
# Homebrew
# ─────────────────────────────────────────────
install_homebrew() {
    if command -v brew &>/dev/null; then
        ok "Homebrew already installed"
    else
        info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Add brew to path for Apple Silicon
        if [[ -f /opt/homebrew/bin/brew ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        ok "Homebrew installed"
    fi
}

# ─────────────────────────────────────────────
# Dependencies
# ─────────────────────────────────────────────
install_deps() {
    info "Installing dependencies via brew..."

    BREW_FORMULAE=(
        stow
        neovim
        tmux
        starship
        tmuxp
        asdf
    )

    BREW_CASKS=(
        ghostty
        nikitabobko/tap/aerospace
        font-jetbrains-mono-nerd-font
    )

    for formula in "${BREW_FORMULAE[@]}"; do
        if brew list "$formula" &>/dev/null; then
            ok "$formula already installed"
        else
            info "Installing $formula..."
            brew install "$formula"
        fi
    done

    for cask in "${BREW_CASKS[@]}"; do
        cask_name=$(basename "$cask")
        if brew list --cask "$cask_name" &>/dev/null 2>&1; then
            ok "$cask_name already installed"
        else
            info "Installing $cask_name..."
            brew install --cask "$cask" 2>/dev/null || brew install "$cask"
        fi
    done

    ok "All dependencies installed"
}

# ─────────────────────────────────────────────
# TPM (Tmux Plugin Manager)
# ─────────────────────────────────────────────
install_tpm() {
    TPM_DIR="$HOME/.tmux/plugins/tpm"
    if [[ -d "$TPM_DIR" ]]; then
        ok "TPM already installed"
    else
        info "Installing TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
        ok "TPM installed — run prefix + I inside tmux to install plugins"
    fi
}

# ─────────────────────────────────────────────
# Stow packages
# ─────────────────────────────────────────────
stow_packages() {
    info "Stowing packages into $TARGET_DIR..."

    for pkg in "${PACKAGES[@]}"; do
        if [[ ! -d "$DOTFILES_DIR/$pkg" ]]; then
            warn "Package '$pkg' not found, skipping"
            continue
        fi

        info "Stowing $pkg..."
        # --restow to handle re-runs cleanly
        if stow -v -R -d "$DOTFILES_DIR" -t "$TARGET_DIR" "$pkg" 2>&1; then
            ok "$pkg stowed"
        else
            err "Failed to stow $pkg — there may be existing files in the way"
            echo -e "    ${YELLOW}Try: stow --adopt -d $DOTFILES_DIR -t $TARGET_DIR $pkg${RESET}"
            echo -e "    ${YELLOW}This will adopt existing files into the dotfiles repo${RESET}"
        fi
    done
}

# ─────────────────────────────────────────────
# Unstow (for cleanup)
# ─────────────────────────────────────────────
unstow_packages() {
    info "Unstowing all packages..."
    for pkg in "${PACKAGES[@]}"; do
        if [[ -d "$DOTFILES_DIR/$pkg" ]]; then
            stow -v -D -d "$DOTFILES_DIR" -t "$TARGET_DIR" "$pkg" 2>&1 || true
            ok "$pkg unstowed"
        fi
    done
}

# ─────────────────────────────────────────────
# Main
# ─────────────────────────────────────────────
usage() {
    echo "Usage: $0 [install|stow|unstow|deps]"
    echo ""
    echo "  install   Full setup: deps + stow (default)"
    echo "  stow      Stow all packages only"
    echo "  unstow    Remove all symlinks"
    echo "  deps      Install dependencies only"
}

main() {
    local cmd="${1:-install}"

    case "$cmd" in
        install)
            install_homebrew
            install_deps
            install_tpm
            stow_packages
            echo ""
            ok "Neu-Alkemy setup complete"
            info "Open a new terminal to pick up all changes"
            ;;
        stow)
            stow_packages
            ;;
        unstow)
            unstow_packages
            ;;
        deps)
            install_homebrew
            install_deps
            install_tpm
            ;;
        -h|--help|help)
            usage
            ;;
        *)
            err "Unknown command: $cmd"
            usage
            exit 1
            ;;
    esac
}

main "$@"
