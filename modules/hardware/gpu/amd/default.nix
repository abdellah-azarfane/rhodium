{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;

  dev = config.modules.device;
in {
  config = mkIf (builtins.elem dev.gpu.type ["amd" "hybrid-amd"]) {
    # enable amdgpu xorg drivers in case Hyprland breaks again
    services.xserver.videoDrivers = lib.mkDefault ["modesetting" "amdgpu"];

    # enable amdgpu kernel module
    boot = {
      initrd.kernelModules = ["amdgpu"]; # load amdgpu kernel module as early as initrd
      kernelModules = ["amdgpu"]; # if loading somehow fails during initrd but the boot continues, try again later
    };

    environment.systemPackages = [pkgs.nvtopPackages.amd];

    # enables OpenCL support
    hardware.graphics = {
      extraPackages = with pkgs;
        [
          # mesa
          mesa
          # vulkan
          vulkan-tools
          vulkan-loader
          vulkan-validation-layers
          vulkan-extension-layer
          # opencl
          rocmPackages.tensile
          rocmPackages.clr
          rocmPackages.rpp-opencl
        ];
    };
  };
}
