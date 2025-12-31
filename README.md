# Rhodium work log (this session)

This document summarizes what was changed during this session, from the initial flake refactor through the latest development tooling changes.

## 1) Flake refactor → flake-parts

### Goal
- Replace the previous monolithic `flake.nix` with a `flake-parts`-based flake.

### What changed
- `flake.nix`
  - Migrated to `flake-parts.lib.mkFlake`.
  - `inputs` remain inline in `flake.nix` (flake loader expects a literal attrset; importing inputs from another file is unreliable).
- `flake/parts/core.nix`
  - Defines shared constructors/helpers (pkgs constructors, context/lib wiring).
  - Provides `perSystem` defaults (formatter / devshell).
  - Exports overlays in the correct flake shape.
- `flake/parts/nixos.nix`
  - Generates `flake.nixosConfigurations` from a host registry.
  - Wires Home Manager into NixOS and ensures `inputs` are passed through as extra args.
- `flake/parts/home.nix`
  - Exposes `flake.homeConfigurations` entries (standalone Home Manager configs).

### Host management improvement
- `flake/hosts.nix`
  - Introduced a host registry to make adding hosts easy (add an entry rather than copying boilerplate).
  - Host module paths default to `hosts/<name>` unless overridden.

### Notes
- A reference `flake/inputs.nix` exists as a copy, but the real flake `inputs` must remain inside `flake.nix`.

## 2) Fixes for real evaluation blockers (only what evaluates)

### Boot defaults
- `modules/boot/boot.nix`
  - Changed `boot.kernelPackages` default to `lib.mkDefault` to avoid “defined multiple times” conflicts when a host overrides kernel packages.

### Maintenance option update
- `modules/maintenance/default.nix`
  - Uses a custom option `maintenance.nhClean` (systemd timer/service to run `nh clean`).
- `hosts/host_002/default.nix`
  - Updated to use `maintenance.nhClean` instead of removed/deprecated `maintenance.garbageCollection`.

## 3) Game controller support (xpadneo)

### Goal
- Add Xbox controller driver support via xpadneo under the games module.

### What changed
- `modules/desktop/games/default.nix`
  - Enables xpadneo in a kernel-packages-correct way using `config.boot.kernelPackages.xpadneo` (so it matches the active kernelPackages, including zen).
  - Uses guards so evaluation doesn’t fail if the attribute is missing.

## 4) Palette de-dup (Kanso)

### Goal
- Reduce repeated Kanso palette definitions across multiple Home Manager modules.

### What changed
- `home/assets/colors/kanso-palette.nix`
  - New shared palette file:
    - `base` palette: `#RRGGBB`
    - `rgba` palette: `#RRGGBBff` (derived)
  - Important: new files must be tracked by git for flakes to see them (untracked files are ignored).

### Consumers refactored
- `home/apps/terminals/prompts/starship/core.nix`
  - Imports `kanso-palette.nix` instead of embedding the palette.
- `home/apps/terminals/prompts/starship/custom-rhodium.nix`
  - Imports shared palette.
- `home/desktop/notifications/mako.nix`
  - Imports the `rgba` palette.
  - Removed an unused icon map.
- `home/apps/terminals/emulators/kitty/themes/kanso.nix`
  - Imports shared palette.

## 5) Home development: enable suites + fix outdated pkgs

### Enable development suites for user_001
- `users/user_001/default.nix`
  - Enabled:
    - `programs.development.ml.enable = true;`
    - `programs.development.misc.enable = true;`
    - `programs.development.opsec.enable = true;`

### Fix evaluation failures caused by missing pkgs
Once those toggles were enabled, some package attributes were missing in the pinned nixpkgs.

- `home/development/ml/default.nix`
  - Guarded optional/unstable/overlay-provided packages using `builtins.hasAttr` checks.
- `home/development/opsec/default.nix`
  - Replaced missing `openvas` with `openvas-scanner` (+ kept `gvm-tools`).
  - Guarded missing packages (e.g. `zaproxy`, `kali-tools`) to prevent evaluation breakage.

## 6) Add `hktools` (new development module)

### Goal
- Add a dedicated module for security testing tools (including `hydra`).

### What changed
- `home/development/hktools/default.nix`
  - New module option: `programs.development.hktools.enable`.
  - Adds a curated list (includes `hydra` / `hydra-cli`) and guards optional tools so it won’t fail evaluation if an attr is missing.
- `home/development/default.nix`
  - Imports `./hktools`.
- `users/user_001/default.nix`
  - Enabled: `programs.development.hktools.enable = true;`.

## 7) Validation used during the session

Evaluation-only checks were used repeatedly to ensure refactors didn’t break the flake:

```zsh
nix flake check --no-build
```

Also used for probing whether certain packages exist in the pinned nixpkgs:

```zsh
nix eval --impure --json --expr 'let flake = builtins.getFlake (toString ./.); pkgs = flake.inputs.nixpkgs.legacyPackages.x86_64-linux; in builtins.hasAttr "<name>" pkgs'
```

## 8) Issues encountered (and how we got through them)

- Flake inputs import limitation
  - Issue: trying to do `inputs = import ./flake/inputs.nix;` breaks because the flake loader expects `inputs` as a literal attrset in `flake.nix`.
  - Fix: keep `inputs` defined inline in `flake.nix` and treat `flake/inputs.nix` only as a reference copy.

- flake-parts module shape
  - Issue: early errors came from setting values at the wrong level (flake-parts expects most assignments under `config = { ... }`).
  - Fix: move module outputs into `config.*` (e.g. `config.flake.nixosConfigurations = ...`).

- Overlays output type mismatch
  - Issue: exporting overlays as the wrong type (function vs attrset-of-overlays) caused evaluation/type errors.
  - Fix: export overlays as an attrset in the flake output shape (from `./overlays`).

- Home Manager extra args missing `inputs`
  - Issue: Home Manager modules referenced `inputs` but it wasn’t being passed through `extraSpecialArgs`.
  - Fix: explicitly `inherit inputs;` when wiring Home Manager.

- Deprecated/removed options
  - Issue: `maintenance.garbageCollection` no longer existed.
  - Fix: switch the host to use the custom `maintenance.nhClean` option (backed by a systemd timer/service).

- `boot.kernelPackages` defined multiple times
  - Issue: both the shared boot module and host config set `boot.kernelPackages`, which produced a “defined multiple times” conflict.
  - Fix: set the shared default as `lib.mkDefault` so hosts can override safely.

- xpadneo attribute path confusion
  - Issue: `xpadneo` is a kernel module package, not a plain `pkgs.xpadneo` package.
  - Fix: reference it via `config.boot.kernelPackages.xpadneo` (and guard it) so it matches the currently selected kernel.

- Missing package attributes once development suites were enabled
  - Issue: enabling `programs.development.opsec/ml` exposed missing package attributes (e.g. `kali-tools`, `openvas`, `zaproxy`, and some ML tooling).
  - Fix: replace where there’s a clear successor (e.g. `openvas` → `openvas-scanner`) and guard “optional” packages with `builtins.hasAttr` to avoid evaluation failure.

- New files ignored by flakes when untracked
  - Issue: adding a new file (e.g. `home/assets/colors/kanso-palette.nix`, `home/development/hktools/default.nix`) didn’t work until git tracked it.
  - Fix: `git add <file>` so the flake evaluation can see it.

## Notes / follow-ups
- `home/development/` is already fairly modular (many small language files). The biggest “modularize” wins are in larger modules like `opsec`/`ml` (split by category) and other large non-development modules (e.g. `niri`, `mako`, `starship`) if you want to continue.
- If you want hktools to include more categories (wireless, reversing, forensics, web), list the tools you want and they can be added with the same “guarded if missing” pattern.
