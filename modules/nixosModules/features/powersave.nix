{
  flake.nixosModules.powersave =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {

      # Intel Thermal Daemon
      services.thermald.enable = true;

      # Advanced CPU power management
      services.auto-cpufreq.enable = true;
      services.auto-cpufreq.settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };

      #  Powertop auto-tuning for USB/PCIe devices
      powerManagement.powertop.enable = true;

      #  Disable conflicting tools to prevent infinite loops
      services.power-profiles-daemon.enable = false; # Conflicts with auto-cpufreq
      services.tlp.enable = false; # Do not use on Asus motherboards

    };
}
