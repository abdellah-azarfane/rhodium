{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.manager.lightdm;
in
{
  options.manager.lightdm = {
    enable = mkEnableOption "LightDM display manager";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager.lightdm = {
        enable = true;
        greeters.gtk.enable = true;
      };
    };
  };
}
