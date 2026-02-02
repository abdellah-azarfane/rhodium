{
  host,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/apps
    ../../modules/containers    
    ../../modules/desktop
    ../../modules/desktop/wm/niri
    ../../modules/disk-boot
    ../../modules/drivers
    ../../modules/hardware
    ../../modules/integration
    ../../modules/maintenance
    ../../modules/manager
    ../../modules/network
    ../../modules/rules
    ../../modules/security
    ../../modules/services
    ../../modules/shell
    ../../modules/users
    ../../modules/utils
  ];

  # Base
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
    keychronQ3Udev.enable = true;
    hdmiAutoSwitch.enable = true;
    netgearA8000Udev.enable = true;
  };

  # Garbage override
  maintenance.garbageCollection = {
    enable = true;
    schedule = "daily";
    deleteOlderThan = "30d";
  };
  system.stateVersion = "25.05"; # NOTE: Original derivation
}
