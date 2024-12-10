#!/usr/bin/env bash

set -e

SOURCE_DIR="$(pwd)"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/nvim.bak"

if [ -d "$NVIM_CONFIG_DIR" ]; then
  echo "Backing up existing Neovim configuration to $BACKUP_DIR..."
  if [ -d "$BACKUP_DIR" ]; then
    TIMESTAMP=$(date "+%Y%m%d%H%M%S")
    BACKUP_DIR="${BACKUP_DIR}_$TIMESTAMP"
  fi
  mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
fi

echo "Installing new Neovim configuration from $SOURCE_DIR..."
mkdir -p "$NVIM_CONFIG_DIR"
cp -r "$SOURCE_DIR"/* "$NVIM_CONFIG_DIR"

echo "Neovim configuration installed successfully!"
