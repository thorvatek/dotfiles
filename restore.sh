#!/bin/bash  

# === Configuration ===  
SOURCE_DIR "."          # Current directory (where your folders are)  
DEST_DIR "$HOME/.config" # Target directory  

# === Choose action: 'copy' or 'move' ===  
ACTION="copy"  # Change to "move" to delete source folders after transfer  

# === Safety: Confirm before proceeding ===  
echo "This will $ACTION all folders from '$SOURCE_DIR' to '$DEST_DIR', overwriting existing content."  
read -p "Continue? [y/N] " -r  
if [[ ! $REPLY =~ ^[Yy]$ ]]; then  
    echo "Aborted."  
    exit 1  
fi  

# === Create destination directory if missing ===  
# mkdir -p "$DEST_DIR"  

# === Process each folder in the current directory ===  
for folder in "$SOURCE_DIR"/*; do  
    if [ -d "$folder" ]; then  # Only process directories  
        folder_name=$(basename "$folder")  
        dest_path="$DEST_DIR/$folder_name"  

        # === Overwrite existing destination ===  
        if [ -e "$dest_path" ]; then  
            echo "Removing existing: $dest_path"  
            rm -rf "$dest_path"  # Delete any existing file/folder  
        fi  

        # === Copy or move the folder ===  
        if [ "$ACTION" = "copy" ]; then  
            echo "Copying: $folder → $dest_path"  
            cp -r "$folder" "$dest_path"  
        else  # move  
            echo "Moving: $folder → $dest_path"  
            mv "$folder" "$dest_path"  
        fi  
    fi  
done  

echo "Operation complete!"  
