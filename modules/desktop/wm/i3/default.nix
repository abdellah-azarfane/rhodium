{ lib, config, ... }:

let
  cfg = config.desktop.wm.i3;
in
{
  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.windowManager.i3.enable = true;
  };
}
