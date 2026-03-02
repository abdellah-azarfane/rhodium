{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.ix.development.languages.haskell;
in
{
  options.ix.development.languages.haskell = {
    enable = lib.mkEnableOption "Enable Haskell Language";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      haskell-language-server
      haskellPackages.fourmolu
      haskellPackages.cabal-install
      haskellPackages.hoogle
    ];
  };
}
