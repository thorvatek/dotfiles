#!/bin/bash  

# === Configuration ===  
SOURCE_DIR "."          # Current directory (where your folders are)  
DEST_DIR "$HOME/.config" # Target directory  

# === Choose action: 'copy' or 'move' ===  
ACTION="copy"  # Change to "move" to delete source folders after transfer  

# === Safety: Confirm before proceeding ===  
echo "This will $ACTION all folders from '$SOURCE_DIR' to '$DEST_DIR', **merging contents** (existing files will only be overwritten if names match)."  
read -p "Continue? [y/N] " -r  
if [[ ! $REPLY =~ ^[Yy]$ ]]; then  
    echo "Aborted."  
    exit 1  
fi  

# === Create destination directory if missing ===  
mkdir -p "$DEST_DIR"  

# === Process each folder in the current directory ===  
for folder in "$SOURCE_DIR"/*; do  
    if [ -d "$folder" ]; then  # Only process directories  
        folder_name=$(basename "$folder")  
        dest_path="$DEST_DIR/$folder_name"  

        # === Create destination folder if it doesn't exist ===  
        if [ ! -e "$dest_path" ]; then  
            echo "Creating: $dest_path"  
            mkdir -p "$dest_path"  
        fi  

        # === Copy or move the **contents** of the folder (merge!) ===  
        if [ "$ACTION" = "copy" ]; then  
            echo "Merging: $folder → $dest_path"  
            cp -r "$folder"/. "$dest_path"  # Copy *contents* (including hidden files)  
        else  # move  
            echo "Moving: $folder → $dest_path"  
            mv "$folder"/. "$dest_path"/.    # Move *contents* (not the folder itself)  
        fi  
    fi  
done  

echo "Operation complete! Existing files in ~/.config were preserved unless overwritten."
