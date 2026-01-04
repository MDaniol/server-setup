#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Copying configuration files ==="

# Backup existing configs
if [ -f "$HOME/.zshrc" ]; then
  echo "Backing up existing .zshrc to .zshrc.backup"
  cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

# Copy .zshrc
echo "Copying .zshrc..."
cp "$SCRIPT_DIR/configs/.zshrc" "$HOME/.zshrc"

# Create config directories
mkdir -p "$HOME/.config/zellij"
mkdir -p "$HOME/.config/yazi"

# Copy Zellij config
echo "Copying Zellij config..."
cp "$SCRIPT_DIR/configs/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"

# Copy yazi config
echo "Copying yazi config..."
cp "$SCRIPT_DIR/configs/yazi/yazi.toml" "$HOME/.config/yazi/yazi.toml"
cp "$SCRIPT_DIR/configs/yazi/keymap.toml" "$HOME/.config/yazi/keymap.toml"

# Copy AstroNvim user config
echo "Copying AstroNvim config..."
if [ -d "$HOME/.config/nvim" ]; then
  # Copy community plugins
  cp "$SCRIPT_DIR/configs/nvim/lua/community.lua" "$HOME/.config/nvim/lua/community.lua"

  # Copy plugin configs
  mkdir -p "$HOME/.config/nvim/lua/plugins"
  cp "$SCRIPT_DIR/configs/nvim/lua/plugins/user.lua" "$HOME/.config/nvim/lua/plugins/user.lua"
  cp "$SCRIPT_DIR/configs/nvim/lua/plugins/astrocore.lua" "$HOME/.config/nvim/lua/plugins/astrocore.lua"
  cp "$SCRIPT_DIR/configs/nvim/lua/plugins/astroui.lua" "$HOME/.config/nvim/lua/plugins/astroui.lua"

  echo "AstroNvim configs copied. Run 'nvim' to sync plugins."
else
  echo "WARNING: ~/.config/nvim not found. Run setup.sh first to install AstroNvim."
fi

echo ""
echo "=== Configs copied! ==="
echo "Restart your shell or run: source ~/.zshrc"
echo "Then run 'nvim' to install AstroNvim plugins"
