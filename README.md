# Rhodium (fork)

Declarative NixOS + Home Manager configuration for my machines, built around a modular flake layout (flake-parts) with a “profiles / modules” style organization.

This repository is a personal fork of the original Rhodium project. It keeps the same spirit (curated defaults, modular structure), but it evolves independently.

## What’s in here

- **Flake layout**: `flake.nix` uses `flake-parts`; the logic is split under `flake/parts/`.
- **Hosts**: `hosts/` contains per-machine configs; `flake/hosts.nix` is the host registry that makes adding a host quick.
- **Modules**: `modules/` contains NixOS modules; `home/` contains Home Manager modules.
- **Automation**: `justfile` wraps common workflows and calls scripts in `build/recipes/`.

## Quick start

List available `just` commands:

```zsh
just
```

Show flake outputs:

```zsh
nix flake show
```

Evaluate checks (no builds):

```zsh
nix flake check --no-build
```

## Build / switch

Switch a host:

```zsh
just switch <host>
```

Fast switch (less output):

```zsh
just switch-fast <host>
```

Build only:

```zsh
just build <host>
```

Update inputs:

```zsh
just update
```

## Adding a new host

1. Create a new directory under `hosts/<new-host>/`.
2. Register it in `flake/hosts.nix`.
3. Build it:

```zsh
just build <new-host>
```

## Home Manager

This flake exposes `homeConfigurations` (standalone HM). Example:

```zsh
nix build .#homeConfigurations.user_001.activationPackage
```

## Notes

- New files must be tracked by git for flakes to see them.
- Some “optional” packages are guarded in modules so evaluation stays resilient across nixpkgs changes.

## Credits

- Inspired by the upstream Rhodium project by `pabloagn`.
