#!/usr/bin/env zsh
# Start Jump development environment

set -e

# Navigate to Jump project directory
cd ~/Jump/api

# Load tmuxp session
tmuxp load -y ~/.tmuxp/jump.yaml

