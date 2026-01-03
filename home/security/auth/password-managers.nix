{ pkgs
, ...
}:
{
  home.packages = [
    # --- 1Password ---
    # pkgs._1password-gui
    # pkgs._1password-gui-beta # NOTE: Required for now since wayland clipboard is in Beta version
    pkgs._1password-gui # NOTE: Use stable version now that it supports wayland clipboard
    pkgs._1password-cli

    # --- Bitwarden ---
    # pkgs.bitwarden-desktop
    # pkgs.bitwarden-cli

    # --- Protonpass ---
    # pkgs.proton-pass
  ];
}
