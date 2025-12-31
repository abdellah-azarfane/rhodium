{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./steam
    ./lutris
  ];

  # Xbox Wireless Controller driver (xpadneo)
  # Nixpkgs package is provided as a kernel module package (e.g. `pkgs.linuxKernel.packages.linux_zen.xpadneo`).
  hardware.xpadneo.enable = lib.mkDefault true;

  boot.extraModulePackages = lib.mkIf (config.boot.kernelPackages ? xpadneo) [
    config.boot.kernelPackages.xpadneo
  ];

  environment.systemPackages = lib.mkIf (config.boot.kernelPackages ? xpadneo) [
    config.boot.kernelPackages.xpadneo
  ];
}

