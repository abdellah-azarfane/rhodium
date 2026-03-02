{
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.desktop.de;

  enabledCount = length (filter (x: x) [
    (config.desktop.de.plasma6.enable or false)
    (config.desktop.de.gnome.enable or false)
    (config.desktop.de.xfce.enable or false)
    (config.desktop.de.cosmic.enable or false)
  ]);
in
{
  imports = [
    ./plasma6
    ./gnome
    ./xfce
    ./cosmic
  ];

  options.desktop.de = {
    type = mkOption {
      type = types.enum [ "plasma6" "gnome" "xfce" "cosmic" "none" ];
      default = "none";
      description = "Select the desktop environment to enable.";
      example = "plasma6";
    };

    plasma6.enable = mkEnableOption "KDE Plasma 6";
    gnome.enable = mkEnableOption "GNOME";
    xfce.enable = mkEnableOption "XFCE";
    cosmic.enable = mkEnableOption "COSMIC";
  };

  config = mkMerge [
    (mkIf (cfg.type == "plasma6") { desktop.de.plasma6.enable = mkDefault true; })
    (mkIf (cfg.type == "gnome") { desktop.de.gnome.enable = mkDefault true; })
    (mkIf (cfg.type == "xfce") { desktop.de.xfce.enable = mkDefault true; })
    (mkIf (cfg.type == "cosmic") { desktop.de.cosmic.enable = mkDefault true; })
    (mkIf (cfg.type == "none") { })

    {
      assertions = [
        {
          assertion = enabledCount <= 1;
          message = "Only one desktop.de.* may be enabled at a time. Prefer setting desktop.de.type = \"...\".";
        }
      ];
    }
  ];
}
