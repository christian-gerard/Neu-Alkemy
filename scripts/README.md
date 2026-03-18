# Development Scripts

Automation scripts for development workflows and environment setup.

## Overview

This collection of scripts provides quick access to common development tasks, environment setup, and workflow automation. Scripts are designed to integrate with tmux, providing instant access to development environments.

## Files

- `scripts/` → `~/scripts/` - Development automation scripts
  - `start_jump.sh` - Launch Jump development environment
  - `start_learn.sh` - Launch learning/experimentation environment

## Available Scripts

### start_jump.sh
**Purpose**: Launch the Jump development environment with tmuxp

**Features**:
- Starts tmux session with predefined layout
- Opens relevant directories and files
- Launches development servers
- Sets up git workflow panes

**Usage**:
```bash
~/scripts/start_jump.sh
# or if ~/scripts is in PATH:
start_jump.sh
```

**Session Layout**:
- **Window 1 (Editor)**: Neovim with project files
- **Window 2 (Server)**: Development server (Rails, Node.js, etc.)
- **Window 3 (Database)**: Database console and monitoring
- **Window 4 (Git)**: Git operations and version control
- **Window 5 (Terminal)**: General purpose terminal

### start_learn.sh  
**Purpose**: Launch learning and experimentation environment

**Features**:
- Creates isolated learning workspace
- Sets up note-taking environment
- Opens documentation and references
- Provides clean experimentation space

**Usage**:
```bash
~/scripts/start_learn.sh
# or if ~/scripts is in PATH:
start_learn.sh
```

**Session Layout**:
- **Window 1 (Notes)**: Markdown notes and documentation
- **Window 2 (Code)**: Code experimentation and prototyping
- **Window 3 (Research)**: Web browser and documentation
- **Window 4 (Terminal)**: Command line exploration

## Script Features

### Tmuxp Integration
All scripts use tmuxp for session management:
- Consistent session layouts
- Reproducible environments
- Easy customization
- Session persistence

### Environment Detection
Scripts automatically detect:
- Project type (Node.js, Python, Ruby, etc.)
- Available tools and dependencies
- Git repository status
- Development server requirements

### Error Handling
- Graceful failure handling
- Dependency checking
- User feedback and guidance
- Rollback capabilities

## Customization

### Creating New Scripts
1. **Create script file**:
   ```bash
   touch ~/scripts/my_script.sh
   chmod +x ~/scripts/my_script.sh
   ```

2. **Basic script template**:
   ```bash
   #!/usr/bin/env bash
   set -euo pipefail
   
   # Script configuration
   SCRIPT_NAME="My Script"
   SESSION_NAME="my-session"
   
   # Colors for output
   GREEN='\033[0;32m'
   BLUE='\033[0;34m'
   RED='\033[0;31m'
   NC='\033[0m'
   
   info() { echo -e "${BLUE}[INFO]${NC} $*"; }
   success() { echo -e "${GREEN}[SUCCESS]${NC} $*"; }
   error() { echo -e "${RED}[ERROR]${NC} $*"; }
   
   main() {
       info "Starting $SCRIPT_NAME..."
       
       # Check if tmux session exists
       if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
           info "Attaching to existing session: $SESSION_NAME"
           tmux attach-session -t "$SESSION_NAME"
       else
           info "Creating new session: $SESSION_NAME"
           tmuxp load ~/.tmuxp/my-session.yaml
       fi
       
       success "$SCRIPT_NAME completed!"
   }
   
   main "$@"
   ```

### Modifying Existing Scripts
Edit scripts in `~/scripts/` to customize:
- Session layouts
- Project paths
- Development servers
- Tool configurations

### Adding to PATH
Add scripts directory to PATH in `~/.zshrc`:
```bash
export PATH="$HOME/scripts:$PATH"
```

## Tmuxp Templates

### Creating Session Templates
Create tmuxp configuration files in `~/.tmuxp/`:

```yaml
# ~/.tmuxp/my-project.yaml
session_name: my-project
start_directory: ~/projects/my-project

windows:
  - window_name: editor
    start_directory: ~/projects/my-project
    panes:
      - nvim
      
  - window_name: server
    start_directory: ~/projects/my-project
    panes:
      - npm run dev
      
  - window_name: database
    start_directory: ~/projects/my-project
    panes:
      - psql my_database
      
  - window_name: git
    start_directory: ~/projects/my-project
    panes:
      - git status
      - # Empty pane for git operations
      
  - window_name: terminal
    start_directory: ~/projects/my-project
    panes:
      - # General purpose terminal
```

### Advanced Templates
```yaml
# Complex layout with split panes
session_name: advanced-project
start_directory: ~/projects/advanced-project

windows:
  - window_name: main
    layout: main-horizontal
    panes:
      - shell_command:
          - nvim
      - shell_command:
          - npm run dev
        start_directory: ~/projects/advanced-project/server
      - shell_command:
          - npm run dev
        start_directory: ~/projects/advanced-project/client
        
  - window_name: monitoring
    layout: tiled
    panes:
      - htop
      - tail -f logs/development.log
      - docker stats
      - watch -n 1 'ps aux | grep node'
```

## Integration

### With Git
Scripts can integrate with git workflows:
```bash
# Check git status before starting
if ! git status &>/dev/null; then
    error "Not in a git repository"
    exit 1
fi

# Create feature branch
BRANCH_NAME="feature/$(date +%Y%m%d-%H%M%S)"
git checkout -b "$BRANCH_NAME"
```

### With Docker
Include Docker services in development environments:
```bash
# Start Docker services
if [ -f "docker-compose.yml" ]; then
    info "Starting Docker services..."
    docker-compose up -d
fi
```

### With Package Managers
Detect and use appropriate package managers:
```bash
# Detect package manager
if [ -f "package.json" ]; then
    if [ -f "yarn.lock" ]; then
        PACKAGE_MANAGER="yarn"
    elif [ -f "pnpm-lock.yaml" ]; then
        PACKAGE_MANAGER="pnpm"
    else
        PACKAGE_MANAGER="npm"
    fi
    
    info "Using package manager: $PACKAGE_MANAGER"
    $PACKAGE_MANAGER install
fi
```

## Best Practices

### Script Organization
- Keep scripts focused on single purposes
- Use descriptive names
- Include help text and usage examples
- Handle errors gracefully

### Session Management
- Use unique session names
- Check for existing sessions
- Provide options to attach or create new
- Clean up on exit

### Environment Setup
- Check dependencies before starting
- Set up environment variables
- Configure development tools
- Validate project structure

## Troubleshooting

### Common Issues

**Script Not Executable**:
```bash
chmod +x ~/scripts/script_name.sh
```

**Tmuxp Template Not Found**:
```bash
# Check if template exists
ls ~/.tmuxp/

# Create missing template
cp ~/.tmuxp/example.yaml ~/.tmuxp/my-template.yaml
```

**Session Already Exists**:
```bash
# Kill existing session
tmux kill-session -t session-name

# Or attach to existing
tmux attach-session -t session-name
```

**Dependencies Missing**:
```bash
# Check for required tools
which tmux tmuxp nvim

# Install missing dependencies
brew install tmux tmuxp neovim
```

### Debugging Scripts
```bash
# Run with debug output
bash -x ~/scripts/script_name.sh

# Check script syntax
bash -n ~/scripts/script_name.sh
```

## Examples

### Quick Development Setup
```bash
#!/usr/bin/env bash
# quick_dev.sh - Rapid development environment setup

PROJECT_DIR="$1"
SESSION_NAME="$(basename "$PROJECT_DIR")"

if [ -z "$PROJECT_DIR" ]; then
    echo "Usage: $0 <project_directory>"
    exit 1
fi

cd "$PROJECT_DIR" || exit 1

# Create tmux session
tmux new-session -d -s "$SESSION_NAME"

# Setup windows
tmux new-window -t "$SESSION_NAME" -n "editor" "nvim"
tmux new-window -t "$SESSION_NAME" -n "server" 
tmux new-window -t "$SESSION_NAME" -n "terminal"

# Attach to session
tmux attach-session -t "$SESSION_NAME"
```

### Project Initializer
```bash
#!/usr/bin/env bash
# init_project.sh - Initialize new project with development environment

PROJECT_NAME="$1"
PROJECT_TYPE="$2"

if [ -z "$PROJECT_NAME" ] || [ -z "$PROJECT_TYPE" ]; then
    echo "Usage: $0 <project_name> <type>"
    echo "Types: node, python, rust, go"
    exit 1
fi

# Create project directory
mkdir -p ~/projects/"$PROJECT_NAME"
cd ~/projects/"$PROJECT_NAME"

# Initialize based on type
case "$PROJECT_TYPE" in
    "node")
        npm init -y
        echo "node_modules/" > .gitignore
        ;;
    "python")
        python -m venv venv
        echo "venv/" > .gitignore
        echo "__pycache__/" >> .gitignore
        ;;
    "rust")
        cargo init
        ;;
    "go")
        go mod init "$PROJECT_NAME"
        ;;
esac

# Initialize git
git init
git add .
git commit -m "Initial commit"

# Start development environment
~/scripts/start_dev.sh "$PROJECT_NAME"
```

## Resources

- [Tmux Manual](https://man7.org/linux/man-pages/man1/tmux.1.html)
- [Tmuxp Documentation](https://tmuxp.git-pull.com/)
- [Bash Scripting Guide](https://tldp.org/LDP/Bash-Beginners-Guide/html/)
- [Shell Style Guide](https://google.github.io/styleguide/shellguide.html)