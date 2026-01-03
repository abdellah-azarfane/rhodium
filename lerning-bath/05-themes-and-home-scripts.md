# Themes + `home/scripts/`

## Themes (where they live)

### 1) Your theme preference (what you choose)

- File: `data/users/preferences/theme.nix`
- Language: **Nix**

This is the “user preference” that picks a theme name + variant:

- `theme.name` (example: `chiaroscuro`)
- `theme.variant` (`dark` or `light`)

### 2) How the repo turns that preference into real tokens

- File: `flake/parts/core.nix`
- Language: **Nix**

In `mkContext`, the flake computes:

- `selectedTheme = getThemeConfig userThemeName userThemeVariant;`

`getThemeConfig` loads a theme definition from:

- `home/assets/themes/<themeName>.nix` (fallback: `home/assets/themes/chiaroscuro.nix`)

and returns either `theme.dark` or `theme.light`.

So: **your preference → flake picks a theme file → produces a `selectedTheme` attrset of tokens**.

### 3) What a theme definition looks like

- Example file: `home/assets/themes/chiaroscuro.nix`
- Language: **Nix**

That file defines a structure like:

- `theme.name`, `theme.description`
- `theme.dark.colors` / `theme.light.colors` (Base16-ish keys like `base00..base0F` + extra tokens)
- `theme.*.fonts`
- `theme.*.icons`
- `theme.*.wallpapers`

It imports token libraries like:

- `home/assets/colors/colors.nix` (color palette tokens)
- `home/assets/wallpapers/wallpapers.nix` (wallpaper packs)
- `home/assets/fonts/fonts.nix`, `home/assets/icons/*` (fonts/icons tokens)

### 4) How modules receive the theme

- File: `home/assets/themes/default.nix` defines `options.theme`
- User config example: `users/user_001/default.nix`

`users/user_001/default.nix` imports `../../home/assets/themes` and sets:

- `theme = theme;`

Meaning: the Home Manager configuration expects a `theme` argument (provided by the flake context), and stores it in `config.theme` for other modules to read.

Example usage:

- `home/modules/desktop.nix` reads `theme = config.theme;` and passes it into desktop-entry generation.

### 5) Assets that theme/scripts depend on

- File: `home/modules/assets.nix`

When you enable:

- `assets.wallpapers.enable = true;`
- `assets.colors.enable = true;`

Home Manager creates symlinks like:

- `$XDG_DATA_HOME/wallpapers` → `home/assets/wallpapers`
- `$XDG_DATA_HOME/colors` → `home/assets/colors`

This is important because many user scripts assume:

- `$XDG_DATA_HOME/colors/<theme>.json` exists (example: `home/assets/colors/kanso.json`)

## `home/scripts/` (what it is)

### What language are these scripts?

- Mostly **Bash** (`*.sh`)
- Sometimes **Python** (`*.py` is allowed)

These are *user-level* utilities (launchers/menus/waybar helpers), different from `build/recipes/` (system management scripts).

### How they get “installed” into your PATH

- File: `home/modules/scripts.nix`
- User config: `users/user_001/default.nix` sets `scripts.enable = true;`

When enabled, `home/modules/scripts.nix`:

- scans `home/scripts/` for specific folders
- symlinks each `*.sh` / `*.py` into:
  - `$XDG_BIN_HOME/<folder>/<script>`
- marks them executable

`$XDG_BIN_HOME` is set by:

- `home/modules/env.nix` → `XDG_BIN_HOME = ~/.local/bin`

So scripts become runnable like:

```zsh
$XDG_BIN_HOME/fuzzel/fuzzel-apps.sh
$XDG_BIN_HOME/utils/utils-opacity.sh
$XDG_BIN_HOME/waybar/custom-clock.sh
```

### The script bootstrap pattern (home scripts)

- File: `home/scripts/common/bootstrap.sh`

Many scripts do:

- `source ../common/bootstrap.sh`

This loads `home/scripts/common/functions.sh`, which provides helpers like:

- `notify` (desktop notifications)
- `copy_to_clipboard`
- `load_metadata` (reads `~/.local/share/rhodium-utils/metadata.json` via `jq`)

### Where they are used (examples)

- Waybar module uses a script:
  - `home/desktop/bars/waybar/modules/custom-clock.nix` runs `$XDG_BIN_HOME/waybar/custom-clock.sh`

- Niri keybind spawns a script:
  - `home/desktop/wm/niri/default.nix` spawns `$USERBIN_UTILS/utils-opacity.sh`

`$USERBIN_UTILS` is also defined in `home/modules/env.nix`.

### Important detail: not every folder is linked

`home/modules/scripts.nix` only links these folders:

- `common`, `docker`, `fuzzel`, `launchers`, `rdp`, `rofi`, `testing`, `utils`, `waybar`

So a folder like `home/scripts/waybar.pendings/` is **not** symlinked into `$XDG_BIN_HOME`.
