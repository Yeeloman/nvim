# Yet another humble attempt

The project still lacks proper documentation and has a few more steps to go, but it’s in a state where I feel comfortable showcasing it. Of course, no configuration is ever truly "finished"—we all love to tweak and refine things to better suit our workflow.

## Overview

This setup is structured around two main sections:

- **Config:** Contains general Neovim settings, key mappings, autocommands, and lazy.nvim integration.  
- **Plugins:** A collection of highly customizable plugins, primarily focused on enhancing aesthetics and usability.  

Since I love a well-polished visual experience, many of the plugins here are chosen for their customization potential. I'll be documenting both the plugins and the actual config files—one step at a time.  

### Extendability & Theming  

The setup is easily extendable and integrates **NeoPywal** to dynamically apply colors from the `wal` command output. So far, this method has been used mainly for theming, but I'm open to suggestions for improvements or additional plugins/configs worth trying.

#### Preview
To clarify any confusion about the `current_wallpaper.txt` file, I have a script that runs at boot to randomly set the wallpaper.
```bash
#!/usr/bin/env bash

# Set the wallpapers directory
WALLPAPER_DIR="$HOME/.config/nvim/.wallpapers"

# Check if directories and files exist
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Wallpaper directory not found: $WALLPAPER_DIR"
    exit 1
fi

# Choose a random image
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Check if a wallpaper was found
if [ -z "$WALLPAPER" ]; then
    echo "No wallpapers found in directory: $WALLPAPER_DIR"
    exit 1
fi

# Apply the wallpaper using wal
wal -i "$WALLPAPER" --backend haishoku -q --saturate 0.9

# Export the chosen wallpaper path to a file
echo "$WALLPAPER" > "$HOME/.config/nvim/lua/current_wallpaper.txt"
```
besides that here are some previews:
<img src="images/entry_1.png" alt="Dinner" width="500">
















