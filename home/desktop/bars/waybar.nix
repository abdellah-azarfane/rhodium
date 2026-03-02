{ lib, config, osConfig ? { }, ... }:

let
  style =
    if osConfig ? desktop && osConfig.desktop ? wm && osConfig.desktop.wm ? type then osConfig.desktop.wm.type
    else "hyprland";

  defaultEnable = builtins.elem style [ "hyprland" "niri" "sway" "river" "mangowc" ];
  cfg = config.ix.desktop.bars.waybar;
  hasStylixColors = lib.hasAttrByPath [ "lib" "stylix" "colors" ] config;
  c = if hasStylixColors then config.lib.stylix.colors else null;

  fallbackBase16 = {
    base00 = "090E13";
    base01 = "080D0F";
    base02 = "1A2027";
    base03 = "6B6863";
    base04 = "A5A5A5";
    base05 = "888071";
    base06 = "D0C9B6";
    base07 = "F2F2F2";
    base08 = "C13F42";
    base09 = "E6C384";
    base0A = "E6C384";
    base0B = "7AA89F";
    base0C = "7AA89F";
    base0D = "938AA9";
    base0E = "938AA9";
    base0F = "C13F42";
  };

  palette =
    if hasStylixColors then {
      inherit (c)
        base00 base01 base02 base03 base04 base05 base06 base07
        base08 base09 base0A base0B base0C base0D base0E base0F;
    }
    else fallbackBase16;

  mkBase16Defines = p: ''
    @define-color base00 #${p.base00};
    @define-color base01 #${p.base01};
    @define-color base02 #${p.base02};
    @define-color base03 #${p.base03};
    @define-color base04 #${p.base04};
    @define-color base05 #${p.base05};
    @define-color base06 #${p.base06};
    @define-color base07 #${p.base07};
    @define-color base08 #${p.base08};
    @define-color base09 #${p.base09};
    @define-color base0A #${p.base0A};
    @define-color base0B #${p.base0B};
    @define-color base0C #${p.base0C};
    @define-color base0D #${p.base0D};
    @define-color base0E #${p.base0E};
    @define-color base0F #${p.base0F};
  '';

  workspaceModule =
    if style == "hyprland" then "hyprland/workspaces"
    else if style == "niri" then "niri/workspaces"
    else if style == "sway" then "sway/workspaces"
    else if style == "river" then "river/tags"
    else if style == "mangowc" then "wlr/workspaces"
    else "niri/workspaces";

  languageModule =
    if style == "hyprland" then "hyprland/language"
    else if style == "niri" then "niri/language"
    else null;

  languageLine =
    if languageModule == null then ""
    else "    \"${languageModule}\",\n";

  baseWaybarConfig = builtins.readFile ./waybar/config.jsonc;
  waybarConfigText = lib.replaceStrings
    [
      "  \"modules-left\": [\"niri/workspaces\"],"
      "  \"modules-left\": [\"hyprland/workspaces\"],"
      "    \"hyprland/language\",\n"
      "    \"niri/language\",\n"
    ]
    [
      "  \"modules-left\": [\"${workspaceModule}\"],"
      "  \"modules-left\": [\"${workspaceModule}\"],"
      languageLine
      languageLine
    ]
    baseWaybarConfig;
in
{
  options.ix.desktop.bars.waybar = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = defaultEnable;
      description = "Enable Waybar.";
    };

    manageConfig = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install and manage the Irix Waybar config under ~/.config/waybar.";
    };
  };

  imports = [
    ./waybar
  ];

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.waybar.enable = true;
    })

    (lib.mkIf (cfg.enable && cfg.manageConfig) {
      xdg.configFile."waybar/config.jsonc" = {
        text = waybarConfigText;
        force = true;
      };

      xdg.configFile."waybar/style.base.css" = {
        source = ./waybar/style.css;
        force = true;
      };

      xdg.configFile."waybar/style.css" = {
        text = ''
          ${mkBase16Defines palette}
          @import "style.base.css";
        '';
        force = true;
      };
    })
  ];
}
