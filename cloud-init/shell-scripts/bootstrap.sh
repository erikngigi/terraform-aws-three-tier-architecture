#!/usr/bin/env bash

set -xe

# Force APT to use IPv4 only (avoid IPv6 unreachable issues)
echo 'Acquire::ForceIPv4 "true";' | sudo tee /etc/apt/apt.conf.d/99force-ipv4

# Update system
sudo apt update -y
sudo apt upgrade -y

# Install MySQL 8.0
sudo apt install -y mysql-server
sudo systemctl daemon-reload

# Change user password
sudo passwd "$USER"

# Install ZSH
sudo apt install -y zsh

# Create a directory for configuration
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/zsh"

# Import ZSH settings from s3 bucket
aws s3 cp s3://magento-s3-configuration/configuration/zsh-home/.zshrc "$HOME/.zshrc"
aws s3 cp s3://magento-s3-configuration/configuration/zsh/ "$HOME/.config/zsh/" --recursive

# Add zap plugin manager for ZSH
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep

# Change shell to ZSH
chsh -s "$(which zsh)"
