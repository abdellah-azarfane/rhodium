{
  config,
  lib,
  pkgs,
  ...
}: {
  options.asus = {
    enable = lib.mkEnableOption "Asus Laptop";
  };

  config = lib.mkIf config.asus.enable {
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