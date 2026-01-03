# `justfile` + recipes (how commands run)

## What language is this?

- `justfile` is written in **Just syntax** (from the `just` command runner).
- It mostly runs **Bash** commands and scripts.

## Key idea

- `justfile` defines short commands like `just switch host_001`.
- Those commands call scripts under `build/recipes/`.

Example:

- `just switch <host>` runs:
  - `build/recipes/rh-switch.sh "<host>"`

## Why `set shell := ["bash", "-euo", "pipefail", "-c"]` matters

All `just` recipes run with bash safety flags:

- `-e` stop on error
- `-u` error on unset variables
- `-o pipefail` pipelines fail if any part fails

That’s good for catching bugs early, but it also means scripts must be careful with pipelines.

## How to discover commands

```zsh
just --list --unsorted
```

## Most-used flows

- Validate/evaluate flake:

```zsh
just check
```

- Build without switching:

```zsh
just build <host>
```

- Switch the running system:

```zsh
just switch <host>
```

- Update inputs:

```zsh
just update
```
