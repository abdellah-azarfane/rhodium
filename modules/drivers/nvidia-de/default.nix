{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.drivers.nvidiaDe;
in
{
  options.drivers.nvidiaDe = {
    enable = mkEnableOption "NVIDIA (desktop) drivers";
  };

  config = mkIf cfg.enable {
    boot.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    hardware.nvidia = {
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      nvidiaSettings = true;
      powerManagement.enable = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        mesa
        nvidia-vaapi-driver
        nv-codec-headers-12
        libva-vdpau-driver
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        mesa
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };

    environment.systemPackages = with pkgs; [
      egl-wayland
      nvidia-vaapi-driver
      libvdpau-va-gl
      vulkan-tools-lunarg
      vulkan-tools
    ];

    hardware.nvidia-container-toolkit.enable = true;
  };
}
