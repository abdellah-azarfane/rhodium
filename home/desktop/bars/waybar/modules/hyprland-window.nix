{
  waybarModules = {
    "hyprland/window" = {
      format = "{}";
      max-length = 60;
      separate-outputs = true;
      icon = true;
      icon-size = 16;
      rewrite = {
        "(.*) — Mozilla Firefox" = " $1";
        "(.*) - Visual Studio Code" = " $1";
        "(.*) - vim" = " $1";
        "(.*) - nvim" = " $1";
        "(.*) - Chromium" = " $1";
        "(.*) - Discord" = "󰙯 $1";
        "Spotify" = " Spotify";
        "(.*) - Thunar" = " $1";
      };
    };
  };
}
