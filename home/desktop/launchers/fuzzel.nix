{ lib, config, ... }:

let
  cfg = config.ix.desktop.launchers.fuzzel;
in
{
  options.ix.desktop.launchers.fuzzel.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Fuzzel launcher.";
  };

  config = lib.mkIf cfg.enable {
    programs.fuzzel.enable = true;
  };
}
