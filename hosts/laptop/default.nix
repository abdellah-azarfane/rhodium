# Laptop host configuration (barevalor)
# Host-specific overrides and additions
{ pkgs, ... }:
let
  _stylixBase16Example = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
in
{


  # Import common configuration shared across all hosts
  imports = [
    ../../modules/apps
    ../../modules/desktop
    ../common.nix
    ../../modules/utils
    ../../modules/virtualization
  ];

  system.stateVersion = "26.05";


  # Modules
  # ---------------------------------
  # Boot + Disk configurations
  diskBoot = {
    enable = true;
    profile = "laptop";
  };
  # Drivers option ( all gpu/cpu drivers configurations + nvidia-laptop for laptop nvidia ) if u using an ARM/aarch64 put the options to none
  drivers = {
    cpu = "intel";
    gpu = "nvidia-laptop";
  };

  # Display Manager
  manager.type = "sddm"; # there variable like gdm, greetd, sddm, getty, regreet, tty .

  # Desktop Environment (optional alongside WM)
  desktop.de.type = "plasma6";

  # Extra Services
  extraServices = {
    asusKeyboardBacklight.enable = true;
    laptopLid.enable = true;
  };

  # Extra rules
  extraRules = {
    keychronUdev.enable = true;
    hdmiAutoSwitch.enable = true;
  };
  # Garbage override
  maintenance.nhClean = {
    enable = true;
    schedule = "daily"; # ou weekly
    deleteOlderThan = "7d"; # supprime les vieilles générations
  };

  # Stylix (per-host overrides)
  # NOTE: Stylix is enabled by default via `flake-parts/hosts.nix`.
  # Uncomment what you want to override/enable.

  stylix = {
    # Prefer ONE of these:
    # 1) Base16 scheme (from nixpkgs):
     base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";

    # 2) Or use an image to generate a palette:
    # image = ../../home/assets/wallpapers/awalls/a_cave_in_a_rocky_area.jpg;

    # Explicit polarity (optional; Stylix can often infer it)
    # polarity = "dark";

    targets = {
      gtk.enable = true;
      qt.enable = true;
      fish.enable = false;
      fontconfig.enable = true;
      "font-packages".enable = true;
      "nixos-icons".enable = true;

      # Optional (enable if you use them):
      # chromium.enable = true;
      # spicetify.enable = true;
      # regreet.enable = true;
      # grub.enable = true;
      # plymouth.enable = true;
    };
  };

}
