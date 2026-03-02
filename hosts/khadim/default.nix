# Desktop host configuration
# Host-specific overrides and additions
{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
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
    profile = "server";
  };
  # Drivers option ( all gpu/cpu drivers configurations + nvidia-laptop for laptop nvidia ) if u using an ARM/aarch64 put the options to none
  drivers = {
    cpu = "none";
    gpu = "none";
  };
  # Display Manager
  manager.type = "tty";

  # Extra Services
  extraServices = {
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
    schedule = "weekly"; # ou daily
    deleteOlderThan = "30d"; # supprime les vieilles générations
  };
}

