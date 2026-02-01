{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.drivers.amdGpu;
in
{
  options.drivers.amdGpu = {
    enable = mkEnableOption "AMD GPU configuration";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      radeontop
    ];

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1"; # For invisible cursors
      AMD_VULKAN_ICD = "RADV";
    };

    # OpenGL options
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        rocmPackages.clr
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        amdvlk
      ];
    };
  };
}
