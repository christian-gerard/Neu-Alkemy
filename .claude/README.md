# Claude Configuration

This directory contains configuration files for Claude Code CLI.

## Files

- `settings.example.json` - Example Claude permissions configuration
- `settings.local.json` - Your local Claude settings (not tracked in git)

## Setup

1. Copy the example file:
   ```bash
   cp .claude/settings.example.json .claude/settings.local.json
   ```

2. Edit `settings.local.json` to match your system paths and preferences

3. The local settings file is ignored by git to prevent sharing personal configurations