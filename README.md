### Bash Script to **Merge** Folders into `~/.config`

Safe script to **copy or move folders** from your current directory into `~/.config`, **merging contents** instead of deleting existing files/folders. Existing files in `~/.config` will **only be overwritten** if they have the **same name** as files/folders being copied — **no entire directories are removed**.  

---

### **How It Works**  

1. **Merging, Not Deleting**  
   - If `~/.config` already has a folder (e.g., `themes`), the script **copies/moves the *contents*** of your source folder into it **without deleting the entire destination folder**.  
   - Example:  
     - `~/.config/themes/` already has `old_style.css`.  
     - Your source `themes/` has `new_style.css`.  
     - After running: `~/.config/themes/` will contain **both** `old_style.css` **and** `new_style.css`.  

2. **Overwriting Specific Files**  
   - If a file **exists in both the source and destination**, the source file **overwrites** the destination file (e.g., `themes/style.css` in the source replaces `~/.config/themes/style.css`).  

3. **Hidden Files Included**  
   - The `/.` suffix in `"$folder"/.` ensures **hidden files** (e.g., `.config.json`) are copied/merged too.  

4. **Move vs. Copy**  
   - **Copy**: Keeps your original folders untouched.  
   - **Move**: Deletes the **contents** of your source folders after moving them (the **empty source folder** remains).  

---

### **How to Use**  

1. **Save the script**:  
   ```bash  
   nano restore.sh  
   ```  
   Paste the code above, then save (`Ctrl+O`) and exit (`Ctrl+X`).  

2. **Make it executable**:  
   ```bash  
   chmod +x restore.sh  
   ```  

3. **Run the script**:  
   ```bash  
   ./restore.sh  
   ```  

   - You’ll get a **confirmation prompt** before proceeding.  
   - To **switch from copy to move**, edit the script and set `ACTION="move"`.  

---

### **Example Scenario**  

**Before**:  
```bash  
./  
├── themes/  
│   ├── old_style.css    # Exists in ~/.config/themes/  
│   └── new_style.css    # Will overwrite ~/.config/themes/new_style.css  
└── shortcuts/  
    └── config.json      # New file  
```  

**After running with `ACTION="copy"`**:  
```bash  
~/.config/  
├── themes/  
│   ├── old_style.css    # **Preserved** (not deleted!)  
│   └── new_style.css    # **Overwritten** from source  
└── shortcuts/  
    └── config.json      # **Added**  
```  

---

### **Safety Tips**  

- **Test with `copy` first**: Always start with `ACTION="copy"` to avoid accidental data loss.  
- **Backup important config**:  
  ```bash  
  cp -r ~/.config ~/.config_backup  
  ```  
- **Avoid running as root**: Running with `sudo` could overwrite system-wide config files!  

This script is ideal for **syncing personal configuration folders** while preserving existing settings in `~/.config`.
