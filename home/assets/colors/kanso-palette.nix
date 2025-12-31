let
  base = {
    # Normal
    color0 = "#0d0c0c";
    color1 = "#c4746e";
    color2 = "#8a9a7b";
    color3 = "#c4b28a";
    color4 = "#8ba4b0";
    color5 = "#a292a3";
    color6 = "#8ea4a2";
    color7 = "#C8C093";

    # Bright
    color8 = "#A4A7A4";
    color9 = "#E46876";
    color10 = "#87a987";
    color11 = "#E6C384";
    color12 = "#7FB4CA";
    color13 = "#938AA9";
    color14 = "#7AA89F";
    color15 = "#C5C9C7";

    # Extended
    color16 = "#b6927b";
    color17 = "#b98d7b";
    color18 = "#4B5F6F";
    color19 = "#4a7fff";
    color20 = "#59bfaa";

    # Extras used by some modules
    color21 = "#0d0d0d";
    color22 = "#C24043";
    color23 = "#f2f2f2";
    color24 = "#2a2a2a";
  };

  withAlpha = alpha: builtins.mapAttrs (_: v: v + alpha) base;
in
{
  inherit base;
  rgba = withAlpha "ff";
}
