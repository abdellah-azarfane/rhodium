{ config
, lib
, ...
}:
with lib;
let
  cfg = config.desktop;

  enabledCount = length (filter (x: x) [
    (config.desktop.wm.hyprland.enable or false)
    (config.desktop.wm.niri.enable or false)
    (config.desktop.wm.sway.enable or false)
    (config.desktop.wm.i3.enable or false)
    (config.desktop.wm.river.enable or false)
    (config.desktop.wm.mangowc.enable or false)
  ]);
in
{
  imports = [
    ./hyprland
    ./niri
    ./sway
    ./i3
    ./river
    ./mangowc
  ];

  options.desktop.wm = {
    type = mkOption {
      type = types.enum [ "hyprland" "niri" "sway" "i3" "river" "mangowc" "none" ];
      default = "hyprland";
      description = "Select the window manager to enable.";
      example = "sway";
    };

    hyprland.enable = mkEnableOption "Hyprland window manager";
    niri.enable = mkEnableOption "Niri window manager";
    sway.enable = mkEnableOption "Sway window manager";
    i3.enable = mkEnableOption "i3 window manager";
    river.enable = mkEnableOption "River window manager";
    mangowc.enable = mkEnableOption "MangoWC window manager";
  };

  config = mkMerge [
    (mkIf (cfg.wm.type == "hyprland") { desktop.wm.hyprland.enable = mkDefault true; })
    (mkIf (cfg.wm.type == "niri") { desktop.wm.niri.enable = mkDefault true; })
    (mkIf (cfg.wm.type == "sway") { desktop.wm.sway.enable = mkDefault true; })
    (mkIf (cfg.wm.type == "i3") { desktop.wm.i3.enable = mkDefault true; })
    (mkIf (cfg.wm.type == "river") { desktop.wm.river.enable = mkDefault true; })
    (mkIf (cfg.wm.type == "mangowc") { desktop.wm.mangowc.enable = mkDefault true; })
    (mkIf (cfg.wm.type == "none") { })

    {
      assertions = [
        {
          assertion = enabledCount <= 1;
          message = "Only one desktop.wm.* may be enabled at a time. Prefer setting desktop.wm.type = \"...\".";
        }
      ];
    }
  ];
}
