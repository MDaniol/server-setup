#!/bin/bash
set -e

echo "=== Ubuntu Server DevOps CLI Setup ==="

# Update package lists (no upgrade)
echo "[1/12] Updating package lists..."
sudo apt update

# Install base packages (neovim installed separately for newer version)
echo "[2/12] Installing base packages..."
sudo apt install -y \
  zsh git curl wget unzip \
  eza bat fd-find ripgrep fzf btop htop tldr \
  build-essential jq \
  python3 python3-pip python3-venv \
  luarocks nodejs npm

# Install Neovim (latest stable from GitHub)
echo "[3/12] Installing Neovim..."
if ! command -v nvim &> /dev/null || [[ $(nvim --version | head -1 | grep -oP '\d+\.\d+') < "0.9" ]]; then
  # Get latest version tag
  NVIM_VERSION=$(curl -s "https://api.github.com/repos/neovim/neovim/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
  echo "Downloading Neovim ${NVIM_VERSION}..."

  # Download with explicit URL and verify
  curl -fSL -o nvim-linux64.tar.gz "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux64.tar.gz"

  # Verify download (should be > 10MB)
  FILESIZE=$(stat -c%s "nvim-linux64.tar.gz" 2>/dev/null || stat -f%z "nvim-linux64.tar.gz" 2>/dev/null)
  if [ "$FILESIZE" -lt 1000000 ]; then
    echo "ERROR: Download failed (file too small: ${FILESIZE} bytes)"
    cat nvim-linux64.tar.gz  # Show error message
    rm -f nvim-linux64.tar.gz
    exit 1
  fi

  sudo rm -rf /opt/nvim-linux64
  sudo tar -C /opt -xzf nvim-linux64.tar.gz
  sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
  rm nvim-linux64.tar.gz
  echo "Neovim $(nvim --version | head -1) installed"
else
  echo "Neovim already up to date, skipping..."
fi

# Install oh-my-zsh
echo "[4/12] Installing oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "oh-my-zsh already installed, skipping..."
fi

# Install Powerlevel10k
echo "[5/12] Installing Powerlevel10k..."
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
  echo "Powerlevel10k already installed, skipping..."
fi

# Install zsh plugins
echo "[6/12] Installing zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
  git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
fi

# Install zoxide
echo "[7/12] Installing zoxide..."
if ! command -v zoxide &> /dev/null; then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
else
  echo "zoxide already installed, skipping..."
fi

# Install Zellij
echo "[8/12] Installing Zellij..."
if ! command -v zellij &> /dev/null; then
  bash <(curl -L https://zellij.dev/launch)
else
  echo "Zellij already installed, skipping..."
fi

# Install yazi (TUI file explorer)
echo "[9/12] Installing yazi..."
if ! command -v yazi &> /dev/null; then
  YAZI_VERSION=$(curl -s "https://api.github.com/repos/sxyazi/yazi/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -fSL -o yazi.zip "https://github.com/sxyazi/yazi/releases/download/v${YAZI_VERSION}/yazi-x86_64-unknown-linux-gnu.zip"
  unzip -q yazi.zip
  sudo install yazi-x86_64-unknown-linux-gnu/yazi /usr/local/bin/
  rm -rf yazi.zip yazi-x86_64-unknown-linux-gnu
else
  echo "yazi already installed, skipping..."
fi

# Install lazygit
echo "[10/12] Installing lazygit..."
if ! command -v lazygit &> /dev/null; then
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -fSL -o lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
  rm -f lazygit lazygit.tar.gz
else
  echo "lazygit already installed, skipping..."
fi

# Install lazydocker
echo "[11/12] Installing lazydocker..."
if ! command -v lazydocker &> /dev/null; then
  curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
else
  echo "lazydocker already installed, skipping..."
fi

# Install AstroNvim
echo "[12/12] Installing AstroNvim..."
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
  rm -rf ~/.config/nvim/.git
  echo "AstroNvim installed. Run 'nvim' to complete setup."
else
  echo "Neovim config already exists at ~/.config/nvim"
  echo "To install AstroNvim, backup and remove it first:"
  echo "  mv ~/.config/nvim ~/.config/nvim.backup"
  echo "  mv ~/.local/share/nvim ~/.local/share/nvim.backup"
  echo "  mv ~/.local/state/nvim ~/.local/state/nvim.backup"
  echo "  mv ~/.cache/nvim ~/.cache/nvim.backup"
fi

# Set zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Setting zsh as default shell..."
  chsh -s $(which zsh)
fi

echo ""
echo "=== Setup complete! ==="
echo ""
echo "Next steps:"
echo "  1. Copy config files:  ./copy-configs.sh"
echo "  2. Log out and back in (or restart SSH session)"
echo "  3. Run: p10k configure"
echo "  4. Run: nvim  (to install AstroNvim plugins)"
echo "  5. Update tldr cache: tldr --update"
