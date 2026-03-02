{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.ix.apps.media.audio.sonicpi;
in
{
  options.ix.apps.media.audio.sonicpi = {
    enable = lib.mkEnableOption "Enable Sonic Pi";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      sonic-pi
    ];
  };
}
