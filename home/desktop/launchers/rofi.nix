{ lib, config, pkgs, ... }:

let
  cfg = config.ix.desktop.launchers.rofi;
  hasStylixColors = lib.hasAttrByPath [ "lib" "stylix" "colors" ] config;
  c = if hasStylixColors then config.lib.stylix.colors else null;
  themeName = if hasStylixColors then "stylix" else "base";
in
{
  options.ix.desktop.launchers.rofi.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable Rofi launcher.";
  };

  config = lib.mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi;
    };

    xdg.configFile."rofi/themes/base.rasi" = {
      source = ./rofi/themes/base.rasi;
      force = true;
    };

    xdg.configFile."rofi/themes/stylix.rasi" = lib.mkIf hasStylixColors {
      text = ''
        * {
          bg: #${c.base00};
          bg-alt: #${c.base01};
          fg: #${c.base05};
          fg-alt: #${c.base04};
          border: #${c.base0D};
          urgent: #${c.base08};
          selected-bg: #${c.base02};
          selected-fg: #${c.base05};
        }

        window {
          background-color: @bg;
          border: 2px;
          border-color: @border;
        }

        mainbox {
          padding: 12px;
          background-color: @bg;
        }

        inputbar {
          spacing: 10px;
          padding: 8px;
          background-color: @bg;
          text-color: @fg;
        }

        entry {
          background-color: @bg-alt;
          text-color: @fg;
          padding: 6px;
        }

        listview {
          background-color: @bg;
          spacing: 6px;
          padding: 6px 0px;
        }

        element {
          padding: 6px 10px;
          background-color: @bg;
          text-color: @fg;
        }

        element selected {
          background-color: @selected-bg;
          text-color: @selected-fg;
        }

        element urgent {
          text-color: @urgent;
        }
      '';
      force = true;
    };

    xdg.configFile."rofi/config.rasi" = {
      text = ''
        configuration {
          show-icons: true;
          modi: "drun,run";
        }

        @theme "themes/${themeName}"
      '';
      force = true;
    };
  };
}
