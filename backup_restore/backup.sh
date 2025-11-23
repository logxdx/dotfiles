#!/usr/bin/env bash

# ============================================
#   Backup specific ~/.config folders using Git
# ============================================

# Git repo where backups will be stored
BACKUP_REPO="$HOME/dotfiles"

# Path to the folder list
FOLDER_LIST="$BACKUP_REPO/backup_restore/folders.txt"

# Ensure folder list exists
if [ ! -f "$FOLDER_LIST" ]; then
    echo "Error: folder list not found at $FOLDER_LIST"
    exit 1
fi

# Create repo structure if missing
mkdir -p "$BACKUP_REPO"
mkdir -p "$BACKUP_REPO/.config" "$BACKUP_REPO/.local"

# Initialize git repo if not already
if [ ! -d "$BACKUP_REPO/.git" ]; then
    echo "Initializing backup repo..."
    git -C "$BACKUP_REPO" init
fi

echo "Backing up selected folders..."

# Read each folder name from file
while IFS= read -r folder; do
    [[ -z "$folder" ]] && continue  # skip empty lines

    SRC="$HOME/.config/$folder"
    DEST="$BACKUP_REPO/.config/$folder"

    if [ -d "$SRC" ]; then
        echo "Copying: $folder"
        rm -rf "$DEST"
        cp -r "$SRC" "$DEST"
    else
        echo "Skipping missing folder: $folder"
    fi
done < "$FOLDER_LIST"

echo "Copying: starship.toml"
cp "$HOME/.config/starship.toml" "$BACKUP_REPO/"

echo "Copying: .bashrc"
cp "$HOME/.bashrc" "$BACKUP_REPO/"

echo "Copying: scripts (*.sh)"
rm -rf "$BACKUP_REPO/.local/"*.sh
cp "$HOME/.local/bin/"*.sh "$BACKUP_REPO/.local/" 2>/dev/null

# Git commit
cd "$BACKUP_REPO"
git add .
git commit -m "Backup $(date '+%Y-%m-%d %H:%M:%S')" >/dev/null

echo "Backup complete!"
echo "Stored in git repo: $BACKUP_REPO"

git push -u origin master

