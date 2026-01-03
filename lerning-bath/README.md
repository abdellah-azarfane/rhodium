# lerning-bath (learning notes)

This folder explains how this repo is wired: the Nix flake config, the `justfile` commands, and the helper scripts.

## Start here

- `01-repo-layout.md` — what each top-level folder is for.
- `02-flake-and-modules.md` — how `flake.nix` + `flake/parts/*` shape the system.
- `03-justfile-and-recipes.md` — how `just` calls scripts in `build/recipes/`.
- `04-scripts-language-and-flow.md` — what language each script uses + how the common helpers work.
- `05-themes-and-home-scripts.md` — how themes are selected/applied + how `home/scripts/` is installed into `$XDG_BIN_HOME`.

## Quick commands

```zsh
just --list --unsorted
just check
```
