#!/usr/bin/env bash

# ============================================
#   Restore configs from Git backup repo
# ============================================

BACKUP_REPO="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
LOCAL_BIN="$HOME/.local/bin"

# Path to folder list
FOLDER_LIST="$BACKUP_REPO/backup_restore/folders.txt"

# Ensure folder list exists
if [ ! -f "$FOLDER_LIST" ]; then
    echo "Error: folder list not found at $FOLDER_LIST"
    exit 1
fi

echo "=== Restoring config folders ==="

# Restore ~/.config folders from list
while IFS= read -r folder; do
    [[ -z "$folder" ]] && continue  # skip empty lines

    SRC="$BACKUP_REPO/.config/$folder"
    DEST="$CONFIG_DIR/$folder"

    if [ -d "$SRC" ]; then
        echo "Restoring: $folder"
        rm -rf "$DEST"
        mkdir -p "$CONFIG_DIR"
        cp -r "$SRC" "$DEST"
    else
        echo "Missing in backup, skipping: $folder"
    fi
done < "$FOLDER_LIST"

echo "=== Restoring extra config files ==="

if [ -f "$BACKUP_REPO/starship.toml" ]; then
    echo "Restoring: starship.toml"
    cp "$BACKUP_REPO/starship.toml" "$HOME/.config/"
fi

if [ -f "$BACKUP_REPO/.bashrc" ]; then
    echo "Restoring: .bashrc"
    cp "$BACKUP_REPO/.bashrc" "$HOME/"
fi

echo "=== Restoring .sh scripts to ~/.local/bin ==="

mkdir -p "$LOCAL_BIN"
for file in "$BACKUP_REPO/.local/"*.sh; do
    [ -e "$file" ] || continue
    echo "Copying $(basename "$file")"
    cp "$file" "$LOCAL_BIN/"
done

echo "=== Restore complete! ==="

echo "Reload Hyprland"
hyprctl reload