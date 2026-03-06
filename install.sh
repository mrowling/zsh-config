#!/usr/bin/env bash
# Install script for modular zsh configuration
# This script will:
# - Backup existing .zshrc if it exists
# - Copy the zshrc file to ~/.zshrc
# - Install development tools (NVM, uv, Go, Bun, GitHub CLI)
# - Keep the modular config in its current location

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSHRC_SOURCE="$SCRIPT_DIR/zshrc"
ZSHRC_TARGET="$HOME/.zshrc"

echo -e "${BLUE}=== Modular Zsh Configuration Installer ===${NC}\n"

# Check if source file exists
if [[ ! -f "$ZSHRC_SOURCE" ]]; then
    echo -e "${RED}Error: zshrc file not found at $ZSHRC_SOURCE${NC}"
    exit 1
fi

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install tools
install_tools() {
    echo -e "${CYAN}=== Installing Development Tools ===${NC}\n"
    
    # Install NVM (Node Version Manager)
    if command_exists nvm; then
        echo -e "${GREEN}✓ NVM already installed${NC}"
    else
        echo -e "${BLUE}Installing NVM...${NC}"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        echo -e "${GREEN}✓ NVM installed${NC}"
        
        # Install latest LTS node
        if command_exists nvm; then
            echo -e "${BLUE}Installing Node.js LTS...${NC}"
            nvm install --lts
            nvm use --lts
            echo -e "${GREEN}✓ Node.js LTS installed${NC}"
        fi
    fi
    echo ""
    
    # Install uv (Python package manager)
    if command_exists uv; then
        echo -e "${GREEN}✓ uv already installed${NC}"
    else
        echo -e "${BLUE}Installing uv (Python package manager)...${NC}"
        curl -LsSf https://astral.sh/uv/install.sh | sh
        echo -e "${GREEN}✓ uv installed${NC}"
    fi
    echo ""
    
    # Install Go
    GO_VERSION="1.26.1"
    
    if command_exists go; then
        CURRENT_GO_VERSION=$(go version | awk '{print $3}' | sed 's/go//')
        if [[ "$CURRENT_GO_VERSION" == "$GO_VERSION" ]]; then
            echo -e "${GREEN}✓ Go ${GO_VERSION} already installed${NC}"
        else
            echo -e "${YELLOW}Go ${CURRENT_GO_VERSION} is installed, but ${GO_VERSION} is specified${NC}"
            read -p "Install Go ${GO_VERSION}? [Y/n] " -n 1 -r
            echo ""
            if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
                echo -e "${BLUE}Installing Go ${GO_VERSION}...${NC}"
                
                if [[ "$OSTYPE" == "darwin"* ]]; then
                    if [[ "$(uname -m)" == "arm64" ]]; then
                        GO_ARCH="darwin-arm64"
                    else
                        GO_ARCH="darwin-amd64"
                    fi
                else
                    GO_ARCH="linux-amd64"
                fi
                
                curl -LO "https://go.dev/dl/go${GO_VERSION}.${GO_ARCH}.tar.gz"
                sudo rm -rf /usr/local/go
                sudo tar -C /usr/local -xzf "go${GO_VERSION}.${GO_ARCH}.tar.gz"
                rm "go${GO_VERSION}.${GO_ARCH}.tar.gz"
                echo -e "${GREEN}✓ Go ${GO_VERSION} installed${NC}"
            else
                echo -e "${YELLOW}Skipping Go installation${NC}"
            fi
        fi
    else
        echo -e "${BLUE}Installing Go ${GO_VERSION}...${NC}"
        
        if [[ "$OSTYPE" == "darwin"* ]]; then
            if [[ "$(uname -m)" == "arm64" ]]; then
                GO_ARCH="darwin-arm64"
            else
                GO_ARCH="darwin-amd64"
            fi
        else
            GO_ARCH="linux-amd64"
        fi
        
        curl -LO "https://go.dev/dl/go${GO_VERSION}.${GO_ARCH}.tar.gz"
        sudo rm -rf /usr/local/go
        sudo tar -C /usr/local -xzf "go${GO_VERSION}.${GO_ARCH}.tar.gz"
        rm "go${GO_VERSION}.${GO_ARCH}.tar.gz"
        echo -e "${GREEN}✓ Go ${GO_VERSION} installed${NC}"
    fi
    echo ""
    
    # Install Bun
    if command_exists bun; then
        echo -e "${GREEN}✓ Bun already installed ($(bun --version))${NC}"
    else
        echo -e "${BLUE}Installing Bun...${NC}"
        curl -fsSL https://bun.sh/install | bash
        echo -e "${GREEN}✓ Bun installed${NC}"
    fi
    echo ""
    
    # Install GitHub CLI
    if command_exists gh; then
        echo -e "${GREEN}✓ GitHub CLI already installed ($(gh --version | head -1))${NC}"
    else
        echo -e "${BLUE}Installing GitHub CLI...${NC}"
        
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            if command_exists brew; then
                brew install gh
            else
                echo -e "${YELLOW}⚠ Homebrew not found. Please install GitHub CLI manually from: https://cli.github.com/${NC}"
            fi
        else
            # Linux
            if command_exists apt-get; then
                # Debian/Ubuntu
                (type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
                && sudo mkdir -p -m 755 /etc/apt/keyrings \
                && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
                && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
                && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
                && sudo apt update \
                && sudo apt install gh -y
            elif command_exists yum; then
                # Fedora/RHEL/CentOS
                sudo dnf install 'dnf-command(config-manager)' -y
                sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
                sudo dnf install gh -y
            else
                echo -e "${YELLOW}⚠ Package manager not supported. Please install GitHub CLI manually from: https://cli.github.com/${NC}"
            fi
        fi
        
        if command_exists gh; then
            echo -e "${GREEN}✓ GitHub CLI installed${NC}"
        fi
    fi
    echo ""
}

# Backup existing .zshrc if it exists
if [[ -f "$ZSHRC_TARGET" ]]; then
    BACKUP_FILE="$ZSHRC_TARGET.backup.$(date +%Y%m%d_%H%M%S)"
    echo -e "${YELLOW}Backing up existing .zshrc to:${NC}"
    echo -e "${BLUE}  $BACKUP_FILE${NC}"
    cp "$ZSHRC_TARGET" "$BACKUP_FILE"
    echo -e "${GREEN}✓ Backup created${NC}\n"
else
    echo -e "${YELLOW}No existing .zshrc found, creating new one${NC}\n"
fi

# Ask user if they want to install tools
echo -e "${CYAN}Do you want to install development tools? (NVM, uv, Go, Bun, GitHub CLI)${NC}"
echo -e "${YELLOW}This will download and install the following:${NC}"
echo -e "  • NVM (Node Version Manager) + Node.js LTS"
echo -e "  • uv (Fast Python package manager)"
echo -e "  • Go (latest stable)"
echo -e "  • Bun (JavaScript runtime)"
echo -e "  • GitHub CLI (gh)"
echo ""
read -p "Install tools? [Y/n] " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
    install_tools
else
    echo -e "${YELLOW}Skipping tool installation${NC}\n"
fi

# Copy zshrc to home directory
echo -e "${BLUE}Installing zshrc to $ZSHRC_TARGET${NC}"
cp "$ZSHRC_SOURCE" "$ZSHRC_TARGET"
echo -e "${GREEN}✓ Installation complete${NC}\n"

# Check if local.zsh exists, if not suggest creating it from example
if [[ ! -f "$SCRIPT_DIR/local.zsh" ]] && [[ -f "$SCRIPT_DIR/local.zsh.example" ]]; then
    echo -e "${YELLOW}Note: local.zsh not found${NC}"
    echo -e "  This file is for machine-specific configuration and secrets."
    echo -e "  See ${BLUE}local.zsh.example${NC} for a template.\n"
fi

# Final instructions
echo -e "${GREEN}=== Installation Complete ===${NC}\n"
echo -e "Next steps:"
echo -e "  1. ${BLUE}source ~/.zshrc${NC} - Reload your shell configuration"
echo -e "  2. Create ${BLUE}local.zsh${NC} for machine-specific config (see local.zsh.example)"
echo -e "  3. Add host-specific config in ${BLUE}host/\$(hostname).zsh${NC} if needed"
echo -e ""
echo -e "For more information, see ${BLUE}README.md${NC}"
