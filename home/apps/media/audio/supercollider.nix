{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.ix.apps.media.audio.supercollider;
in
{
  options.ix.apps.media.audio.supercollider = {
    enable = lib.mkEnableOption "Enable SuperCollider";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      supercollider
    ];
  };
}
