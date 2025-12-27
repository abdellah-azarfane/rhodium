{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.extraServices.asusKeyboardBacklight;
in
{
  options.extraServices.asusKeyboardBacklight = {
    enable = mkEnableOption "ASUS keyboard backlight";
  };

  config = mkIf cfg.enable {
    # ----Asusctl----
    services.asusd = {
      enable = true;
      enableUserService = true;
    };
    #----- Base services-----
    # Network

    environment.systemPackages = with pkgs; [asusctl];

    # openrgb
    services.hardware.openrgb.enable = true;
  };
}
