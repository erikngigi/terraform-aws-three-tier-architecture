#!/usr/bin/env bash

set -e

# Exit immediately if a command exits with a non-zero status.
# set -e ensures that the script stops on error.

echo "Installing required packages..."
sudo apt-get -y install git binutils rustc cargo pkg-config libssl-dev gettext

# Define a temporary directory
TMP_DIR="/tmp/efs-utils"

# Remove old directory if it exists
if [ -d "$TMP_DIR" ]; then
  echo "Removing existing directory: $TMP_DIR"
  rm -rf "$TMP_DIR"
fi

echo "Cloning AWS EFS Utils repository..."
git clone https://github.com/aws/efs-utils "$TMP_DIR"

echo "Building the EFS Utils Debian package..."
cd "$TMP_DIR"
./build-deb.sh

echo "Installing the built package..."
sudo apt-get -y install ./build/amazon-efs-utils*deb

echo "Cleaning up..."
cd /
rm -rf "$TMP_DIR"

echo "✅ Installation complete: amazon-efs-utils installed successfully."
