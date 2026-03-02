{ lib, config, ... }:

let
  cfg = config.ix.desktop;

  widgetSystems = cfg.widgetSystems;
  hasWidget = w: builtins.elem w widgetSystems;

  barCfg = cfg.bar;
  barIs = name: barCfg == name;

  shouldEnableWaybar = barIs "waybar";
  shouldDisableWaybar = barIs "none";

  shouldEnableEww = hasWidget "eww";
  shouldEnableAgs = hasWidget "ags";

  selectorEnabled = (barCfg != "auto") || (widgetSystems != [ ]);

  inherit (lib) mkOption types mkIf mkMerge;
in
{
  options.ix.desktop = {
    bar = mkOption {
      type = types.enum [ "auto" "none" "waybar" ];
      default = "auto";
      description = ''
        Select which bar implementation to use.

        - "auto": keep module defaults (usually enables Waybar on Wayland WMs)
        - "none": disable any configured bar
        - "waybar": enable Waybar and its user service
      '';
    };

    widgetSystems = mkOption {
      type = types.listOf (types.enum [ "eww" "ags" ]);
      default = [ ];
      description = ''
        Select which widget systems to enable.

        - Include "eww" to enable Eww (+ its user service)
        - Include "ags" to enable AGS
      '';
      example = [ "eww" ];
    };
  };

  config = mkMerge [
    (mkIf selectorEnabled {
      assertions = [
        {
          assertion = (barCfg == "auto") || (barCfg == "none") || (barCfg == "waybar");
          message = "ix.desktop.bar must be one of: auto, none, waybar.";
        }
      ];
    })

    (mkIf shouldEnableWaybar {
      ix.desktop.bars.waybar.enable = true;
      userExtraServices.waybar.enable = true;
    })

    (mkIf shouldDisableWaybar {
      ix.desktop.bars.waybar.enable = false;
      userExtraServices.waybar.enable = false;
    })

    (mkIf (widgetSystems != [ ]) {
      ix.desktop.widgets.eww.enable = shouldEnableEww;
      ix.desktop.widgets.ags.enable = shouldEnableAgs;

      userExtraServices.eww.enable = shouldEnableEww;
    })
  ];
}
