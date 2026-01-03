# Waydroid service configuration
# Waydroid is an Android container for Linux
{ config
, pkgs
, ...
}: {
  # Enable Waydroid virtualization service
  virtualisation.waydroid.enable = true;

  # Add waydroid package to system packages
  environment.systemPackages = with pkgs; [
    waydroid
  ];

  # Wrapper script to force waydroid to use Intel iGPU instead of NVIDIA
  # This is useful for hybrid graphics laptops (Intel + NVIDIA)
  environment.etc."waydroid-wrapper".source = pkgs.writeScript "waydroid-wrapper" ''
    #!${pkgs.bash}/bin/bash
    # Force Intel iGPU usage
    export DRI_PRIME=0
    export __NV_PRIME_RENDER_OFFLOAD=0
    export __GLX_VENDOR_LIBRARY_NAME=mesa
    export LIBVA_DRIVER_NAME=i965  # Intel VAAPI driver
    exec ${pkgs.waydroid}/bin/waydroid "$@"
  '';

  # Alternative: Set environment variables globally for waydroid service
  # This ensures waydroid always uses Intel iGPU
  # systemd.services.waydroid-container.environment = {
  #   DRI_PRIME = "0";
  #   __NV_PRIME_RENDER_OFFLOAD = "0";
  #   __GLX_VENDOR_LIBRARY_NAME = "mesa";
  #   LIBVA_DRIVER_NAME = "i965";
  # };
  # Note: After enabling, you need to initialize waydroid:
  # sudo waydroid init -s GAPPS -f  # For Google Apps support
  # sudo systemctl start waydroid-container
  # waydroid session start
}
