#!/bin/bash

# Directory containing wallpapers
WALL_DIR="$HOME/Wallpapers"
CURRENT_BACKGROUND_LINK="$HOME/.config/omarchy/current/background"

# Current directory (to cd back to)
CWD="$(pwd)"

cd "$WALL_DIR" || exit

# Handle spaces in filenames
IFS=$'\n'

# Grab the user-selected wallpaper
SELECTED_WALL=$WALL_DIR/$(for a in *.jpg *.png *.jpeg; do
    echo -en "$a\0icon\x1f$a\n"
done | walker --dmenu)

if [ -n "$SELECTED_WALL" ]; then
    ln -nsf "$SELECTED_WALL" "$CURRENT_BACKGROUND_LINK"
    matugen image "$SELECTED_WALL"
fi

# Go back to where you came from
cd "$CWD" || exit
