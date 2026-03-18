#!/usr/bin/env bash
set -euo pipefail

# ═══════════════════════════════════════════════════════════════════════════════
# Neu-Alkemy Dotfiles Installer
# ═══════════════════════════════════════════════════════════════════════════════

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Configuration
DRY_RUN=false
VERBOSE=false
FORCE=false
SKIP_DEPS=false

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

# Logging functions
info()  { echo -e "${BLUE}[info]${RESET}  $*"; }
ok()    { echo -e "${GREEN}[ok]${RESET}    $*"; }
warn()  { echo -e "${YELLOW}[warn]${RESET}  $*"; }
err()   { echo -e "${RED}[err]${RESET}   $*"; }
debug() { [[ "$VERBOSE" == true ]] && echo -e "${MAUVE}[debug]${RESET} $*" || true; }

# Dry run wrapper
run_cmd() {
    if [[ "$DRY_RUN" == true ]]; then
        echo -e "${YELLOW}[dry-run]${RESET} Would run: $*"
        return 0
    else
        debug "Running: $*"
        "$@"
    fi
}

# ─────────────────────────────────────────────
# System checks
# ─────────────────────────────────────────────
check_os() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        err "This installer is designed for macOS only"
        err "Current OS: $OSTYPE"
        exit 1
    fi
    
    local macos_version
    macos_version=$(sw_vers -productVersion)
    info "macOS version: $macos_version"
    
    # Check for minimum macOS version (12.0+)
    if [[ $(echo "$macos_version" | cut -d. -f1) -lt 12 ]]; then
        warn "macOS 12+ recommended for best compatibility"
    fi
}

check_prerequisites() {
    info "Checking prerequisites..."
    
    # Check for required commands
    local required_commands=("curl" "git")
    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" &>/dev/null; then
            err "Required command not found: $cmd"
            exit 1
        fi
        debug "$cmd: $(which "$cmd")"
    done
    
    # Check for Xcode Command Line Tools
    if ! xcode-select -p &>/dev/null; then
        err "Xcode Command Line Tools not installed"
        info "Install with: xcode-select --install"
        exit 1
    fi
    
    # Check disk space (need at least 1GB)
    local available_space
    available_space=$(df -h "$HOME" | awk 'NR==2 {print $4}' | sed 's/[^0-9.]//g')
    debug "Available disk space: ${available_space}GB"
    
    # Check internet connectivity
    if ! curl -s --head https://github.com >/dev/null; then
        err "No internet connection detected"
        exit 1
    fi
    
    ok "Prerequisites check passed"
}

check_conflicts() {
    info "Checking for potential conflicts..."
    
    local conflicts=()
    
    # Check for existing dotfiles that might conflict
    local dotfiles=(
        "$HOME/.zshrc"
        "$HOME/.tmux.conf"
        "$HOME/.aerospace.toml"
        "$HOME/.config/nvim"
        "$HOME/.config/ghostty"
    )
    
    for dotfile in "${dotfiles[@]}"; do
        if [[ -e "$dotfile" ]] && [[ ! -L "$dotfile" ]]; then
            conflicts+=("$dotfile")
        fi
    done
    
    if [[ ${#conflicts[@]} -gt 0 ]]; then
        warn "Found existing configuration files that may conflict:"
        for conflict in "${conflicts[@]}"; do
            echo "  - $conflict"
        done
        
        if [[ "$FORCE" != true ]]; then
            echo ""
            echo "Options:"
            echo "  1. Backup existing files (recommended)"
            echo "  2. Use --force to overwrite"
            echo "  3. Cancel installation"
            echo ""
            read -p "Backup existing files? [Y/n]: " -r
            if [[ $REPLY =~ ^[Nn]$ ]]; then
                info "Installation cancelled by user"
                exit 0
            fi
        fi
        
        backup_existing_configs "${conflicts[@]}"
    fi
}

backup_existing_configs() {
    local files=("$@")
    
    if [[ ${#files[@]} -eq 0 ]]; then
        return 0
    fi
    
    info "Creating backup directory: $BACKUP_DIR"
    run_cmd mkdir -p "$BACKUP_DIR"
    
    for file in "${files[@]}"; do
        if [[ -e "$file" ]]; then
            local backup_path="$BACKUP_DIR/$(basename "$file")"
            info "Backing up $file to $backup_path"
            run_cmd cp -r "$file" "$backup_path"
        fi
    done
    
    ok "Backup completed"
}

# ─────────────────────────────────────────────
# Installation functions
# ─────────────────────────────────────────────
install_homebrew() {
    if command -v brew &>/dev/null; then
        ok "Homebrew already installed"
        return 0
    fi
    
    if [[ "$SKIP_DEPS" == true ]]; then
        warn "Skipping Homebrew installation (--skip-deps)"
        return 0
    fi
    
    info "Installing Homebrew..."
    if [[ "$DRY_RUN" == true ]]; then
        echo -e "${YELLOW}[dry-run]${RESET} Would install Homebrew"
        return 0
    fi
    
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add brew to path for Apple Silicon
    if [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    
    ok "Homebrew installed"
}

install_deps() {
    if [[ "$SKIP_DEPS" == true ]]; then
        warn "Skipping dependency installation (--skip-deps)"
        return 0
    fi
    
    info "Installing dependencies via brew..."
    
    local brew_formulae=(
        stow
        neovim
        tmux
        starship
        tmuxp
        asdf
    )
    
    local brew_casks=(
        ghostty
        nikitabobko/tap/aerospace
        font-jetbrains-mono-nerd-font
    )
    
    # Update Homebrew
    info "Updating Homebrew..."
    run_cmd brew update
    
    # Install formulae
    for formula in "${brew_formulae[@]}"; do
        if brew list "$formula" &>/dev/null; then
            ok "$formula already installed"
        else
            info "Installing $formula..."
            run_cmd brew install "$formula"
        fi
    done
    
    # Install casks
    for cask in "${brew_casks[@]}"; do
        local cask_name
        cask_name=$(basename "$cask")
        if brew list --cask "$cask_name" &>/dev/null 2>&1; then
            ok "$cask_name already installed"
        else
            info "Installing $cask_name..."
            run_cmd brew install --cask "$cask" 2>/dev/null || run_cmd brew install "$cask"
        fi
    done
    
    ok "All dependencies installed"
}

install_tpm() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"
    
    if [[ -d "$tpm_dir" ]]; then
        ok "TPM already installed"
        return 0
    fi
    
    info "Installing TPM (Tmux Plugin Manager)..."
    run_cmd git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    ok "TPM installed — run prefix + I inside tmux to install plugins"
}

stow_packages() {
    info "Stowing packages into $TARGET_DIR..."
    
    # Verify stow is available
    if ! command -v stow &>/dev/null; then
        err "GNU Stow not found. Install with: brew install stow"
        return 1
    fi
    
    local failed_packages=()
    
    for pkg in "${PACKAGES[@]}"; do
        if [[ ! -d "$DOTFILES_DIR/$pkg" ]]; then
            warn "Package '$pkg' not found, skipping"
            continue
        fi
        
        info "Stowing $pkg..."
        
        # Use --restow to handle re-runs cleanly
        if run_cmd stow -v -R -d "$DOTFILES_DIR" -t "$TARGET_DIR" "$pkg" 2>&1; then
            ok "$pkg stowed"
        else
            err "Failed to stow $pkg"
            failed_packages+=("$pkg")
            
            if [[ "$FORCE" == true ]]; then
                warn "Trying with --adopt flag..."
                if run_cmd stow --adopt -v -R -d "$DOTFILES_DIR" -t "$TARGET_DIR" "$pkg" 2>&1; then
                    ok "$pkg stowed with --adopt"
                else
                    err "Failed to stow $pkg even with --adopt"
                fi
            else
                echo -e "    ${YELLOW}Try: stow --adopt -d $DOTFILES_DIR -t $TARGET_DIR $pkg${RESET}"
                echo -e "    ${YELLOW}This will adopt existing files into the dotfiles repo${RESET}"
            fi
        fi
    done
    
    if [[ ${#failed_packages[@]} -gt 0 ]]; then
        warn "Some packages failed to stow: ${failed_packages[*]}"
        return 1
    fi
}

unstow_packages() {
    info "Unstowing all packages..."
    
    for pkg in "${PACKAGES[@]}"; do
        if [[ -d "$DOTFILES_DIR/$pkg" ]]; then
            info "Unstowing $pkg..."
            run_cmd stow -v -D -d "$DOTFILES_DIR" -t "$TARGET_DIR" "$pkg" 2>&1 || true
            ok "$pkg unstowed"
        fi
    done
}

# ─────────────────────────────────────────────
# Rollback functionality
# ─────────────────────────────────────────────
rollback_installation() {
    local backup_dir="$1"
    
    if [[ ! -d "$backup_dir" ]]; then
        err "Backup directory not found: $backup_dir"
        return 1
    fi
    
    info "Rolling back installation using backup: $backup_dir"
    
    # Unstow packages first
    unstow_packages
    
    # Restore backed up files
    for backup_file in "$backup_dir"/*; do
        if [[ -f "$backup_file" ]] || [[ -d "$backup_file" ]]; then
            local original_path="$HOME/$(basename "$backup_file")"
            info "Restoring $original_path"
            run_cmd cp -r "$backup_file" "$original_path"
        fi
    done
    
    ok "Rollback completed"
}

list_backups() {
    info "Available backups:"
    find "$HOME" -maxdepth 1 -name ".dotfiles-backup-*" -type d | sort
}

# ─────────────────────────────────────────────
# Verification
# ─────────────────────────────────────────────
verify_installation() {
    info "Verifying installation..."
    
    local verification_failed=false
    
    # Check if packages are stowed correctly
    local expected_links=(
        "$HOME/.zshrc"
        "$HOME/.tmux.conf"
        "$HOME/.aerospace.toml"
        "$HOME/.config/nvim"
        "$HOME/.config/ghostty"
    )
    
    for link in "${expected_links[@]}"; do
        if [[ -L "$link" ]]; then
            ok "$(basename "$link") symlinked correctly"
        else
            warn "$(basename "$link") not found or not a symlink"
            verification_failed=true
        fi
    done
    
    # Check if tools are available
    local tools=("nvim" "tmux" "starship" "stow")
    for tool in "${tools[@]}"; do
        if command -v "$tool" &>/dev/null; then
            ok "$tool available in PATH"
        else
            warn "$tool not found in PATH"
            verification_failed=true
        fi
    done
    
    if [[ "$verification_failed" == true ]]; then
        warn "Some verification checks failed"
        return 1
    else
        ok "Installation verification passed"
        return 0
    fi
}

# ─────────────────────────────────────────────
# Banner
# ─────────────────────────────────────────────
show_banner() {
    echo -e "${MAUVE}"
    cat << 'EOF'

    ╔╗╔┌─┐┬ ┬   ╔═╗┬  ┬┌─┌─┐┌┬┐┬ ┬
    ║║║├┤ │ │───╠═╣│  ├┴┐├┤ │││└┬┘
    ╝╚╝└─┘└─┘   ╩ ╩┴─┘┴ ┴└─┘┴ ┴ ┴

    dotfiles installer

EOF
    echo -e "${RESET}"
}

# ─────────────────────────────────────────────
# Usage and help
# ─────────────────────────────────────────────
usage() {
    cat << EOF
Usage: $0 [COMMAND] [OPTIONS]

COMMANDS:
  install         Full setup: deps + stow (default)
  stow            Stow all packages only
  unstow          Remove all symlinks
  deps            Install dependencies only
  verify          Verify installation
  rollback DIR    Rollback using backup directory
  list-backups    List available backup directories

OPTIONS:
  --dry-run       Show what would be done without executing
  --verbose       Enable verbose output
  --force         Force installation, overwrite conflicts
  --skip-deps     Skip dependency installation
  -h, --help      Show this help message

EXAMPLES:
  $0                          # Full installation
  $0 --dry-run                # Preview what would be installed
  $0 stow --force             # Force stow packages
  $0 rollback ~/.dotfiles-backup-20231201-120000

For detailed setup instructions, see: docs/SETUP.md
For troubleshooting help, see: docs/TROUBLESHOOTING.md
EOF
}

# ─────────────────────────────────────────────
# Main function
# ─────────────────────────────────────────────
main() {
    local cmd="install"
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            install|stow|unstow|deps|verify|list-backups)
                cmd="$1"
                shift
                ;;
            rollback)
                cmd="rollback"
                shift
                if [[ $# -eq 0 ]]; then
                    err "rollback command requires backup directory"
                    exit 1
                fi
                BACKUP_DIR="$1"
                shift
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --verbose)
                VERBOSE=true
                shift
                ;;
            --force)
                FORCE=true
                shift
                ;;
            --skip-deps)
                SKIP_DEPS=true
                shift
                ;;
            -h|--help|help)
                usage
                exit 0
                ;;
            *)
                err "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done
    
    # Show banner unless in dry-run mode
    [[ "$DRY_RUN" != true ]] && show_banner
    
    # Execute command
    case "$cmd" in
        install)
            check_os
            check_prerequisites
            check_conflicts
            install_homebrew
            install_deps
            install_tpm
            stow_packages
            verify_installation
            echo ""
            ok "Neu-Alkemy setup complete!"
            info "Backup created at: $BACKUP_DIR"
            info "Open a new terminal to pick up all changes"
            info "See docs/SETUP.md for post-installation steps"
            ;;
        stow)
            check_os
            check_conflicts
            stow_packages
            ;;
        unstow)
            unstow_packages
            ;;
        deps)
            check_os
            check_prerequisites
            install_homebrew
            install_deps
            install_tpm
            ;;
        verify)
            verify_installation
            ;;
        rollback)
            rollback_installation "$BACKUP_DIR"
            ;;
        list-backups)
            list_backups
            ;;
        *)
            err "Unknown command: $cmd"
            usage
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"