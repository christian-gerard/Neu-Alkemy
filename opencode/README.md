# OpenCode Configuration

AI coding agent configurations with custom agents and themes.

## Overview

OpenCode is an AI-powered coding assistant that provides intelligent code completion, generation, and analysis. This configuration includes custom agents specialized for different development tasks and a cohesive theme integration.

## Files

- `.config/opencode/` → `~/.config/opencode/` - Complete OpenCode configuration
  - `opencode.jsonc` - Main configuration file
  - `agent/` - Custom agent definitions
  - `themes/` - Theme configurations
  - `skills/` - Specialized skills and workflows

## Key Features

- **🤖 Custom Agents**: Specialized AI agents for different development tasks
- **🎨 Neu-Alkemy Theme**: Consistent theming with the rest of the dotfiles
- **🛠️ Skills System**: Reusable workflows and code patterns
- **⚡ Fast Integration**: Quick access to AI assistance during development
- **🔧 Customizable**: Easily extendable with new agents and skills

## Custom Agents

### Metis - The Planner
**Purpose**: Architecture and planning specialist
- System design and architecture decisions
- Project planning and task breakdown
- Code structure recommendations
- Technology stack suggestions

**Usage**:
```bash
opencode agent metis "Plan the architecture for a new web application"
```

### Noesis - The Researcher  
**Purpose**: Research and analysis specialist
- Code analysis and review
- Best practices research
- Technology comparisons
- Documentation analysis

**Usage**:
```bash
opencode agent noesis "Analyze this codebase for potential improvements"
```

### Tekton - The Builder
**Purpose**: Implementation and coding specialist
- Code generation and implementation
- Bug fixes and optimizations
- Refactoring assistance
- Testing code generation

**Usage**:
```bash
opencode agent tekton "Implement a REST API for user management"
```

## Theme Configuration

### Neu-Alkemy Theme
The OpenCode interface uses the Catppuccin Mocha color palette:

```json
{
  "theme": {
    "name": "neu-alkemy",
    "colors": {
      "background": "#1e1e2e",
      "foreground": "#cdd6f4",
      "accent": "#89b4fa",
      "success": "#a6e3a1",
      "warning": "#f9e2af",
      "error": "#f38ba8"
    }
  }
}
```

## Skills System

### Available Skills
- **testing** - Test generation and validation workflows
- **refactoring** - Code refactoring patterns
- **documentation** - Documentation generation
- **debugging** - Debugging assistance workflows

### Using Skills
```bash
# Apply a skill to current context
opencode skill testing "Generate unit tests for this function"

# List available skills
opencode skills list
```

## Configuration

### Main Settings (`opencode.jsonc`)
```json
{
  "model": "claude-3-sonnet",
  "theme": "neu-alkemy",
  "agents": {
    "default": "tekton",
    "planning": "metis",
    "research": "noesis",
    "implementation": "tekton"
  },
  "features": {
    "autocompletion": true,
    "contextAware": true,
    "multiAgent": true
  }
}
```

### Agent Configuration
Each agent has its own configuration file in `agent/`:
- `metis.md` - Planning and architecture agent
- `noesis.md` - Research and analysis agent  
- `tekton.md` - Implementation and coding agent

## Setup

1. **Install OpenCode**:
   ```bash
   npm install -g @opencode-ai/cli
   ```

2. **Stow configuration**:
   ```bash
   stow -d ~/Neu-Alkemy -t ~ opencode
   ```

3. **Initialize OpenCode**:
   ```bash
   opencode init
   ```

4. **Configure API key**:
   ```bash
   opencode config set apiKey YOUR_API_KEY
   ```

## Usage

### Basic Commands
```bash
# Start interactive session
opencode

# Quick code generation
opencode generate "Create a React component for user profile"

# Code analysis
opencode analyze file.js

# Use specific agent
opencode agent metis "Plan database schema for e-commerce app"
```

### Integration with Neovim
OpenCode integrates seamlessly with Neovim:
- Code completion in insert mode
- Quick agent access via key bindings
- Context-aware suggestions

### Integration with Tmux
Use OpenCode in dedicated tmux panes:
```bash
# Create OpenCode session
tmux new-window -n "ai" "opencode"

# Quick agent access
tmux send-keys -t ai "opencode agent tekton 'fix this bug'" Enter
```

## Customization

### Creating Custom Agents
Create a new agent file in `agent/`:
```markdown
# Custom Agent Name

## Role
Specialized description of the agent's purpose

## Capabilities
- Capability 1
- Capability 2
- Capability 3

## Examples
Example prompts and use cases

## Configuration
Specific settings for this agent
```

### Adding Skills
Create skill files in `skills/`:
```markdown
# Skill Name

## Description
What this skill does

## Workflow
Step-by-step process

## Templates
Code templates and patterns

## Usage Examples
How to use this skill effectively
```

### Theme Customization
Edit `themes/neu-alkemy.json`:
```json
{
  "name": "neu-alkemy",
  "colors": {
    "primary": "#89b4fa",
    "secondary": "#cba6f7",
    "background": "#1e1e2e",
    "surface": "#313244",
    "text": "#cdd6f4"
  },
  "syntax": {
    "keyword": "#cba6f7",
    "string": "#a6e3a1",
    "comment": "#6c7086",
    "function": "#89b4fa"
  }
}
```

## Workflows

### Development Workflow
1. **Planning**: Use Metis for architecture decisions
2. **Research**: Use Noesis for technology analysis
3. **Implementation**: Use Tekton for code generation
4. **Review**: Use Noesis for code review

### Example Session
```bash
# Plan the feature
opencode agent metis "Plan user authentication system"

# Research best practices
opencode agent noesis "Compare JWT vs session-based auth"

# Implement the code
opencode agent tekton "Generate JWT authentication middleware"

# Review the implementation
opencode agent noesis "Review this authentication code for security"
```

## Troubleshooting

### Common Issues

**API Key Issues**:
```bash
# Check current configuration
opencode config list

# Reset API key
opencode config set apiKey NEW_API_KEY
```

**Agent Not Found**:
```bash
# List available agents
opencode agents list

# Check agent configuration
opencode agent info metis
```

**Theme Issues**:
```bash
# List available themes
opencode themes list

# Apply theme
opencode theme set neu-alkemy
```

### Performance Issues
```bash
# Clear cache
opencode cache clear

# Check status
opencode status

# Update to latest version
npm update -g @opencode-ai/cli
```

## Integration

### With Git
```bash
# Generate commit messages
opencode generate "Create commit message for these changes" --context git

# Code review assistance
opencode agent noesis "Review this pull request"
```

### With Testing
```bash
# Generate tests
opencode skill testing "Generate tests for this module"

# Debug test failures
opencode agent tekton "Fix failing test: $(cat test-output.log)"
```

### With Documentation
```bash
# Generate documentation
opencode skill documentation "Document this API endpoint"

# Update README
opencode generate "Update README with new features"
```

## Best Practices

### Prompt Engineering
- Be specific about requirements
- Provide context and examples
- Use appropriate agents for different tasks
- Iterate and refine prompts

### Agent Selection
- **Metis**: For planning and architecture
- **Noesis**: For research and analysis
- **Tekton**: For implementation and coding

### Workflow Integration
- Use OpenCode as part of your development workflow
- Combine with existing tools (git, testing, etc.)
- Leverage skills for common patterns

## Resources

- [OpenCode Documentation](https://opencode.ai/docs)
- [Agent Development Guide](https://opencode.ai/docs/agents)
- [Skills Reference](https://opencode.ai/docs/skills)
- [API Reference](https://opencode.ai/docs/api)