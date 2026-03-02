{ config, lib, ... }:

let
  cfg = config.ix.apps.media.audio.ncspot;
in
{
  options.ix.apps.media.audio.ncspot = {
    enable = lib.mkEnableOption "Enable ncspot TUI Spotify client";
  };

  config = lib.mkIf cfg.enable {
    programs.ncspot = {
      enable = true;

      settings = {
        gapless = true;
      };
    };
  };
}
