# Flake + modules (what it is)

## What language is this?

- `*.nix` files are written in the **Nix language**.
- They are evaluated by the **Nix** tool to produce “outputs” like NixOS systems and Home Manager configs.

## `flake.nix` (the entrypoint)

`flake.nix` does 2 main things:

1. Declares **inputs** (pinned dependencies), e.g.:
   - `nixpkgs` (stable channel: `nixos-25.11`)
   - `nixpkgs-unstable`
   - `home-manager`
   - `flake-parts` (used to structure the flake)
2. Declares **outputs** using `flake-parts`:
   - It imports `./flake/parts/core.nix`, `./flake/parts/nixos.nix`, `./flake/parts/home.nix`.
   - Those files define the actual NixOS and Home Manager outputs.

## How a host build works (conceptually)

- A host is usually exposed as: `.#nixosConfigurations.<host>`.
- A build command like:

```zsh
nixos-rebuild build --flake .#<host>
```

means:

- evaluate the flake
- select the `nixosConfigurations.<host>` output
- build the system closure for that host

## Where modules fit

- Hosts in `hosts/<host>/` typically enable modules from:
  - `modules/` (system services, networking, hardware, etc.)
  - `home/` (user environment)
- This keeps hosts small and reusable.
