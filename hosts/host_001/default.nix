{ host
, pkgs
, ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/boot/boot.nix
    ../../modules/services
    ../../modules/hardware
    ../../modules/shell
    ../../modules/security
    ../../modules/users
    ../../modules/manager
    ../../modules/desktop
    ../../modules/desktop/wm/hyprland/intel.nix
    ../../modules/integration
    ../../modules/virtualization
    ../../modules/virtualization/docker-nvidia.nix
    ../../modules/apps
    ../../modules/rules
    ../../modules/maintenance
    ../../modules/utils
    ../../modules/network
    ./disko.nix
  ];

  # Base

  # Host Configuration
  networking = {
    hostName = host.hostname or "nixos";
    networkmanager.enable = true;
  };

  # Modules
  # ---------------------------------
  # Display Manager
  manager = {
    gdm.enable = false;
  };

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

  # Extra Args
  # ---------------------------------
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "26.05"; # NOTE: U DO HAVE TO USE THIS VERSION !!!! USE 25.11 IF U IN STABLE CHANNEL
}
