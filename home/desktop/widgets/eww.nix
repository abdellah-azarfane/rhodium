{ lib, config, ... }:

let
  cfg = config.ix.desktop.widgets.eww;
in
{
  options.ix.desktop.widgets.eww.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Eww widgets.";
  };

  config = lib.mkIf cfg.enable {
    programs.eww.enable = true;
  };
}
