# Neu-Alkemy Dotfiles Makefile
# Provides convenient shortcuts for common operations

.PHONY: help install stow unstow clean validate test lint format check-links backup restore

# Default target
.DEFAULT_GOAL := help

# Colors for output
BLUE := \033[36m
GREEN := \033[32m
YELLOW := \033[33m
RED := \033[31m
RESET := \033[0m

# Configuration
DOTFILES_DIR := $(shell pwd)
BACKUP_DIR := $(HOME)/.dotfiles-backup-$(shell date +%Y%m%d-%H%M%S)
PACKAGES := aerospace ghostty nvim opencode scripts tmux zsh

## Installation and Setup

install: ## Full installation (dependencies + stow)
	@echo "$(BLUE)🚀 Running full installation...$(RESET)"
	./install.sh

install-deps: ## Install dependencies only
	@echo "$(BLUE)📦 Installing dependencies...$(RESET)"
	./install.sh deps

install-dry-run: ## Preview installation without executing
	@echo "$(BLUE)🧪 Running dry-run installation...$(RESET)"
	./install.sh --dry-run

## Stow Operations

stow: ## Stow all packages
	@echo "$(BLUE)🔗 Stowing all packages...$(RESET)"
	./install.sh stow

stow-package: ## Stow specific package (usage: make stow-package PACKAGE=nvim)
	@if [ -z "$(PACKAGE)" ]; then \
		echo "$(RED)❌ Error: PACKAGE not specified$(RESET)"; \
		echo "$(YELLOW)Usage: make stow-package PACKAGE=nvim$(RESET)"; \
		exit 1; \
	fi
	@echo "$(BLUE)🔗 Stowing package: $(PACKAGE)$(RESET)"
	stow -v -d $(DOTFILES_DIR) -t $(HOME) $(PACKAGE)

unstow: ## Remove all symlinks
	@echo "$(BLUE)🔓 Unstowing all packages...$(RESET)"
	./install.sh unstow

unstow-package: ## Unstow specific package (usage: make unstow-package PACKAGE=nvim)
	@if [ -z "$(PACKAGE)" ]; then \
		echo "$(RED)❌ Error: PACKAGE not specified$(RESET)"; \
		echo "$(YELLOW)Usage: make unstow-package PACKAGE=nvim$(RESET)"; \
		exit 1; \
	fi
	@echo "$(BLUE)🔓 Unstowing package: $(PACKAGE)$(RESET)"
	stow -v -D -d $(DOTFILES_DIR) -t $(HOME) $(PACKAGE)

restow: ## Restow all packages (useful for updates)
	@echo "$(BLUE)🔄 Restowing all packages...$(RESET)"
	for package in $(PACKAGES); do \
		echo "$(BLUE)🔄 Restowing $$package...$(RESET)"; \
		stow -v -R -d $(DOTFILES_DIR) -t $(HOME) $$package; \
	done

## Validation and Testing

validate: ## Run all validation checks
	@echo "$(BLUE)🔍 Running validation suite...$(RESET)"
	./install.sh verify

test: validate ## Alias for validate

test-stow: ## Test stow operations without applying
	@echo "$(BLUE)🧪 Testing stow operations...$(RESET)"
	@for package in $(PACKAGES); do \
		echo "$(BLUE)Testing stow for $$package...$(RESET)"; \
		stow --simulate -v -d $(DOTFILES_DIR) -t /tmp/stow-test $$package || { \
			echo "$(RED)❌ Stow test failed for $$package$(RESET)"; \
			exit 1; \
		}; \
	done
	@echo "$(GREEN)✅ All stow tests passed$(RESET)"

test-install: ## Test installation in temporary directory
	@echo "$(BLUE)🧪 Testing installation process...$(RESET)"
	@mkdir -p /tmp/dotfiles-test
	@cp -r . /tmp/dotfiles-test/
	@cd /tmp/dotfiles-test && ./install.sh --dry-run
	@rm -rf /tmp/dotfiles-test
	@echo "$(GREEN)✅ Installation test passed$(RESET)"

## Code Quality

lint: ## Run linting checks
	@echo "$(BLUE)🔍 Running linting checks...$(RESET)"
	@echo "$(BLUE)Checking shell scripts...$(RESET)"
	@find . -name "*.sh" -type f -exec shellcheck {} \; || echo "$(YELLOW)⚠️ ShellCheck issues found$(RESET)"
	@echo "$(BLUE)Checking YAML files...$(RESET)"
	@find . -name "*.yml" -o -name "*.yaml" | grep -v ".git" | xargs -I {} yamllint {} || echo "$(YELLOW)⚠️ YAML issues found$(RESET)"
	@echo "$(BLUE)Checking JSON files...$(RESET)"
	@find . -name "*.json" -type f | grep -v ".git" | grep -v "node_modules" | while read -r file; do \
		echo "Validating $$file"; \
		python3 -m json.tool "$$file" > /dev/null || echo "$(RED)❌ Invalid JSON: $$file$(RESET)"; \
	done

format: ## Format shell scripts and configuration files
	@echo "$(BLUE)🎨 Formatting files...$(RESET)"
	@echo "$(BLUE)Formatting shell scripts...$(RESET)"
	@find . -name "*.sh" -type f -exec shfmt -w {} \; 2>/dev/null || echo "$(YELLOW)⚠️ shfmt not available$(RESET)"
	@echo "$(GREEN)✅ Formatting complete$(RESET)"

check-syntax: ## Check syntax of shell scripts
	@echo "$(BLUE)🔍 Checking shell script syntax...$(RESET)"
	@find . -name "*.sh" -type f -exec bash -n {} \; && echo "$(GREEN)✅ All shell scripts have valid syntax$(RESET)"

check-links: ## Check documentation links
	@echo "$(BLUE)🔗 Checking documentation links...$(RESET)"
	@if command -v markdown-link-check >/dev/null 2>&1; then \
		find . -name "*.md" -not -path "./.git/*" -exec markdown-link-check {} \; || true; \
	else \
		echo "$(YELLOW)⚠️ markdown-link-check not available. Install with: npm install -g markdown-link-check$(RESET)"; \
	fi

## Backup and Restore

backup: ## Create backup of current configurations
	@echo "$(BLUE)💾 Creating backup...$(RESET)"
	@mkdir -p $(BACKUP_DIR)
	@for package in $(PACKAGES); do \
		if [ -d "$$package" ]; then \
			echo "$(BLUE)Backing up $$package configurations...$(RESET)"; \
			find $$package -name ".*" -type f | while read -r file; do \
				target="$(HOME)/$$(echo $$file | sed 's|^[^/]*/||')"; \
				if [ -f "$$target" ] && [ ! -L "$$target" ]; then \
					mkdir -p "$(BACKUP_DIR)/$$(dirname $$file)"; \
					cp "$$target" "$(BACKUP_DIR)/$$file"; \
				fi; \
			done; \
		fi; \
	done
	@echo "$(GREEN)✅ Backup created at: $(BACKUP_DIR)$(RESET)"

restore: ## Restore from backup (usage: make restore BACKUP_DIR=path/to/backup)
	@if [ -z "$(BACKUP_DIR)" ]; then \
		echo "$(RED)❌ Error: BACKUP_DIR not specified$(RESET)"; \
		echo "$(YELLOW)Usage: make restore BACKUP_DIR=/path/to/backup$(RESET)"; \
		echo "$(YELLOW)Available backups:$(RESET)"; \
		find $(HOME) -maxdepth 1 -name ".dotfiles-backup-*" -type d | sort; \
		exit 1; \
	fi
	@echo "$(BLUE)🔄 Restoring from backup: $(BACKUP_DIR)$(RESET)"
	./install.sh rollback $(BACKUP_DIR)

list-backups: ## List available backup directories
	@echo "$(BLUE)📋 Available backups:$(RESET)"
	@find $(HOME) -maxdepth 1 -name ".dotfiles-backup-*" -type d | sort

## Cleanup

clean: ## Clean up temporary files and caches
	@echo "$(BLUE)🧹 Cleaning up...$(RESET)"
	@echo "$(BLUE)Removing temporary files...$(RESET)"
	@find . -name "*.tmp" -type f -delete
	@find . -name "*.log" -type f -delete
	@find . -name ".DS_Store" -type f -delete
	@echo "$(BLUE)Cleaning Neovim cache...$(RESET)"
	@rm -rf $(HOME)/.local/share/nvim/lazy
	@rm -rf $(HOME)/.local/state/nvim
	@rm -rf $(HOME)/.cache/nvim
	@echo "$(GREEN)✅ Cleanup complete$(RESET)"

clean-all: clean unstow ## Complete cleanup (remove symlinks and temporary files)
	@echo "$(GREEN)✅ Complete cleanup finished$(RESET)"

## Information

status: ## Show current dotfiles status
	@echo "$(BLUE)📊 Dotfiles Status$(RESET)"
	@echo "$(BLUE)==================$(RESET)"
	@echo "$(BLUE)Repository:$(RESET) $(DOTFILES_DIR)"
	@echo "$(BLUE)Packages:$(RESET) $(PACKAGES)"
	@echo ""
	@echo "$(BLUE)Stowed packages:$(RESET)"
	@for package in $(PACKAGES); do \
		if [ -d "$$package" ]; then \
			echo -n "  $$package: "; \
			if stow --simulate -d $(DOTFILES_DIR) -t $(HOME) $$package >/dev/null 2>&1; then \
				echo "$(GREEN)✅ Ready to stow$(RESET)"; \
			else \
				echo "$(YELLOW)⚠️ Conflicts detected$(RESET)"; \
			fi; \
		fi; \
	done
	@echo ""
	@echo "$(BLUE)Git status:$(RESET)"
	@git status --porcelain | head -10

info: status ## Alias for status

packages: ## List all available packages
	@echo "$(BLUE)📦 Available Packages$(RESET)"
	@echo "$(BLUE)=====================$(RESET)"
	@for package in $(PACKAGES); do \
		if [ -d "$$package" ]; then \
			echo "$(GREEN)✅ $$package$(RESET)"; \
			if [ -f "$$package/README.md" ]; then \
				echo "   📖 Documentation: $$package/README.md"; \
			fi; \
		else \
			echo "$(RED)❌ $$package$(RESET) (missing)"; \
		fi; \
	done

deps: ## Check dependencies
	@echo "$(BLUE)🔍 Checking Dependencies$(RESET)"
	@echo "$(BLUE)========================$(RESET)"
	@echo -n "$(BLUE)Homebrew:$(RESET) "
	@if command -v brew >/dev/null 2>&1; then \
		echo "$(GREEN)✅ $(shell brew --version | head -1)$(RESET)"; \
	else \
		echo "$(RED)❌ Not installed$(RESET)"; \
	fi
	@echo -n "$(BLUE)GNU Stow:$(RESET) "
	@if command -v stow >/dev/null 2>&1; then \
		echo "$(GREEN)✅ $(shell stow --version | head -1)$(RESET)"; \
	else \
		echo "$(RED)❌ Not installed$(RESET)"; \
	fi
	@echo -n "$(BLUE)ShellCheck:$(RESET) "
	@if command -v shellcheck >/dev/null 2>&1; then \
		echo "$(GREEN)✅ $(shell shellcheck --version | grep version | cut -d' ' -f2)$(RESET)"; \
	else \
		echo "$(YELLOW)⚠️ Not installed (optional)$(RESET)"; \
	fi

## Development

dev-setup: ## Setup development environment
	@echo "$(BLUE)🛠️ Setting up development environment...$(RESET)"
	@echo "$(BLUE)Installing development dependencies...$(RESET)"
	@brew install shellcheck yamllint shfmt 2>/dev/null || echo "$(YELLOW)⚠️ Some tools may not be available$(RESET)"
	@npm install -g markdown-link-check 2>/dev/null || echo "$(YELLOW)⚠️ markdown-link-check not installed$(RESET)"
	@echo "$(GREEN)✅ Development environment ready$(RESET)"

pre-commit: lint check-syntax test-stow ## Run pre-commit checks
	@echo "$(GREEN)✅ Pre-commit checks passed$(RESET)"

## Documentation

docs: ## Generate/update documentation
	@echo "$(BLUE)📚 Updating documentation...$(RESET)"
	@echo "$(BLUE)Checking documentation completeness...$(RESET)"
	@for package in $(PACKAGES); do \
		if [ ! -f "$$package/README.md" ]; then \
			echo "$(RED)❌ Missing README for $$package$(RESET)"; \
		else \
			echo "$(GREEN)✅ $$package/README.md$(RESET)"; \
		fi; \
	done

help: ## Show this help message
	@echo "$(BLUE)Neu-Alkemy Dotfiles Makefile$(RESET)"
	@echo "$(BLUE)=============================$(RESET)"
	@echo ""
	@echo "$(BLUE)Usage:$(RESET) make [target]"
	@echo ""
	@awk 'BEGIN {FS = ":.*##"; printf "$(BLUE)Available targets:$(RESET)\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  $(GREEN)%-20s$(RESET) %s\n", $$1, $$2 } /^##@/ { printf "\n$(BLUE)%s$(RESET)\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@echo ""
	@echo "$(BLUE)Examples:$(RESET)"
	@echo "  make install                    # Full installation"
	@echo "  make stow-package PACKAGE=nvim  # Stow specific package"
	@echo "  make backup                     # Create backup"
	@echo "  make validate                   # Run all checks"
	@echo "  make clean                      # Clean temporary files"