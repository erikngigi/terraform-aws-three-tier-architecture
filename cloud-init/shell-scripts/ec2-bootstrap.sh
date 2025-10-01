#!/usr/bin/env bash

set -xe

# Force APT to use IPv4 only (avoid IPv6 unreachable issues)
echo 'Acquire::ForceIPv4 "true";' | sudo tee /etc/apt/apt.conf.d/99force-ipv4

# Update system
sudo apt update -y
sudo apt upgrade -y

# Install Amazon CLI
sudo snap install aws-cli --classic

# Install MySQL 8.0
sudo apt install -y mysql-server

# Install ZSH
sudo apt install -y zsh
