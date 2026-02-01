{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.drivers.intelGpu;
in
{
  options.drivers.intelGpu = {
    enable = mkEnableOption "Intel GPU configuration";
  };

  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
        (intel-vaapi-driver.override { enableHybridCodec = true; })
        libva-vdpau-driver
        libvdpau-va-gl
        mesa
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver
        (intel-vaapi-driver.override { enableHybridCodec = true; })
        libva-vdpau-driver
        libvdpau-va-gl
        mesa
      ];
    };
  };
}
