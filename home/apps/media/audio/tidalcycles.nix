{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.ix.apps.media.audio.tidalcycles;
in
{
  imports = [
    ../../../development
  ];

  options.ix.apps.media.audio.tidalcycles = {
    enable = lib.mkEnableOption "Enable TidalCycles";
  };

  config = lib.mkIf cfg.enable {
    ix.development.languages.haskell = {
      enable = true;
    };
    home.packages = with pkgs; [
      haskellPackages.tidal
    ];
  };
}
