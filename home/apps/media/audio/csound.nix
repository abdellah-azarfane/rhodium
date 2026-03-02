{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.ix.apps.media.audio.csound;
in
{
  options.ix.apps.media.audio.csound = {
    enable = lib.mkEnableOption "Enable CSound";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      csound
    ];
  };
}
