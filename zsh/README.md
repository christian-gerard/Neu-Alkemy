# Zsh Configuration

Modern Zsh setup with Oh-my-zsh, Starship prompt, and Catppuccin theming.

## Overview

This Zsh configuration provides a powerful, beautiful, and productive shell experience with modern features, intelligent completions, and a stunning prompt powered by Starship.

## Files

- `.zshrc` → `~/.zshrc` - Main Zsh configuration
- `.config/starship.toml` → `~/.config/starship.toml` - Starship prompt configuration

## Key Features

- **🚀 Starship Prompt**: Fast, customizable prompt with git integration
- **🎨 Catppuccin Theme**: Beautiful colors throughout the shell experience
- **⌨️ Vi Mode**: Vim-style command line editing
- **📝 Oh-my-zsh**: Powerful framework with plugins and themes
- **🔍 Intelligent Completion**: Smart tab completion and suggestions
- **📚 Useful Aliases**: Productive shortcuts for common commands
- **🔧 Tool Integration**: Seamless integration with development tools

## Prompt Features

### Starship Modules
- **Directory**: Current path with smart truncation
- **Git Branch**: Current branch with status indicators
- **Git Status**: Staged, modified, and untracked file counts
- **Language Versions**: Node.js, Python, Rust, Go versions when relevant
- **Command Duration**: Execution time for long-running commands
- **Exit Code**: Error indicator for failed commands
- **Battery**: Battery level on laptops
- **Time**: Current time (optional)

### Git Integration
- `●` - Staged changes
- `+` - Unstaged changes  
- `?` - Untracked files
- `⇡` - Ahead of remote
- `⇣` - Behind remote
- `⇕` - Diverged from remote

## Oh-my-zsh Plugins

### Enabled Plugins
```bash
plugins=(
  git              # Git aliases and functions
  vi-mode          # Vim-style editing
  zsh-autosuggestions  # Command suggestions
  zsh-syntax-highlighting  # Syntax highlighting
  brew             # Homebrew completions
  docker           # Docker completions
  kubectl          # Kubernetes completions
  tmux             # Tmux integration
)
```

### Plugin Features
- **git**: Extensive git aliases (`gst`, `gco`, `gp`, etc.)
- **vi-mode**: Vim keybindings in command line
- **autosuggestions**: Fish-like command suggestions
- **syntax-highlighting**: Real-time syntax highlighting
- **brew**: Homebrew command completions
- **docker**: Docker command completions

## Key Bindings

### Vi Mode
- `ESC` - Enter normal mode
- `i` - Enter insert mode
- `A` - Append at end of line
- `I` - Insert at beginning of line
- `dd` - Delete line
- `yy` - Yank line
- `p` - Paste

### Navigation
- `Ctrl-A` - Beginning of line
- `Ctrl-E` - End of line
- `Ctrl-W` - Delete word backward
- `Ctrl-U` - Delete line backward
- `Ctrl-K` - Delete line forward

### History
- `Ctrl-R` - Reverse history search
- `Ctrl-P` - Previous command
- `Ctrl-N` - Next command
- `!!` - Previous command
- `!$` - Last argument of previous command

## Aliases

### Git Aliases
```bash
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gp='git push'
alias gl='git pull'
alias gst='git status'
alias gd='git diff'
alias gb='git branch'
alias gm='git merge'
```

### Navigation
```bash
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'
```

### File Operations
```bash
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -ltr'
alias lh='ls -lh'
```

### System
```bash
alias reload='source ~/.zshrc'
alias path='echo $PATH | tr ":" "\n"'
alias ports='lsof -i -P -n | grep LISTEN'
alias top='htop'
```

### Development
```bash
alias vim='nvim'
alias v='nvim'
alias tmux='tmux -2'
alias t='tmux'
alias dc='docker-compose'
alias k='kubectl'
```

## Functions

### Utility Functions
```bash
# Create directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract various archive formats
extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Find and kill process by name
killport() {
  lsof -ti:$1 | xargs kill -9
}
```

## Setup

1. **Install Zsh** (usually pre-installed on macOS):
   ```bash
   brew install zsh
   ```

2. **Install Oh-my-zsh**:
   ```bash
   sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

3. **Install Starship**:
   ```bash
   brew install starship
   ```

4. **Install additional plugins**:
   ```bash
   # zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   
   # zsh-syntax-highlighting
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   ```

5. **Stow configuration**:
   ```bash
   stow -d ~/Neu-Alkemy -t ~ zsh
   ```

6. **Restart shell**:
   ```bash
   exec zsh
   ```

## Customization

### Starship Prompt
Edit `~/.config/starship.toml`:
```toml
# Custom format
format = """
$username\
$hostname\
$directory\
$git_branch\
$git_status\
$nodejs\
$python\
$rust\
$cmd_duration\
$line_break\
$character"""

# Directory settings
[directory]
truncation_length = 3
truncation_symbol = "…/"

# Git branch
[git_branch]
symbol = " "
format = "on [$symbol$branch]($style) "

# Command duration
[cmd_duration]
min_time = 2_000
format = "took [$duration]($style) "
```

### Adding Custom Aliases
Add to `~/.zshrc`:
```bash
# Custom aliases
alias myalias='my command'
alias work='cd ~/work && tmux new-session -s work'
```

### Oh-my-zsh Theme
While we use Starship, you can still customize Oh-my-zsh:
```bash
# In ~/.zshrc
ZSH_THEME="robbyrussell"  # Default theme
# ZSH_THEME=""  # Disable for Starship
```

### Environment Variables
```bash
# Add to ~/.zshrc
export EDITOR='nvim'
export BROWSER='open'
export TERM='xterm-256color'
export LANG='en_US.UTF-8'
```

## Integration

### With Tmux
Seamless integration:
- Shared history across tmux panes
- Proper color support
- Vi-mode works in tmux

### With Neovim
Perfect development workflow:
- Shared clipboard
- Consistent vi-mode experience
- Terminal integration

### With Git
Enhanced git workflow:
- Rich git prompt information
- Extensive git aliases
- Smart completions

## Performance

### Optimization Tips
```bash
# Lazy load heavy plugins
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Reduce plugin load time
zstyle ':omz:update' mode disabled  # Disable auto-updates
```

### Profiling
```bash
# Profile startup time
time zsh -i -c exit

# Enable profiling
zmodload zsh/zprof
# ... rest of config
zprof
```

## Troubleshooting

### Slow Startup
1. **Profile startup**: Use `time zsh -i -c exit`
2. **Disable plugins**: Comment out plugins temporarily
3. **Check compinit**: Ensure completion cache is working

### Plugin Issues
```bash
# Reload Oh-my-zsh
omz reload

# Update Oh-my-zsh
omz update

# Reinstall plugins
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/plugin-name
# Reinstall plugin
```

### Starship Issues
```bash
# Check Starship config
starship config

# Test prompt
starship prompt

# Update Starship
brew upgrade starship
```

### Completion Issues
```bash
# Rebuild completion cache
rm ~/.zcompdump*
compinit

# Check completion system
autoload -Uz compinit && compinit
```

## Advanced Features

### Custom Completions
```bash
# Add custom completion
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit && compinit
```

### Conditional Loading
```bash
# Load different configs based on system
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS specific
  source ~/.zsh/macos.zsh
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux specific
  source ~/.zsh/linux.zsh
fi
```

### History Configuration
```bash
# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
```

## Resources

- [Zsh Documentation](https://zsh.sourceforge.io/Doc/)
- [Oh-my-zsh](https://ohmyz.sh/)
- [Starship](https://starship.rs/)
- [Catppuccin](https://github.com/catppuccin/catppuccin)