{ ... }:
let
  c = (import ../../../../../assets/colors/kanso-palette.nix).base;
in
{
  programs.kitty = {
    settings = {
      background_opacity = 1.0; # NOTE: This goes on top of the compositor's transparency
      background = "#090E13";
      foreground = "#C5C9C7";
      selection_background = "#393B44";
      selection_foreground = "#C5C9C7";
      url_color = "#72A7BC";
      cursor = "#C5C9C7";
      cursor_text_color = "#090E13";
      # Tabs
      active_tab_background = "#090E13";
      active_tab_foreground = "#C5C9C7";
      inactive_tab_background = "#090E13";
      inactive_tab_foreground = "#A4A7A4";
      # Normal
      color0 = c.color0;
      color1 = c.color1;
      color2 = c.color2;
      color3 = c.color3;
      color4 = c.color4;
      color5 = c.color5;
      color6 = c.color6;
      color7 = c.color7;
      # Bright
      color8 = c.color8;
      color9 = c.color9;
      color10 = c.color10;
      color11 = c.color11;
      color12 = c.color12;
      color13 = c.color13;
      color14 = c.color14;
      color15 = c.color15;
      # Extended
      color16 = c.color16;
      color17 = c.color17;
    };
  };
}
