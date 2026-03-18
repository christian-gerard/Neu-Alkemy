# Contributing to Neu-Alkemy

Thank you for your interest in contributing to the Neu-Alkemy dotfiles! This document provides guidelines for contributing to make the process smooth and consistent.

## 🤝 How to Contribute

### Reporting Issues
- **Search existing issues** before creating a new one
- **Use issue templates** when available
- **Provide detailed information**:
  - macOS version
  - Shell version (`zsh --version`)
  - Steps to reproduce
  - Expected vs actual behavior
  - Error messages (full output)

### Suggesting Features
- **Check existing feature requests** first
- **Explain the use case** and why it would be beneficial
- **Consider the scope** - features should align with the dotfiles' philosophy
- **Provide examples** of how it would work

### Pull Requests
1. **Fork the repository**
2. **Create a feature branch** from `main`
3. **Make your changes** following the guidelines below
4. **Test thoroughly** using the provided tools
5. **Submit a pull request** with a clear description

## 📋 Development Guidelines

### Code Style

#### Shell Scripts
- **Use ShellCheck**: All shell scripts must pass `shellcheck`
- **Follow POSIX standards** where possible
- **Use proper error handling**:
  ```bash
  set -euo pipefail  # Exit on error, undefined vars, pipe failures
  ```
- **Include function documentation**:
  ```bash
  # Function description
  # Arguments:
  #   $1 - Description of first argument
  # Returns:
  #   0 on success, 1 on failure
  function_name() {
      local arg1="$1"
      # Function implementation
  }
  ```

#### Configuration Files
- **Maintain consistency** with existing style
- **Use meaningful comments** to explain complex configurations
- **Follow tool-specific conventions**
- **Test configurations** before submitting

#### Documentation
- **Use clear, concise language**
- **Include code examples** where helpful
- **Follow markdown best practices**
- **Update relevant documentation** when making changes

### Commit Message Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/) specification:

#### Format
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

#### Types
- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation only changes
- **style**: Changes that don't affect code meaning (formatting, etc.)
- **refactor**: Code change that neither fixes a bug nor adds a feature
- **test**: Adding missing tests or correcting existing tests
- **chore**: Changes to build process or auxiliary tools

#### Examples
```bash
# Good commit messages
feat(nvim): add LSP configuration for Rust
fix(tmux): resolve status bar color issues
docs: update installation instructions for Apple Silicon
refactor(install): improve error handling in dependency check
chore: update GitHub Actions workflow

# Bad commit messages
fix stuff
update
changes
WIP
```

#### Scope Guidelines
- **Package names**: `nvim`, `tmux`, `zsh`, `aerospace`, `ghostty`, `opencode`, `scripts`
- **Infrastructure**: `install`, `docs`, `ci`, `theme`
- **General**: omit scope for repository-wide changes

### Testing Guidelines

#### Before Submitting
1. **Run the validation suite**:
   ```bash
   # Test install script
   ./install.sh --dry-run
   ./install.sh verify
   
   # Validate shell scripts
   find . -name "*.sh" -exec shellcheck {} \;
   
   # Test stow operations
   make test-stow  # or manual testing
   ```

2. **Test on clean environment**:
   ```bash
   # Create test environment
   docker run -it --rm -v $(pwd):/dotfiles ubuntu:latest
   # Test installation process
   ```

3. **Verify documentation**:
   ```bash
   # Check for broken links
   make check-links
   
   # Validate markdown
   markdownlint *.md docs/*.md
   ```

#### Package Testing
When modifying packages:
- **Test stow/unstow operations**
- **Verify symlinks are created correctly**
- **Test with existing configurations** (backup/restore)
- **Check for conflicts** with default system configs

#### Integration Testing
- **Test with other packages** to ensure no conflicts
- **Verify theme consistency** across all tools
- **Test on fresh macOS installation** when possible

## 🎨 Theme Guidelines

### Color Consistency
All packages should use the **Catppuccin Mocha** color palette:

```
Base Colors:
- Base: #1e1e2e (background)
- Text: #cdd6f4 (foreground)
- Blue: #89b4fa (accent)
- Green: #a6e3a1 (success)
- Yellow: #f9e2af (warning)
- Red: #f38ba8 (error)
```

### Adding Theme Support
When adding new tools:
1. **Check for existing Catppuccin themes**
2. **Create custom theme** if none exists
3. **Document color mappings** in package README
4. **Test theme integration** with existing tools

## 📁 File Organization

### Directory Structure
```
package-name/
├── README.md              # Package documentation
├── .config/              # → ~/.config/
│   └── tool-name/
│       └── config-files
├── .tool-config          # → ~/.tool-config
└── additional-files
```

### Documentation Structure
- **Package README**: Focus on tool-specific information
- **Main README**: High-level overview and quick start
- **docs/**: Detailed guides and troubleshooting

### Naming Conventions
- **Files**: Use lowercase with hyphens (`my-config.conf`)
- **Directories**: Use lowercase with hyphens (`my-package/`)
- **Scripts**: Use descriptive names (`start_development.sh`)

## 🔧 Adding New Packages

### Checklist
- [ ] Create package directory with proper structure
- [ ] Add package to `PACKAGES` array in `install.sh`
- [ ] Include necessary dependencies in install script
- [ ] Create comprehensive package README
- [ ] Add theme integration (if applicable)
- [ ] Test stow operations
- [ ] Update main documentation
- [ ] Add to CI/CD validation

### Package README Template
```markdown
# Tool Name Configuration

Brief description of what this tool does.

## Files
- List of files and their targets

## Key Features
- Feature 1
- Feature 2

## Setup
Installation and configuration steps

## Key Bindings
Important shortcuts and commands

## Customization
How to customize the configuration

## Integration
How it works with other tools

## Troubleshooting
Common issues and solutions
```

## 🚨 Security Guidelines

### Sensitive Information
- **Never commit** API keys, passwords, or personal information
- **Use example files** for configurations with sensitive data
- **Add sensitive patterns** to `.gitignore`
- **Review changes** before committing

### File Permissions
- **Scripts should be executable**: `chmod +x script.sh`
- **Config files should not be executable**: `chmod 644 config.file`
- **Avoid overly permissive permissions**

### Dependencies
- **Only use trusted sources** for dependencies
- **Pin versions** when possible
- **Document security implications** of new dependencies

## 📝 Documentation Standards

### Writing Style
- **Use clear, concise language**
- **Write for different skill levels**
- **Include practical examples**
- **Use consistent terminology**

### Markdown Guidelines
- **Use proper heading hierarchy** (H1 → H2 → H3)
- **Include table of contents** for long documents
- **Use code blocks** with language specification
- **Add alt text** for images

### Code Examples
```bash
# Good: Clear, commented example
# Install dependencies
brew install neovim tmux

# Bad: Unclear, uncommented
brew install neovim tmux
```

## 🎯 Review Process

### Pull Request Reviews
- **Code quality**: Follows style guidelines
- **Functionality**: Works as intended
- **Documentation**: Adequate and accurate
- **Testing**: Properly tested
- **Security**: No security issues

### Review Criteria
- **Does it solve the stated problem?**
- **Is it consistent with existing code?**
- **Are there any breaking changes?**
- **Is documentation updated?**
- **Are tests passing?**

## 🏷️ Release Process

### Versioning
We use [Semantic Versioning](https://semver.org/):
- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes (backward compatible)

### Release Checklist
- [ ] All tests passing
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Version bumped
- [ ] Git tag created

## 🙏 Recognition

### Contributors
All contributors will be:
- **Listed in CONTRIBUTORS.md**
- **Mentioned in release notes** for significant contributions
- **Credited in relevant documentation**

### Types of Contributions
We value all types of contributions:
- **Code contributions**
- **Documentation improvements**
- **Bug reports**
- **Feature suggestions**
- **Testing and feedback**
- **Community support**

## 📞 Getting Help

### Communication Channels
- **GitHub Issues**: Bug reports and feature requests
- **GitHub Discussions**: General questions and community support
- **Pull Request Comments**: Code-specific discussions

### Response Times
- **Issues**: We aim to respond within 48 hours
- **Pull Requests**: Initial review within 72 hours
- **Security Issues**: Immediate attention (email maintainers)

## 📚 Resources

### Development Tools
- [ShellCheck](https://www.shellcheck.net/) - Shell script analysis
- [markdownlint](https://github.com/DavidAnson/markdownlint) - Markdown linting
- [GNU Stow](https://www.gnu.org/software/stow/) - Symlink management

### Style Guides
- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)

### macOS Development
- [Homebrew](https://brew.sh/) - Package manager
- [macOS Terminal](https://support.apple.com/guide/terminal/) - Built-in terminal
- [Accessibility API](https://developer.apple.com/accessibility/) - For window managers

Thank you for contributing to Neu-Alkemy! 🚀