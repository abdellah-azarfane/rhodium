# Repo layout (high level)

## Main configuration (Nix)

- `flake.nix` — entrypoint for Nix flake; declares inputs and delegates outputs to `flake-parts`.
- `flake/parts/` — split flake logic (core + nixos + home-manager).
- `hosts/` — per-machine NixOS configurations (one folder per host).
- `modules/` — NixOS modules (reusable pieces you enable from hosts).
- `home/` — Home Manager modules (user-level config).
- `lib/` — shared Nix helpers (functions, generators, parsers).
- `overlays/` — Nix overlays (patch/extend packages).
- `data/` — data sources used by modules (host/user registries, preferences, extras).

## Automation (Just + shell/python)

- `justfile` — human-friendly command aliases (build, switch, update, health, etc.).
- `build/recipes/` — “commands” executed by `just` (mostly Bash).
- `build/common/` — shared helpers sourced by many scripts (Bash) + one Python tool.

## Samples

- `samples/` — example configs/snippets/templates (not required for runtime).
